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

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import me.pi.admin.common.mybatis.validate.SaveGroup;
import me.pi.admin.common.mybatis.validate.UpdateGroup;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * @author ZnPi
 * @date 2023-05-22
 */
@Data
@Schema(title = "套餐 DTO")
public class PackageDTO implements Serializable {
    /**
     * 主键
     */
    @Schema(description = "主键")
    @NotNull(message = "id 不能为空", groups = {UpdateGroup.class})
    private Long id;

    /**
     * 套餐名称
     */
    @Schema(description = "套餐名称")
    @NotBlank(message = "套餐名称不能为空", groups = {SaveGroup.class, UpdateGroup.class})
    private String name;

    /**
     * 状态(0:=禁用; 1:=启用)
     */
    @Schema(description = "状态(0:=禁用; 1:=启用)")
    private Integer enabled;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
