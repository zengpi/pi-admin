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
import me.pi.admin.core.system.pojo.po.SysPackageMenu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import me.pi.admin.core.system.pojo.po.SysRole;

import java.util.List;
import java.util.Set;

/**
 * 针对表【sys_package_menu】的数据库操作Mapper
 *
 * @author ZnPi
 * @date 2023-05-26
 * @see me.pi.admin.core.system.pojo.po.SysPackageMenu
 */
public interface PackageMenuMapper extends BaseMapper<SysPackageMenu> {

    /**
     * 根据套餐 ID 获取叶子菜单 ID 列表
     *
     * @param packageId 套餐 ID
     * @return 叶子菜单 ID 列表
     */
    Set<Long> getLeafMenuIdsByPackageId(Long packageId);

    /**
     * 根据套餐获取套餐的租户角色列表
     *
     * @param packageId 套餐标识
     * @return 套餐的租户角色列表
     */
    @InterceptorIgnore(tenantLine = "1")
    List<SysRole> getPackageTenantRolesByPackageId(Long packageId);
}




