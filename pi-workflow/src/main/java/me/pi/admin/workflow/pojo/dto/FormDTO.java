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
import me.pi.admin.common.mybatis.validate.SaveGroup;
import me.pi.admin.common.mybatis.validate.UpdateGroup;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author ZnPi
 * @date 2023-04-03
 */
@Data
@Schema(name = "表单 DTO")
public class FormDTO {
    /**
     * 唯一标识
     */
    @Schema(description = "标识")
    @NotNull(message = "id 不能为空", groups = {UpdateGroup.class})
    private Long id;
    /**
     * 表单名称
     */
    @Schema(description = "表单名称")
    @NotBlank(message = "表单名称不能为空", groups = {SaveGroup.class, UpdateGroup.class})
    private String name;
    /**
     * 是否内置
     */
    @Schema(description = "是否内置")
    private Integer builtIn;
    /**
     * 组件路径（如果为内置表单，则需要填写组件路径）
     */
    @Schema(description = "组件路径")
    private String componentPath;
    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;
}
