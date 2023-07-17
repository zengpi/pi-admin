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

package me.pi.admin.workflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import me.pi.admin.workflow.pojo.dto.ApproveCommonDTO;
import me.pi.admin.workflow.pojo.dto.ApproveRejectDTO;
import me.pi.admin.workflow.pojo.query.FlowableTaskQuery;
import me.pi.admin.workflow.pojo.vo.*;
import me.pi.admin.workflow.pojo.dto.ApproveCompleteDTO;
import me.pi.admin.workflow.pojo.query.TodoTaskQuery;
import org.flowable.form.api.FormInfo;
import org.flowable.task.api.TaskInfo;

import java.util.List;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
public interface FlowableProcessTaskService {
    /**
     * 查询任务
     *
     * @param query 查询条件
     * @return 任务列表
     */
    List<? extends TaskInfo> listTasks(FlowableTaskQuery query);

    /**
     * 根据流程实例 id 查询任务
     *
     * @param processInstanceId 流程实例 id
     * @return 任务
     */
    List<ProcessTaskVO> listTaskByProcessInstanceId(String processInstanceId);

    /**
     * 获取待办任务
     *
     * @param todoTaskQuery 获取代办任务查询参数
     * @return 代办任务
     */
    IPage<TodoTaskVO> listTodoTask(TodoTaskQuery todoTaskQuery);

    /**
     * 获取任务表单
     *
     * @param taskId 任务 ID
     * @return 任务表单
     */
    ProcessFormVO getAllTaskFormByTaskId(String taskId);

    /**
     * 根据任务 id 获取任务表单
     *
     * @param taskId 任务 id
     * @return 任务表单
     */
    FormInfo getTaskFormByTaskId(String taskId);

    /**
     * 审批通过
     *
     * @param approveCompleteDto task 数据传输对象
     */
    void approve(ApproveCompleteDTO approveCompleteDto);

    /**
     * 委派
     *
     * @param approveCommonDto 委派任务 DTO
     */
    void delegate(ApproveCommonDTO approveCommonDto);

    /**
     * 转办
     *
     * @param approveCommonDto 转办任务 DTO
     */
    void transfer(ApproveCommonDTO approveCommonDto);

    /**
     * 驳回
     *
     * @param approveRejectDto 驳回任务 DTO
     */
    void reject(ApproveRejectDTO approveRejectDto);

    /**
     * 获取已办任务
     *
     * @param todoTaskQuery 任务查询参数
     * @return 已办任务
     */
    IPage<DoneTaskVO> listDoneTask(TodoTaskQuery todoTaskQuery);

    /**
     * 撤回已办任务
     *
     * @param taskId            任务 ID
     * @param processInstanceId 流程实例 ID
     */
    void revoke(String taskId, String processInstanceId);

    /**
     * 设置下一级审批人
     *
     * @param processInstanceId 流程实例 ID
     * @param nextAssignees     下一级审批人
     */
    void setNextAssignees(String processInstanceId, List<String> nextAssignees);

    /**
     * 获取抄送列表
     *
     * @param todoTaskQuery 查询参数
     * @return 抄送列表
     */
    IPage<CopyVO> listCopies(TodoTaskQuery todoTaskQuery);
}
