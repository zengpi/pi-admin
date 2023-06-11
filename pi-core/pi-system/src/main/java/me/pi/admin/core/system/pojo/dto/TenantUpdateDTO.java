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

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

/**
 * @author ZnPi
 * @date 2023-05-29
 */
@Data
public class TenantUpdateDTO implements Serializable {
    /**
     * 主键
     */
    @Schema(description = "主键")
    @NotNull(message = "主键不能为空")
    private Long id;

    /**
     * 租户套餐主键
     */
    @Schema(description = "租户套餐主键")
    @NotNull(message = "租户套餐不能为空")
    private Long packageId;

    /**
     * 手机
     */
    @Schema(description = "手机")
    private String phone;

    /**
     * 邮箱
     */
    @Schema(description = "邮箱")
    private String email;

    /**
     * 租户套餐
     */
    @Schema(description = "租户套餐")
    @NotBlank(message = "租户套餐不能为空")
    private String packageName;

    /**
     * 到期时间
     */
    @Schema(description = "到期时间")
    private Date expires;

    /**
     * 用户数量(-1:=不限制)
     */
    @Schema(description = "用户数量(-1:=不限制)")
    private Long userQuantity;

    /**
     * 状态（0:=禁用; 1:=启用）
     */
    @Schema(description = "状态（0:=禁用; 1:=启用）")
    private Integer enabled;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private Long remark;

    private static final long serialVersionUID = 1L;
}
