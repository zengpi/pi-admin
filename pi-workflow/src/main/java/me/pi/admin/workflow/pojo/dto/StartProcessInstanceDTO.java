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

package me.pi.admin.workflow.pojo.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.NotEmpty;
import java.util.Map;

/**
 * 启动流程实例的参数
 *
 * @author ZnPi
 * @date 2023-07-14
 */
@Data
@Schema(title = "启动流程实例的参数")
public class StartProcessInstanceDTO {
    /**
     * 流程实例 id
     */
    @Schema(description = "流程实例 id", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotEmpty(message = "流程实例 id 是必须的！")
    private String processDefinitionId;

    /**
     * 名称
     */
    @Schema(description = "名称")
    private String processDefinitionName;

    /**
     * 流程变量
     */
    @Schema(description = "流程变量")
    private Map<String, Object> variables;

    /**
     * 是否内置表单（0:=否；1:是）
     */
    @Schema(description = "是否内置表单")
    private Integer isBuiltInForm;

    private String outcome;
}
