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

package me.pi.admin.core.security.service;

import javax.servlet.http.HttpServletResponse;

/**
 * 验证码
 *
 * @author ZnPi
 * @since 2023-01-03
 */
public interface CaptchaService {
    /**
     * 生成验证码并保存，将结果写入 HttpServletResponse 中。
     *
     * @param response   响应
     * @param randomCode 随机码
     */
    void genCaptcha(HttpServletResponse response, String randomCode);

    /**
     * 保存验证码
     *
     * @param randomCode 随机码
     * @param captcha    验证码
     */
    void save(String randomCode, String captcha);

    /**
     * 删除指定随机码对应的验证码
     *
     * @param randomCode 随机码
     */
    void remove(String randomCode);

    /**
     * 根据随机码查找
     *
     * @param randomCode 随机码
     * @return 验证码
     */
    String findByRandomCode(String randomCode);
}
