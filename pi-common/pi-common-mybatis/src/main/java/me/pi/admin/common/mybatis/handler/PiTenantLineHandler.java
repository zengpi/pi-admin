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

package me.pi.admin.common.mybatis.handler;

import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.config.TenantProperties;
import me.pi.admin.common.util.SecurityUtils;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.StringValue;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @date 2023-05-29
 */
public class PiTenantLineHandler implements TenantLineHandler {
    private final Set<String> ignoreTables;

    public PiTenantLineHandler(TenantProperties tenantProperties) {
        ignoreTables = genIgnoreTables(tenantProperties);
    }

    @Override
    public Expression getTenantId() {
        String tenantId = SecurityUtils.getTenantId();
        if (tenantId == null) {
            throw new BizException("获取租户失败");
        }
        return new StringValue(tenantId);
    }

    @Override
    public boolean ignoreTable(String tableName) {
        String tenantId = SecurityUtils.getTenantId();
        if (StrUtil.isNotEmpty(tenantId)) {
            return ignoreTables.contains(tableName);
        }
        return true;
    }

    private Set<String> genIgnoreTables(TenantProperties tenantProperties) {
        Set<String> systemIgnoreTables = new HashSet<>(ListUtil.toList(
                "sys_tenant",
                "sys_package",
                "sys_tenant_package",
                "sys_menu",
                "sys_package_menu",
                "sys_enterprise",
                "sys_role_menu",
                "sys_user_role",
                "sys_role_dept"));
        if (Objects.isNull(tenantProperties.getIgnores())) {
            return systemIgnoreTables;
        }
        Set<String> configIgnoreTables = tenantProperties.getIgnores().stream()
                .filter(StrUtil::isNotEmpty).collect(Collectors.toSet());
        systemIgnoreTables.addAll(configIgnoreTables);
        return systemIgnoreTables;
    }
}
