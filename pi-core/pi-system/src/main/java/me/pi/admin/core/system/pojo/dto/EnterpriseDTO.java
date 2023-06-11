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

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import me.pi.admin.common.mybatis.validate.SaveGroup;
import me.pi.admin.common.mybatis.validate.UpdateGroup;
import me.pi.admin.common.util.DateUtil;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author ZnPi
 * @date 2023-05-20
 */
@Data
@Schema(title = "企业 DTO")
public class EnterpriseDTO {
    /**
     * 主键
     */
    @Schema(description = "标识")
    @NotNull(message = "id 不能为空", groups = {UpdateGroup.class})
    private Long id;

    /**
     * 企业名称
     */
    @Schema(description = "企业名称")
    @NotBlank(message = "企业名称不能为空", groups = {SaveGroup.class, UpdateGroup.class})
    private String name;

    /**
     * 英文名称
     */
    @Schema(description = "英文名称")
    private String nameEn;

    /**
     * 简称
     */
    @Schema(description = "简称")
    private String shortName;

    /**
     * 统一社会信用代码
     */
    @Schema(description = "统一社会信用代码")
    private String usci;

    /**
     * 注册币种
     */
    @Schema(description = "注册币种")
    private String registeredCurrency;

    /**
     * 注册资本
     */
    @Schema(description = "注册资本")
    private String registeredCapital;

    /**
     * 法人
     */
    @Schema(description = "法人")
    private String legalPerson;

    /**
     * 成立时间
     */
    @Schema(description = "成立时间")
    @JsonFormat(pattern = DateUtil.PATTERN_DATE)
    private Date establishingTime;

    /**
     * 企业性质
     */
    @Schema(description = "企业性质")
    private String businessNature;

    /**
     * 所属行业
     */
    @Schema(description = "所属行业")
    private String industryInvolved;

    /**
     * 注册地址
     */
    @Schema(description = "注册地址")
    private String registeredAddress;

    /**
     * 经营范围
     */
    @Schema(description = "经营范围")
    private String businessScope;

    /**
     * 员工数
     */
    @Schema(description = "员工数")
    private String staffNumber;

    /**
     * 状态
     */
    @Schema(description = "状态")
    private String state;
}
