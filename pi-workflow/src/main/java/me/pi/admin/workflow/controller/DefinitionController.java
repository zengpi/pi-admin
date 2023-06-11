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
import me.pi.admin.workflow.pojo.query.BootableDefinitionQuery;
import me.pi.admin.workflow.pojo.query.ProcessDefQuery;
import me.pi.admin.workflow.pojo.vo.FormVO;
import me.pi.admin.workflow.pojo.vo.ProcessDefinitionVO;
import me.pi.admin.workflow.service.ProcessDefinitionService;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 流程定义
 *
 * @author ZnPi
 * @date 2023-04-02
 */
@RestController
@RequestMapping("/workflow/definition")
@Tag(name = "流程定义")
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
@RequiredArgsConstructor
public class DefinitionController {
    private final ProcessDefinitionService processDefinitionService;

    @GetMapping
    @Operation(summary = "获取流程定义")
    @PreAuthorize("hasAuthority('workflow_definition_list')")
    public ResponseData<IPage<ProcessDefinitionVO>> listProcessDefinitions(ProcessDefQuery processDefQuery) {
        return ResponseData.ok(processDefinitionService.listProcessDefinitions(processDefQuery));
    }

    @GetMapping("/bootableDefinition")
    @Operation(summary = "获取可启动的流程定义")
    @PreAuthorize("hasAuthority('workflow_definition_list')")
    public ResponseData<IPage<ProcessDefinitionVO>> getBootableDefinition(BootableDefinitionQuery query) {
        return ResponseData.ok(processDefinitionService.getBootableDefinition(query));
    }

    @GetMapping("/processForm/{processDefinitionId}")
    @Operation(summary = "获取流程表单")
    @PreAuthorize("hasAuthority('workflow_definition_list')")
    public ResponseData<FormVO> getProcessDefinitionForm(@PathVariable String processDefinitionId) {
        return ResponseData.ok(processDefinitionService.getProcessDefinitionForm(processDefinitionId));
    }

    @GetMapping("/bpmnXml/{definitionId}")
    @Operation(summary = "根据流程定义 ID 获取 BPMN Xml")
    public ResponseData<String> getBpmnXml(@PathVariable String definitionId) {
        return ResponseData.ok(processDefinitionService.getBpmnXml(definitionId));
    }

    @PatchMapping("/state/{definitionId}/{suspended}")
    @Operation(summary = "更改流程状态")
    @PreAuthorize("hasAuthority('workflow_definition_update')")
    public ResponseData<?> changeState(@PathVariable String definitionId, @PathVariable Boolean suspended) {
        processDefinitionService.changeState(definitionId, suspended);
        return ResponseData.ok();
    }

    @GetMapping("/history")
    @Operation(summary = "获取历史版本")
    @PreAuthorize("hasAuthority('workflow_definition_list')")
    public ResponseData<IPage<ProcessDefinitionVO>> listHistoryProcessDefinitions(ProcessDefQuery processDefQuery) {
        return ResponseData.ok(processDefinitionService.listHistoryProcessDefinitions(processDefQuery));
    }
}
