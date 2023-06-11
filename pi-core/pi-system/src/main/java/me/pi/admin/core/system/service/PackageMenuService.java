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

package me.pi.admin.core.system.service;

import me.pi.admin.core.system.pojo.po.SysPackageMenu;
import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.core.system.pojo.po.SysRole;

import java.util.List;
import java.util.Set;

/**
 * 针对表【sys_package_menu】的数据库操作 Service
 *
 * @author ZnPi
 * @date 2023-05-26
 */
public interface PackageMenuService extends IService<SysPackageMenu> {
    /**
     * 根据套餐 ID 获取菜单 ID 列表
     *
     * @param packageId 套餐 ID
     * @return 菜单 ID 列表
     */
    Set<Long> getMenuIdsByPackageId(Long packageId);

    /**
     * 根据套餐 ID 获取叶子菜单 ID 列表
     *
     * @param packageId 套餐 ID
     * @return 叶子菜单 ID 列表
     */
    Set<Long> getLeafMenuIdsByPackageId(Long packageId);

    /**
     * 为套餐分配菜单
     *
     * @param packageId 套餐
     * @param menuIds   菜单列表
     */
    void allocatePackageMenu(Long packageId, Set<Long> menuIds);

    /**
     * 为套餐租户角色分配菜单
     *
     * @param packageId 套餐
     * @param menuIds   待分配菜单列表
     */
    void allocateRoleMenu(Long packageId, Set<Long> menuIds);

    /**
     * 为套餐租户角色分配菜单
     *
     * @param menuIds   待分配菜单列表
     * @param curTenantRoles 当前租户角色
     */
    void allocateRoleMenu(Set<Long> menuIds, List<SysRole> curTenantRoles);

    /**
     * 根据套餐 ID 获取套餐租户角色列表
     *
     * @param packageId 套餐 ID
     * @return 套餐租户角色列表
     */
    List<SysRole> getPackageTenantRolesByPackageId(Long packageId);
}
