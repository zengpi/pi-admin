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

package me.pi.admin.core.system.pojo.dto;

import io.swagger.v3.oas.annotations.media.Schema;

import lombok.Data;
import me.pi.admin.common.mybatis.validate.SaveGroup;
import me.pi.admin.common.mybatis.validate.UpdateGroup;

import javax.validation.constraints.NotNull;

/**
 * @author ZnPi
 * @since 2022-09-25
 */
@Schema(title = "角色 DTO")
@Data
public class RoleDTO {
    @Schema(description = "标识")
    @NotNull(message = "id 不能为空", groups = {UpdateGroup.class})
    private Long id;

    @Schema(description = "角色名称")
    @NotNull(message = "角色名称不能为空", groups = {SaveGroup.class, UpdateGroup.class})
    private String name;

    @Schema(description = "角色编码")
    @NotNull(message = "角色编码不能为空", groups = {SaveGroup.class, UpdateGroup.class})
    private String roleCode;

    @Schema(description = "数据范围（1:=全部;2:=部门;3:=部门及下级部门;4:=自定义部门;5:=本人;）")
    private Integer roleScope;

    @Schema(description = "自定义部门列表")
    private Long[] customDept;

    @Schema(description = "角色描述")
    private String roleDesc;
}
