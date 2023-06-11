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


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.core.system.pojo.dto.RoleDTO;
import me.pi.admin.core.system.pojo.po.SysRole;
import me.pi.admin.core.system.pojo.vo.RoleVO;

import java.util.Collection;
import java.util.List;


/**
 * @author ZnPi
 * @since 2022-08-20
 */
public interface RoleService extends IService<SysRole> {
    /**
     * 获取角色
     *
     * @param query 查询参数
     * @return 角色
     */
    IPage<RoleVO> listRolesByCondition(BaseQuery query);

    /**
     * 新增或编辑角色
     *
     * @param dto RoleDTO
     */
    void saveOrUpdate(RoleDTO dto);

    /**
     * 角色删除
     *
     * @param ids 待删除 ID
     */
    void removeRoles(Collection<Long> ids);

    /**
     * 获取所有角色
     *
     * @return 角色
     */
    List<RoleVO> listRoles();

    /**
     * 根据用户 ID 获取该用户的角色
     *
     * @param id 用户 ID
     * @return 该用户的角色
     */
    List<SysRole> listByUserId(Long id);

    /**
     * 根据用户名获取该用户的角色
     *
     * @param username 用户名
     * @return 该用户的角色
     */
    List<SysRole> listByUserName(String username);

    /**
     * 根据用户名获取该用户的角色
     *
     * @param username 用户名
     * @param tenantId 租户
     * @return 该用户的角色
     */
    List<SysRole> listByUserName(String username, String tenantId);

    /**
     * 根据角色 ID 获取菜单 ID 列表
     *
     * @param roleId 角色 ID
     * @return 菜单 ID 列表
     */
    List<Long> listMenuIdsByRoleId(Long roleId);

    /**
     * 根据租户 ID 列表删除角色
     *
     * @param tenantIds 租户 ID 列表
     */
    void removeByTenantIds(Collection<String> tenantIds);

    /**
     * 根据租户获取角色
     *
     * @param tenantId 租户
     * @return 角色列表
     */
    List<SysRole> listByTenantId(String tenantId);
}
