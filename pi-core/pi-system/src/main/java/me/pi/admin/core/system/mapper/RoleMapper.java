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

package me.pi.admin.core.system.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import me.pi.admin.core.system.pojo.po.SysRole;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.ss.formula.functions.T;

import java.util.Collection;
import java.util.List;

/**
 * @author ZnPi
 * @since 2022-08-19
 */
public interface RoleMapper extends BaseMapper<SysRole> {
    /**
     * 根据用户 ID 获取该用户的角色
     *
     * @param id 用户 ID
     * @return 该用户的角色
     */
    List<SysRole> listRoleByUserId(@Param("id") Long id);

    /**
     * 根据用户名获取该用户的角色
     *
     * @param username 用户名
     * @return 该用户的角色
     */
    List<SysRole> listRoleByUsername(@Param("username") String username);

    /**
     * 根据角色 ID 获取菜单 ID 列表
     *
     * @param roleId 角色 ID
     * @return 菜单 ID 列表
     */
    List<Long> getMenuIdsByRoleId(@Param("roleId") Long roleId);

    /**
     * 根据角色 ID 获取菜单 ID 列表
     *
     * @param username 用户名
     * @param tenantId 租户
     * @return 菜单 ID 列表
     */
    List<SysRole> listRoleByUsernameAndTenantId(@Param("username") String username, @Param("tenantId") String tenantId);

    /**
     * 获取租户管理员
     *
     * @param tenantCode 租户
     * @return 租户管理员
     */
    @InterceptorIgnore(tenantLine = "1")
    SysRole getTenantAdmin(@Param("tenantCode") String tenantCode);

    /**
     * 根据租户查询角色
     *
     * @param tenantId 租户
     * @return 角色列表
     */
    @InterceptorIgnore(tenantLine = "true")
    List<SysRole> selectByTenantId(@Param("tenantId") String tenantId);

    /**
     * 根据租户 ID 列表删除角色
     *
     * @param tenantIds 租户 ID 列表
     */
    @InterceptorIgnore(tenantLine = "true")
    void deleteByTenantIds(@Param("tenantIds") Collection<String> tenantIds);
}
