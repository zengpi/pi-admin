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

package me.pi.admin.core.system.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import me.pi.admin.core.system.pojo.po.SysDept;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;

/**
 * @author ZnPi
 * @since 2022-08-29
 */
public interface DeptMapper extends BaseMapper<SysDept> {
    /**
     * 根据部门 ID 判断是否存在
     * @param deptId 部门 ID
     * @return 1：存在；null：不存在
     */
    Integer existsByDeptId(@Param("deptId") Long deptId);

    /**
     * 根据租户 ID 列表删除部门
     *
     * @param tenantIds 租户 ID 列表
     */
    @InterceptorIgnore(tenantLine = "true")
    void deleteByTenantIds(@Param("tenantIds") Collection<String> tenantIds);
}
