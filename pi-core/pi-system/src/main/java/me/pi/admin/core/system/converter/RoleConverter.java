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

package me.pi.admin.core.system.converter;

import com.baomidou.mybatisplus.core.metadata.IPage;
import me.pi.admin.core.system.pojo.dto.RoleDTO;
import me.pi.admin.core.system.pojo.vo.RoleVO;
import me.pi.admin.core.system.pojo.po.SysRole;
import me.pi.admin.common.mybatis.PiPage;
import org.mapstruct.Mapper;

import java.util.List;

/**
 * @author ZnPi
 * @since 2022-09-04
 */
@Mapper(componentModel = "spring")
public interface RoleConverter {
    /**
     * PiPage<SysRole> -> PiPage<RoleVO>
     * @param rolePage PiPage<SysRole>
     * @return PiPage<RoleVO>
     */
    PiPage<RoleVO> sysRolePageToRoleVoPage(IPage<SysRole> rolePage);

    /**
     * List<SysRole> -> List<RoleVO>
     * @param roleList List<SysRole>
     * @return List<RoleVO>
     */
    List<RoleVO> sysRoleListToRoleVoList(List<SysRole> roleList);

    /**
     * RoleDTO -> SysRole
     * @param dto RoleDTO
     * @return SysRole
     */
    SysRole roleDtoToSysRole(RoleDTO dto);
}
