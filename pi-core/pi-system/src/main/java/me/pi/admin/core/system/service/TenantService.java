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
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.core.system.pojo.dto.TenantSaveDTO;
import me.pi.admin.core.system.pojo.dto.TenantUpdateDTO;
import me.pi.admin.core.system.pojo.po.SysTenant;
import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.core.system.pojo.vo.TenantVO;

import java.util.Collection;
import java.util.List;
import java.util.Set;

/**
 * 针对表【sys_tenant】的数据库操作 Service
 *
 * @author ZnPi
 * @date 2023-05-22
 */
public interface TenantService extends IService<SysTenant> {

    /**
     * 查询租户
     *
     * @param query 查询参数
     * @return 租户列表
     */
    IPage<TenantVO> listTenantsByCondition(BaseQuery query);

    /**
     * 新增
     *
     * @param dto 租户新增 DTO
     */
    void saveTenant(TenantSaveDTO dto);

    /**
     * 更新租户
     *
     * @param dto 租户更新 DTO
     */
    void updateTenant(TenantUpdateDTO dto);

    /**
     * 根据租户账号获取租户信息
     *
     * @param username 租户账号
     * @return 租户信息，当 username 为 null 时返回所有
     */
    List<SysTenant> getTenantsByUsername(String username);

    /**
     * 根据租户获取租户用户数量限制
     *
     * @param tenantCode 租户
     * @return 租户用户数量限制
     */
    Long getTenantUserQuantityLimit(String tenantCode);

    /**
     * 企业是否为租户
     *
     * @param enterpriseIds 企业 ID 列表
     * @return 只要有一个企业为租户，则返回 True
     */
    Boolean isEnterpriseTenant(Set<Long> enterpriseIds);

    /**
     * 删除租户
     *
     * @param ids 待删除租户 ID 列表
     */
    void deleteTenants(Collection<Long> ids);
}
