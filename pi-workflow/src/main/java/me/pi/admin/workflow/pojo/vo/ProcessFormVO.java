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
import lombok.NoArgsConstructor;
import org.flowable.form.api.FormInfo;
import org.flowable.form.model.FormField;
import org.flowable.form.model.SimpleFormModel;

import java.util.List;
import java.util.Map;

/**
 * 流程表单
 *
 * @author ZnPi
 * @date 2023-04-07
 */
@Data
@NoArgsConstructor
@Schema(title = "流程表单视图对象")
public class ProcessFormVO {
    /**
     * 唯一标识
     */
    @Schema(description = "标识")
    private String id;
    /**
     * 表单 key
     */
    @Schema(description = "表单 key")
    private String key;
    /**
     * 表单名称
     */
    @Schema(description = "表单名称")
    private String name;
    /**
     * 版本
     */
    @Schema(description = "版本")
    private Integer version;
    /**
     * 描述
     */
    @Schema(description = "描述")
    private String description;
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
     * 表单字段（如果为非内置表单）
     */
    @Schema(description = "表单字段")
    private List<FormField> fields;

    public ProcessFormVO(FormInfo formInfo) {
        // 非内置表单
        this.builtIn = 0;
        this.id = formInfo.getId();
        this.name = formInfo.getName();
        this.description = formInfo.getDescription();
        this.key = formInfo.getKey();
        this.version = formInfo.getVersion();
    }

    public ProcessFormVO(FormInfo formInfo, SimpleFormModel formModel) {
        this(formInfo);
        this.fields = formModel.getFields();
    }
}
