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
import me.pi.admin.workflow.pojo.dto.ApproveCommonDTO;
import me.pi.admin.workflow.pojo.dto.ApproveCompleteDTO;
import me.pi.admin.workflow.pojo.dto.ApproveRejectDTO;
import me.pi.admin.workflow.pojo.query.TaskQuery;
import me.pi.admin.workflow.pojo.vo.DoneTaskVO;
import me.pi.admin.workflow.pojo.vo.TodoTaskVO;
import me.pi.admin.workflow.service.ProcessTaskService;
import me.pi.admin.workflow.pojo.vo.CopyVO;
import me.pi.admin.workflow.pojo.vo.ProcessFormVO;
import org.springframework.http.HttpHeaders;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
@RestController
@RequestMapping("/workflow/task")
@Tag(name = "任务管理")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class TaskController {
    private final ProcessTaskService processTaskService;

    @GetMapping("/todoTask")
    @Operation(summary = "获取待办任务")
    public ResponseData<IPage<TodoTaskVO>> listTodoTask(TaskQuery taskQuery) {
        return ResponseData.ok(processTaskService.listTodoTask(taskQuery));
    }

    @GetMapping("/form/{taskId}")
    @Operation(summary = "获取任务表单")
    public ResponseData<ProcessFormVO> getTaskFormById(@NotNull(message = "任务 ID 不能为空") @PathVariable String taskId) {
        return ResponseData.ok(processTaskService.getTaskFormById(taskId));
    }

    @Operation(summary = "审批通过")
    @PostMapping("/approve")
    public ResponseData<?> approve(@Valid @RequestBody ApproveCompleteDTO approveCompleteDto) {
        processTaskService.approve(approveCompleteDto);
        return ResponseData.ok();
    }

    @PostMapping("/delegate")
    @Operation(summary = "委派")
    public ResponseData<?> delegate(@Valid @RequestBody ApproveCommonDTO approveCommonDto) {
        processTaskService.delegate(approveCommonDto);
        return ResponseData.ok();
    }

    @PostMapping("/transfer")
    @Operation(summary = "转办")
    public ResponseData<?> transfer(@Valid @RequestBody ApproveCommonDTO approveCommonDto) {
        processTaskService.transfer(approveCommonDto);
        return ResponseData.ok();
    }

    @PostMapping("/reject")
    @Operation(summary = "驳回")
    public ResponseData<?> reject(@Valid @RequestBody ApproveRejectDTO approveRejectDto) {
        processTaskService.reject(approveRejectDto);
        return ResponseData.ok();
    }

    @GetMapping("/doneTask")
    @Operation(summary = "获取已办任务")
    public ResponseData<IPage<DoneTaskVO>> listDoneTask(TaskQuery taskQuery) {
        return ResponseData.ok(processTaskService.listDoneTask(taskQuery));
    }

    @PostMapping("/revoke")
    @Operation(summary = "撤回已办任务")
    public ResponseData<?> revoke(@NotEmpty(message = "任务 ID 不能为空") String taskId,
                                  @NotEmpty(message = "流程实例 ID 不能为空") String processInstanceId) {
        processTaskService.revoke(taskId, processInstanceId);
        return ResponseData.ok();
    }

    @GetMapping("/copies")
    @Operation(summary = "获取抄送列表")
    public ResponseData<IPage<CopyVO>> listCopies(TaskQuery taskQuery) {
        return ResponseData.ok(processTaskService.listCopies(taskQuery));
    }
}
