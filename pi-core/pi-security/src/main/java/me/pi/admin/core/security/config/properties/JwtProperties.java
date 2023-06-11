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

package me.pi.admin.core.security.config.properties;

import lombok.Data;

/**
 * @author ZnPi
 * @date 2023-06-04
 */
@Data
public class JwtProperties {
    /**
     * token 过期时间（单位：s）
     */
    private Long expire;
    /**
     * token 秘钥
     */
    private String secret;

    /**
     * 续期阈值（单位：s），当过期时间小于此阈值时，如果用户操作了，则进行续期
     */
    private Long renewalThreshold;
    /**
     * 续期时间（单位：s）
     */
    private Long renewalTime;
}
