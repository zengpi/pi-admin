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
import me.pi.admin.workflow.pojo.query.MyProcessQuery;
import me.pi.admin.workflow.pojo.vo.MyProcessInstanceVO;
import me.pi.admin.workflow.pojo.vo.ProcessInstanceDetailVO;

import java.util.Map;

/**
 * @author ZnPi
 * @date 2023-04-19
 */
public interface ProcessInstanceService {
    /**
     * 启动流程实例
     *
     * @param processDefinitionId 流程定义 ID
     * @param variables           流程变量
     */
    void startProcessInstance(String processDefinitionId, Map<String, Object> variables);

    /**
     * 获取我的流程
     *
     * @param myProcessQuery 我的流程查询参数
     * @return 我的流程
     */
    IPage<MyProcessInstanceVO> getMyProcesses(MyProcessQuery myProcessQuery);

    /**
     * 获取流程详情
     *
     * @param processInstanceId 流程实例 ID
     * @return ProcessInstanceDetailVO 流程实例详情
     */
    ProcessInstanceDetailVO getProcessInstanceDetail(String processInstanceId);

    /**
     * 删除流程实例
     *
     * @param processInstanceId 流程实例 ID
     */
    void delete(String processInstanceId);

    /**
     * 取消流程实例
     *
     * @param processInstanceId 流程实例 ID
     */
    void cancel(String processInstanceId);
}
