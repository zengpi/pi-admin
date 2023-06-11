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

package me.pi.admin.core.system.pojo.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import me.pi.admin.common.mybatis.BaseEntity;

import java.io.Serializable;
import java.util.Date;

/**
 * @author ZnPi
 * @date 2023-05-19
 */
@TableName(value = "sys_enterprise")
@Data
@EqualsAndHashCode(callSuper = true)
public class SysEnterprise extends BaseEntity implements Serializable {
    /**
     * 企业名称
     */
    private String name;

    /**
     * 英文名称
     */
    private String nameEn;

    /**
     * 简称
     */
    private String shortName;

    /**
     * 统一社会信用代码
     */
    private String usci;

    /**
     * 注册币种
     */
    private String registeredCurrency;

    /**
     * 注册资本
     */
    private String registeredCapital;

    /**
     * 法人
     */
    private String legalPerson;

    /**
     * 成立时间
     */
    private Date establishingTime;

    /**
     * 企业性质
     */
    private String businessNature;

    /**
     * 所属行业
     */
    private String industryInvolved;

    /**
     * 注册地址
     */
    private String registeredAddress;

    /**
     * 经营范围
     */
    private String businessScope;

    /**
     * 员工数
     */
    private String staffNumber;

    /**
     * 状态
     */
    private String state;

    /**
     * 是否删除（0:=未删除;null:=已删除）
     */
    private Integer deleted;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}