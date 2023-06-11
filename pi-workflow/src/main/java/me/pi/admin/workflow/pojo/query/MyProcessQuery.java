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

package me.pi.admin.workflow.pojo.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import me.pi.admin.common.mybatis.PageQuery;

import java.time.LocalDateTime;

/**
 * 我的流程查询参数
 *
 * @author ZnPi
 * @date 2023-04-06
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Schema(title = "我的流程查询参数")
public class MyProcessQuery extends PageQuery {
    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    private LocalDateTime[] startTime;
    /**
     * 流程标识
     */
    @Schema(description = "流程标识")
    private String key;
    /**
     * 流程名称
     */
    @Schema(description = "流程名称")
    private String name;
    /**
     * 流程分类
     */
    @Schema(description = "流程分类")
    private String category;
}
