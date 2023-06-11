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

package me.pi.admin.core.security.extension;

import lombok.RequiredArgsConstructor;
import me.pi.admin.common.constant.SecurityConstant;
import me.pi.admin.core.security.service.AuthenticationService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextHolderStrategy;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author ZnPi
 * @since 2022-10-22
 */
@RequiredArgsConstructor
public class OAuth2LogoutHandler implements LogoutHandler {
    private final AuthenticationService authenticationService;
    private final SecurityContextHolderStrategy securityContextHolderStrategy = SecurityContextHolder
            .getContextHolderStrategy();

    @Override
    public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        Assert.notNull(request, "HttpServletRequest required");
        String authHeader = request.getHeader(SecurityConstant.AUTHORIZATION);
        if (!StringUtils.hasText(authHeader)) {
            return;
        }
        String token = authHeader.replaceAll(SecurityConstant.TOKEN_PREFIX + " *", "");
        Authentication authorization = authenticationService.findByToken(token);
        if (authorization == null) {
            return;
        }

        authenticationService.remove(token);

        SecurityContext context = this.securityContextHolderStrategy.getContext();
        this.securityContextHolderStrategy.clearContext();
        context.setAuthentication(null);
    }
}