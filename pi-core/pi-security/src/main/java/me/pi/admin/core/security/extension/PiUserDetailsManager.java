/*
 * Copyright 2022-2023 ZnPi
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package me.pi.admin.core.security.extension;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.pi.admin.common.pojo.dto.AuthenticatedRole;
import me.pi.admin.common.pojo.dto.AuthenticatedUser;
import me.pi.admin.core.system.service.UserService;
import me.pi.admin.common.constant.SecurityConstant;
import me.pi.admin.core.system.service.MenuService;
import me.pi.admin.core.system.service.RoleService;
import me.pi.admin.core.system.pojo.po.SysRole;
import me.pi.admin.core.system.pojo.po.SysUser;
import me.pi.admin.core.system.util.HttpEndpointUtils;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @since 2022-11-30
 */
@RequiredArgsConstructor
@Component
@Slf4j
public class PiUserDetailsManager implements UserDetailsService {
    private final UserService userService;
    private final RoleService roleService;
    private final MenuService menuService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        ServletRequestAttributes servletRequestAttributes =
                (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        Assert.notNull(servletRequestAttributes, "RequestAttributes 不能为 null");
        HttpServletRequest request = servletRequestAttributes.getRequest();

        String tenantId = HttpEndpointUtils.getParameters(request).getFirst("tenantId");

        SysUser sysUser = userService.getByUsername(username, tenantId);
        if (sysUser == null) {
            log.debug("Query returned no results for user '" + username + "'");
            throw new UsernameNotFoundException("用户 " + username + " 不存在");
        }

        List<SysRole> roles = roleService.listByUserName(username, tenantId);
        Set<GrantedAuthority> dbAuthsSet = new HashSet<>(loadUserAuthorities(roles));

        List<GrantedAuthority> dbAuths = new ArrayList<>(dbAuthsSet);
        addCustomAuthorities(username, dbAuths);
        if (dbAuths.size() == 0) {
            log.debug("User '" + username + "' has no authorities and will be treated as 'not found'");
            throw new UsernameNotFoundException("用户 " + username + " 未授权");
        }

        boolean accLocked = false;
        boolean accExpired = false;
        boolean credentialsExpired = false;
        List<AuthenticatedRole> authenticatedRoles = roles.stream()
                .map(role -> new AuthenticatedRole(role.getId(), role.getRoleScope())).collect(Collectors.toList());
        return new AuthenticatedUser(sysUser.getId(), username, tenantId, sysUser.getName(),
                sysUser.getPassword(), sysUser.getDeptId(), authenticatedRoles, sysUser.getEnabled().equals(1),
                !accExpired, !credentialsExpired, !accLocked, dbAuths);
    }

    /**
     * Allows subclasses to add their own granted authorities to the list to be returned
     * in the <tt>UserDetails</tt>.
     *
     * @param username    the username, for use by finder methods
     * @param authorities the current granted authorities, as populated from the
     *                    <code>authoritiesByUsername</code> mapping
     */
    protected void addCustomAuthorities(String username, List<GrantedAuthority> authorities) {
    }

    private List<GrantedAuthority> loadUserAuthorities(List<SysRole> roles) {
        Long[] roleIds = new Long[roles.size()];
        Set<GrantedAuthority> dbAuthsSet = new HashSet<>();

        for (int i = 0; i < roles.size(); i++) {
            roleIds[i] = roles.get(i).getId();
            dbAuthsSet.add(new SimpleGrantedAuthority(SecurityConstant.ROLE + roles.get(i).getRoleCode()));
        }

        if (roleIds.length != 0) {
            List<SimpleGrantedAuthority> authorities = menuService.listPermissionByRoleIds(roleIds).stream()
                    .map(item -> new SimpleGrantedAuthority(item.getPermission())).collect(Collectors.toList());
            dbAuthsSet.addAll(authorities);
        }

        return new ArrayList<>(dbAuthsSet);
    }
}
