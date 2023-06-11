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

import javax.validation.constraints.NotNull;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
@Schema(title = "流程分类数据传输对象")
@Data
public class ProcessCategoryDTO {
    /**
     * 标识
     */
    @NotNull(message = "id 不能为空", groups = {UpdateGroup.class})
    @Schema(description = "标识")
    private String id;
    /**
     * 分类编码
     */
    @NotNull(message = "分类编码不能为空", groups = {SaveGroup.class, UpdateGroup.class})
    @Schema(description = "分类编码")
    private String code;
    /**
     * 分类名称
     */
    @NotNull(message = "分类名称不能为空", groups = {SaveGroup.class, UpdateGroup.class})
    @Schema(description = "分类名称")
    private String name;
    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;
}
