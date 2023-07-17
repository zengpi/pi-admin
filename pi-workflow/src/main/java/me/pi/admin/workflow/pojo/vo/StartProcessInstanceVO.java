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

package me.pi.admin.workflow.pojo.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.flowable.engine.runtime.ProcessInstance;

/**
 * @author ZnPi
 * @date 2023-07-14
 */
@Data
@NoArgsConstructor
public class StartProcessInstanceVO {
    /**
     * 流程实例 id
     */
    private String processInstanceId;
    /**
     * 流程实例名称
     */
    private String processInstanceName;
    private String businessKey;

    public StartProcessInstanceVO(ProcessInstance processInstance) {
        this.processInstanceId = processInstance.getProcessInstanceId();
        this.processInstanceName = processInstance.getProcessDefinitionName();
        this.businessKey = processInstance.getBusinessKey();
    }
}
