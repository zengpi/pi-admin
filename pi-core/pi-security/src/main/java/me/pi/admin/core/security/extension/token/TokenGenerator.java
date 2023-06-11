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

package me.pi.admin.core.security.extension.token;

import org.springframework.lang.Nullable;
import org.springframework.security.core.Authentication;

/**
 * @author ZnPi
 * @since 2022-11-27
 */
public interface TokenGenerator {
    /**
     * 生成 Token
     * @param authentication 认证
     * @return Token
     */
    @Nullable
    String build(Authentication authentication);

    /**
     * 验证 Token
     * @param jws Token
     * @return 验证结果：true 成功；false 失败
     */
    boolean verify(String jws);
}
