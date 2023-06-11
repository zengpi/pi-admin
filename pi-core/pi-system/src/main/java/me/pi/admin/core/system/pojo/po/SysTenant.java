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
 * sys_tenant
 *
 * @author ZnPi
 * @date 2023-05-22
 */
@TableName(value = "sys_tenant")
@Data
@EqualsAndHashCode(callSuper = true)
public class SysTenant extends BaseEntity implements Serializable {
    /**
     * 租户编码
     */
    private String tenantCode;

    /**
     * 企业主键
     */
    private Long enterpriseId;

    /**
     * 企业名称
     */
    private String enterpriseName;

    /**
     * 租户管理员主键
     */
    private Long adminId;

    /**
     * 联系人
     */
    private String contact;

    /**
     * 账号
     */
    private String account;

    /**
     * 手机
     */
    private String phone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 租户套餐
     */
    private Long packageId;

    /**
     * 到期时间
     */
    private Date expires;

    /**
     * 用户数量(-1:=不限制)
     */
    private Long userQuantity;

    /**
     * 状态（0:=禁用; 1:=启用）
     */
    private Integer enabled;

    /**
     * 是否删除（0:=未删除;null:=已删除）
     */
    private Integer deleted;

    /**
     * 备注
     */
    private Long remark;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}