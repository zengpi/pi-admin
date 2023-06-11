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

import lombok.Data;

import java.util.Map;

/**
 * 流程表单
 *
 * @author ZnPi
 * @date 2023-04-07
 */
@Data
public class ProcessFormVO {
    /**
     * 表单 ID
     */
    private Long id;
    /**
     * 表单名称
     */
    private String name;
    /**
     * 组件路径（如果为内置表单，则组件路径不为空）
     */
    private String componentPath;
    /**
     * 是否内置
     */
    private Integer builtIn;
    /**
     * 表单数据
     */
    private Map<String, Object> formData;
}
