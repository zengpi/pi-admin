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

package me.pi.admin.common.mybatis.util;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.PageQuery;
import me.pi.admin.common.mybatis.PiPage;
import org.apache.commons.lang3.StringUtils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.List;

/**
 * 分页工具
 *
 * @author linwei
 * @date 2023-05-05
 * @see PageQuery
 */
@Deprecated
public class PageUtil {
    public static <T> PiPage<T> toPage(PageQuery reqDTO, OrderItem... defaultOrders) {
        PiPage<T> page = new PiPage<>(reqDTO.getPageNum(), reqDTO.getPageSize());
        List<OrderItem> orders = getOrders(reqDTO.getOrderByColumns());
        if (CollectionUtils.isNotEmpty(orders)) {
            page.addOrder(orders);
        } else if (defaultOrders != null && defaultOrders.length > 0) {
            page.addOrder(Arrays.asList(defaultOrders));
        }
        return page;
    }

    private static List<OrderItem> getOrders(String sortOrder) {
        if (StringUtils.isBlank(sortOrder)) {
            return null;
        }

        try {
            sortOrder = URLDecoder.decode(sortOrder, StandardCharsets.UTF_8.name());
            return JSON.parseArray(sortOrder, OrderItem.class);
        } catch (UnsupportedEncodingException e) {
            throw new BizException(ResponseStatusEnum.BIZ_EXCEPTION, "url 转换错误：{}：" + e.getMessage());
        }
    }
}
