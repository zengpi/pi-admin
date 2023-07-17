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
import me.pi.admin.workflow.pojo.dto.ProcessModelDTO;
import me.pi.admin.workflow.pojo.dto.SaveModelDesignDTO;
import me.pi.admin.workflow.pojo.query.ProcessModelQuery;
import org.flowable.engine.repository.Model;

import java.util.Collection;
import java.util.Set;

/**
 * @author ZnPi
 * @date 2023-04-03
 */
public interface FlowableProcessModelService {
    /**
     * 获取流程模型
     *
     * @param processModelQuery 查询参数
     * @return 流程模型
     */
    IPage<Model> listModels(ProcessModelQuery processModelQuery);

    /**
     * 新增流程模型
     *
     * @param processModelDto 流程模型
     */
    void saveModel(ProcessModelDTO processModelDto);

    /**
     * 更新流程模型
     *
     * @param processModelDto 流程模型
     */
    void updateModel(ProcessModelDTO processModelDto);

    /**
     * 删除流程模型
     *
     * @param modelIds 待删除 ID
     */
    void deleteModels(Collection<String> modelIds);

    /**
     * 保存流程模型设计
     *
     * @param saveModelDesignDto 流程模型设计值
     */
    void saveModelDesign(SaveModelDesignDTO saveModelDesignDto);

    /**
     * 根据模型 ID 获取 Bpmn xml
     *
     * @param modelId 模型 ID
     * @return Bpmn xml
     */
    String getBpmnXmlById(String modelId);

    /**
     * 部署流程模型
     *
     * @param modelId 模型 ID
     */
    void deployModel(String modelId);

    /**
     * 是否存在指定分类的模型
     *
     * @param categories 分类列表
     * @return 是否存在指定分类的模型。在分类列表中，只要有一个分类属于某个模型，则返回 true，否则返回 false
     */
    Boolean isExistsByCategories(Set<String> categories);
}
