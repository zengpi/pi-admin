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
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.core.system.pojo.po.SysUser;
import me.pi.admin.core.system.pojo.query.RoleMemberQuery;
import me.pi.admin.core.system.pojo.query.UserQuery;
import me.pi.admin.core.system.pojo.vo.OptionalUserVO;
import me.pi.admin.core.system.pojo.vo.RoleMemberVO;
import me.pi.admin.core.system.pojo.vo.UserExportVO;
import me.pi.admin.core.system.pojo.vo.UserVO;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;
import java.util.List;

/**
 * @author ZnPi
 * @since 2022-08-19
 */
public interface UserMapper extends BaseMapper<SysUser> {
    /**
     * 获取用户
     *
     * @param query 查询条件
     * @param page      分页
     * @return 用户
     */
    PiPage<UserVO> listUsers(@Param("page") IPage<?> page, @Param("query") UserQuery query);

    /**
     * 指定的用户名是否存在
     *
     * @param username 用户名
     * @return 如果用户存在，则返回 1，否则返回 null
     */
    Integer existsByUsername(@Param("username") String username);

    /**
     * 获取待导出记录
     *
     * @param page  分页
     * @param query 查询条件
     * @return 下载记录
     */
    List<UserExportVO> listExportRecode(@Param("page") IPage<UserExportVO> page, @Param("query") UserQuery query);

    /**
     * 可选用户
     *
     * @param page 分页参数
     * @param query 查询条件
     * @return 可选用户列表
     */
    PiPage<OptionalUserVO> listOptionalUsers(@Param("page") PiPage<OptionalUserVO> page, @Param("query") BaseQuery query);

    /**
     * 获取角色成员
     *
     * @param page       分页
     * @param query 查询参数
     * @return 角色成员
     */
    PiPage<RoleMemberVO> getRoleMembers(@Param("page") PiPage<RoleMemberVO> page, @Param("query") RoleMemberQuery query);

    /**
     * 根据租户 ID 列表删除用户
     *
     * @param tenantIds 租户 ID 列表
     */
    @InterceptorIgnore(tenantLine = "true")
    void deleteByTenantIds(@Param("tenantIds") Collection<String> tenantIds);
}
