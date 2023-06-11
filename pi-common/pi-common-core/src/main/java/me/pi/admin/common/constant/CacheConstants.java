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
 * @since 2022-10-26
 */
public interface CacheConstants {
    /**
     * 验证码前缀
     */
    String CAPTCHA_PREFIX = "captcha:";

    /**
     * Token 前缀
     */
    String TOKEN = "token";

    /**
     * 缓存 key 根前缀
     */
    String CACHE_ROOT = "pi_admin:";

    /**
     * Token 缓存前缀
     */
    String CACHE_TOKEN = CACHE_ROOT + TOKEN;

    /**
     * 菜单缓存 key
     */
    String CACHE_MENU = CACHE_ROOT + "cache_menu";

    /**
     * 用户缓存 key
     */
    String CACHE_USER = CACHE_ROOT + "cache_user";
}
