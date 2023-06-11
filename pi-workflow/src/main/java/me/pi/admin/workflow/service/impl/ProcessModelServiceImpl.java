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

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.util.SecurityUtils;
import me.pi.admin.workflow.constant.FlowableConstants;
import me.pi.admin.workflow.mapper.ProcessModelMapper;
import me.pi.admin.workflow.pojo.dto.ProcessModelDTO;
import me.pi.admin.workflow.pojo.dto.ProcessModelMetaInfoDTO;
import me.pi.admin.workflow.pojo.dto.SaveModelDesignDTO;
import me.pi.admin.workflow.pojo.query.ProcessModelQuery;
import me.pi.admin.workflow.service.ProcessModelService;
import me.pi.admin.workflow.util.FlowableUtil;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.Model;
import org.flowable.engine.repository.ModelQuery;
import org.flowable.engine.repository.ProcessDefinition;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;
import java.util.*;

/**
 * @author ZnPi
 * @date 2023-04-03
 */
@Service
@RequiredArgsConstructor
public class ProcessModelServiceImpl implements ProcessModelService {
    private final RepositoryService repositoryService;
    private final ProcessModelMapper processModelMapper;

    @Override
    public IPage<Model> listModels(ProcessModelQuery processModelQuery) {
        ModelQuery modelQuery = repositoryService
                .createModelQuery()
                .modelTenantId(SecurityUtils.getTenantId())
                .latestVersion()
                .orderByCreateTime()
                .desc();
        if (StrUtil.isNotEmpty(processModelQuery.getKey())) {
            modelQuery.modelKey(processModelQuery.getKey());
        }
        if (StrUtil.isNotEmpty(processModelQuery.getName())) {
            modelQuery.modelNameLike("%" + processModelQuery.getName() + "%");
        }
        if (StrUtil.isNotEmpty(processModelQuery.getCategory())) {
            modelQuery.modelCategory(processModelQuery.getCategory());
        }
        IPage<Model> page = processModelQuery.page();
        long count = modelQuery.count();
        page.setTotal(count);
        if (count <= 0) {
            return page;
        }

        int offset = processModelQuery.getPageSize() * (processModelQuery.getPageNum() - 1);
        List<Model> modelList = modelQuery.listPage(offset, processModelQuery.getPageSize());
        page.setRecords(modelList);
        return page;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveModel(ProcessModelDTO processModelDto) {
        Model model = repositoryService.newModel();
        model.setKey(processModelDto.getKey());
        model.setName(processModelDto.getName());
        model.setTenantId(SecurityUtils.getTenantId());
        model.setCategory(processModelDto.getCategory());
        model.setMetaInfo(JSON.toJSONString(processModelDto.getMetaInfo()));
        repositoryService.saveModel(model);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateModel(ProcessModelDTO processModelDto) {
        Model model = repositoryService.getModel(processModelDto.getId());
        if (Objects.isNull(model)) {
            throw new BizException("流程模型不存在");
        }
        model.setName(processModelDto.getName());
        model.setCategory(processModelDto.getCategory());
        ProcessModelMetaInfoDTO processModelMetaInfo =
                JSON.parseObject(model.getMetaInfo(), ProcessModelMetaInfoDTO.class);
        processModelMetaInfo.setDescription(processModelDto.getMetaInfo().getDescription());
        model.setMetaInfo(JSON.toJSONString(processModelMetaInfo));
        repositoryService.saveModel(model);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteModels(Collection<String> modelIds) {
        if(modelIds.isEmpty()) {
            throw new BizException("待删除 id 列表不能为空");
        }
        if (!(modelIds instanceof Set)) {
            modelIds = new HashSet<>(modelIds);
        }
        modelIds.forEach(repositoryService::deleteModel);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveModelDesign(SaveModelDesignDTO saveModelDesignDto) {
        Model model = repositoryService.getModel(saveModelDesignDto.getId());
        if (Objects.isNull(model)) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "流程模型不存在");
        }

        BpmnModel bpmnModel = FlowableUtil.getBpmnModel(saveModelDesignDto.getBpmnXml());
        if (Objects.isNull(bpmnModel)) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "解析 xml 失败");
        }

        if (Boolean.TRUE.equals(saveModelDesignDto.getNewVersion())) {
            Model newModel = repositoryService.newModel();
            newModel.setName(model.getName());
            newModel.setKey(model.getKey());
            newModel.setTenantId(model.getTenantId());
            newModel.setCategory(model.getCategory());
            newModel.setMetaInfo(model.getMetaInfo());
            newModel.setVersion(model.getVersion() + 1);
            repositoryService.saveModel(newModel);
            model = newModel;
        }
        byte[] bytes = StringUtils.getBytes(saveModelDesignDto.getBpmnXml(), StandardCharsets.UTF_8);
        repositoryService.addModelEditorSource(model.getId(), bytes);
    }

    @Override
    public String getBpmnXmlById(String modelId) {
        return StrUtil.utf8Str(repositoryService.getModelEditorSource(modelId));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deployModel(String modelId) {
        Model model = repositoryService.getModel(modelId);
        if (Objects.isNull(model)) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "流程模型不存在");
        }
        byte[] modelEditorSource = repositoryService.getModelEditorSource(modelId);
        String processName = model.getName() + FlowableConstants.BPMN_FILE_SUFFIX;

        Deployment deploy = repositoryService.createDeployment()
                .name(model.getName())
                .key(model.getKey())
                .tenantId(model.getTenantId())
                .category(model.getCategory())
                .addBytes(processName, modelEditorSource)
                .deploy();
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .deploymentId(deploy.getId())
                .singleResult();
        repositoryService.setProcessDefinitionCategory(processDefinition.getId(), model.getCategory());
    }

    @Override
    public Boolean isExistsByCategories(Set<String> categories) {
        long count = processModelMapper.countByCategory(categories);
        return count > 0;
    }
}
