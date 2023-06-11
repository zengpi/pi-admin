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
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.core.log.event.LogEvent;
import me.pi.admin.core.log.pojo.dto.LogDTO;
import me.pi.admin.core.log.util.LogUtils;
import me.pi.admin.core.security.exception.CustomAuthenticationException;
import me.pi.admin.core.security.extension.token.TokenGenerator;
import me.pi.admin.core.security.service.AuthenticationService;
import me.pi.admin.core.security.service.CaptchaService;
import me.pi.admin.core.system.util.HttpEndpointUtils;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.common.util.SecurityUtils;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.core.log.LogMessage;
import org.springframework.http.HttpMethod;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextHolderStrategy;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.util.Assert;
import org.springframework.util.MultiValueMap;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Processor of RESTful HTTP-based authentication requests.
 *
 * <h3>Authentication Process</h3>
 * <p>
 * The filter requires that you set the <tt>authenticationManager</tt> property. An
 * <tt>AuthenticationManager</tt> is required to process the authentication request tokens
 * created by implementing classes.
 * <p>
 * This filter will intercept a request and attempt to perform authentication from that
 * request if the request matches the
 *
 * @author ZnPi
 * @since 2022-11-29
 */
public class TokenAuthenticationFilter extends GenericFilterBean {
    public static final String SPRING_SECURITY_FORM_USERNAME_KEY = "username";
    public static final String SPRING_SECURITY_FORM_PASSWORD_KEY = "password";
    private static final AntPathRequestMatcher DEFAULT_ANT_PATH_REQUEST_MATCHER = new AntPathRequestMatcher("/login",
            "POST");
    private final SecurityContextHolderStrategy securityContextHolderStrategy = SecurityContextHolder
            .getContextHolderStrategy();

    private final AuthenticationManager authenticationManager;
    private final TokenGenerator tokenGenerator;
    private final AuthenticationService authenticationService;
    private final CaptchaService captchaService;
    private final ApplicationEventPublisher publisher;

    public TokenAuthenticationFilter(AuthenticationManager authenticationManager,
                                     TokenGenerator tokenGenerator,
                                     AuthenticationService authenticationService,
                                     CaptchaService captchaService,
                                     ApplicationEventPublisher publisher) {
        Assert.notNull(authenticationManager, "authenticationManager must be not null");
        Assert.notNull(tokenGenerator, "tokenGenerator must not be null");
        Assert.notNull(authenticationService, "authenticationService must not be null");
        this.authenticationManager = authenticationManager;
        this.tokenGenerator = tokenGenerator;
        this.authenticationService = authenticationService;
        this.captchaService = captchaService;
        this.publisher = publisher;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        doFilter((HttpServletRequest) request, (HttpServletResponse) response, chain);
    }

    private void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (!requiresAuthentication(request, response)) {
            chain.doFilter(request, response);
            return;
        }

        // 登录耗时
        long currentTime = System.currentTimeMillis();

        try {
            // 校验验证码
            verifyCode(request);

            Authentication authenticationResult = attemptAuthentication(request);
            if (authenticationResult == null) {
                // return immediately as subclass has indicated that it hasn't completed
                return;
            }

            String jws = tokenGenerator.build(authenticationResult);

            authenticationService.save(jws, authenticationResult);

            Map<String, Object> tokenResponseParameters = new HashMap<>(3);
            tokenResponseParameters.put("token", SecurityConstant.TOKEN_PREFIX + jws);

            SecurityContext context = SecurityContextHolder.createEmptyContext();
            context.setAuthentication(authenticationResult);
            SecurityContextHolder.setContext(context);

            if (this.logger.isDebugEnabled()) {
                this.logger.debug(LogMessage.format("Set SecurityContextHolder to %s", authenticationResult));
            }

            HttpEndpointUtils.writeWithMessageConverters(ResponseData.ok(tokenResponseParameters),
                    new ServletServerHttpResponse(response));

            // 记录日志
            log(request, currentTime);
        } catch (InternalAuthenticationServiceException failed) {
            this.logger.error("An internal error occurred while trying to authenticate the user.", failed);
            unsuccessfulAuthentication(request, response, failed);
            throw failed;
        } catch (AuthenticationException ex) {
            unsuccessfulAuthentication(request, response, ex);
            throw ex;
        }
    }

    private void log(HttpServletRequest request, long currentTime) {
        LogDTO logDTO = LogUtils.getDefaultLogDTO(request);
        logDTO.setRequestTime(System.currentTimeMillis() - currentTime);
        logDTO.setTitle("用户登录");
        logDTO.setMethodName("-");
        logDTO.setRequestParam("-");
        logDTO.setUsername(SecurityUtils.getUserName());
        logDTO.setTenantId(SecurityUtils.getTenantId());
        publisher.publishEvent(new LogEvent(logDTO));
    }

    private void verifyCode(HttpServletRequest request) {
        String code = HttpEndpointUtils.getParameters(request).getFirst("code");
        if (StrUtil.isBlank(code)) {
            throw new CustomAuthenticationException(ResponseStatusEnum.CAPTCHA_EMPTY);
        }
        String randomCode = HttpEndpointUtils.getParameters(request).getFirst("randomCode");
        String savedCode = captchaService.findByRandomCode(randomCode);
        captchaService.remove(randomCode);

        if (StrUtil.isBlank(code) || !code.equals(savedCode)) {
            throw new CustomAuthenticationException(ResponseStatusEnum.CAPTCHA_INCORRECT);
        }
    }

    public Authentication attemptAuthentication(HttpServletRequest request)
            throws AuthenticationException {
        if (!request.getMethod().equals(HttpMethod.POST.name())) {
            throw new AuthenticationServiceException("认证方法不支持：" + request.getMethod());
        }

        MultiValueMap<String, String> parameters = HttpEndpointUtils.getParameters(request);
        String username = parameters.getFirst(SPRING_SECURITY_FORM_USERNAME_KEY);
        String password = parameters.getFirst(SPRING_SECURITY_FORM_PASSWORD_KEY);

        UsernamePasswordAuthenticationToken authRequest = UsernamePasswordAuthenticationToken.unauthenticated(username,
                password);

        return authenticationManager.authenticate(authRequest);
    }

    /**
     * Indicates whether this filter should attempt to process a login request for the
     * current invocation.
     *
     * @return <code>true</code> if the filter should attempt authentication,
     * <code>false</code> otherwise.
     */
    private boolean requiresAuthentication(HttpServletRequest request, HttpServletResponse response) {
        if (DEFAULT_ANT_PATH_REQUEST_MATCHER.matches(request)) {
            return true;
        }
        if (this.logger.isTraceEnabled()) {
            this.logger
                    .trace(LogMessage.format("Did not match request to %s", DEFAULT_ANT_PATH_REQUEST_MATCHER));
        }
        return false;
    }

    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
                                              AuthenticationException failed) throws IOException, ServletException {
        this.securityContextHolderStrategy.clearContext();
        this.logger.trace("Failed to process authentication request", failed);
        this.logger.trace("Cleared SecurityContextHolder");
        this.logger.trace("Handling authentication failure");
    }
}
