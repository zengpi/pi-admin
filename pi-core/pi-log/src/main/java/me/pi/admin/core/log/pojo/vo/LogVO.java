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

package me.pi.admin.core.log.pojo.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @author ZnPi
 * @since 2022-11-20
 */
@Schema(title = "日志")
@Data
public class LogVO implements Serializable {
    private static final long serialVersionUID = 35888237550426755L;

    @Schema(description = "标识")
    private Integer id;

    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    private LocalDateTime createTime;

    @Schema(description = "操作人")
    private String createBy;

    @Schema(description = "类型(0:=异常;1:=正常)")
    private Integer type;

    @Schema(description = "IP地址")
    private String ip;

    @Schema(description = "标题")
    private String title;

    @Schema(description = "描述")
    private String exceptionDesc;

    @Schema(description = "请求 URL")
    private String requestUrl;

    @Schema(description = "请求方式")
    private String requestMethod;

    @Schema(description = "请求参数")
    private String requestParam;

    @Schema(description = "请求时间")
    private String requestTime;

    @Schema(description = "方法名称")
    private String methodName;
}
