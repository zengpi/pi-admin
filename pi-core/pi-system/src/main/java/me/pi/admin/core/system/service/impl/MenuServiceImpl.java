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

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.constant.CacheConstants;
import me.pi.admin.common.constant.PiConstants;
import me.pi.admin.common.constant.TenantConstant;
import me.pi.admin.common.enums.MenuTypeEnum;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.pojo.vo.SelectTreeVO;
import me.pi.admin.common.util.SecurityUtils;
import me.pi.admin.core.system.converter.MenuConverter;
import me.pi.admin.core.system.mapper.MenuMapper;
import me.pi.admin.core.system.pojo.dto.MenuDTO;
import me.pi.admin.core.system.pojo.po.SysMenu;
import me.pi.admin.core.system.pojo.po.SysRole;
import me.pi.admin.core.system.pojo.query.MenuTreeQuery;
import me.pi.admin.core.system.pojo.vo.CurrentUserMenuTreeVO;
import me.pi.admin.core.system.pojo.vo.MenuTreeVO;
import me.pi.admin.core.system.service.MenuService;
import me.pi.admin.core.system.service.RoleService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @since 2022-08-19
 */
@Service
@RequiredArgsConstructor
public class MenuServiceImpl extends ServiceImpl<MenuMapper, SysMenu> implements MenuService {
    private final MenuMapper menuMapper;
    private final MenuConverter menuConverter;
    private final RoleService roleService;

    @Override
    public List<MenuTreeVO> getMenuTree(MenuTreeQuery query) {
        List<SysMenu> menuList;
        // 平台管理员
        if (TenantConstant.PLATFORM_MANAGER_TENANT_ID.equals(SecurityUtils.getTenantId())) {
            LambdaQueryWrapper<SysMenu> wrapper = Wrappers.lambdaQuery(SysMenu.class)
                    .like(StrUtil.isNotBlank(query.getKeyWord()), SysMenu::getName, query.getKeyWord())
                    .or()
                    .like(StrUtil.isNotBlank(query.getKeyWord()), SysMenu::getComponent, query.getKeyWord())
                    .or()
                    .like(StrUtil.isNotBlank(query.getKeyWord()), SysMenu::getPermission, query.getKeyWord())
                    .orderByAsc(SysMenu::getSort)
                    .select(SysMenu::getId,
                            SysMenu::getCreateTime, SysMenu::getName, SysMenu::getPath, SysMenu::getComponentName,
                            SysMenu::getComponent, SysMenu::getPermission, SysMenu::getIcon, SysMenu::getSort,
                            SysMenu::getKeepAlive, SysMenu::getType, SysMenu::getExternalLinks, SysMenu::getVisible,
                            SysMenu::getRedirect, SysMenu::getParentId);

            menuList = super.list(wrapper);
        } else {
            menuList = menuMapper.listMenuByTenantId(SecurityUtils.getTenantId());
        }

        if (CollUtil.isEmpty(menuList)) {
            return Collections.emptyList();
        }

        if (StrUtil.isBlank(query.getKeyWord())) {
            return this.buildMenuTree(PiConstants.TREE_ROOT_ID, menuList);
        }

        List<Long> ids = menuList.stream().map(SysMenu::getId).collect(Collectors.toList());
        return menuList.stream().map(menu -> {
            if (!ids.contains(menu.getParentId())) {
                ids.add(menu.getParentId());
                return buildMenuTree(menu.getParentId(), menuList);
            }
            return new ArrayList<MenuTreeVO>();
        }).collect(ArrayList::new, ArrayList::addAll, ArrayList::addAll);
    }

