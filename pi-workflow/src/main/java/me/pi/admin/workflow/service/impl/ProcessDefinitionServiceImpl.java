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

import cn.hutool.core.io.IORuntimeException;
import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.util.SecurityUtils;
import me.pi.admin.workflow.converter.ProcessFormConverter;
import me.pi.admin.workflow.pojo.vo.FormVO;
import me.pi.admin.workflow.pojo.vo.ProcessDefinitionVO;
import me.pi.admin.workflow.converter.ProcessDefinitionConverter;
import me.pi.admin.workflow.pojo.query.BootableDefinitionQuery;
import me.pi.admin.workflow.pojo.query.ProcessDefQuery;
import me.pi.admin.workflow.service.ProcessDefinitionService;
import me.pi.admin.workflow.service.ProcessFormService;
import me.pi.admin.workflow.util.FlowableUtil;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.StartEvent;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.impl.ProcessDefinitionQueryProperty;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.repository.ProcessDefinitionQuery;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.InputStream;
import java.util.List;
import java.util.Objects;

/**
 * @author ZnPi
 * @since 2023-03-23
 */
@Service
@RequiredArgsConstructor
public class ProcessDefinitionServiceImpl implements ProcessDefinitionService {
    private final RepositoryService repositoryService;
    private final ProcessFormService processFormService;
    private final ProcessDefinitionConverter processDefinitionConverter;
    private final ProcessFormConverter processFormConverter;

    @Override
    public IPage<ProcessDefinitionVO> listProcessDefinitions(ProcessDefQuery processDefQuery) {
        IPage<ProcessDefinition> processDefinitionPage = getPageProcessDefinition(processDefQuery);
        return processDefinitionConverter.pageToVoPage(processDefinitionPage);
    }

    @Override
    public IPage<ProcessDefinition> getPageProcessDefinition(ProcessDefQuery processDefQuery) {
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery();
        buildQuery(processDefinitionQuery, processDefQuery);
        long total = processDefinitionQuery.count();
        IPage<ProcessDefinition> page = processDefQuery.page();
        page.setTotal(total);
        if (total <= 0) {
            return page;
        }
        int offset = processDefQuery.getPageSize() * (processDefQuery.getPageNum() - 1);
        List<ProcessDefinition> processDefinitionList = processDefinitionQuery
                .listPage(offset, processDefQuery.getPageSize());
        page.setRecords(processDefinitionList);
        return page;
    }

    @Override
    public IPage<ProcessDefinitionVO> getBootableDefinition(BootableDefinitionQuery bootableDefinitionQuery) {
        ProcessDefQuery processDefQuery = processDefinitionConverter
                .toStartProcessDefinitionQueryToProcessDefQuery(bootableDefinitionQuery);
        // 激活
        processDefQuery.setSuspended(false);
        // 最新版本
        processDefQuery.setLatestVersion(true);

        IPage<ProcessDefinition> processDefinition = getPageProcessDefinition(processDefQuery);
        return processDefinitionConverter.pageToVoPage(processDefinition);
    }

    @Override
    public FormVO getProcessDefinitionForm(String definitionId) {
        BpmnModel bpmnModel = repositoryService.getBpmnModel(definitionId);
        if (Objects.isNull(bpmnModel)) {
            throw new BizException("bpmn 模型不存在");
        }

        StartEvent startEvent = FlowableUtil.getStartEvent(bpmnModel);
        return processFormConverter.poToVo(processFormService.getById(startEvent.getFormKey()));
    }

    @Override
    public String getBpmnXml(String processDefinitionId) {
        InputStream processModel = repositoryService.getProcessModel(processDefinitionId);
        try{
            return IoUtil.readUtf8(processModel);
        }catch (IORuntimeException e) {
            throw new BizException("获取 xml 文件失败：" + e.getMessage());
        }
    }

    @Override
    public void changeState(String definitionId, Boolean suspended) {
        if (suspended) {
            repositoryService.suspendProcessDefinitionById(definitionId, true, null);
        } else {
            repositoryService.activateProcessDefinitionById(definitionId, true, null);
        }
    }

    @Override
    public IPage<ProcessDefinitionVO> listHistoryProcessDefinitions(ProcessDefQuery processDefQuery) {
        // 版本倒叙
        processDefQuery.setOrderByColumns(ProcessDefinitionQueryProperty.PROCESS_DEFINITION_VERSION.getName());
        processDefQuery.setOrderings("desc");

        IPage<ProcessDefinition> processDefinitionPage = getPageProcessDefinition(processDefQuery);
        return processDefinitionConverter.pageToVoPage(processDefinitionPage);
    }

    private void buildQuery(ProcessDefinitionQuery processDefinitionQuery,
                            ProcessDefQuery procDefQuery) {
        processDefinitionQuery.processDefinitionTenantId(SecurityUtils.getTenantId());

        if (StringUtils.hasText(procDefQuery.getOrderByColumns())
                && StringUtils.hasText(procDefQuery.getOrderings())) {
            String[] orderByColumnArr = procDefQuery.getOrderByColumns().split(",");
            String[] orderingArr = procDefQuery.getOrderings().split(",");
            if (orderingArr.length != 1 && orderingArr.length != orderByColumnArr.length) {
                throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "排序规则不符合要求");
            }
            for (int i = 0; i < orderByColumnArr.length; i++) {
                String orderByColumn = orderByColumnArr[i];
                String ordering = orderingArr.length == 1 ? orderingArr[0] : orderingArr[i];
                if ("asc".equals(ordering)) {
                    processDefinitionQuery.orderBy(ProcessDefinitionQueryProperty.findByName(orderByColumn))
                            .asc();
                } else if ("desc".equals(ordering)) {
                    processDefinitionQuery.orderBy(ProcessDefinitionQueryProperty.findByName(orderByColumn)).desc();
                } else {
                    throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "排序参数错误，可选：asc/desc");
                }
            }
        }

        if (StringUtils.hasText(procDefQuery.getKey())) {
            processDefinitionQuery.processDefinitionKeyLike("%" + procDefQuery.getKey() + "%");
        }
        if (StringUtils.hasText(procDefQuery.getName())) {
            processDefinitionQuery.processDefinitionNameLike("%" + procDefQuery.getName() + "%");
        }
        if (StringUtils.hasText(procDefQuery.getCategory())) {
            processDefinitionQuery.processDefinitionCategoryLike("%" + procDefQuery.getCategory() + "%");
        }
        if (StringUtils.hasText(procDefQuery.getDeploymentId())) {
            processDefinitionQuery.deploymentId(procDefQuery.getDeploymentId());
        }
        if (procDefQuery.getSuspended() != null) {
            if (procDefQuery.getSuspended()) {
                processDefinitionQuery.suspended();
            } else {
                processDefinitionQuery.active();
            }
        }
        if (procDefQuery.getLatestVersion() != null) {
            if (procDefQuery.getLatestVersion()) {
                processDefinitionQuery.latestVersion();
            }
        }
    }
}
