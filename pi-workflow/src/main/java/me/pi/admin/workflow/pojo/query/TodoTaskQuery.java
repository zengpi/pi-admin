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

import lombok.Data;
import lombok.EqualsAndHashCode;
import me.pi.admin.common.mybatis.PageQuery;

import java.time.LocalDate;

/**
 * @author ZnPi
 * @date 2023-04-15
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class TodoTaskQuery extends PageQuery {
    /**
     * 日期范围
     */
    private LocalDate[] dateRange;
    /**
     * 流程名称
     */
    private String processDefinitionName;
}