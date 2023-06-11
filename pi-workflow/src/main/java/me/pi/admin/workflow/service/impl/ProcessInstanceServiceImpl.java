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
import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.util.SecurityUtils;
import me.pi.admin.core.system.service.DeptService;
import me.pi.admin.core.system.service.RoleService;
import me.pi.admin.core.system.service.UserService;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.common.util.DateUtil;
import me.pi.admin.core.system.pojo.po.SysDept;
import me.pi.admin.core.system.pojo.po.SysRole;
import me.pi.admin.core.system.pojo.po.SysUser;
import me.pi.admin.workflow.converter.ProcessDefinitionConverter;
import me.pi.admin.workflow.pojo.dto.ViewerElementDTO;
import me.pi.admin.workflow.pojo.po.ActReForm;
import me.pi.admin.workflow.service.ProcessFormService;
import me.pi.admin.workflow.constant.FlowableConstants;
import me.pi.admin.workflow.pojo.vo.ProcessFormVO;
import me.pi.admin.workflow.pojo.dto.ProcessInstanceLogDTO;
import me.pi.admin.workflow.pojo.query.MyProcessQuery;
import me.pi.admin.workflow.pojo.vo.MyProcessInstanceVO;
import me.pi.admin.workflow.pojo.vo.ProcessInstanceDetailVO;
import me.pi.admin.workflow.service.ProcessInstanceService;
import me.pi.admin.workflow.service.ProcessTaskService;
import me.pi.admin.workflow.util.FlowableUtil;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.model.*;
import org.flowable.bpmn.model.Process;
import org.flowable.common.engine.impl.identity.Authentication;
import org.flowable.engine.*;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.history.HistoricProcessInstanceQuery;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.engine.task.Comment;
import org.flowable.identitylink.api.history.HistoricIdentityLink;
import org.flowable.task.api.Task;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @date 2023-04-19
 */
@Service
@RequiredArgsConstructor
public class ProcessInstanceServiceImpl implements ProcessInstanceService {
    /**
     * 历史活动实例数排序条件
     */
    private static final int HISTORIC_ACTIVITY_INST_COUNT_SORT_CONDITION = 2;
    private final RepositoryService repositoryService;
    private final HistoryService historyService;
    private final TaskService taskService;
    private final IdentityService identityService;
    private final RuntimeService runtimeService;
    private final ProcessFormService processFormService;
    private final UserService userService;
    private final RoleService roleService;
    private final DeptService deptService;
    private final ProcessTaskService processTaskService;
    private final ProcessDefinitionConverter processDefinitionConverter;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startProcessInstance(String processDefinitionId, Map<String, Object> variables) {
        // 查询流程定义
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionTenantId(SecurityUtils.getTenantId())
                .processDefinitionId(processDefinitionId)
                .singleResult();
        if (Objects.isNull(processDefinition)) {
            throw new BizException("流程定义不存在");
        }

        // 判断流程是否已挂起
        if (processDefinition.isSuspended()) {
            throw new BizException("流程已挂起");
        }

        // 设置流程发起人
        String userName = SecurityUtils.getUserName();
        identityService.setAuthenticatedUserId(SecurityUtils.getUserName());
        variables.put(BpmnXMLConstants.ATTRIBUTE_EVENT_START_INITIATOR, userName);

        // 发起流程实例
        ProcessInstance processInstance = runtimeService.startProcessInstanceById(processDefinitionId, variables);

        // 设置下一个任务审批人
        if (!variables.containsKey(FlowableConstants.APPROVE_CANDIDATES)) {
            return;
        }
        List<String> candidates = Arrays.asList(variables
                .get(FlowableConstants.APPROVE_CANDIDATES).toString().split(","));
        processTaskService.setNextAssignees(processInstance.getProcessInstanceId(), candidates);
    }

