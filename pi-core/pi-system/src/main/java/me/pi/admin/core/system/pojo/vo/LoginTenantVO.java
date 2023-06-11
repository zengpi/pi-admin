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

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;

/**
 * @author ZnPi
 * @date 2023-05-28
 */
@Data
@Schema(title="登录租户")
public class LoginTenantVO implements Serializable {
    /**
     * 租户编码
     */
    @Schema(description = "租户编码")
    private String tenantCode;
    /**
     * 企业名称
     */
    @Schema(description = "企业名称")
    private String enterpriseName;

    private static final long serialVersionUID = -1;
}
