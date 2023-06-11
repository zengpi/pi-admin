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
 * @date 2023-04-04
 */
@Data
@Schema(title = "流程模型数据传输对象")
public class ProcessModelDTO {
    /**
     * 主键
     */
    @Schema(description = "主键")
    @NotNull(message = "id 不能为空", groups = {UpdateGroup.class})
    private String id;
    /**
     * 模型标识
     */
    @NotNull(message = "模型标识不能为空", groups = {SaveGroup.class, UpdateGroup.class})
    @Schema(description = "模型标识")
    private String key;
    /**
     * 模型名称
     */
    @NotNull(message = "模型名称不能为空", groups = {SaveGroup.class, UpdateGroup.class})
    @Schema(description = "模型名称")
    private String name;
    /**
     * 模型分类
     */
    @Schema(description = "模型分类")
    private String category;
    /**
     * 元信息
     */
    @Schema(description = "元信息")
    private ProcessModelMetaInfoDTO metaInfo;
}
