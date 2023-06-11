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
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.core.system.converter.TenantConverter;
import me.pi.admin.core.system.pojo.dto.TenantSaveDTO;
import me.pi.admin.core.system.pojo.dto.TenantUpdateDTO;
import me.pi.admin.core.system.pojo.vo.LoginTenantVO;
import me.pi.admin.core.system.pojo.vo.TenantVO;
import me.pi.admin.core.system.service.TenantService;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Set;

/**
 * @author ZnPi
 * @date 2023-05-22
 */
@RestController
@RequestMapping("/tenant")
@Tag(name = "租户管理")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class TenantController {
    private final TenantService tenantService;
    private final TenantConverter tenantConverter;

    @GetMapping
    @Operation(summary = "查询租户")
    @PreAuthorize("hasAuthority('sys_tenant_query')")
    public ResponseData<IPage<TenantVO>> getTenants(BaseQuery query) {
        return ResponseData.ok(tenantService.listTenantsByCondition(query));
    }

    @PostMapping
    @Operation(summary = "新增租户")
    @PreAuthorize("hasAuthority('sys_tenant_add')")
    public ResponseData<?> saveTenant(@RequestBody @Valid TenantSaveDTO dto) {
        tenantService.saveTenant(dto);
        return ResponseData.ok();
    }

    @PutMapping
    @Operation(summary = "更新租户")
    @PreAuthorize("hasAuthority('sys_tenant_update')")
    public ResponseData<?> updateTenant(@RequestBody @Valid TenantUpdateDTO dto) {
        tenantService.updateTenant(dto);
        return ResponseData.ok();
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除租户")
    @PreAuthorize("hasAuthority('sys_tenant_delete')")
    public ResponseData<?> deleteTenants(@PathVariable Set<Long> ids) {
        tenantService.deleteTenants(ids);
        return ResponseData.ok();
    }

    @GetMapping("/login/tenants")
    @Operation(summary = "根据账号获取租户列表", description = "当 username 为 null 时返回所有")
    public ResponseData<List<LoginTenantVO>> getTenantsByUsername(String username) {
        return ResponseData.ok(tenantConverter.posToLoginVos(tenantService.getTenantsByUsername(username)));
    }
}
