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
import me.pi.admin.common.mybatis.validate.UpdateGroup;
import me.pi.admin.core.log.annotation.Log;
import me.pi.admin.core.system.service.*;
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.core.system.pojo.dto.RoleDTO;
import me.pi.admin.core.system.pojo.dto.RoleUserAllocationDTO;
import me.pi.admin.core.system.pojo.query.RoleMemberQuery;
import me.pi.admin.core.system.pojo.vo.RoleMemberVO;
import me.pi.admin.core.system.pojo.vo.RoleVO;
import me.pi.admin.common.pojo.vo.ResponseData;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Set;

/**
 * @author ZnPi
 * @since 2022-09-04
 */
@RestController
@RequestMapping("/role")
@Tag(name = "角色管理")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class RoleController {
    private final RoleService roleService;
    private final UserService userService;
    private final RoleMenuService roleMenuService;
    private final UserRoleService userRoleService;
    private final RoleDeptService roleDeptService;

    @GetMapping
    @Operation(summary = "获取角色")
    @PreAuthorize("hasAuthority('sys_role_query')")
    public ResponseData<IPage<RoleVO>> getRoles(BaseQuery query) {
        return ResponseData.ok(roleService.listRolesByCondition(query));
    }

    @PostMapping
    @Operation(summary = "新增角色")
    @PreAuthorize("hasAuthority('sys_role_add')")
    public ResponseData<?> saveRole(@RequestBody @Validated(SaveGroup.class) RoleDTO dto) {
        roleService.saveOrUpdate(dto);
        return ResponseData.ok();
    }

    @PutMapping
    @Operation(summary = "编辑角色")
    @PreAuthorize("hasAuthority('sys_role_edit')")
    @Log("编辑角色")
    public ResponseData<?> updateRole(@RequestBody @Validated(UpdateGroup.class) RoleDTO dto) {
        roleService.saveOrUpdate(dto);
        return ResponseData.ok();
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除角色")
    @PreAuthorize("hasAuthority('sys_role_delete')")
    public ResponseData<?> deleteRole(@PathVariable Set<Long> ids) {
        roleService.removeRoles(ids);
        return ResponseData.ok();
    }

    @GetMapping("/allRoles")
    @Operation(summary = "获取所有角色")
    public ResponseData<List<RoleVO>> allRoles() {
        return ResponseData.ok(roleService.listRoles());
    }

    @GetMapping("/roleMembers")
    @Operation(summary = "获取角色成员")
    public ResponseData<PiPage<RoleMemberVO>> getRoleMembers(@Valid RoleMemberQuery queryParam) {
        return ResponseData.ok(userService.getRoleMembers(queryParam));
    }

    @PostMapping("/roleUserAllocation")
    @Operation(summary = "角色用户分配")
    @PreAuthorize("hasAuthority('sys_role_user_allocation')")
    @Log("角色用户分配")
    public ResponseData<?> allocateRoleUser(@RequestBody RoleUserAllocationDTO dto) {
        userRoleService.allocationRoleUser(dto);
        return ResponseData.ok();
    }

    @PostMapping("/roleMenuAllocation/{roleId}")
    @Operation(summary = "角色菜单分配")
    @PreAuthorize("hasAuthority('sys_role_menu_allocation')")
    @Log("角色菜单分配")
    public ResponseData<?> allocateRoleMenu(@PathVariable Long roleId, @RequestBody Set<Long> menuIds) {
        roleMenuService.roleMenuAllocation(roleId, menuIds);
        return ResponseData.ok();
    }

    @GetMapping("/dataPermissionDeptIds/{roleId}")
    @Operation(summary = "根据角色 ID 获取数据权限部门 ID 列表")
    public ResponseData<List<Long>> getDataPermissionDeptIdsByRoleId(@PathVariable Long roleId) {
        return ResponseData.ok(roleDeptService.getDeptIdsByRoleId(roleId));
    }

    @Operation(summary = "根据角色 ID 获取菜单 ID 列表")
    @GetMapping("/menuIds/{roleId}")
    public ResponseData<List<Long>> getMenuIdsByRoleId(@PathVariable Long roleId) {
        return ResponseData.ok(roleService.listMenuIdsByRoleId(roleId));
    }
}
