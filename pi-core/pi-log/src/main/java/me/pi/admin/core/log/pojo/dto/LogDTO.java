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

package me.pi.admin.core.log.pojo.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * @author ZnPi
 * @since 2022-11-18
 */
@Schema(title="日志 DTO")
@Data
public class LogDTO {
    /**
     * 类型(0:=异常;1:=正常)
     */
    @Schema(description = "类型(0:=异常;1:=正常)")
    private Integer type;
    /**
     * 操作人
     */
    @Schema(description = "操作人")
    private String username;
    /**
     * IP地址
     */
    @Schema(description = "IP地址")
    private String ip;
    /**
     * 标题
     */
    @Schema(description = "标题")
    private String title;
    /**
     * 租户
     */
    @Schema(description = "租户")
    private String tenantId;
    /**
     * 请求 URL
     */
    @Schema(description = "请求 URL")
    private String requestUrl;
    /**
     * 描述
     */
    @Schema(description = "描述")
    private String exceptionDesc;
    /**
     * 请求方式
     */
    @Schema(description = "请求方式")
    private String requestMethod;
    /**
     * 请求参数
     */
    @Schema(description = "请求参数")
    private String requestParam;
    /**
     * 请求时间
     */
    @Schema(description = "请求时间")
    private Long requestTime;
    /**
     * 方法名称
     */
    @Schema(description = "方法名称")
    private String methodName;
}
