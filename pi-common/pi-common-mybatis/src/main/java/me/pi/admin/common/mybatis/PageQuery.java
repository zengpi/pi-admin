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

package me.pi.admin.common.mybatis;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BadRequestException;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 分页查询
 *
 * @author ZnPi
 * @date 2023-04-01
 */
@Data
@Schema(title = "分页查询")
public class PageQuery {
    /**
     * 页码默认值
     */
    private static final Integer DEFAULT_PAGE_NUM = 1;
    /**
     * 每页记录数默认值
     */
    private static final Integer DEFAULT_PAGE_SIZE = 20;
    /**
     * 页码
     */
    @Schema(description = "页码")
    private Integer pageNum = DEFAULT_PAGE_NUM;

    /**
     * 每页记录数
     */
    @Schema(description = "每页记录数")
    private Integer pageSize = DEFAULT_PAGE_SIZE;

    /**
     * <p>
     * 排序列
     * </p>
     * {"orderByColumns": "name,age"}
     */
    @Schema(description = "排序列")
    private String orderByColumns;

    /**
     * <p>
     * 排序规则
     * </p>
     * <ul>
     * <li>如果所有排序规则都相同，则只需要指定一个：{"orderings": "desc"};</li>
     * <li>如果规则之一不同，则需要指定多个，并且与 orderByColumns 列数相同：{"orderings": "asc,desc"}</li>
     * </ul>
     */
    @Schema(description = "排序规则")
    private String orderings;

    public <T> IPage<T> page() {
        PiPage<T> page = new PiPage<>(this.pageNum, this.pageSize);
        List<OrderItem> orderItems = buildOrderItem();
        if (CollUtil.isNotEmpty(orderItems)) {
            page.addOrder(orderItems);
        }
        return page;
    }

    private List<OrderItem> buildOrderItem() {
        if (!StringUtils.hasText(this.orderByColumns) || !StringUtils.hasText(this.orderings)) {
            return null;
        }
        String underlineCaseOrderByColumns = StrUtil.toUnderlineCase(this.orderByColumns);
        String[] orderByColumnArr = underlineCaseOrderByColumns.split(",");
        String[] orderingArr = this.orderings.split(",");
        if (orderingArr.length != 1 && orderingArr.length != orderByColumnArr.length) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "排序规则不符合要求");
        }
        ArrayList<OrderItem> orderItems = new ArrayList<>();
        for (int i = 0; i < orderByColumnArr.length; i++) {
            String orderByColumn = orderByColumnArr[i];
            String ordering = orderingArr.length == 1 ? orderingArr[0] : orderingArr[i];
            if ("asc".equals(ordering)) {
                orderItems.add(OrderItem.asc(orderByColumn));
            } else if ("desc".equals(ordering)) {
                orderItems.add(OrderItem.desc(orderByColumn));
            } else {
                throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "排序参数错误，可选：asc/desc");
            }
        }
        return orderItems;
    }
}
