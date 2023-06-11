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

package me.pi.admin.core.security.listener;

import cn.hutool.core.date.DateField;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.util.DateUtil;
import me.pi.admin.core.security.config.properties.AuthProperties;
import me.pi.admin.core.security.event.SecurityEvent;
import me.pi.admin.core.security.service.AuthenticationService;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

/**
 * @author ZnPi
 * @date 2023-06-04
 */
@Component
@RequiredArgsConstructor
public class SecurityListener {
    /**
     * s/ms = 1_1000
     */
    private static final int S_MS_SCALE = 1_000;
    private final AuthenticationService authenticationService;
    private final AuthProperties authProperties;

    @Async
    @EventListener(SecurityEvent.class)
    public void processSecurityEvent(SecurityEvent event) {
        String bearerToken = (String) event.getSource();

        Long expire = authenticationService.getExpire(bearerToken, TimeUnit.MILLISECONDS);

        if(Objects.isNull(expire)) {
            throw new BadCredentialsException("无法获取 Token 的过期时间");
        }

        // 过期时间
        Date expireDate = DateUtil.offset(new Date(), DateField.MILLISECOND, expire.intValue());
        // 过期时间距离现在的毫秒数
        long differ = expireDate.getTime() - System.currentTimeMillis();
        if(differ < authProperties.getJwt().getRenewalThreshold() * S_MS_SCALE){
            long timeout = expire + authProperties.getJwt().getRenewalTime() * S_MS_SCALE;
            authenticationService.setExpire(bearerToken, timeout, TimeUnit.MILLISECONDS);
        }
    }
}
