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
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.config.annotation.web.HttpSecurityBuilder;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.util.Assert;

/**
 * @author ZnPi
 * @since 2022-11-28
 */
public class TokenAuthorizationConfigurer<H extends HttpSecurityBuilder<H>>
        extends AbstractHttpConfigurer<TokenAuthenticationConfigurer<H>, H> {
    private final TokenGenerator tokenGenerator;
    private final AuthenticationService authenticationService;
    private final ApplicationEventPublisher publisher;

    public TokenAuthorizationConfigurer(TokenGenerator tokenGenerator, AuthenticationService authenticationService,
                                        ApplicationEventPublisher publisher){
        Assert.notNull(tokenGenerator, "tokenGenerator must not be null");
        Assert.notNull(authenticationService, "authenticationService must not be null");
        this.tokenGenerator = tokenGenerator;
        this.authenticationService = authenticationService;
        this.publisher = publisher;
    }

    @Override
    public void configure(H builder) {
        builder.addFilterAfter(new TokenAuthorizationFilter(tokenGenerator, authenticationService, publisher),
                TokenAuthenticationFilter.class);
    }
}
