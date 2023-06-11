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

/**
 * sys_package
 * @author ZnPi
 * @date 2023-05-22
 */
@TableName(value ="sys_package")
@Data
@EqualsAndHashCode(callSuper = true)
public class SysPackage extends BaseEntity implements Serializable {
    /**
     * 套餐名称
     */
    private String name;

    /**
     * 状态(0:=禁用; 1:=启用)
     */
    private Integer enabled;

    /**
     * 是否删除（0:=未删除;null:=已删除）
     */
    private Integer deleted;

    /**
     * 备注
     */
    private String remark;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}