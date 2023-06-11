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

package me.pi.admin.workflow.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.common.mybatis.validate.SaveGroup;
import me.pi.admin.common.mybatis.validate.UpdateGroup;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.workflow.converter.ProcessFormConverter;
import me.pi.admin.workflow.enums.BuiltInFormEnum;
import me.pi.admin.workflow.pojo.dto.FormDTO;
import me.pi.admin.workflow.pojo.po.ActReForm;
import me.pi.admin.workflow.pojo.vo.FormVO;
import me.pi.admin.workflow.service.ProcessFormService;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

/**
 * 表单管理
 *
 * @author ZnPi
 * @date 2023-04-03
 */
@RestController
@RequestMapping("/workflow/form")
@Tag(name = "表单管理")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class FormController {
    private final ProcessFormService processFormService;
    private final ProcessFormConverter processFormConverter;

    @GetMapping
    @Operation(summary = "获取表单列表")
    @PreAuthorize("hasAuthority('workflow_form_list')")
    public ResponseData<IPage<FormVO>> listForms(BaseQuery baseQuery) {
        IPage<ActReForm> forms = processFormService.listForms(baseQuery);
        return ResponseData.ok(processFormConverter.poPageToVoPage(forms));
    }

    @PostMapping
    @Operation(summary = "新增表单")
    @PreAuthorize("hasAuthority('workflow_form_save')")
    public ResponseData<?> saveForm(@RequestBody @Validated(SaveGroup.class) FormDTO formDto) {
        saveOrUpdate(formDto);
        return ResponseData.ok();
    }

    @PutMapping
    @Operation(summary = "编辑表单")
    @PreAuthorize("hasAuthority('workflow_form_update')")
    public ResponseData<?> updateForm(@RequestBody @Validated(UpdateGroup.class) FormDTO formDto) {
        saveOrUpdate(formDto);
        return ResponseData.ok();
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除表单")
    @PreAuthorize("hasAuthority('workflow_form_delete')")
    public ResponseData<?> deleteForm(@PathVariable Set<Long> ids) {
        processFormService.deleteForms(ids);
        return ResponseData.ok();
    }

    @GetMapping("/{formId}")
    @Operation(summary = "根据表单 ID 获取表单")
    public ResponseData<FormVO> getById(@PathVariable String formId) {
        return ResponseData.ok(processFormConverter.poToVo(processFormService.getById(formId)));
    }

    @GetMapping("/allForms")
    @Operation(summary = "获取所有表单")
    public ResponseData<List<FormVO>> listAllForms() {
        return ResponseData.ok(processFormService.listAllForms());
    }

    private void saveOrUpdate(FormDTO dto) {
        if (Integer.valueOf(BuiltInFormEnum.BUILT_IN.ordinal()).equals(dto.getBuiltIn())
                && !StringUtils.hasText(dto.getComponentPath())) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "内置表单组件路径不能为空");
        }
        processFormService.saveOrUpdate(dto);
    }
}
