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

import lombok.Data;
import lombok.EqualsAndHashCode;
import me.pi.admin.common.mybatis.BaseEntity;

/**
 * @author ZnPi
 * @since 2022-08-13
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class SysClient extends BaseEntity {
    /**
     * 客户端 ID
     */
    private String clientId;
    /**
     * 客户端秘钥
     */
    private String clientSecret;
    /**
     * 授权类型
     */
    private String grantTypes;
    /**
     * 重定向地址
     */
    private String redirectUri;
    /**
     * 范围
     */
    private String scope;
    /**
     * 刷新令牌有效期（单位：秒）
     */
    private Integer accessTokenValidity;
    /**
     * 访问令牌有效期（单位：秒）
     */
    private Integer refreshTokenValidity;
}
