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
import me.pi.admin.workflow.pojo.vo.DoneTaskVO;
import me.pi.admin.workflow.pojo.vo.CopyVO;
import me.pi.admin.workflow.pojo.dto.ApproveCompleteDTO;
import me.pi.admin.workflow.pojo.query.TaskQuery;
import me.pi.admin.workflow.pojo.vo.ProcessFormVO;
import me.pi.admin.workflow.pojo.vo.TodoTaskVO;

import java.util.List;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
public interface ProcessTaskService {
    /**
     * 获取待办任务
     *
     * @param taskQuery 获取代办任务查询参数
     * @return 代办任务
     */
    IPage<TodoTaskVO> listTodoTask(TaskQuery taskQuery);

    /**
     * 获取任务表单
     *
     * @param taskId 任务 ID
     * @return 任务表单
     */
    ProcessFormVO getTaskFormById(String taskId);

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
     * @param taskQuery 任务查询参数
     * @return 已办任务
     */
    IPage<DoneTaskVO> listDoneTask(TaskQuery taskQuery);

    /**
     * 撤回已办任务
     *
     * @param taskId 任务 ID
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
     * @param taskQuery 查询参数
     * @return 抄送列表
     */
    IPage<CopyVO> listCopies(TaskQuery taskQuery);
}
