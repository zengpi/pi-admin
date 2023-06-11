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

package me.pi.admin.core.system.pojo.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import me.pi.admin.common.mybatis.BaseQuery;

/**
 * 获取用户查询参数
 *
 * @author ZnPi
 * @since 2022-08-29
 */
@Schema(title = "获取用户查询参数")
@Getter
@Setter
public class UserQuery extends BaseQuery {
    /**
     * 用户状态（0:=禁用;1:=启用）
     */
    @Schema(description = "用户状态（0:=禁用;1:=启用）")
    private Integer enabled;

    /**
     * 部门 ID
     */
    @Schema(description = "部门 ID")
    private Long deptId;
}
