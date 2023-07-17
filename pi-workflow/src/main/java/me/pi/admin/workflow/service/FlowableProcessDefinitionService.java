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
import me.pi.admin.workflow.pojo.query.ProcessDefQuery;
import me.pi.admin.workflow.pojo.vo.ProcessDefinitionStartFormVO;
import me.pi.admin.workflow.pojo.vo.ProcessDefinitionVO;
import me.pi.admin.workflow.pojo.query.BootableDefinitionQuery;
import org.flowable.engine.repository.ProcessDefinition;

/**
 * @author ZnPi
 * @since 2023-03-23
 */
public interface FlowableProcessDefinitionService {
    /**
     * 分页查询流程定义
     *
     * @param processDefQuery 查询参数
     * @return 流程定义
     */
    IPage<ProcessDefinition> getPageProcessDefinition(ProcessDefQuery processDefQuery);

    /**
     * 获取流程定义
     *
     * @param processDefQuery 流程定义查询参数
     * @return 流程定义
     */
    IPage<ProcessDefinitionVO> listProcessDefinitions(ProcessDefQuery processDefQuery);

    /**
     * 获取可启动的流程定义
     *
     * @param bootableDefinitionQuery 查询参数
     * @return 可启动的流程定义
     */
    IPage<ProcessDefinitionVO> getBootableDefinition(BootableDefinitionQuery bootableDefinitionQuery);

    /**
     * 获取启动流程表单
     *
     * @param processDefinitionId 流程定义 id
     * @return 流程表单
     */
    ProcessDefinitionStartFormVO getProcessDefinitionStartForm(String processDefinitionId);

    /**
     * 根据流程定义 ID 获取 BPMN Xml 文件
     *
     * @param definitionId 流程定义 ID
     * @return BPMN Xml 文件
     */
    String getBpmnXml(String definitionId);

    /**
     * 更改状态
     *
     * @param definitionId 流程定义 ID
     * @param suspended    状态（true: 挂起，false: 激活）
     */
    void changeState(String definitionId, Boolean suspended);

    /**
     * 获取流程部署历史版本
     *
     * @param processDefQuery 查询参数
     * @return 历史版本
     */
    IPage<ProcessDefinitionVO> listHistoryProcessDefinitions(ProcessDefQuery processDefQuery);
}
