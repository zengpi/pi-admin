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
 * @date 2023-05-22
 */
@Data
@Schema(title = "租户新增 DTO")
public class TenantSaveDTO implements Serializable {
    /**
     * 企业主键
     */
    @Schema(description = "企业主键")
    @NotNull(message = "企业ID不能为空")
    private Long enterpriseId;
    /**
     * 企业名称
     */
    @Schema(description = "企业名称")
    @NotBlank(message = "企业名称不能为空")
    private String enterpriseName;

    /**
     * 联系人
     */
    @Schema(description = "联系人")
    @NotBlank(message = "联系人不能为空")
    private String contact;

    /**
     * 账号
     */
    @Schema(description = "账号")
    @NotBlank(message = "租户账号不能为空")
    private String account;

    /**
     * 密码
     */
    @Schema(description = "密码")
    @NotBlank(message = "密码不能为空")
    private String password;

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
     * 租户套餐主键
     */
    @Schema(description = "租户套餐主键")
    private Long packageId;
    /**
     * 租户套餐
     */
    @Schema(description = "租户套餐")
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