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

package me.pi.admin.core.system.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.constant.TenantConstant;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.common.pojo.vo.SelectTreeVO;
import me.pi.admin.common.util.SecurityUtils;
import me.pi.admin.core.system.pojo.dto.MenuDTO;
import me.pi.admin.core.system.pojo.query.MenuTreeQuery;
import me.pi.admin.core.system.pojo.vo.CurrentUserMenuTreeVO;
import me.pi.admin.core.system.pojo.vo.MenuTreeVO;
import me.pi.admin.core.system.service.MenuService;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Set;

/**
 * @author ZnPi
 * @since 2022-08-20
 */
@RestController
@RequestMapping("/menu")
@Tag(name = "菜单管理")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class MenuController {
    private final MenuService menuService;

    @GetMapping
    @Operation(summary = "获取菜单（树形）")
    @PreAuthorize("hasAuthority('sys_menu_query')")
    public ResponseData<List<MenuTreeVO>> getMenuTree(MenuTreeQuery query) {
        return ResponseData.ok(menuService.getMenuTree(query));
    }

    @PostMapping
    @Operation(summary = "新增菜单")
    @PreAuthorize("hasAuthority('sys_menu_add')")
    public ResponseData<?> saveMenu(@RequestBody @Valid MenuDTO dto) {
        if(!TenantConstant.PLATFORM_MANAGER_TENANT_ID.equals(SecurityUtils.getTenantId())) {
            throw new BizException("你没有权限执行此操作");
        }
        menuService.saveOrUpdate(dto);
        return ResponseData.ok();
    }

    @PutMapping
    @Operation(summary = "编辑菜单")
    @PreAuthorize("hasAuthority('sys_menu_update')")
    public ResponseData<?> updateMenu(@RequestBody @Valid MenuDTO dto) {
        if(!TenantConstant.PLATFORM_MANAGER_TENANT_ID.equals(SecurityUtils.getTenantId())) {
            throw new BizException("你没有权限执行此操作");
        }
        menuService.saveOrUpdate(dto);
        return ResponseData.ok();
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除菜单")
    @PreAuthorize("hasAuthority('sys_menu_delete')")
    public ResponseData<?> deleteMenu(@PathVariable Set<Long> ids) {
        if(!TenantConstant.PLATFORM_MANAGER_TENANT_ID.equals(SecurityUtils.getTenantId())) {
            throw new BizException("你没有权限执行此操作");
        }
        menuService.deleteMenu(ids);
        return ResponseData.ok();
    }

    @GetMapping("/buildMenu")
    @Operation(summary = "构建当前用户的菜单（树形）")
    public ResponseData<List<CurrentUserMenuTreeVO>> buildMenu() {
        return ResponseData.ok(menuService.buildMenu());
    }

    @GetMapping("/menuSelectTree/{containsButtons}")
    @Operation(summary = "获取菜单选择器（树形）")
    public ResponseData<List<SelectTreeVO>> getMenuSelectTree(@PathVariable Boolean containsButtons) {
        return ResponseData.ok(menuService.getMenuSelectTree(containsButtons));
    }
}
