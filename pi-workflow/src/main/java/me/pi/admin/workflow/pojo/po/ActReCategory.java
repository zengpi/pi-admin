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

package me.pi.admin.workflow.pojo.po;

import lombok.Data;
import lombok.EqualsAndHashCode;
import me.pi.admin.common.mybatis.BaseEntity;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ActReCategory extends BaseEntity {
    /**
     * 分类编码
     */
    private String code;
    /**
     * 分类名称
     */
    private String name;
    /**
     * 是否删除（0:=未删除, 1:=已删除）
     */
    private Integer deleted;
    /**
     * 备注
     */
    private String remark;
}
