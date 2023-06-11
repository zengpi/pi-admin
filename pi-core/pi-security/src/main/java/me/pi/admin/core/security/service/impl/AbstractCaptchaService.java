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

import com.pig4cloud.captcha.ArithmeticCaptcha;
import lombok.*;
import me.pi.admin.core.security.service.CaptchaService;
import org.springframework.beans.factory.annotation.Value;

import javax.servlet.http.HttpServletResponse;

/**
 * @author ZnPi
 * @since 2023-01-03
 */
@NoArgsConstructor
@AllArgsConstructor
public abstract class AbstractCaptchaService implements CaptchaService {
    @Setter
    private Integer imageWidth = 100;
    @Setter
    private Integer imageHeight = 32;

    @Override
    @SneakyThrows
    public final void genCaptcha(HttpServletResponse response, String randomCode) {
        ArithmeticCaptcha arithmeticCaptcha = new ArithmeticCaptcha(imageWidth, imageHeight);
        String captcha = arithmeticCaptcha.text();

        this.save(randomCode, captcha);

        arithmeticCaptcha.out(response.getOutputStream());
    }
}
