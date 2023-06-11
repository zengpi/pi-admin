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
 * @date 2023-04-17
 */
@Data
@Schema(title = "流程分类视图对象")
public class ProcessCategoryVO {
    /**
     * 标识
     */
    @Schema(description = "标识")
    private Long id;
    /**
     * 分类编码
     */
    @Schema(description = "分类编码")
    private String code;
    /**
     * 分类名称
     */
    @Schema(description = "分类名称")
    private String name;
    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;
}
