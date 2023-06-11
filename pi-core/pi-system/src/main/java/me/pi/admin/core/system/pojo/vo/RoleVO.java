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

package me.pi.admin.core.system.pojo.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;

/**
 * @author ZnPi
 * @since 2022-09-04
 */
@Schema(title = "角色")
@Data
public class RoleVO implements Serializable {
    private static final long serialVersionUID = 374363160059522111L;

    @Schema(description = "角色 ID")
    private Long id;

    @Schema(description = "角色名称")
    private String name;

    @Schema(description = "角色编码")
    private String roleCode;

    @Schema(description = "数据范围（1:=全部;2:=部门;3:=部门及下级部门;4:=自定义部门;5:=本人;）")
    private Integer roleScope;

    @Schema(description = "角色描述")
    private String roleDesc;
}
