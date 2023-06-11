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

package me.pi.admin.workflow.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.BetweenFormatter;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.common.util.SecurityUtils;
import me.pi.admin.core.system.pojo.po.SysRole;
import me.pi.admin.core.system.pojo.po.SysUser;
import me.pi.admin.core.system.service.RoleService;
import me.pi.admin.core.system.service.UserService;
import me.pi.admin.workflow.converter.ProcessTaskConverter;
import me.pi.admin.workflow.pojo.dto.ApproveCommonDTO;
import me.pi.admin.workflow.pojo.dto.ApproveCompleteDTO;
import me.pi.admin.workflow.pojo.dto.ApproveRejectDTO;
import me.pi.admin.workflow.pojo.po.ActHiCopy;
import me.pi.admin.workflow.pojo.po.ActReForm;
import me.pi.admin.workflow.service.ProcessCopyService;
import me.pi.admin.workflow.service.ProcessFormService;
import me.pi.admin.workflow.service.ProcessTaskService;
import me.pi.admin.common.util.DateUtil;
import me.pi.admin.workflow.constant.FlowableConstants;
import me.pi.admin.workflow.enums.CommentEnum;
import me.pi.admin.workflow.pojo.query.TaskQuery;
import me.pi.admin.workflow.util.FlowableUtil;
import me.pi.admin.workflow.pojo.vo.*;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.EndEvent;
import org.flowable.bpmn.model.UserTask;
import org.flowable.common.engine.api.FlowableObjectNotFoundException;
import org.flowable.engine.HistoryService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.DelegationState;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.api.history.HistoricTaskInstanceQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
@Service
@RequiredArgsConstructor
public class ProcessTaskServiceImpl implements ProcessTaskService {
    /**
     * 日期范围长度
     */
    private static final int DATE_RANGE_LENGTH = 2;
    private final RepositoryService repositoryService;
    private final HistoryService historyService;
    private final TaskService taskService;
    private final ProcessTaskConverter processTaskConverter;
    private final UserService userService;
    private final RoleService roleService;
    private final ProcessFormService processFormService;
    private final ProcessCopyService processCopyService;
    private final RuntimeService runtimeService;

    @Override
    public IPage<TodoTaskVO> listTodoTask(TaskQuery todoTaskQuery) {
        IPage<TodoTaskVO> page = new PiPage<>();

        org.flowable.task.api.TaskQuery taskQuery = taskService.createTaskQuery()
                .taskTenantId(SecurityUtils.getTenantId())
                .active()
                .includeProcessVariables()
                .taskCandidateOrAssigned(SecurityUtils.getUserName())
                .taskCandidateGroupIn(getCandidateGroup())
                .orderByTaskCreateTime().desc();
        if (Objects.nonNull(todoTaskQuery.getProcessDefinitionName())) {
            taskQuery.processDefinitionNameLike("%" + todoTaskQuery.getProcessDefinitionName() + "%");
        }
        if (Objects.nonNull(todoTaskQuery.getDateRange()) && todoTaskQuery.getDateRange().length == DATE_RANGE_LENGTH) {
            taskQuery.taskCreatedAfter(DateUtil.localDateToDate(todoTaskQuery.getDateRange()[0]))
                    .taskCreatedBefore(DateUtil.localDateToDate(todoTaskQuery.getDateRange()[1]));
        }
        long count = taskQuery.count();
        if (count <= 0) {
            return page;
        }
        page.setTotal(taskQuery.count());
        int offset = todoTaskQuery.getPageSize() * (todoTaskQuery.getPageNum() - 1);
        List<Task> tasks = taskQuery.listPage(offset, todoTaskQuery.getPageSize());

        Set<String> processDefinitionIds = tasks.stream()
                .map(Task::getProcessDefinitionId).collect(Collectors.toSet());
        List<ProcessDefinition> processDefinitions = repositoryService.createProcessDefinitionQuery()
                .processDefinitionIds(processDefinitionIds)
                .list();

        Set<String> processInstanceIds = tasks.stream().map(Task::getProcessInstanceId).collect(Collectors.toSet());
        List<HistoricProcessInstance> historicProcessInstances = historyService.createHistoricProcessInstanceQuery()
                .processInstanceIds(processInstanceIds)
                .list();
        ArrayList<TodoTaskVO> todoTasks = new ArrayList<>();
        tasks.forEach(task -> {
            TodoTaskVO todoTask = processTaskConverter.taskToTodoTaskVo(task);

            processDefinitions.stream()
                    .filter(processDefinition -> task.getProcessDefinitionId().equals(processDefinition.getId()))
                    .findFirst()
                    .ifPresent(processDefinition -> {
                        todoTask.setProcessDefinitionName(processDefinition.getName());
                        todoTask.setProcessDefinitionVersion(processDefinition.getVersion());
                        todoTask.setDeploymentId(processDefinition.getDeploymentId());
                    });

            historicProcessInstances.stream()
                    .filter(historicProcessInstance ->
                            task.getProcessDefinitionId()
                                    .equals(historicProcessInstance.getProcessDefinitionId()))
                    .findFirst()
                    .ifPresent(historicProcessInstance -> {
                        SysUser user = userService.getByUsername(historicProcessInstance.getStartUserId());
                        todoTask.setStartUsername(user.getUsername());
                        todoTask.setStartName(user.getName());
                    });

            todoTask.setProcessVars(getProcessVars(task.getId()));

            todoTasks.add(todoTask);
        });

        page.setRecords(todoTasks);

        return page;
    }

