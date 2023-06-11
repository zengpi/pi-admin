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

package me.pi.admin.common.mybatis.enums;

import lombok.Getter;
import org.springframework.util.Assert;

import java.util.Objects;

/**
 * @author ZnPi
 * @date 2023-05-03
 */
public enum DataPermissionTypeEnum {
    /**
     * 全部
     */
    ALL(1),
    /**
     * 部门
     */
    DEPT(2, "#{#deptId} = #{#data.deptId}", "dept_id = #{#data.deptId}"),
    /**
     * 部门及下级部门
     */
    DEPT_AND_CHILD(3, "#{#deptId} IN (#{@dps.getDeptAndChildId(#data.deptId)})",
            "dept_id IN (#{@dps.getDeptAndChildId(#data.deptId)})"),
    /**
     * 自定义部门
     */
    CUSTOM_DEPT(4, "#{#deptId} IN (#{@dps.getDeptIdsByRoleId(#data.roleId)})",
            "dept_id IN (#{@dps.getDeptIdsByRoleId(#data.roleId)})"),
    /**
     * 本人
     */
    SELF(5, "#{#userId} = #{#data.id}", "user_id = #{#data.userId}");

    @Getter
    private final Integer code;
    @Getter
    private final String sqlTemplate;
    @Getter
    private String defaultSqlTemplate;

    DataPermissionTypeEnum(Integer code) {
        this.code = code;
        this.sqlTemplate = "";
    }

    DataPermissionTypeEnum(Integer code, String sqlTemplate) {
        Assert.notNull(sqlTemplate, "sql 模板不能为空");
        this.code = code;
        this.sqlTemplate = sqlTemplate;
    }

    DataPermissionTypeEnum(Integer code, String sqlTemplate, String defaultSqlTemplate) {
        Assert.notNull(sqlTemplate, "sql 模板不能为空");
        this.code = code;
        this.sqlTemplate = sqlTemplate;
        this.defaultSqlTemplate = defaultSqlTemplate;
    }

    public static DataPermissionTypeEnum getDataPermissionType(Integer code) {
        if (Objects.isNull(code)) {
            return null;
        }
        for (DataPermissionTypeEnum dataPermissionTypeEnum : values()) {
            if (dataPermissionTypeEnum.getCode().equals(code)) {
                return dataPermissionTypeEnum;
            }
        }
        return null;
    }
}
