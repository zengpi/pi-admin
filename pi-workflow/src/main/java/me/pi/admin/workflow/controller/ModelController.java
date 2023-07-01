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
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.common.mybatis.validate.SaveGroup;
import me.pi.admin.common.mybatis.validate.UpdateGroup;
import me.pi.admin.core.log.annotation.Log;
import me.pi.admin.workflow.pojo.dto.SaveModelDesignDTO;
import me.pi.admin.workflow.converter.ProcessModelConverter;
import me.pi.admin.workflow.pojo.dto.ProcessModelDTO;
import me.pi.admin.workflow.pojo.query.ProcessModelQuery;
import me.pi.admin.workflow.pojo.vo.ProcessModelVO;
import me.pi.admin.workflow.service.ProcessModelService;
import org.flowable.engine.repository.Model;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Set;

/**
 * 流程模型管理
 *
 * @author ZnPi
 * @date 2023-04-03
 */
@RestController
@RequestMapping("/workflow/model")
@Tag(name = "流程模型管理")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class ModelController {
    private final ProcessModelService processModelService;
    private final ProcessModelConverter processModelConverter;

    @GetMapping
    @Operation(summary = "获取流程模型")
    @PreAuthorize("hasAuthority('workflow_model_list')")
    public ResponseData<IPage<ProcessModelVO>> listModels(ProcessModelQuery processModelQuery) {
        IPage<Model> page = processModelService.listModels(processModelQuery);
        return ResponseData.ok(processModelConverter.poPageToVoPage(page));
    }

    @PostMapping
    @Operation(summary = "新增流程模型")
    @PreAuthorize("hasAuthority('workflow_model_save')")
    @Log("新增流程模型")
    public ResponseData<?> saveModel(@Validated(SaveGroup.class) @RequestBody ProcessModelDTO processModelDto) {
        processModelService.saveModel(processModelDto);
        return ResponseData.ok();
    }

    @PutMapping
    @Operation(summary = "更新流程模型")
    @PreAuthorize("hasAuthority('workflow_model_update')")
    @Log("更新流程模型")
    public ResponseData<?> updateModel(@Validated(UpdateGroup.class) @RequestBody ProcessModelDTO processModelDto) {
        processModelService.updateModel(processModelDto);
        return ResponseData.ok();
    }

    @DeleteMapping("/{modelIds}")
    @Operation(summary = "删除流程模型")
    @PreAuthorize("hasAuthority('workflow_model_delete')")
    @Log("删除流程模型")
    public ResponseData<?> deleteModels(@NotEmpty(message = "主键不能为空") @PathVariable Set<String> modelIds) {
        processModelService.deleteModels(modelIds);
        return ResponseData.ok();
    }

    @GetMapping("/bpmnXml/{modelId}")
    @Operation(summary = "根据模型 ID 获取 Bpmn xml")
    public ResponseData<String> getBpmnXmlById(@NotNull(message = "Model Id 不能为空") @PathVariable String modelId) {
        return ResponseData.ok(processModelService.getBpmnXmlById(modelId));
    }

    @PostMapping("/modelDesign")
    @Operation(summary = "保存流程模型设计")
    @PreAuthorize("hasAuthority('workflow_model_save_design')")
    @Log("保存流程模型设计")
    public ResponseData<?> saveModelDesign(@Valid @RequestBody SaveModelDesignDTO saveModelDesignDto) {
        processModelService.saveModelDesign(saveModelDesignDto);
        return ResponseData.ok();
    }

    @PostMapping("/deploy/{modelId}")
    @Operation(summary = "部署流程模型")
    @PreAuthorize("hasAuthority('workflow_model_deploy')")
    @Log("部署流程模型")
    public ResponseData<?> deployModel(@PathVariable String modelId) {
        processModelService.deployModel(modelId);
        return ResponseData.ok();
    }
}
