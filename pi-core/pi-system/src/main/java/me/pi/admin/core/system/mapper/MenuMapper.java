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

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import me.pi.admin.core.system.pojo.po.SysMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author ZnPi
 * @since 2022-08-19
 */
public interface MenuMapper extends BaseMapper<SysMenu> {
    /**
     * 根据租户获取菜单
     *
     * @param tenantId 租户
     * @return 菜单列表
     */
    List<SysMenu> listMenuByTenantId(@Param("tenantId") String tenantId);

    /**
     * 根据角色编码列表获取菜单
     *
     * @param roleCodeList 角色编码列表
     * @return 菜单
     */
    List<SysMenu> listMenuByRoleCodeList(@Param("roleCodeList") List<String> roleCodeList);

    /**
     * 根据角色 ID 获取权限标识
     *
     * @param ids 角色 ID
     * @return 权限标识
     */
    List<SysMenu> listPermissionByRoleIds(@Param("ids") Long[] ids);
}