    @Override
    public IPage<MyProcessInstanceVO> getMyProcesses(MyProcessQuery myProcessQuery) {
        IPage<HistoricProcessInstance> historicProcessInstancePage = getHistoricProcessInstance(myProcessQuery);
        List<HistoricProcessInstance> historicProcessInstances = historicProcessInstancePage.getRecords();

        PiPage<MyProcessInstanceVO> page = new PiPage<>();
        if (historicProcessInstancePage.getTotal() == 0) {
            page.setTotal(0);
            return page;
        }

        List<String> deploymentIds = historicProcessInstances.stream()
                .map(HistoricProcessInstance::getDeploymentId).collect(Collectors.toList());
        List<String> historicProcessInstanceIds = historicProcessInstances.stream()
                .map(HistoricProcessInstance::getId).collect(Collectors.toList());

        List<Deployment> deployments = repositoryService.createDeploymentQuery().deploymentIds(deploymentIds).list();
        List<Task> tasks = taskService.createTaskQuery().processInstanceIdIn(historicProcessInstanceIds).list();

        ArrayList<MyProcessInstanceVO> myProcessInstanceVos = new ArrayList<>();
        historicProcessInstances.forEach(record -> {
            MyProcessInstanceVO myProcess = processDefinitionConverter.historicProcessInstanceToMyProcessVo(record);
            // 耗时
            if (Objects.nonNull(record.getEndTime())) {
                myProcess.setDuration(DateUtil.getDayToMinDuration(DateUtil.dateToLocalDateTime(record.getStartTime()),
                        DateUtil.dateToLocalDateTime(record.getEndTime())));
            } else {
                myProcess.setDuration(DateUtil.getDayToMinDuration(DateUtil.dateToLocalDateTime(record.getStartTime()),
                        LocalDateTime.now()));
            }

            // 类别
            deployments.stream().filter(deployment -> deployment.getId().equals(record.getDeploymentId())).findFirst()
                    .ifPresent(deployment -> myProcess.setProcessCategory(deployment.getCategory()));

            List<Task> targetTasks = tasks.stream().filter(task -> task.getProcessInstanceId().equals(record.getId()))
                    .collect(Collectors.toList());
            if (targetTasks.size() > 0) {
                // 当前节点
                String currentNode = targetTasks.stream()
                        .map(Task::getName)
                        .filter(StringUtils::hasText)
                        .collect(Collectors.joining(","));
                myProcess.setCurrentNode(currentNode);
                // 任务 ID
                myProcess.setTaskId(targetTasks.get(0).getId());
            }
            myProcessInstanceVos.add(myProcess);
        });

        page.setRecords(myProcessInstanceVos);
        page.setTotal(historicProcessInstancePage.getTotal());

        return page;
    }

