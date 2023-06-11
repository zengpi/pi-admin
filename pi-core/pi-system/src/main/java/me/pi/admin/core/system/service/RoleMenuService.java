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

import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.core.system.pojo.po.SysRoleMenu;

import java.util.List;
import java.util.Set;

/**
 * @author ZnPi
 * @since 2022-09-26
 */
public interface RoleMenuService extends IService<SysRoleMenu> {
    /**
     * 为角色分配菜单
     *
     * @param roleId  角色 ID
     * @param menuIds 菜单 ID 列表
     */
    void roleMenuAllocation(Long roleId, Set<Long> menuIds);

    /**
     * 根据角色 ID 列表获取菜单 ID 列表
     *
     * @param roleIds 角色 ID 列表
     * @return 菜单 ID 列表
     */
    Set<Long> listMenuIdsByRoleIds(Set<Long> roleIds);

    /**
     * 根据角色 ID 列表获取角色菜单
     *
     * @param roleIds 角色 ID 列表
     * @return 角色菜单
     */
    List<SysRoleMenu> listByRoleIds(Set<Long> roleIds);
}
