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
import com.baomidou.mybatisplus.core.metadata.IPage;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.core.system.pojo.dto.TenantRoleMenuDTO;
import me.pi.admin.core.system.pojo.po.SysTenant;
import me.pi.admin.core.system.pojo.vo.TenantVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

/**
 * 针对表【sys_tenant】的数据库操作 Mapper
 *
 * @author ZnPi
 * @date 2023-05-22
 * @see me.pi.admin.core.system.pojo.po.SysTenant
 */
public interface TenantMapper extends BaseMapper<SysTenant> {

    /**
     * 根据条件分页查询租户
     *
     * @param page  分页参数
     * @param query 查询参数
     * @return 租户
     */
    IPage<TenantVO> selectPageTenantsByCondition(IPage<Object> page, BaseQuery query);

    /**
     * 根据租户账号获取租户信息
     *
     * @param username 租户账号
     * @return 租户信息，当 username 为 null 时返回所有
     */
    List<SysTenant> getTenantsByUsername(@Param("username") String username);
}




