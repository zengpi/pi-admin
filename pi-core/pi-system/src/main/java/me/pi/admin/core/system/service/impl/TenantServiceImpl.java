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

package me.pi.admin.core.system.service.impl;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.constant.CacheConstants;
import me.pi.admin.common.constant.PiConstants;
import me.pi.admin.common.constant.TenantConstant;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.core.system.converter.TenantConverter;
import me.pi.admin.core.system.mapper.TenantMapper;
import me.pi.admin.core.system.pojo.dto.TenantSaveDTO;
import me.pi.admin.core.system.pojo.dto.TenantUpdateDTO;
import me.pi.admin.core.system.pojo.po.*;
import me.pi.admin.core.system.pojo.vo.TenantVO;
import me.pi.admin.core.system.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 针对表【sys_tenant】的数据库操作 Service 实现
 *
 * @author ZnPi
 * @date 2023-05-22
 */
@Service
@RequiredArgsConstructor
public class TenantServiceImpl extends ServiceImpl<TenantMapper, SysTenant>
        implements TenantService {
    private final TenantConverter tenantConverter;
    private final RoleService roleService;
    private final PackageMenuService packageMenuService;
    private final RoleMenuService roleMenuService;
    private final DeptService deptService;
    private final PasswordEncoder passwordEncoder;
    private UserService userService;
    private final UserRoleService userRoleService;
    private final TenantMapper tenantMapper;

    @Autowired
    @Lazy
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public IPage<TenantVO> listTenantsByCondition(BaseQuery query) {
        return tenantMapper.selectPageTenantsByCondition(query.page(), query);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveTenant(TenantSaveDTO dto) {
        // 判断企业是否已经是租户
        long count = super.count(Wrappers.lambdaQuery(SysTenant.class)
                .eq(SysTenant::getEnterpriseId, dto.getEnterpriseId()));
        if (count > 0) {
            throw new BizException("待新增租户的企业已经存在，不能重复");
        }
        // 生成六位租户编码
        String tenantCode = genTenantCode();

        // 创建角色，并绑定角色菜单
        SysRole role = createRoleMenu(dto, tenantCode);

        // 创建部门，部门 名称为企业名称
        SysDept dept = createDept(dto, tenantCode);

        // 创建租户管理员用户，将用户与角色、部门进行关联
        SysUser user = new SysUser();
        user.setUsername(dto.getAccount());
        user.setName(dto.getContact());
        user.setTenantId(tenantCode);
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setPhone(dto.getPhone());
        user.setEmail(dto.getEmail());
        user.setDeptId(dept.getId());
        userService.save(user);

        SysUserRole userRole = new SysUserRole(user.getId(), role.getId());
        userRoleService.save(userRole);

        // 创建租户
        SysTenant tenant = tenantConverter.saveDtoToPo(dto);
        tenant.setTenantCode(tenantCode);
        tenant.setAdminId(user.getId());
        super.save(tenant);
    }

    private SysDept createDept(TenantSaveDTO dto, String tenantCode) {
        SysDept dept = new SysDept();
        dept.setName(dto.getEnterpriseName());
        dept.setTenantId(tenantCode);
        dept.setSort(1);
        dept.setParentId(PiConstants.TREE_ROOT_ID);
        deptService.save(dept);
        return dept;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    @CacheEvict(value = {CacheConstants.CACHE_MENU, CacheConstants.CACHE_USER}, allEntries = true)
    public void updateTenant(TenantUpdateDTO dto) {
        // 获取待更新租户
        SysTenant tenant = super.getOne(Wrappers.lambdaQuery(SysTenant.class)
                .eq(SysTenant::getId, dto.getId())
                .select(SysTenant::getId, SysTenant::getPackageId, SysTenant::getTenantCode));
        if (Objects.isNull(tenant)) {
            throw new BizException("待更新租户不存在");
        }

        // 更新套餐
        updatePackage(dto, tenant);

        // 更新租户
        super.updateById(tenantConverter.updateDtoToPo(dto));
    }

    private void updatePackage(TenantUpdateDTO dto, SysTenant tenant) {
        // 套餐没有改变，直接返回
        if (dto.getPackageId().equals(tenant.getPackageId())) {
            return;
        }

        // 待分配菜单
        Set<Long> menuIds = packageMenuService.getMenuIdsByPackageId(dto.getPackageId());

        // 当前租户的角色
        List<SysRole> roles = roleService.listByTenantId(tenant.getTenantCode());
        // 为套餐租户角色分配菜单
        packageMenuService.allocateRoleMenu(menuIds, roles);
    }

    @Override
    public List<SysTenant> getTenantsByUsername(String username) {
        if (StrUtil.isNotBlank(username)) {
            return tenantMapper.getTenantsByUsername(username);
        }
        return super.list(Wrappers.lambdaQuery(SysTenant.class)
                .select(SysTenant::getTenantCode, SysTenant::getEnterpriseName));
    }

    @Override
    public Long getTenantUserQuantityLimit(String tenantCode) {
        SysTenant tenant = super.getOne(Wrappers.lambdaQuery(SysTenant.class)
                .eq(SysTenant::getTenantCode, tenantCode)
                .select(SysTenant::getUserQuantity));
        if (Objects.isNull(tenant)) {
            throw new BizException("租户不存在");
        }
        return tenant.getUserQuantity();
    }

    @Override
    public Boolean isEnterpriseTenant(Set<Long> enterpriseIds) {
        long count = super.count(Wrappers.lambdaQuery(SysTenant.class)
                .in(SysTenant::getEnterpriseId, enterpriseIds));
        return count > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteTenants(Collection<Long> ids) {
        if (ids.isEmpty()) {
            throw new BizException("待删除租户 ID 列表不能为空");
        }
        if (!(ids instanceof Set)) {
            ids = new HashSet<>(ids);
        }

        Set<String> tenantCodes = listTenantCodesByTenantIds(ids);

        // 删除租户角色
        roleService.removeByTenantIds(tenantCodes);

        // 删除租户部门
        deptService.removeByTenantIds(tenantCodes);

        // 删除租户用户
        userService.removeByTenantIds(tenantCodes);

        // 删除租户
        super.removeByIds(ids);
    }

    /**
     * 根据租户 ID 列表获取租户编码列表
     *
     * @param ids 租户 ID 列表
     * @return 租户编码列表
     */
    private Set<String> listTenantCodesByTenantIds(Collection<Long> ids) {
        return super.list(Wrappers.lambdaQuery(SysTenant.class)
                        .in(SysTenant::getId, ids))
                .stream()
                .map(SysTenant::getTenantCode)
                .collect(Collectors.toSet());
    }

    /**
     * 创建角色并绑定角色菜单
     *
     * @param dto        租户保存 DTO
     * @param tenantCode 租户编码
     * @return 角色
     */
    private SysRole createRoleMenu(TenantSaveDTO dto, String tenantCode) {
        // 创建角色
        SysRole role = new SysRole();
        role.setName("管理员");
        role.setRoleCode(TenantConstant.ADMIN_ROLE_CODE);
        role.setTenantId(tenantCode);
        role.setRoleDesc("租户管理员");
        roleService.save(role);

        if (Objects.isNull(dto.getPackageId())) {
            return role;
        }

        // 获取套餐菜单
        Set<Long> menuIds = packageMenuService.getMenuIdsByPackageId(dto.getPackageId());

        if (menuIds.isEmpty()) {
            return role;
        }
        // 角色与套餐绑定
        ArrayList<SysRoleMenu> roleMenus = new ArrayList<>(menuIds.size());
        menuIds.forEach(menuId -> roleMenus.add(new SysRoleMenu(role.getId(), menuId)));
        roleMenuService.saveBatch(roleMenus);

        return role;
    }

    private String genTenantCode() {
        String tenantCode;
        while (true) {
            tenantCode = RandomUtil.randomNumbers(6);
            long count = super.count(Wrappers.lambdaQuery(SysTenant.class)
                    .eq(SysTenant::getTenantCode, tenantCode));
            if (count == 0) {
                break;
            }
        }
        return tenantCode;
    }
}




