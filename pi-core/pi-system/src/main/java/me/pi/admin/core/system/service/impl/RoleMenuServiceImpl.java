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
import me.pi.admin.core.system.mapper.RoleMenuMapper;
import me.pi.admin.core.system.pojo.po.SysRoleMenu;
import me.pi.admin.core.system.service.RoleMenuService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @since 2022-09-26
 */
@Service
@RequiredArgsConstructor
public class RoleMenuServiceImpl extends ServiceImpl<RoleMenuMapper, SysRoleMenu> implements RoleMenuService {
    @Override
    @Transactional(rollbackFor = Exception.class)
    @CacheEvict(value = {CacheConstants.CACHE_MENU, CacheConstants.CACHE_USER}, allEntries = true)
    public void roleMenuAllocation(Long roleId, Set<Long> menuIds) {
        // 获取当前角色的所有菜单
        Set<Long> curMenuIdSet = super.list(Wrappers.lambdaQuery(SysRoleMenu.class)
                        .eq(SysRoleMenu::getRoleId, roleId)
                        .select(SysRoleMenu::getMenuId))
                .stream().map(SysRoleMenu::getMenuId)
                .collect(Collectors.toSet());

        // 待删除
        Set<Long> toBeDeleted;
        // 待新增
        Set<SysRoleMenu> toBeAdded = new HashSet<>(menuIds.size());

        if (menuIds.isEmpty()) {
            toBeDeleted = curMenuIdSet;
        } else {
            toBeAdded = menuIds.stream()
                    .filter(e -> !curMenuIdSet.contains(e))
                    .map(e -> new SysRoleMenu(roleId, e))
                    .collect(Collectors.toSet());

            toBeDeleted = curMenuIdSet.stream()
                    .filter(e -> !menuIds.contains(e))
                    .collect(Collectors.toSet());
        }

        if (!toBeDeleted.isEmpty()) {
            super.remove(Wrappers.lambdaQuery(SysRoleMenu.class)
                    .eq(SysRoleMenu::getRoleId, roleId)
                    .in(SysRoleMenu::getMenuId, toBeDeleted));
        }
        if (!toBeAdded.isEmpty()) {
            super.saveBatch(toBeAdded);
        }
    }

    @Override
    public Set<Long> listMenuIdsByRoleIds(Set<Long> roleIds) {
        return super.list(Wrappers.lambdaQuery(SysRoleMenu.class)
                        .in(SysRoleMenu::getRoleId, roleIds)
                        .select(SysRoleMenu::getMenuId))
                .stream().map(SysRoleMenu::getMenuId)
                .collect(Collectors.toSet());
    }

    @Override
    public List<SysRoleMenu> listByRoleIds(Set<Long> roleIds) {
        return super.list(Wrappers.lambdaQuery(SysRoleMenu.class)
                .in(SysRoleMenu::getRoleId, roleIds)
                .select(SysRoleMenu::getId, SysRoleMenu::getRoleId, SysRoleMenu::getMenuId));
    }
}
