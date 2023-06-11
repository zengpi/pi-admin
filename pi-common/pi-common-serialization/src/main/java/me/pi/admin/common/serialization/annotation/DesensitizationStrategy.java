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

package me.pi.admin.common.serialization.annotation;

import cn.hutool.core.util.DesensitizedUtil;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.function.Function;

/**
 * 脱敏策略
 *
 * @author ZnPi
 * @date 2023-05-12
 * @see DesensitizedUtil.DesensitizedType
 */
@AllArgsConstructor
public enum DesensitizationStrategy {
    /**
     * 中文名
     */
    CHINESE_NAME(DesensitizedUtil::chineseName),
    /**
     * 身份证号
     */
    ID_CARD(s -> DesensitizedUtil.idCardNum(s, 2, 4)),
    /**
     * 座机号
     */
    FIXED_PHONE(DesensitizedUtil::fixedPhone),
    /**
     * 手机号
     */
    MOBILE_PHONE(DesensitizedUtil::mobilePhone),
    /**
     * 地址
     */
    ADDRESS(s -> DesensitizedUtil.address(s, 4)),
    /**
     * 电子邮件
     */
    EMAIL(DesensitizedUtil::email),
    /**
     * 密码
     */
    PASSWORD(DesensitizedUtil::password),
    /**
     * 中国大陆车牌，包含普通车辆、新能源车辆
     */
    CAR_LICENSE(DesensitizedUtil::carLicense),
    /**
     * 银行卡
     */
    BANK_CARD(DesensitizedUtil::bankCard),
    /**
     * IPv4地址
     */
    IPV4(DesensitizedUtil::ipv4),
    /**
     * IPv6地址
     */
    IPV6(DesensitizedUtil::ipv6),
    /**
     * 定义了一个first_mask的规则，只显示第一个字符。
     */
    FIRST_MASK(DesensitizedUtil::firstMask);

    @Getter
    private final Function<String, String> action;
}
