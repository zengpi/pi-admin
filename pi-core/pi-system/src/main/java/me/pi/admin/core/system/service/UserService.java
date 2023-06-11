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

import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.core.system.pojo.query.OptionalUserQuery;
import me.pi.admin.core.system.pojo.dto.ProfileDTO;
import me.pi.admin.core.system.pojo.dto.UserDTO;
import me.pi.admin.core.system.pojo.dto.UserImportDTO;
import me.pi.admin.core.system.pojo.po.SysUser;
import me.pi.admin.core.system.pojo.query.RoleMemberQuery;
import me.pi.admin.core.system.pojo.query.UserQuery;
import me.pi.admin.core.system.pojo.vo.OptionalUserVO;
import me.pi.admin.core.system.pojo.vo.RoleMemberVO;
import me.pi.admin.core.system.pojo.vo.UserInfoVO;
import me.pi.admin.core.system.pojo.vo.UserVO;
import me.pi.admin.common.mybatis.PiPage;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

/**
 * @author ZnPi
 * @since 2022-08-19
 */
public interface UserService extends IService<SysUser> {
    /**
     * 用户查询
     *
     * @param query 查询条件
     * @return 用户
     */
    PiPage<UserVO> listUsers(UserQuery query);

    /**
     * 新增用户
     *
     * @param dto UserDTO
     */
    void saveUser(UserDTO dto);

    /**
     * 编辑用户
     *
     * @param dto UserDTO
     */
    void updateUser(UserDTO dto);

    /**
     * 删除用户
     *
     * @param ids 待删除用户 ID，多个以逗号分隔
     */
    void deleteUsers(String ids);

    /**
     * 根据用户名查找用户，不能暴露为接口，只供内部使用
     *
     * @param username 用户名
     * @return 用户
     */
    SysUser getByUsername(String username);

    /**
     * 根据用户名查找用户，不能暴露为接口，只供内部使用
     *
     * @param username 用户名
     * @param tenantId 租户
     * @return 用户
     */
    SysUser getByUsername(String username, String tenantId);

    /**
     * 用户导出
     *
     * @param query    用户查询参数
     * @param response 响应
     * @throws IOException If the named encoding is not supported / if an input or output exception occurred
     */
    void exportUser(UserQuery query, HttpServletResponse response) throws IOException;

    /**
     * 下载用户导入模板
     *
     * @param response HttpServletResponse
     * @throws IOException If the named encoding is not supported / if an input or output exception occurred
     */
    void downloadUserImportTemp(HttpServletResponse response) throws IOException;

    /**
     * 用户导入
     *
     * @param dto 用户导入 DTO
     * @return 导入结果
     */
    String importUser(UserImportDTO dto);

    /**
     * 获取用户信息
     *
     * @return /
     */
    UserInfoVO getUserInfo();

    /**
     * 修改用户个人信息
     *
     * @param profileDTO 待修改用户个人信息
     */
    void editProfile(ProfileDTO profileDTO);

    /**
     * 密码重置，默认密码为 123456
     *
     * @param id 待重置密码的用户 ID
     */
    void resetPass(Long id);

    /**
     * 可选用户。如：为角色指定用户时，需要先查询出可以选择的用户列表，然后选择用户
     *
     * @param query 查询条件
     * @return 可选用户列表
     */
    PiPage<OptionalUserVO> getOptionalUsers(OptionalUserQuery query);

    /**
     * 头像上传
     *
     * @param file     头像
     * @param username 用户名
     * @param avatar   旧头像名称
     */
    void uploadAvatar(MultipartFile file, String username, String avatar);


    /**
     * 角色成员
     *
     * @param query 查询参数
     * @return 角色成员
     */
    PiPage<RoleMemberVO> getRoleMembers(RoleMemberQuery query);

    /**
     * 根据租户 ID 列表删除用户
     *
     * @param tenantIds 租户 ID 列表
     */
    void removeByTenantIds(Collection<String> tenantIds);
}
