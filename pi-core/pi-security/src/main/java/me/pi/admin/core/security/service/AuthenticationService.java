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

package me.pi.admin.core.security.service;

import org.springframework.security.core.Authentication;

import java.util.concurrent.TimeUnit;

/**
 * @author ZnPi
 * @since 2023-01-04
 */
public interface AuthenticationService {
    /**
     * 保存认证
     *
     * @param token          Token
     * @param authentication 认证
     */
    void save(String token, Authentication authentication);

    /**
     * 通过 Token 获取认证
     *
     * @param token Token
     * @return 认证
     */
    Authentication findByToken(String token);

    /**
     * 删除 token
     *
     * @param token Token
     */
    void remove(String token);

    /**
     * 获取 token 的过期时间
     *
     * @param token token
     * @param timeUnit 时间单位
     * @return 过期时间
     */
    Long getExpire(String token, TimeUnit timeUnit);

    /**
     * 设置 token 的过期时间
     *
     * @param token   Token
     * @param timeout 过期时间
     * @param unit    时间单位
     */
    void setExpire(String token, final long timeout, final TimeUnit unit);
}
