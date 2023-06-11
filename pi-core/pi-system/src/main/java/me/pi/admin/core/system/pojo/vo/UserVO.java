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
import me.pi.admin.common.serialization.annotation.Desensitization;
import me.pi.admin.common.serialization.annotation.DesensitizationStrategy;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * @author ZnPi
 * @since 2022-08-29
 */
@Schema(title = "用户 VO")
@Data
public class UserVO implements Serializable {
    @Schema(description = "标识")
    private Long id;

    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    private LocalDateTime createTime;

    @Schema(description = "用户名")
    private String username;

    @Schema(description = "姓名")
    private String name;

    @Schema(description = "性别(1:=男; 2:=女)")
    private Integer sex;

    @Schema(description = "年龄")
    private Integer age;

    @Schema(description = "生日")
    private LocalDateTime birthday;

    @Schema(description = "手机")
    private String phone;

    @Schema(description = "部门 ID")
    private Integer deptId;

    @Schema(description = "部门名称")
    private String deptName;

    @Schema(description = "角色 ID 列表")
    private List<Long> roleIds;

    @Schema(description = "状态（0:=禁用，1:=启用）")
    private Integer enabled;

    private static final long serialVersionUID = -1L;
}
