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

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

import lombok.Data;

/**
 * sys_package_menu
 *
 * @author ZnPi
 * @date 2023-05-26
 */
@TableName(value = "sys_package_menu")
@Data
public class SysPackageMenu implements Serializable {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 套餐标识
     */
    private Long packageId;

    /**
     * 菜单标识
     */
    private Long menuId;

    public SysPackageMenu() {
    }

    public SysPackageMenu(Long packageId, Long menuId) {
        this.packageId = packageId;
        this.menuId = menuId;
    }

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}