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

import lombok.RequiredArgsConstructor;
import me.pi.admin.common.constant.CacheConstants;
import me.pi.admin.core.security.config.properties.AuthProperties;
import me.pi.admin.core.security.config.properties.JwtProperties;
import me.pi.admin.core.security.service.AuthenticationService;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.Objects;
import java.util.concurrent.TimeUnit;

/**
 * @author ZnPi
 * @since 2023-01-04
 */
@Service
@RequiredArgsConstructor
public class RedisAuthenticationServiceImpl implements AuthenticationService {
    private static final Long DEFAULT_TOKEN_EXPIRE = 14400L;
    private final RedisTemplate<String, Object> redisTemplate;
    private final AuthProperties authProperties;

    @Override
    public void save(String jws, Authentication authentication) {
        long tokenExpire = DEFAULT_TOKEN_EXPIRE;
        JwtProperties jwtProperties = authProperties.getJwt();
        if(Objects.nonNull(jwtProperties) && Objects.nonNull(jwtProperties.getExpire())) {
            tokenExpire = jwtProperties.getExpire();
        }
        redisTemplate.opsForValue().set(buildKey(jws), authentication, tokenExpire, TimeUnit.SECONDS);
    }

    @Override
    public Authentication findByToken(String token) {
        return (Authentication) redisTemplate.opsForValue().get(buildKey(token));
    }

    @Override
    public void remove(String token) {
        redisTemplate.delete(buildKey(token));
    }

    @Override
    public Long getExpire(String token, TimeUnit timeUnit) {
        return redisTemplate.getExpire(buildKey(token), timeUnit);
    }

    @Override
    public void setExpire(String token, long timeout, TimeUnit unit) {
        redisTemplate.expire(buildKey(token), timeout, unit);
    }

    private String buildKey(String token){
        return String.format("%s:%s", CacheConstants.CACHE_TOKEN, token);
    }
}
