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

package me.pi.admin.workflow.mapper;

import lombok.RequiredArgsConstructor;
import me.pi.admin.common.util.SecurityUtils;
import org.flowable.engine.ManagementService;
import org.flowable.engine.impl.util.CommandContextUtil;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Set;

/**
 * @author ZnPi
 * @date 2023-06-05
 */
@Repository
@RequiredArgsConstructor
public class ProcessModelMapper {
    private final ManagementService managementService;

    public long countByCategory(Set<String> categories) {
        HashMap<String, Object> map = new HashMap<>(4);
        map.put("categories", categories);
        map.put("tenantId", SecurityUtils.getTenantId());
        return managementService.executeCommand(commandContext ->
                (long) CommandContextUtil.getDbSqlSession(commandContext)
                        .selectOne("countByCategory", map));
    }
}