    @Override
    public ProcessInstanceDetailVO getProcessInstanceDetail(String processInstanceId) {
        ProcessInstanceDetailVO processInstanceDetail = new ProcessInstanceDetailVO();

        // 流程实例
        HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                .processInstanceTenantId(SecurityUtils.getTenantId())
                .processInstanceId(processInstanceId)
                .includeProcessVariables()
                .singleResult();

        if (Objects.isNull(historicProcessInstance)) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "流程实例不存在");
        }

        // 获取 bpmn 模型
        String bpmnXml = getBpmnXml(historicProcessInstance);
        processInstanceDetail.setBpmnXml(bpmnXml);

        BpmnModel bpmnModel = FlowableUtil.getBpmnModel(bpmnXml);

        // 获取流程实例表单
        processInstanceDetail.setForms(getProcessInstanceForms(historicProcessInstance, bpmnModel));
        // 获取日志
        processInstanceDetail.setLogs(getProcessInstanceLogs(historicProcessInstance));

        // 查看器节点
        processInstanceDetail.setViewerElement(getViewerElement(processInstanceId, bpmnModel));

        return processInstanceDetail;
    }

    @Override
    public void delete(String processInstanceId) {
        HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();
        if (Objects.isNull(historicProcessInstance)) {
            throw new BizException("流程实例不存在");
        }
        if (Objects.nonNull(historicProcessInstance.getEndTime())) {
            historyService.deleteHistoricProcessInstance(historicProcessInstance.getId());
            return;
        }
        runtimeService.deleteProcessInstance(processInstanceId, "");
        historyService.deleteHistoricProcessInstance(processInstanceId);
    }

    @Override
    public void cancel(String processInstanceId) {
        List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstanceId).list();
        if (tasks.isEmpty()) {
            throw new BizException("流程未启动或已完成");
        }
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstance.getProcessDefinitionId());
        if (Objects.nonNull(bpmnModel)) {
            Process mainProcess = bpmnModel.getMainProcess();
            List<EndEvent> endEvents = mainProcess.findFlowElementsOfType(EndEvent.class, false);
            if (!endEvents.isEmpty()) {
                Authentication.setAuthenticatedUserId(SecurityUtils.getUserName());
                String id = endEvents.get(0).getId();
                List<Execution> executions = runtimeService.createExecutionQuery()
                        .parentId(processInstance.getProcessInstanceId()).list();
                List<String> executionIds = executions.stream().map(Execution::getId).collect(Collectors.toList());
                runtimeService.createChangeActivityStateBuilder()
                        .moveExecutionsToSingleActivityId(executionIds, id).changeState();
            }
        }
    }

    private String getBpmnXml(HistoricProcessInstance historicProcessInstance) {
        InputStream inputStream = repositoryService.getProcessModel(historicProcessInstance.getProcessDefinitionId());
        return IoUtil.readUtf8(inputStream);
    }

    private ArrayList<ProcessFormVO> getProcessInstanceForms(HistoricProcessInstance historicProcessInstance,
                                                             BpmnModel bpmnModel) {
        ArrayList<ProcessFormVO> processForms = new ArrayList<>();
        // 历史 Activity 实例
        List<HistoricActivityInstance> historicActivityInstances = historyService.createHistoricActivityInstanceQuery()
                .processInstanceId(historicProcessInstance.getId())
                .finished()
                .activityTypes(CollUtil.newHashSet(BpmnXMLConstants.ELEMENT_EVENT_START,
                        BpmnXMLConstants.ELEMENT_TASK_USER))
                .orderByHistoricActivityInstanceStartTime().asc()
                .list();

        for (HistoricActivityInstance historicActivityInstance : historicActivityInstances) {
            ProcessFormVO processForm = new ProcessFormVO();

            // 流程元素
            FlowElement flowElement = FlowableUtil.getFlowElementById(bpmnModel,
                    historicActivityInstance.getActivityId());

            // 表单 ID
            String formKey = FlowableUtil.getFormKey(flowElement);
            if (!StringUtils.hasText(formKey)) {
                continue;
            }
            processForm.setId(Long.valueOf(formKey));
            processForm.setFormData(historicProcessInstance.getProcessVariables());

            processForms.add(processForm);
        }

        // 获取所有表单 ID
        List<Long> formIds = processForms.stream()
                .map(ProcessFormVO::getId).collect(Collectors.toList());
        // 查询表单信息
        List<ActReForm> forms = processFormService.getByIds(formIds);

        for (ProcessFormVO processInstanceForm : processForms) {
            Optional<ActReForm> actReForm = forms.stream()
                    .filter(form -> form.getId().equals(processInstanceForm.getId())).findFirst();
            actReForm.ifPresent(item -> {
                processInstanceForm.setName(item.getName());
                processInstanceForm.setBuiltIn(item.getBuiltIn());
                if (item.getBuiltIn() == 1) {
                    processInstanceForm.setComponentPath(item.getComponentPath());
                }
            });
        }
        return processForms;
    }

    private ViewerElementDTO getViewerElement(String processInstanceId, BpmnModel bpmnModel) {
        ViewerElementDTO viewerElement = new ViewerElementDTO();

        List<HistoricActivityInstance> historicActivityInstances = historyService.createHistoricActivityInstanceQuery()
                .activityTenantId(SecurityUtils.getTenantId())
                .processInstanceId(processInstanceId).list();
        if (historicActivityInstances.isEmpty()) {
            return viewerElement;
        }
        // 已完成活动
        List<HistoricActivityInstance> finishedHistoricActivityInstances = historicActivityInstances.stream()
                .filter(historicActivityInstance -> Objects.nonNull(historicActivityInstance.getEndTime()))
                .collect(Collectors.toList());

        // 已完成序列流
        HashSet<String> finishedSequenceFlows = new HashSet<>();
        // 已完成任务
        HashSet<String> finishedTasks = new HashSet<>();

        for (HistoricActivityInstance finishedHistoricActivityInstance : finishedHistoricActivityInstances) {
            if (BpmnXMLConstants.ELEMENT_SEQUENCE_FLOW.equals(finishedHistoricActivityInstance.getActivityType())) {
                finishedSequenceFlows.add(finishedHistoricActivityInstance.getActivityId());
            } else {
                finishedTasks.add(finishedHistoricActivityInstance.getActivityId());
            }
        }

        // 未完成活动
        Set<String> todoTasks = historicActivityInstances.stream()
                .filter(historicActivityInstance -> Objects.isNull(historicActivityInstance.getEndTime()))
                .map(HistoricActivityInstance::getActivityId)
                .collect(Collectors.toSet());

        ArrayList<FlowElement> allElements = new ArrayList<>();
        FlowableUtil.getAllElements(bpmnModel.getMainProcess().getFlowElements(), allElements);

        // 已拒绝活动
        HashSet<String> rejectedTasks = new HashSet<>();
        for (FlowElement flowElement : allElements) {
            if (flowElement instanceof UserTask && todoTasks.contains(flowElement.getId())) {
                List<String> parentElements = FlowableUtil.getParentElements(flowElement);
                ArrayList<String> rejectedElements = new ArrayList<>();
                getRejectedElements(flowElement, finishedSequenceFlows,
                        finishedTasks, parentElements, rejectedElements);
                rejectedTasks.addAll(rejectedElements);
            }
        }

        viewerElement.setFinishedTasks(finishedTasks);
        viewerElement.setFinishedSequenceFlows(finishedSequenceFlows);
        viewerElement.setTodoTasks(todoTasks);
        viewerElement.setRejectedTasks(rejectedTasks);

        return viewerElement;
    }


    private void getRejectedElements(FlowElement target, HashSet<String> finishedSequenceFlows,
                                     HashSet<String> finishedTasks, List<String> finishedSequenceFlowIds,
                                     ArrayList<String> rejectedElements) {
        finishedSequenceFlowIds = finishedSequenceFlowIds == null ? new ArrayList<>() : finishedSequenceFlowIds;

        // 获取出口连线
        List<SequenceFlow> sequenceFlows = FlowableUtil.getOutgoingFlows(target);

        if (sequenceFlows != null) {
            for (SequenceFlow sequenceFlow : sequenceFlows) {
                // 如果发现连线重复，说明循环了，跳过这个循环
                if (finishedSequenceFlowIds.contains(sequenceFlow.getId())) {
                    continue;
                }
                finishedSequenceFlowIds.add(sequenceFlow.getId());
                FlowElement targetElement = sequenceFlow.getTargetFlowElement();
                // 添加未完成的元素
                if (finishedTasks.contains(targetElement.getId())) {
                    rejectedElements.add(targetElement.getId());
                }
                // 添加未完成的连线
                if (finishedSequenceFlows.contains(sequenceFlow.getId())) {
                    rejectedElements.add(sequenceFlow.getId());
                }
                if (targetElement instanceof SubProcess) {
                    FlowElement firstElement = (FlowElement) (((SubProcess) targetElement).getFlowElements().toArray()[0]);
                    getRejectedElements(firstElement, finishedSequenceFlows, finishedTasks,
                            finishedSequenceFlowIds, rejectedElements);
                }
                getRejectedElements(targetElement, finishedSequenceFlows, finishedTasks, finishedSequenceFlowIds,
                        rejectedElements);
            }
        }
    }

    private List<ProcessInstanceLogDTO> getProcessInstanceLogs(HistoricProcessInstance historicProcessInstance) {
        // 历史 Activity 实例
        List<HistoricActivityInstance> historicActivityInstances = historyService.createHistoricActivityInstanceQuery()
                .activityTenantId(SecurityUtils.getTenantId())
                .processInstanceId(historicProcessInstance.getId())
                .activityTypes(CollUtil.newHashSet(BpmnXMLConstants.ELEMENT_EVENT_START,
                        BpmnXMLConstants.ELEMENT_EVENT_END,
                        BpmnXMLConstants.ELEMENT_TASK_USER))
                .orderByHistoricActivityInstanceStartTime().desc()
                .orderByHistoricActivityInstanceEndTime().desc()
                .list();

        if (historicActivityInstances.isEmpty()) {
            return Collections.emptyList();
        }

        // 当流程活动实例数为 2 且两个流程活动实例开始时间相同时，重新排序保证结束时间为 Null 的在前面
        sortHistoricActivityInstances(historicActivityInstances);

        List<Comment> comments = taskService.getProcessInstanceComments(historicProcessInstance.getId());

        ArrayList<ProcessInstanceLogDTO> processInstanceLogs = new ArrayList<>();
        for (HistoricActivityInstance historicActivityInstance : historicActivityInstances) {
            ProcessInstanceLogDTO processInstanceLog =
                    processDefinitionConverter.historicProcessInstanceToProcessInstanceLogDTO(historicActivityInstance);

            if (Objects.nonNull(historicActivityInstance.getDurationInMillis())) {
                processInstanceLog.setDuration(DateUtil.formatBetween(historicActivityInstance.getDurationInMillis(),
                        BetweenFormatter.Level.SECOND));
            }
            if (BpmnXMLConstants.ELEMENT_EVENT_START.equals(historicActivityInstance.getActivityType())) {
                String username = historicProcessInstance.getStartUserId();
                if (StringUtils.hasText(username)) {
                    SysUser user = userService.getByUsername(username);
                    if (Objects.nonNull(user)) {
                        processInstanceLog.setAssigneeName(user.getName());
                    }
                }

            } else if (BpmnXMLConstants.ELEMENT_TASK_USER.equals(historicActivityInstance.getActivityType())) {
                String username = historicActivityInstance.getAssignee();
                if (StringUtils.hasText(username)) {
                    SysUser user = userService.getByUsername(username);
                    processInstanceLog.setAssigneeName(user.getName());
                }

                List<HistoricIdentityLink> historicIdentityLinksForTask =
                        historyService.getHistoricIdentityLinksForTask(historicActivityInstance.getTaskId());
                StringBuilder candidates = new StringBuilder();
                for (HistoricIdentityLink historicIdentityLink : historicIdentityLinksForTask) {
                    if ("candidate".equals(historicIdentityLink.getType())) {
                        username = historicIdentityLink.getUserId();
                        if (StringUtils.hasText(username)) {
                            SysUser user = userService.getByUsername(username);
                            candidates.append(user.getName()).append(",");
                        }
                    }
                    String groupId = historicIdentityLink.getGroupId();
                    if (StringUtils.hasText(groupId)) {
                        if (groupId.startsWith(FlowableConstants.ROLE_CANDIDATE_GROUP_PREFIX)) {
                            Long roleId = Long.parseLong(org.apache.commons.lang3.StringUtils
                                    .stripStart(historicIdentityLink.getGroupId(),
                                            FlowableConstants.ROLE_CANDIDATE_GROUP_PREFIX));
                            SysRole role = roleService.getById(roleId);
                            candidates.append(role.getName()).append(",");
                        } else if (groupId.startsWith(FlowableConstants.DEPT_CANDIDATE_GROUP_PREFIX)) {
                            long deptId = Long.parseLong(org.apache.commons.lang3.StringUtils
                                    .stripStart(historicIdentityLink.getGroupId(),
                                            FlowableConstants.DEPT_CANDIDATE_GROUP_PREFIX));
                            SysDept dept = deptService.getById(deptId);
                            candidates.append(dept.getName()).append(",");
                        }
                    }
                }
                if (StringUtils.hasText(candidates)) {
                    processInstanceLog.setCandidate(candidates.substring(0, candidates.length() - 1));
                }

                // 获取意见评论内容
                if (!comments.isEmpty()) {
                    List<Comment> target = comments.stream().filter(comment ->
                                    comment.getTaskId().equals(historicActivityInstance.getTaskId()))
                            .collect(Collectors.toList());
                    processInstanceLog.setComments(target);
                }
            }

            processInstanceLogs.add(processInstanceLog);
        }
        return processInstanceLogs;
    }

    /**
     * 当流程活动实例数为 2 且两个流程活动实例开始时间相同时，重新排序保证结束时间为 Null 的在前面
     *
     * @param historicActivityInstances 历史活动实例
     */
    private static void sortHistoricActivityInstances(List<HistoricActivityInstance> historicActivityInstances) {
        if (historicActivityInstances.size() == HISTORIC_ACTIVITY_INST_COUNT_SORT_CONDITION &&
                historicActivityInstances.get(0).getStartTime()
                        .equals(historicActivityInstances.get(1).getStartTime())) {

            historicActivityInstances.sort((o1, o2) -> {
                if (Objects.isNull(o1.getEndTime())) {
                    return -1;
                } else if (Objects.isNull(o2.getEndTime())) {
                    return 1;
                }
                return 0;
            });
        }
    }

    private IPage<HistoricProcessInstance> getHistoricProcessInstance(MyProcessQuery myProcessQuery) {
        IPage<HistoricProcessInstance> page = myProcessQuery.page();
        HistoricProcessInstanceQuery instanceQuery = historyService.createHistoricProcessInstanceQuery()
                .processInstanceTenantId(SecurityUtils.getTenantId())
                .startedBy(SecurityUtils.getUserName())
                .orderByProcessInstanceStartTime().desc();
        long count = instanceQuery.count();
        if (count <= 0) {
            return page;
        }
        page.setTotal(count);
        int offset = myProcessQuery.getPageSize() * (myProcessQuery.getPageNum() - 1);
        List<HistoricProcessInstance> historicProcessInstances =
                instanceQuery.listPage(offset, myProcessQuery.getPageSize());
        page.setRecords(historicProcessInstances);
        return page;
    }
}
