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
import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.workflow.pojo.dto.FormDTO;
import me.pi.admin.workflow.pojo.po.ActReForm;
import me.pi.admin.workflow.pojo.vo.ProcessDefinitionStartFormVO;
import org.flowable.form.api.FormInfo;

import java.util.Collection;
import java.util.List;

/**
 * @author ZnPi
 * @date 2023-04-03
 */
public interface FlowableProcessFormService extends IService<ActReForm> {
    /**
     * 获取表单列表
     *
     * @param baseQuery 查询参数
     * @return 表单列表
     */
    IPage<ActReForm> listForms(BaseQuery baseQuery);

    /**
     * 新增或编辑表单
     *
     * @param formDto 表单数据
     */
    void saveOrUpdate(FormDTO formDto);

    /**
     * 删除表单
     *
     * @param ids 待删除表单 IDs
     */
    void deleteForms(Collection<Long> ids);

    /**
     * 根据 ID 列表获取表单
     *
     * @param ids ID 列表
     * @return 表单信息
     */
    List<ActReForm> getByIds(Collection<Long> ids);

    /**
     * 获取所有表单
     *
     * @return 所有表单
     */
    List<ProcessDefinitionStartFormVO> listAllForms();

    /**
     * 根据表单 key 获取表单
     *
     * @param formKey 表单 key
     * @return 表单
     */
    ActReForm getByFormKey(String formKey);

    /**
     * 根据表单 key 列表获取表单列表
     *
     * @param formKeys 表单 key 列表
     * @return 表单
     */
    List<ActReForm> listByFormKeys(Collection<String> formKeys);
}
