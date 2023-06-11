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

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.constant.CacheConstants;
import me.pi.admin.common.constant.TenantConstant;
import me.pi.admin.core.system.mapper.PackageMenuMapper;
import me.pi.admin.core.system.pojo.po.*;
import me.pi.admin.core.system.service.*;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 针对表【sys_package_menu】的数据库操作 Service 实现
 *
 * @author ZnPi
 * @date 2023-05-26
 */
@Service
@RequiredArgsConstructor
public class PackageMenuServiceImpl extends ServiceImpl<PackageMenuMapper, SysPackageMenu>
        implements PackageMenuService {
    private final PackageMenuMapper packageMenuMapper;
    private final RoleMenuService roleMenuService;
    private final PackageService packageService;

    @Override
    public Set<Long> getMenuIdsByPackageId(Long packageId) {
        return super.list(Wrappers.lambdaQuery(SysPackageMenu.class)
                        .eq(SysPackageMenu::getPackageId, packageId)
                        .select(SysPackageMenu::getMenuId))
                .stream()
                .map(SysPackageMenu::getMenuId)
                .collect(Collectors.toSet());
    }

    @Override
    public Set<Long> getLeafMenuIdsByPackageId(Long packageId) {
        return packageMenuMapper.getLeafMenuIdsByPackageId(packageId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    @CacheEvict(value = {CacheConstants.CACHE_MENU, CacheConstants.CACHE_USER}, allEntries = true)
    public void allocatePackageMenu(Long packageId, Set<Long> menuIds) {
        // 套餐是否存在
        if (!packageService.isExists(packageId)) {
            return;
        }

        // 分配菜单
        doAllocatePackageMenu(packageId, menuIds);
        // 分配租户角色菜单
        allocateRoleMenu(packageId, menuIds);
    }

    public void allocateRoleMenu(Long packageId, Set<Long> menuIds) {
        // 当前套餐租户角色
        List<SysRole> curPackageTenantRoles = packageMenuMapper.getPackageTenantRolesByPackageId(packageId);
        if (curPackageTenantRoles.isEmpty()) {
            return;
        }

        allocateRoleMenu(menuIds, curPackageTenantRoles);
    }

    @Override
    public void allocateRoleMenu(Set<Long> menuIds, List<SysRole> curTenantRoles) {
        // 角色 ID 列表
        Set<Long> roleIds = curTenantRoles.stream()
                .map(SysRole::getId)
                .collect(Collectors.toSet());

        // 当前角色菜单
        List<SysRoleMenu> curRoleMenus = roleMenuService.listByRoleIds(roleIds);

        if (menuIds.isEmpty() && curRoleMenus.isEmpty()) {
            return;
        }

        // 给租户管理员新增角色菜单
        addRoleMenu(menuIds, curTenantRoles, curRoleMenus);
        // 删除角色菜单
        deleteRoleMenu(menuIds, curRoleMenus);
    }

    @Override
    public List<SysRole> getPackageTenantRolesByPackageId(Long packageId) {
        return packageMenuMapper.getPackageTenantRolesByPackageId(packageId);
    }

    private void doAllocatePackageMenu(Long packageId, Set<Long> menuIds) {
        // 当前套餐的菜单ID列表
        Set<Long> curMenuIdSet = super.list(Wrappers.lambdaQuery(SysPackageMenu.class)
                        .eq(SysPackageMenu::getPackageId, packageId)
                        .select(SysPackageMenu::getMenuId))
                .stream()
                .map(SysPackageMenu::getMenuId)
                .collect(Collectors.toSet());

        if (menuIds.isEmpty() && curMenuIdSet.isEmpty()) {
            return;
        }

        // 删除套餐菜单
        deletePackageMenu(packageId, menuIds, curMenuIdSet);

        // 新增套餐菜单
        addPackageMenu(packageId, menuIds, curMenuIdSet);
    }

    private void deletePackageMenu(Long packageId, Set<Long> menuIds, Set<Long> curMenuIdSet) {
        if (curMenuIdSet.isEmpty()) {
            return;
        }

        Set<Long> toBeDeleted;
        if (menuIds.isEmpty()) {
            toBeDeleted = curMenuIdSet;
        } else {
            toBeDeleted = curMenuIdSet.stream()
                    .filter(e -> !menuIds.contains(e))
                    .collect(Collectors.toSet());
        }

        if (!toBeDeleted.isEmpty()) {
            super.remove(Wrappers.lambdaQuery(SysPackageMenu.class)
                    .eq(SysPackageMenu::getPackageId, packageId)
                    .in(SysPackageMenu::getMenuId, toBeDeleted));
        }
    }

    private void addPackageMenu(Long packageId, Set<Long> menuIds, Set<Long> curMenuIdSet) {
        if (menuIds.isEmpty()) {
            return;
        }

        Set<SysPackageMenu> toBeAdded;
        if (curMenuIdSet.isEmpty()) {
            toBeAdded = menuIds.stream()
                    .map(menuId -> new SysPackageMenu(packageId, menuId))
                    .collect(Collectors.toSet());
        } else {
            toBeAdded = menuIds.stream()
                    .filter(e -> !curMenuIdSet.contains(e))
                    .map(e -> new SysPackageMenu(packageId, e))
                    .collect(Collectors.toSet());
        }
        if (!toBeAdded.isEmpty()) {
            super.saveBatch(toBeAdded);
        }
    }

    private void addRoleMenu(Set<Long> menuIds, List<SysRole> curTenantRoles, List<SysRoleMenu> curRoleMenus) {
        if (menuIds.isEmpty()) {
            return;
        }
        // 租户管理员角色 ID 列表
        Set<Long> roleIds = curTenantRoles.stream()
                .filter(curPackageTenantRole ->
                        TenantConstant.ADMIN_ROLE_CODE.equals(curPackageTenantRole.getRoleCode()))
                .map(SysRole::getId)
                .collect(Collectors.toSet());
        if (roleIds.isEmpty()) {
            return;
        }

        ArrayList<SysRoleMenu> toBeAddedRoleMenus = new ArrayList<>();
        roleIds.forEach(roleId -> {
            // 租户管理员现有菜单 ID 列表
            Set<Long> curMenuIds = curRoleMenus.stream()
                    .filter(curRoleMenu -> roleId.equals(curRoleMenu.getRoleId()))
                    .map(SysRoleMenu::getMenuId)
                    .collect(Collectors.toSet());

            if (curMenuIds.isEmpty()) {
                menuIds.forEach(menuId -> toBeAddedRoleMenus.add(new SysRoleMenu(roleId, menuId)));
            } else {
                menuIds.stream()
                        .filter(menuId -> !curMenuIds.contains(menuId))
                        .forEach(menuId -> toBeAddedRoleMenus.add(new SysRoleMenu(roleId, menuId)));
            }
        });

        if (!toBeAddedRoleMenus.isEmpty()) {
            roleMenuService.saveBatch(toBeAddedRoleMenus);
        }
    }

    private void deleteRoleMenu(Set<Long> menuIds, List<SysRoleMenu> curRoleMenus) {
        if (curRoleMenus.isEmpty()) {
            return;
        }
        Set<Long> toBeDeleted;
        if (menuIds.isEmpty()) {
            toBeDeleted = curRoleMenus.stream()
                    .map(SysRoleMenu::getId)
                    .collect(Collectors.toSet());
        } else {
            toBeDeleted = curRoleMenus.stream()
                    .filter(curRoleMenu -> !menuIds.contains(curRoleMenu.getMenuId()))
                    .map(SysRoleMenu::getId)
                    .collect(Collectors.toSet());
        }

        if (!toBeDeleted.isEmpty()) {
            roleMenuService.removeByIds(toBeDeleted);
        }
    }
}




