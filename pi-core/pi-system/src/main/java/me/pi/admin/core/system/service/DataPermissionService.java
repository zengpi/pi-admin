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

package me.pi.admin.core.system.service;

/**
 * @author ZnPi
 * @date 2023-05-09
 */
public interface DataPermissionService {
    /**
     * 通过部门 ID 获取当前部门及下级部门的部门 ID 列表，以逗号分隔
     *
     * @param deptId 当前部门 ID
     * @return 当前部门及下级部门的部门 ID 列表，以逗号分隔
     */
    String getDeptAndChildId(Long deptId);

    /**
     * 通过角色 ID 获取部门 ID 列表
     * @param roleId 角色 ID
     * @return 部门 ID 列表
     */
    String getDeptIdsByRoleId(Long roleId);
}