    @Override
    public ProcessFormVO getTaskFormById(String taskId) {
        HistoricTaskInstance historicTaskInstance = historyService.createHistoricTaskInstanceQuery()
                .taskId(taskId)
                .includeTaskLocalVariables()
                .singleResult();
        if (Objects.isNull(historicTaskInstance)) {
            throw new BadRequestException("任务不存在");
        }
        if (Objects.isNull(historicTaskInstance.getFormKey())) {
            return null;
        }
        ActReForm form = processFormService.getById(historicTaskInstance.getFormKey());
        if (Objects.isNull(form)) {
            throw new BizException("表单不存在");
        }
        ProcessFormVO processForm = processTaskConverter.formPoToProcessFormVo(form);
        processForm.setFormData(historicTaskInstance.getTaskLocalVariables());
        return processForm;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approve(ApproveCompleteDTO approveCompleteDto) {
        // 获取任务
        Task task = taskService.createTaskQuery().taskId(approveCompleteDto.getTaskId()).singleResult();
        if (Objects.isNull(task)) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "任务不存在");
        }

        String processInstanceId = approveCompleteDto.getProcessInstanceId();
        if (DelegationState.PENDING.equals(task.getDelegationState())) {
            taskService.addComment(approveCompleteDto.getTaskId(), approveCompleteDto.getProcessInstanceId(),
                    CommentEnum.DELEGATE.getCode(), approveCompleteDto.getComment());
            taskService.resolveTask(approveCompleteDto.getTaskId());
        } else {
            taskService.addComment(approveCompleteDto.getTaskId(), processInstanceId,
                    CommentEnum.NORMAL.getCode(), approveCompleteDto.getComment());
            taskService.setAssignee(approveCompleteDto.getTaskId(), SecurityUtils.getUserName());
            if (CollUtil.isNotEmpty(approveCompleteDto.getVariables())) {
                taskService.complete(approveCompleteDto.getTaskId(), approveCompleteDto.getVariables());
            } else {
                taskService.complete(approveCompleteDto.getTaskId());
            }
        }

        // 抄送人
        setCopyUsers(task, processInstanceId, approveCompleteDto.getCopyUsers());

