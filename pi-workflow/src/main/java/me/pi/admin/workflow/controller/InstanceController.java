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
import me.pi.admin.workflow.pojo.query.MyProcessQuery;
import me.pi.admin.workflow.pojo.vo.MyProcessInstanceVO;
import me.pi.admin.workflow.pojo.vo.ProcessInstanceDetailVO;
import me.pi.admin.workflow.service.ProcessInstanceService;
import org.springframework.http.HttpHeaders;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 流程实例
 *
 * @author ZnPi
 * @date 2023-04-19
 */
@RestController
@RequestMapping("/workflow/instance")
@Tag(name = "流程实例")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class InstanceController {
    private final ProcessInstanceService processInstanceService;

    @Operation(summary = "启动流程实例")
    @PostMapping("/startProcessInstance/{processDefinitionId}")
    public ResponseData<?> startProcessInstance(@PathVariable String processDefinitionId,
                                                @RequestBody Map<String, Object> variables) {
        processInstanceService.startProcessInstance(processDefinitionId, variables);
        return ResponseData.ok();
    }

    @Operation(summary = "获取我的流程")
    @GetMapping("/myProcesses")
    public ResponseData<IPage<MyProcessInstanceVO>> listMyProcesses(MyProcessQuery myProcessQuery) {
        return ResponseData.ok(processInstanceService.getMyProcesses(myProcessQuery));
    }

    @DeleteMapping("/delete/{processInstanceId}")
    @Operation(summary = "删除流程实例")
    public ResponseData<?> delete(@PathVariable String processInstanceId) {
        processInstanceService.delete(processInstanceId);
        return ResponseData.ok();
    }

    @DeleteMapping("/cancel/{processInstanceId}")
    @Operation(summary = "取消流程实例")
    public ResponseData<?> cancel(@PathVariable String processInstanceId) {
        processInstanceService.cancel(processInstanceId);
        return ResponseData.ok();
    }

    @Operation(summary = "获取流程实例详情")
    @GetMapping("/detail/{processInstanceId}")
    public ResponseData<ProcessInstanceDetailVO> getProcessInstanceDetail(@PathVariable String processInstanceId) {
        return ResponseData.ok(processInstanceService.getProcessInstanceDetail(processInstanceId));
    }
}
