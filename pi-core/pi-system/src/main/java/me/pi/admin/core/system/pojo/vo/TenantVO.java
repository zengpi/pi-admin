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

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import me.pi.admin.common.util.DateUtil;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

/**
 * 租户 VO
 *
 * @author ZnPi
 * @date 2023-05-22
 */
@Data
@Schema(title = "租户 VO")
public class TenantVO implements Serializable {
    /**
     * 主键
     */
    @Schema(description = "主键")
    private Long id;
    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    @JsonFormat(pattern = DateUtil.PATTERN_DATETIME)
    private LocalDateTime createTime;

    /**
     * 租户编号
     */
    @Schema(description = "租户编号")
    private String tenantCode;

    /**
     * 企业名称
     */
    @Schema(description = "企业名称")
    private String enterpriseName;

    /**
     * 联系人
     */
    @Schema(description = "联系人")
    private String contact;

    /**
     * 账号
     */
    @Schema(description = "账号")
    private String account;

    /**
     * 手机
     */
    @Schema(description = "手机")
    private String phone;

    /**
     * 邮箱
     */
    @Schema(description = "手机")
    private String email;

    /**
     * 租户套餐标识
     */
    @Schema(description = "租户套餐标识")
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