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

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
 * 我的流程视图对象
 *
 * @author ZnPi
 * @date 2023-04-06
 */
@Data
@Schema(title = "我的流程实例视图对象")
public class MyProcessInstanceVO {
    /**
     * 流程实例 ID
     */
    @Schema(description = "流程实例 ID")
    private String id;
    /**
     * 任务 ID
     */
    @Schema(description = "任务 ID")
    private String taskId;
    /**
     * 提交时间
     */
    @Schema(description = "提交时间")
    private Date startTime;

    /**
     * 完成时间
     */
    @Schema(description = "完成时间")
    private Date endTime;
    /**
     * 流程定义 ID
     */
    @Schema(description = "流程定义 ID")
    private String processDefinitionId;
    /**
     * 流程定义名称
     */
    @Schema(description = "流程定义名称")
    private String processDefinitionName;
    /**
     * 流程定义类别
     */
    @Schema(description = "流程定义类别")
    private String processCategory;
    /**
     * 流程定义版本
     */
    @Schema(description = "流程定义版本")
    private String processDefinitionVersion;
    /**
     * 当前节点
     */
    @Schema(description = "当前节点")
    private String currentNode;
    /**
     * 耗时
     */
    @Schema(description = "耗时")
    private String duration;
}
