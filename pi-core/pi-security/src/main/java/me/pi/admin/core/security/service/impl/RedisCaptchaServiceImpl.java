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

package me.pi.admin.core.security.service.impl;

import me.pi.admin.common.constant.CacheConstants;
import me.pi.admin.core.security.config.properties.AuthProperties;
import me.pi.admin.core.security.config.properties.CodeProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.concurrent.TimeUnit;

/**
 * @author ZnPi
 * @since 2023-01-03
 */
@Service
public class RedisCaptchaServiceImpl extends AbstractCaptchaService {
    private final StringRedisTemplate redisTemplate;
    private Long captchaTimeOut = 30L;

    @Autowired
    public RedisCaptchaServiceImpl(StringRedisTemplate redisTemplate, AuthProperties authProperties) {
        this.redisTemplate = redisTemplate;

        Optional<CodeProperties> codeProperties = Optional.ofNullable(authProperties.getCode());
        codeProperties.map(CodeProperties::getWidth).ifPresent(super::setImageWidth);
        codeProperties.map(CodeProperties::getHeight).ifPresent(super::setImageHeight);
        codeProperties.map(CodeProperties::getTimeout).ifPresent(timeOut -> this.captchaTimeOut = timeOut);
    }

    @Override
    public void save(String randomCode, String captcha) {
        redisTemplate.opsForValue().set(buildKey(randomCode), captcha,
                captchaTimeOut, TimeUnit.SECONDS);
    }

    @Override
    public void remove(String randomCode) {
        redisTemplate.delete(buildKey(randomCode));
    }

    @Override
    public String findByRandomCode(String randomCode) {
        return redisTemplate.opsForValue().get(buildKey(randomCode));
    }

    private String buildKey(String randomCode) {
        return String.format("%s:%s", CacheConstants.CAPTCHA_PREFIX, randomCode);
    }
}
