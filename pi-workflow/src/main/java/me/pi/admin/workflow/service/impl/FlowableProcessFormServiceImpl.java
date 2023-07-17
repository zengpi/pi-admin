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

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import liquibase.pro.packaged.H;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.workflow.pojo.dto.FormDTO;
import me.pi.admin.workflow.pojo.po.ActReForm;
import me.pi.admin.workflow.pojo.vo.ProcessDefinitionStartFormVO;
import me.pi.admin.workflow.converter.ProcessFormConverter;
import me.pi.admin.workflow.mapper.ProcessFormMapper;
import me.pi.admin.workflow.service.FlowableProcessFormService;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.form.api.FormInfo;
import org.flowable.form.api.FormRepositoryService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;

/**
 * @author ZnPi
 * @date 2023-04-03
 */
@Service
@RequiredArgsConstructor
public class FlowableProcessFormServiceImpl extends ServiceImpl<ProcessFormMapper, ActReForm>
        implements FlowableProcessFormService {
    private final ProcessFormConverter processFormConverter;
    protected final FormRepositoryService formRepositoryService;
    protected final ProcessEngineConfiguration processEngineConfiguration;

    @Override
    public IPage<ActReForm> listForms(BaseQuery baseQuery) {
        return super.page(baseQuery.page(), Wrappers.lambdaQuery(ActReForm.class)
                .like(StringUtils.hasText(baseQuery.getKeyWord()),
                        ActReForm::getName, baseQuery.getKeyWord())
                .select(ActReForm::getId, ActReForm::getName, ActReForm::getFormKey, ActReForm::getBuiltIn,
                        ActReForm::getComponentPath, ActReForm::getRemark));
    }

    @Override
    public void saveOrUpdate(FormDTO formDto) {
        super.saveOrUpdate(processFormConverter.dtoToPo(formDto));
    }

    @Override
    public void deleteForms(Collection<Long> ids) {
        if (ids.isEmpty()) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "待删除 id 列表不能为空");
        }
        if (!(ids instanceof Set)) {
            ids = new HashSet<>(ids);
        }
        super.removeBatchByIds(ids);
    }

    @Override
    public List<ActReForm> getByIds(Collection<Long> ids) {
        if (ids.isEmpty()) {
            throw new BadRequestException("id 列表不能为空");
        }
        return super.list(Wrappers.lambdaQuery(ActReForm.class).in(ActReForm::getId, ids));
    }

    @Override
    public List<ProcessDefinitionStartFormVO> listAllForms() {
        List<ActReForm> forms = super.list(Wrappers.lambdaQuery(ActReForm.class)
                .select(ActReForm::getId, ActReForm::getName, ActReForm::getFormKey,
                        ActReForm::getBuiltIn, ActReForm::getComponentPath));

        return processFormConverter.posToVos(forms);
    }

    @Override
    public ActReForm getByFormKey(String formKey) {
        return super.getOne(Wrappers.lambdaQuery(ActReForm.class).eq(ActReForm::getFormKey, formKey));
    }

    @Override
    public List<ActReForm> listByFormKeys(Collection<String> formKeys) {
        if (formKeys.isEmpty()) {
            throw new BadRequestException("表单 key 列表不能为空");
        }
        if (!(formKeys instanceof Set)) {
            formKeys = new HashSet<>(formKeys);
        }
        return super.list(Wrappers.lambdaQuery(ActReForm.class).in(ActReForm::getFormKey, formKeys));
    }
}
