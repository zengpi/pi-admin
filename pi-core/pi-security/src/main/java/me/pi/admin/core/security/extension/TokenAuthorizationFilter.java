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

import cn.hutool.core.util.StrUtil;
import me.pi.admin.common.constant.SecurityConstant;
import me.pi.admin.core.security.event.SecurityEvent;
import me.pi.admin.core.security.extension.token.TokenGenerator;
import me.pi.admin.core.security.service.AuthenticationService;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * @author ZnPi
 * @since 2022-11-28
 */
public class TokenAuthorizationFilter extends GenericFilterBean {
    private final TokenGenerator tokenGenerator;
    private final AuthenticationService authenticationService;
    private final ApplicationEventPublisher publisher;

    public TokenAuthorizationFilter(TokenGenerator tokenGenerator, AuthenticationService authenticationService,
                                    ApplicationEventPublisher publisher) {
        Assert.notNull(tokenGenerator, "tokenGenerator can not be null");
        Assert.notNull(authenticationService, "authenticationService can not be null");
        Assert.notNull(publisher, "publisher can not be null");
        this.tokenGenerator = tokenGenerator;
        this.authenticationService = authenticationService;
        this.publisher = publisher;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
            ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        String bearerToken = httpServletRequest.getHeader(HttpHeaders.AUTHORIZATION);
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith(SecurityConstant.TOKEN_PREFIX)) {
            bearerToken = bearerToken.replace(SecurityConstant.TOKEN_PREFIX, "");
        } else {
            bearerToken = null;
        }
        if (StrUtil.isNotBlank(bearerToken)) {
            if (tokenGenerator.verify(bearerToken)) {
                Authentication authentication = authenticationService.findByToken(bearerToken);

                if (authentication != null) {
                    SecurityContext context = SecurityContextHolder.createEmptyContext();
                    context.setAuthentication(authentication);
                    SecurityContextHolder.setContext(context);

                    // Token 续期
                    publisher.publishEvent(new SecurityEvent(bearerToken));
                } else {
                    throw new BadCredentialsException("无效的会话，或者会话已过期，请重新登录。");
                }
            }
        }

        chain.doFilter(request, response);
    }
}
