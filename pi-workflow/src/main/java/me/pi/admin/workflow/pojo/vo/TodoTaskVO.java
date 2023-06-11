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

import java.util.Date;
import java.util.Map;

/**
 * @author ZnPi
 * @date 2023-04-15
 */
@Data
public class TodoTaskVO {
    /**
     * 任务 ID
     */
    private String id;
    /**
     * 任务名称
     */
    private String name;
    private String taskDefinitionKey;
    /**
     * 接收时间
     */
    private Date createTime;
    /**
     * 流程实例 ID
     */
    private String processInstanceId;
    /**
     * 流程定义 ID
     */
    private String processDefinitionId;
    /**
     * 流程定义名称
     */
    private String processDefinitionName;
    /**
     * 流程定义版本
     */
    private Integer processDefinitionVersion;
    /**
     * 流程部署 ID
     */
    private String deploymentId;
    /**
     * 发起人
     */
    private String startUsername;
    /**
     * 发起人姓名
     */
    private String startName;
    /**
     * 流程变量
     */
    private Map<String, Object> processVars;
}