        // 下一级审批人
        List<String> nextUsers = approveCompleteDto.getNextUsers();
        setNextAssignees(processInstanceId, nextUsers);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delegate(ApproveCommonDTO approveCommonDto) {
        Task task = taskService.createTaskQuery().taskId(approveCommonDto.getTaskId()).singleResult();
        if (Objects.isNull(task)) {
            throw new BizException("任务不存在");
        }
        SysUser delegateUser = userService.getByUsername(approveCommonDto.getUserName());
        if (Objects.isNull(delegateUser)) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "指定的用户不存在");
        }
        SysUser user = userService.getByUsername(SecurityUtils.getUserName());
        StringBuilder comment = new StringBuilder("由 " + user.getName()).append(" 委派给 ")
                .append(delegateUser.getName());
        if (StringUtils.hasText(approveCommonDto.getComment())) {
            comment.append("：").append(approveCommonDto.getComment());
        }
        taskService.addComment(approveCommonDto.getTaskId(), approveCommonDto.getProcessInstanceId(),
                CommentEnum.DELEGATE.getCode(), comment.toString());
        taskService.setOwner(approveCommonDto.getTaskId(), SecurityUtils.getUserName());
        taskService.delegateTask(approveCommonDto.getTaskId(), approveCommonDto.getUserName());
        // 抄送人
        setCopyUsers(task, approveCommonDto.getProcessInstanceId(), approveCommonDto.getCopyUsers());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void transfer(ApproveCommonDTO approveCommonDto) {
        Task task = taskService.createTaskQuery().taskId(approveCommonDto.getTaskId()).singleResult();
        if (Objects.isNull(task)) {
            throw new BizException("任务不存在");
        }
        SysUser delegateUser = userService.getByUsername(approveCommonDto.getUserName());
        if (Objects.isNull(delegateUser)) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "指定的用户不存在");
        }
        SysUser user = userService.getByUsername(SecurityUtils.getUserName());
        StringBuilder comment = new StringBuilder("由 " + user.getName()).append(" 转办给 ")
                .append(delegateUser.getName());
        if (StringUtils.hasText(approveCommonDto.getComment())) {
            comment.append("：").append(approveCommonDto.getComment());
        }
        taskService.addComment(approveCommonDto.getTaskId(), approveCommonDto.getProcessInstanceId(),
                CommentEnum.TRANSFER.getCode(), comment.toString());
        taskService.setOwner(approveCommonDto.getTaskId(), SecurityUtils.getUserName());
        taskService.setAssignee(approveCommonDto.getTaskId(), approveCommonDto.getUserName());
        // 抄送人
        setCopyUsers(task, approveCommonDto.getProcessInstanceId(), approveCommonDto.getCopyUsers());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void reject(ApproveRejectDTO approveRejectDto) {
        Task task = taskService.createTaskQuery().taskId(approveRejectDto.getTaskId()).singleResult();
        if (Objects.isNull(task)) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "任务不存在");
        }
        if (task.isSuspended()) {
            throw new BizException("任务处于挂起状态");
        }
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(approveRejectDto.getProcessInstanceId())
                .singleResult();
        if (Objects.isNull(processInstance)) {
            throw new BizException("流程实例不存在");
        }

        taskService.addComment(approveRejectDto.getTaskId(), approveRejectDto.getProcessInstanceId(),
                CommentEnum.REJECT.getCode(), approveRejectDto.getComment());

        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(task.getProcessDefinitionId())
                .singleResult();
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinition.getId());
        EndEvent endEvent = FlowableUtil.getEndEvent(bpmnModel);

        List<Execution> executions = runtimeService.createExecutionQuery()
                .parentId(task.getProcessInstanceId())
                .list();
        List<String> executionIds = executions.stream().map(Execution::getId).collect(Collectors.toList());
        runtimeService.createChangeActivityStateBuilder()
                .processInstanceId(task.getProcessInstanceId())
                .moveExecutionsToSingleActivityId(executionIds, endEvent.getId())
                .changeState();

        // 抄送人
        setCopyUsers(task, approveRejectDto.getProcessInstanceId(), approveRejectDto.getCopyUsers());
    }

    @Override
    public IPage<DoneTaskVO> listDoneTask(TaskQuery taskQuery) {
        PiPage<DoneTaskVO> page = new PiPage<>();
        HistoricTaskInstanceQuery historicTaskInstanceQuery = historyService.createHistoricTaskInstanceQuery()
                .includeProcessVariables()
                .finished()
                .taskAssignee(SecurityUtils.getUserName())
                .orderByHistoricTaskInstanceEndTime().desc();
        if (StringUtils.hasText(taskQuery.getProcessDefinitionName())) {
            historicTaskInstanceQuery.processDefinitionNameLike("%" + taskQuery.getProcessDefinitionName() + "%");
        }
        if (Objects.nonNull(taskQuery.getDateRange()) && taskQuery.getDateRange().length == DATE_RANGE_LENGTH) {
            historicTaskInstanceQuery.taskCompletedAfter(DateUtil.localDateToDate(taskQuery.getDateRange()[0]));
            historicTaskInstanceQuery.taskCompletedBefore(DateUtil.localDateToDate(taskQuery.getDateRange()[1]));
        }
        long count = historicTaskInstanceQuery.count();
        if (count == 0) {
            return page;
        }
        page.setTotal(count);
        int offset = taskQuery.getPageSize() * (taskQuery.getPageNum() - 1);
        List<HistoricTaskInstance> historicTaskInstances = historicTaskInstanceQuery
                .listPage(offset, taskQuery.getPageSize());
        ArrayList<DoneTaskVO> doneTasks = new ArrayList<>();
        for (HistoricTaskInstance historicTaskInstance : historicTaskInstances) {
            DoneTaskVO doneTask = processTaskConverter.historicTaskInstanceToDoneTaskVo(historicTaskInstance);
            doneTask.setDuration(DateUtil.formatBetween(historicTaskInstance.getDurationInMillis(),
                    BetweenFormatter.Level.SECOND));

            // 流程定义
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(historicTaskInstance.getProcessDefinitionId())
                    .singleResult();
            doneTask.setProcessDefinitionName(processDefinition.getName());

            // 流程发起人
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(historicTaskInstance.getProcessInstanceId())
                    .singleResult();
            SysUser user = userService.getByUsername(historicProcessInstance.getStartUserId());
            doneTask.setStartUsername(user.getUsername());
            doneTask.setStartName(user.getName());

            doneTasks.add(doneTask);
        }

        page.setRecords(doneTasks);
        return page;
    }

    @Override
    public void revoke(String taskId, String processInstanceId) {
        // 判断流程是否已结束
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .active()
                .singleResult();
        if (Objects.isNull(processInstance)) {
            throw new BizException("流程已结束或挂起，无法撤回");
        }

        // 任务实例
        HistoricTaskInstance historicTaskInstance = historyService.createHistoricTaskInstanceQuery()
                .taskId(taskId)
                .taskAssignee(SecurityUtils.getUserName())
                .singleResult();
        if (Objects.isNull(historicTaskInstance)) {
            throw new BizException("任务不存在");
        }
        BpmnModel bpmnModel = repositoryService.getBpmnModel(historicTaskInstance.getProcessDefinitionId());
        UserTask userTask = FlowableUtil.getUserTaskByKey(bpmnModel, historicTaskInstance.getTaskDefinitionKey());
        List<UserTask> nextUserTasks = FlowableUtil.getNextUserTasks(userTask);
        List<String> nextUserTaskIds = nextUserTasks.stream().map(UserTask::getId).collect(Collectors.toList());
        List<HistoricTaskInstance> finishedTaskInstances = historyService.createHistoricTaskInstanceQuery()
                .processInstanceId(processInstanceId)
                .taskCreatedAfter(historicTaskInstance.getEndTime())
                .finished()
                .list();
        for (HistoricTaskInstance finishedTaskInstance : finishedTaskInstances) {
            if (CollUtil.contains(nextUserTaskIds, finishedTaskInstance.getTaskDefinitionKey())) {
                throw new BizException("下一流程已处理，无法撤回");
            }
        }
        List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstanceId).list();
        ArrayList<String> revokeExecutionIds = new ArrayList<>();
        SysUser user = userService.getByUsername(SecurityUtils.getUserName());
        for (Task task : tasks) {
            if (CollUtil.contains(nextUserTaskIds, task.getTaskDefinitionKey())) {
                taskService.setAssignee(task.getId(), SecurityUtils.getUserName());
                taskService.addComment(task.getId(), task.getProcessInstanceId(), CommentEnum.REVOKE.getCode(),
                        user.getName() + "撤回流程");
                revokeExecutionIds.add(task.getExecutionId());
            }
        }
        try {
            runtimeService.createChangeActivityStateBuilder()
                    .processInstanceId(processInstanceId)
                    .moveExecutionsToSingleActivityId(revokeExecutionIds, historicTaskInstance.getTaskDefinitionKey())
                    .changeState();
        } catch (FlowableObjectNotFoundException e) {
            throw new BizException("未找到流程实例，流程可能已发生变化");
        }
    }

    @Override
    public void setNextAssignees(String processInstanceId, List<String> nextAssignees) {
        if (!nextAssignees.isEmpty()) {
            List<Task> instanceTasks = taskService.createTaskQuery()
                    .processInstanceId(processInstanceId)
                    .list();
            if (instanceTasks.isEmpty()) {
                return;
            }
            instanceTasks.forEach(instanceTask -> {
                for (String candidate : nextAssignees) {
                    taskService.addCandidateUser(instanceTask.getId(), candidate);
                }
            });
        }
    }

    @Override
    public IPage<CopyVO> listCopies(TaskQuery taskQuery) {
        LambdaQueryWrapper<ActHiCopy> wrapper = Wrappers.lambdaQuery(ActHiCopy.class)
                .like(StringUtils.hasText(taskQuery.getProcessDefinitionName()), ActHiCopy::getProcessDefinitionName,
                        taskQuery.getProcessDefinitionName())
                .eq(ActHiCopy::getCopyUser, SecurityUtils.getUserName());

        if (Objects.nonNull(taskQuery.getDateRange())) {
            if (taskQuery.getDateRange().length != DATE_RANGE_LENGTH) {
                throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR,
                        "如果需要按时间搜索，请指定开始时间和结束时间");
            }
            wrapper.ge(ActHiCopy::getCreateTime, taskQuery.getDateRange()[0])
                    .le(ActHiCopy::getCreateTime, taskQuery.getDateRange()[1]);
        }

        IPage<ActHiCopy> page = processCopyService.page(taskQuery.page(), wrapper);
        PiPage<CopyVO> result = processTaskConverter.copyToCopyVo(page);

        result.getRecords().forEach(record -> {
            SysUser user = userService.getByUsername(record.getCreateBy());
            record.setCreateName(user.getName());
        });

        return result;
    }

    private void setCopyUsers(Task task, String processInstanceId, List<String> copyUsers) {
        if (!copyUsers.isEmpty()) {
            // 历史流程实例
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(processInstanceId).singleResult();
            ArrayList<ActHiCopy> copies = new ArrayList<>();
            for (String copyUser : copyUsers) {
                ActHiCopy copy = new ActHiCopy();
                copy.setName(historicProcessInstance.getProcessDefinitionName() + "-" + task.getName());
                copy.setProcessDefinitionId(historicProcessInstance.getProcessDefinitionId());
                copy.setProcessDefinitionName(historicProcessInstance.getProcessDefinitionName());
                copy.setProcessInstanceId(processInstanceId);
                copy.setCopyUser(copyUser);

                copies.add(copy);
            }
            processCopyService.saveBatch(copies);
        }
    }

    private Map<String, Object> getProcessVars(String id) {
        HistoricTaskInstance historicTaskInstance = historyService.createHistoricTaskInstanceQuery()
                .includeProcessVariables()
                .finished()
                .taskId(id)
                .singleResult();
        if (Objects.nonNull(historicTaskInstance)) {
            return historicTaskInstance.getProcessVariables();
        }
        return taskService.getVariables(id);
    }

    private List<String> getCandidateGroup() {
        String userName = SecurityUtils.getUserName();
        List<SysRole> roles = roleService.listByUserName(userName);
        SysUser user = userService.getByUsername(userName);

        ArrayList<String> list = new ArrayList<>();

        if (!roles.isEmpty()) {
            roles.forEach(role -> list.add(FlowableConstants.ROLE_CANDIDATE_GROUP_PREFIX + role.getId()));
        }
        if (Objects.nonNull(user)) {
            list.add(FlowableConstants.DEPT_CANDIDATE_GROUP_PREFIX + user.getDeptId());
        }

        return list;
    }
}