    @Override
    @CacheEvict(value = CacheConstants.CACHE_MENU, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    public void saveOrUpdate(MenuDTO dto) {
        if (dto.getParentId().equals(dto.getId())) {
            throw new BadRequestException("上级类目不能为自己！");
        }
        if (!dto.getParentId().equals(0L)) {
            SysMenu menu = super.getOne(Wrappers.lambdaQuery(SysMenu.class)
                    .eq(SysMenu::getId, dto.getParentId()).select(SysMenu::getType));
            if (menu == null) {
                throw new BadRequestException("上级类目不存在");
            }

            if (!MenuTypeEnum.BUTTON.getType().equals(dto.getType()) &&
                    !MenuTypeEnum.DIR.getType().equals(menu.getType())) {
                throw new BadRequestException("上级类目必须为目录");
            }
        }
        if (MenuTypeEnum.DIR.getType().equals(dto.getType()) && dto.getExternalLinks() != 1) {
            if (PiConstants.TREE_ROOT_ID.equals(dto.getParentId())) {
                dto.setComponent("Navigation");
            } else {
                dto.setComponent("ParentView");
            }
        }
        SysMenu menu = menuConverter.menuDtoToSysMenu(dto);
        super.saveOrUpdate(menu);

        // 更新 hasChildren
        if (dto.getParentId() != 0) {
            SysMenu sysMenu = super.getOne(Wrappers.lambdaQuery(SysMenu.class)
                    .eq(SysMenu::getId, dto.getParentId())
                    .select(SysMenu::getHasChildren));
            Optional.of(sysMenu).ifPresent(e -> {
                if (e.getHasChildren() == 0) {
                    super.update(Wrappers.lambdaUpdate(SysMenu.class)
                            .set(SysMenu::getHasChildren, 1)
                            .eq(SysMenu::getId, dto.getParentId()));
                }
            });
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    @CacheEvict(value = CacheConstants.CACHE_MENU, allEntries = true)
    public void deleteMenu(Collection<Long> ids) {
        if (ids.isEmpty()) {
            throw new BadRequestException("待删除记录 id 列表不能为空");
        }
        if (!(ids instanceof Set)) {
            ids = new HashSet<>(ids);
        }

        // 更新父菜单的 hasChildren
        // 所有父菜单
        Set<Long> parentMenuIdSet = super.list(Wrappers.lambdaQuery(SysMenu.class)
                        .in(SysMenu::getId, ids)
                        .select(SysMenu::getParentId))
                .stream()
                .map(SysMenu::getParentId)
                .collect(Collectors.toSet());

        // 待删除菜单 ID 列表，包括子菜单。
        // 此操作必须在获取待更新父菜的 hasChildren 之后，更新父菜单的 hasChildren 之前，否则删除后就没办法获取父菜单了
        Set<Long> toBeRemoved = new HashSet<>();
        ids.forEach(id -> {
            if (!toBeRemoved.contains(id)) {
                toBeRemoved.add(id);
                getToBeRemovedChildrenMenuIds(id, toBeRemoved);
            }
        });
        super.removeByIds(toBeRemoved);

        // 更新 hasChildren
        Set<Long> toBeUpdatedHasChildrenId = new HashSet<>();
        parentMenuIdSet.forEach(id -> {
            // 跟目录的父目录无需处理
            if (PiConstants.TREE_ROOT_ID.equals(id)) {
                return;
            }
            // 父菜单是否有子菜单
            long count = super.count(Wrappers.lambdaQuery(SysMenu.class)
                    .eq(SysMenu::getParentId, id));
            if (count <= 0) {
                toBeUpdatedHasChildrenId.add(id);
            }
        });
        if (!toBeUpdatedHasChildrenId.isEmpty()) {
            super.update(Wrappers.lambdaUpdate(SysMenu.class)
                    .set(SysMenu::getHasChildren, 0)
                    .in(SysMenu::getId, toBeUpdatedHasChildrenId));
        }
    }

    @Override
    @Cacheable(value = CacheConstants.CACHE_MENU,
            key = "T(me.pi.admin.common.util.SecurityUtils).userName + ':' + T(me.pi.admin.common.util.SecurityUtils).tenantId")
    public List<CurrentUserMenuTreeVO> buildMenu() {
        // 角色标识
        List<SysRole> sysRoleList = roleService.listByUserName(SecurityUtils.getUserName());
        List<String> roleCodeList = sysRoleList.stream().map(SysRole::getRoleCode).collect(Collectors.toList());

        return buildCurrentUserMenuTree(PiConstants.TREE_ROOT_ID, menuMapper.listMenuByRoleCodeList(roleCodeList));
    }

    @Override
    public List<SelectTreeVO> getMenuSelectTree(Boolean containsButtons) {
        List<SysMenu> menuList;
        String tenantId = SecurityUtils.getTenantId();
        if (TenantConstant.PLATFORM_MANAGER_TENANT_ID.equals(tenantId)) {
            menuList = super.list(Wrappers.lambdaQuery(SysMenu.class)
                    .ne(!containsButtons, SysMenu::getType, MenuTypeEnum.BUTTON.getType())
                    .select(SysMenu::getId, SysMenu::getName, SysMenu::getParentId)
                    .orderByAsc(SysMenu::getSort)
            );
        } else {
            menuList = menuMapper.listMenuByTenantId(tenantId);
        }
        if (CollUtil.isEmpty(menuList)) {
            return Collections.emptyList();
        }
        return buildMenuSelectTree(PiConstants.TREE_ROOT_ID, menuList);
    }

    @Override
    public List<SysMenu> listPermissionByRoleIds(Long[] ids) {
        return menuMapper.listPermissionByRoleIds(ids);
    }

    private List<MenuTreeVO> buildMenuTree(Long parentId, List<SysMenu> menuList) {
        return menuList.stream()
                .filter(menu -> menu.getParentId().equals(parentId))
                .map(menu -> {
                    MenuTreeVO menuTreeVO = menuConverter.sysMenuToMenuTreeVo(menu);
                    menuTreeVO.setChildren(buildMenuTree(menu.getId(), menuList));
                    return menuTreeVO;
                }).collect(Collectors.toList());
    }

    private void getToBeRemovedChildrenMenuIds(Long parentId, Set<Long> toBeRemoved) {
        List<SysMenu> childrenMenuList = super.list(Wrappers.lambdaQuery(SysMenu.class)
                .eq(SysMenu::getParentId, parentId)
                .select(SysMenu::getId, SysMenu::getParentId));

        childrenMenuList.forEach(childrenMenu -> {
            toBeRemoved.add(childrenMenu.getId());
            getToBeRemovedChildrenMenuIds(childrenMenu.getId(), toBeRemoved);
        });
    }

    private List<CurrentUserMenuTreeVO> buildCurrentUserMenuTree(Long parentId, List<SysMenu> menuList) {
        return menuList.stream()
                .filter(menu -> menu.getParentId().equals(parentId))
                .map(menu -> {
                    CurrentUserMenuTreeVO currentUserMenuTreeVO = menuConverter.sysMenuToCurrentUserMenuTreeVo(menu);
                    if (MenuTypeEnum.MENU.getType().equals(menu.getType())) {
                        if (StrUtil.isNotBlank(menu.getComponentName())) {
                            currentUserMenuTreeVO.setName(menu.getComponentName());
                        } else {
                            currentUserMenuTreeVO.setName(menu.getName());
                        }
                    }
                    currentUserMenuTreeVO.setChildren(buildCurrentUserMenuTree(menu.getId(), menuList));
                    return currentUserMenuTreeVO;
                })
                .collect(Collectors.toList());
    }

    private List<SelectTreeVO> buildMenuSelectTree(Long parentId, List<SysMenu> menuList) {
        return menuList.stream().filter(e -> e.getParentId().equals(parentId))
                .map(menu -> {
                    SelectTreeVO selectTree = menuConverter.sysMenuToSelectTreeVo(menu);
                    selectTree.setChildren(buildMenuSelectTree(menu.getId(), menuList));
                    return selectTree;
                }).collect(Collectors.toList());
    }
}
