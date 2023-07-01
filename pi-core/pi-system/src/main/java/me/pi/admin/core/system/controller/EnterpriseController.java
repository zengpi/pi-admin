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
import me.pi.admin.common.mybatis.validate.SaveGroup;
import me.pi.admin.common.mybatis.validate.UpdateGroup;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.core.log.annotation.Log;
import me.pi.admin.core.system.pojo.dto.EnterpriseDTO;
import me.pi.admin.core.system.pojo.vo.EnterpriseVO;
import me.pi.admin.core.system.service.EnterpriseService;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

/**
 * @author ZnPi
 * @date 2023-05-19
 */
@RestController
@RequestMapping("/enterprise")
@Tag(name = "企业管理")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class EnterpriseController {
    private final EnterpriseService enterpriseService;

    @GetMapping
    @Operation(summary = "查询企业")
    @PreAuthorize("hasAuthority('sys_enterprise_query')")
    public ResponseData<IPage<EnterpriseVO>> getEnterprises(BaseQuery query) {
        return ResponseData.ok(enterpriseService.getEnterprises(query));
    }

    @PostMapping
    @Operation(summary = "新增企业")
    @PreAuthorize("hasAuthority('sys_enterprise_add')")
    public ResponseData<?> saveEnterprise(@RequestBody @Validated(SaveGroup.class) EnterpriseDTO dto) {
        enterpriseService.saveOrUpdate(dto);
        return ResponseData.ok();
    }

    @PutMapping
    @Operation(summary = "编辑企业")
    @PreAuthorize("hasAuthority('sys_enterprise_update')")
    @Log("编辑企业")
    public ResponseData<?> updateEnterprise(@RequestBody @Validated(UpdateGroup.class) EnterpriseDTO dto) {
        enterpriseService.saveOrUpdate(dto);
        return ResponseData.ok();
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除企业")
    @PreAuthorize("hasAuthority('sys_enterprise_delete')")
    public ResponseData<?> deleteEnterprises(@PathVariable Set<Long> ids) {
        enterpriseService.delete(ids);
        return ResponseData.ok();
    }
}
