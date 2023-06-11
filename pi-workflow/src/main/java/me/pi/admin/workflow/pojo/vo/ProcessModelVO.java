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
import me.pi.admin.workflow.pojo.dto.ProcessModelMetaInfoDTO;

import java.util.Date;

/**
 * @author ZnPi
 * @date 2023-04-03
 */
@Data
@Schema(title = "流程模型视图对象")
public class ProcessModelVO {
    /**
     * 主键
     */
    @Schema(description = "主键")
    private String id;

    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    private Date createTime;
    /**
     * 模型名称
     */
    @Schema(description = "模型名称")
    private String name;
    /**
     * 模型标识
     */
    @Schema(description = "模型标识")
    private String key;
    /**
     * 分类
     */
    @Schema(description = "分类")
    private String category;
    /**
     * 版本
     */
    @Schema(description = "版本")
    private Integer version;
    /**
     * 元信息
     */
    @Schema(description = "元信息")
    private ProcessModelMetaInfoDTO metaInfo;
}
