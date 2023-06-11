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

package me.pi.admin.common.util;

import me.pi.admin.common.pojo.dto.AuthenticatedUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * @author ZnPi
 * @since 2022-11-27
 */
public class SecurityUtils {
    /**
     * 获取 Authentication
     *
     * @return Authentication
     */
    public static Authentication getAuthentication() {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    /**
     * 获取用户 ID
     *
     * @return 用户 ID
     */
    public static Long getUserId() {
        AuthenticatedUser user = SecurityUtils.getUser();
        if (user == null) {
            return null;
        }

        return user.getId();
    }

    /**
     * 获取用户名
     *
     * @return 用户名
     */
    public static String getUserName() {
        if (SecurityUtils.getAuthentication() == null) {
            return null;
        }
        return SecurityUtils.getAuthentication().getName();
    }

    /**
     * 获取租户
     *
     * @return 租户
     */
    public static String getTenantId() {
        AuthenticatedUser user = SecurityUtils.getUser();
        if (user == null) {
            return null;
        }

        return user.getName();
    }

    /**
     * 获取用户
     *
     * @return 用户
     */
    public static AuthenticatedUser getUser() {
        if (SecurityUtils.getAuthentication() == null) {
            return null;
        }
        Object principal = SecurityUtils.getAuthentication().getPrincipal();
        if(principal instanceof AuthenticatedUser) {
            return (AuthenticatedUser) principal;
        }
        return null;
    }
}
