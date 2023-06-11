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

import me.pi.admin.core.security.extension.token.TokenGenerator;
import me.pi.admin.core.security.service.AuthenticationService;
import me.pi.admin.core.security.service.CaptchaService;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.HttpSecurityBuilder;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.access.ExceptionTranslationFilter;
import org.springframework.util.Assert;

/**
 * @author ZnPi
 * @since 2022-11-29
 */
public class TokenAuthenticationConfigurer<H extends HttpSecurityBuilder<H>>
        extends AbstractHttpConfigurer<TokenAuthenticationConfigurer<H>, H> {

    private final TokenGenerator tokenGenerator;
    private final AuthenticationService authenticationService;
    private final CaptchaService captchaService;
    private final ApplicationEventPublisher publisher;

    public TokenAuthenticationConfigurer(TokenGenerator tokenGenerator,
                                         AuthenticationService authenticationService,
                                         CaptchaService captchaService,
                                         ApplicationEventPublisher publisher) {
        Assert.notNull(tokenGenerator, "tokenGenerator must not be null");
        Assert.notNull(authenticationService, "authenticationService must not be null");
        this.tokenGenerator = tokenGenerator;
        this.authenticationService = authenticationService;
        this.captchaService = captchaService;
        this.publisher = publisher;
    }

    @Override
    public void configure(H builder) {
        TokenAuthenticationFilter filter =
                new TokenAuthenticationFilter(builder.getSharedObject(AuthenticationManager.class),
                        tokenGenerator, authenticationService, captchaService, publisher);
        builder.addFilterAfter(filter, ExceptionTranslationFilter.class);
    }
}
