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

package me.pi.admin.common.constant;

/**
 * @author ZnPi
 * @since 2022-11-28 19:04
 */
public interface SecurityConstant {
    String TOKEN_PREFIX = "Bearer ";
    String DEFAULT_PASSWORD = "123456";
    /**
     * 角色前缀
     */
    String ROLE = "ROLE_";
    /**
     * 授权标识
     */
    String AUTHORIZATION = "Authorization";
}
