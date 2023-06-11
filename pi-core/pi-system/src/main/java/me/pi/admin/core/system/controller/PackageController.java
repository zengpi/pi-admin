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

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.mybatis.validate.SaveGroup;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.core.system.pojo.dto.PackageDTO;
import me.pi.admin.core.system.pojo.query.PackageQuery;
import me.pi.admin.core.system.pojo.vo.PackageVO;
import me.pi.admin.core.system.service.PackageMenuService;
import me.pi.admin.core.system.service.PackageService;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

/**
 * @author ZnPi
 * @date 2023-05-22
 */
@RestController
@RequestMapping("/package")
@Tag(name = "套餐管理")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class PackageController {
    private final PackageService packageService;
    private final PackageMenuService packageMenuService;

    @GetMapping
    @Operation(summary = "查询套餐")
    @PreAuthorize("hasAuthority('sys_package_query')")
    public ResponseData<IPage<PackageVO>> getPackages(PackageQuery query) {
        return ResponseData.ok(packageService.getPackages(query));
    }

    @PostMapping
    @Operation(summary = "新增套餐")
    @PreAuthorize("hasAuthority('sys_package_add')")
    public ResponseData<?> savePackage(@RequestBody @Validated(SaveGroup.class) PackageDTO dto) {
        packageService.saveOrUpdate(dto);
        return ResponseData.ok();
    }

    @PutMapping
    @Operation(summary = "编辑套餐")
    @PreAuthorize("hasAuthority('sys_package_update')")
    public ResponseData<?> updatePackage(@RequestBody @Validated(SaveGroup.class) PackageDTO dto) {
        packageService.saveOrUpdate(dto);
        return ResponseData.ok();
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除套餐")
    @PreAuthorize("hasAuthority('sys_package_delete')")
    public ResponseData<?> deletePackages(@PathVariable Set<Long> ids) {
        packageService.delete(ids);
        return ResponseData.ok();
    }

    @GetMapping("/menuIds/{packageId}")
    @Operation(summary = "根据套餐 ID 获取叶子菜单 ID 列表")
    @PreAuthorize("hasAuthority('sys_package_query')")
    public ResponseData<Set<Long>> getMenuIdsByPackageId(@PathVariable Long packageId) {
        return ResponseData.ok(packageMenuService.getLeafMenuIdsByPackageId(packageId));
    }

    @PostMapping("/packageMenusAllocate/{packageId}")
    @Operation(summary = "为套餐分配菜单")
    @PreAuthorize("hasAuthority('sys_package_menus_allocate')")
    public ResponseData<?> allocatePackageMenu(@PathVariable Long packageId, @RequestBody Set<Long> menuIds) {
        packageMenuService.allocatePackageMenu(packageId, menuIds);
        return ResponseData.ok();
    }
}
