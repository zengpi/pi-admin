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

package me.pi.admin.core.security.config;

import lombok.RequiredArgsConstructor;
import me.pi.admin.core.security.config.properties.AuthProperties;
import me.pi.admin.core.security.extension.*;
import me.pi.admin.core.security.extension.token.TokenGenerator;
import me.pi.admin.core.security.service.AuthenticationService;
import me.pi.admin.core.security.service.CaptchaService;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * SpringSecurity 配置
 *
 * @author ZnPi
 * @date 2023-03-07
 */
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
@EnableConfigurationProperties({AuthProperties.class})
public class SecurityConfiguration {
    private final TokenGenerator tokenGenerator;
    private final AuthenticationService authenticationService;
    private final CaptchaService captchaService;
    private final ApplicationEventPublisher publisher;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        .mvcMatchers("/",
                                "/tenant/login/tenants/**",
                                "/captcha/**",
                                "/v3/api-docs.yaml",
                                "/v3/api-docs/**",
                                "/swagger-ui.html",
                                "/swagger-ui/**").permitAll()
                        .anyRequest().authenticated()
                )
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(sessionManagement ->
                        sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .apply(tokenLoginConfigurer())
                .and()
                .apply(tokenAuthorizationConfigurer(publisher))
                .and()
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        .accessDeniedHandler(new PiAccessDeniedHandler())
                        .authenticationEntryPoint(new PiAuthenticationEntryPoint()))
                .logout(logout -> logout
                        .addLogoutHandler(new OAuth2LogoutHandler(authenticationService))
                        .logoutSuccessHandler(new PiLogoutSuccessHandler()));
        return http.build();
    }

    private TokenAuthenticationConfigurer<HttpSecurity> tokenLoginConfigurer() {
        return new TokenAuthenticationConfigurer<>(tokenGenerator, authenticationService, captchaService, publisher);
    }

    private TokenAuthorizationConfigurer<HttpSecurity> tokenAuthorizationConfigurer(ApplicationEventPublisher publisher) {
        return new TokenAuthorizationConfigurer<>(tokenGenerator, authenticationService, publisher);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
}