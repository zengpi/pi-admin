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

package me.pi.admin.core.system.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import me.pi.admin.core.system.mapper.RoleDeptMapper;
import me.pi.admin.core.system.pojo.po.SysRoleDeptDataPermission;
import me.pi.admin.core.system.service.RoleDeptService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @date 2023-05-09
 */
@Service
public class RoleDeptServiceImpl extends ServiceImpl<RoleDeptMapper, SysRoleDeptDataPermission> implements RoleDeptService {
    @Override
    public List<Long> getDeptIdsByRoleId(Long roleId) {
        return super.list(Wrappers.lambdaQuery(SysRoleDeptDataPermission.class)
                        .eq(SysRoleDeptDataPermission::getRoleId, roleId)
                        .select(SysRoleDeptDataPermission::getDeptId))
                .stream()
                .map(SysRoleDeptDataPermission::getDeptId)
                .collect(Collectors.toList());
    }
}
