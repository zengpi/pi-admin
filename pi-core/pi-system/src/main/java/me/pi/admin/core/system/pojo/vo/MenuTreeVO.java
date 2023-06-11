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

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * @author ZnPi
 * @since 2022-09-21
 */
@Data
@Schema(title = "菜单（树形）")
public class MenuTreeVO implements Serializable {
    /**
     * 标识
     */
    @Schema(description = "标识")
    private Long id;
    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    private LocalDateTime createTime;
    /**
     * 菜单名称
     */
    @Schema(description = "菜单名称")
    private String name;
    /**
     * 路由路径（浏览器地址栏路径）
     */
    @Schema(description = "路由路径（浏览器地址栏路径）")
    private String path;
    /**
     * 组件名称
     */
    @Schema(description = "组件名称")
    private String componentName;
    /**
     * 组件路径（vue页面完整路径，省略.vue后缀）
     */
    @Schema(description = "组件路径（vue页面完整路径，省略.vue后缀）")
    private String component;
    /**
     * 权限标识
     */
    @Schema(description = "权限标识")
    private String permission;
    /**
     * 图标
     */
    @Schema(description = "图标")
    private String icon;
    /**
     * 排序
     */
    @Schema(description = "排序")
    private Integer sort;
    /**
     * 是否缓存（0:=关闭, 1:=开启）
     */
    @Schema(description = "是否缓存（0:=关闭, 1:=开启）")
    private Integer keepAlive;
    /**
     * 菜单类型（1:=菜单, 2:=目录，3:=按钮）
     */
    @Schema(description = "菜单类型（1:=菜单, 2:=目录，3:=按钮）")
    private Integer type;
    /**
     * 是否外链（0:=否, 1:=是）
     */
    @Schema(description = "是否外链（0:=否, 1:=是）")
    private Integer externalLinks;
    /**
     * 是否可见（0:=不可见，1：可见）
     */
    @Schema(description = "是否可见（0:=不可见，1：可见）")
    private Integer visible;
    /**
     * 重定向路径
     */
    @Schema(description = "重定向路径")
    private String redirect;
    /**
     * 父目录 ID（0表示根目录）
     */
    @Schema(description = "父目录 ID（0表示根目录）")
    private Long parentId;
    /**
     * 子菜单
     */
    @Schema(description = "子菜单")
    private List<MenuTreeVO> children;

    private static final long serialVersionUID = -3992266652124385316L;
}
