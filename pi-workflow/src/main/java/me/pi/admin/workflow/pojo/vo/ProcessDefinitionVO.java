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

/**
 * @author ZnPi
 * @date 2023-04-01
 */
@Data
@Schema(title = "流程定义视图对象")
public class ProcessDefinitionVO {
    /**
     * 唯一标识
     */
    @Schema(description = "唯一标识")
    private String id;
    /**
     * 流程名称
     */
    @Schema(description = "流程名称")
    private String name;
    /**
     * 流程定义的所有版本的唯一名称
     */
    @Schema(description = "流程定义的所有版本的唯一名称")
    private String key;
    /**
     * 类别，派生自定义元素中的 targetNamespace 属性
     */
    @Schema(description = "类别，派生自定义元素中的 targetNamespace 属性")
    private String category;
    /**
     * 流程定义的版本
     */
    @Schema(description = "流程定义的版本")
    private Integer version;
    /**
     * 如果流程定义处于挂起状态，则返回 true。
     */
    @Schema(description = "如果流程定义处于挂起状态，则返回 true。")
    private Boolean suspended;
}
