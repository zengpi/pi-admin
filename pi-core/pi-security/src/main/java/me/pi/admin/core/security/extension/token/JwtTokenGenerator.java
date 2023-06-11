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

package me.pi.admin.core.security.extension.token;

import cn.hutool.core.util.IdUtil;
import io.jsonwebtoken.IncorrectClaimException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.pi.admin.core.security.config.properties.AuthProperties;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.crypto.SecretKey;

/**
 * @author ZnPi
 * @since 2022-11-27
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class JwtTokenGenerator implements TokenGenerator {
    private final AuthProperties authProperties;
    private SecretKey key;
    private static final String ISSUER = "pi-admin";

    @PostConstruct
    public void init() {
        key = Keys.hmacShaKeyFor(Decoders.BASE64.decode(authProperties.getJwt().getSecret()));
    }

    @Override
    public String build(Authentication authentication) {
        return Jwts.builder()
                .setId(IdUtil.simpleUUID())
                .setIssuer(ISSUER)
                .setSubject(authentication.getName())
                .signWith(key)
                .compact();
    }

    @Override
    public boolean verify(String jws) {
        try {
            Jwts.parserBuilder()
                    .requireIssuer(ISSUER)
                    .setSigningKey(key)
                    .build().parseClaimsJws(jws);
        } catch (IncorrectClaimException | SignatureException e) {
            log.error(e.getMessage());
            return false;
        }
        return true;
    }
}
