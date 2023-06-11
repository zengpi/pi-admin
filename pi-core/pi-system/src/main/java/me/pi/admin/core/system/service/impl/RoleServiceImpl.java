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

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.constant.TenantConstant;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.enums.DataPermissionTypeEnum;
import me.pi.admin.common.util.SecurityUtils;
import me.pi.admin.core.system.converter.RoleConverter;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.core.system.mapper.RoleMapper;
import me.pi.admin.core.system.pojo.po.SysRoleDeptDataPermission;
import me.pi.admin.core.system.service.RoleDeptService;
import me.pi.admin.core.system.service.RoleService;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.core.system.pojo.dto.RoleDTO;
import me.pi.admin.core.system.pojo.po.SysRole;
import me.pi.admin.core.system.pojo.vo.RoleVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @since 2022-08-20
 */
@Service
@RequiredArgsConstructor
public class RoleServiceImpl extends ServiceImpl<RoleMapper, SysRole> implements RoleService {
    private final RoleMapper roleMapper;
    private final RoleConverter roleConverter;
    private final RoleDeptService roleDeptService;

    @Override
    public IPage<RoleVO> listRolesByCondition(BaseQuery query) {
        IPage<SysRole> roles = super.page(query.page(), Wrappers.lambdaQuery(SysRole.class)
                .like(StrUtil.isNotBlank(query.getKeyWord()), SysRole::getName, query.getKeyWord())
                .or()
                .like(StrUtil.isNotBlank(query.getKeyWord()), SysRole::getRoleCode, query.getKeyWord())
                .select(SysRole::getId, SysRole::getName, SysRole::getRoleCode, SysRole::getRoleScope,
                        SysRole::getRoleDesc)
        );
        return roleConverter.sysRolePageToRoleVoPage(roles);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveOrUpdate(RoleDTO dto) {
        // 非平台用户无法新增 超级管理员 角色
        if (TenantConstant.SUPER_ADMIN_ROLE_CODE.equals(dto.getRoleCode())) {
            if (!TenantConstant.PLATFORM_MANAGER_TENANT_ID.equals(SecurityUtils.getTenantId())) {
                throw new BizException("非平台用户无法新增 " + TenantConstant.SUPER_ADMIN_ROLE_CODE + " 角色");
            }
        }

        // 角色编码不能重复
        long count = super.count(Wrappers.lambdaQuery(SysRole.class)
                .eq(SysRole::getRoleCode, dto.getRoleCode()));
        if (count > 0) {
            throw new BizException("已存在编码为 " + dto.getRoleCode() + " 的角色");
        }

        // 执行编辑或保存
        SysRole sysRole = roleConverter.roleDtoToSysRole(dto);
        super.saveOrUpdate(sysRole);

        // 维护自定义部门角色数据权限
        if (dto.getRoleScope().equals(DataPermissionTypeEnum.CUSTOM_DEPT.getCode())) {
            handleCustomDeptRoleDataPermission(dto, sysRole);
        }
    }

    @Override
    public void removeRoles(Collection<Long> ids) {
        if (ids.isEmpty()) {
            throw new BadRequestException("待删除记录的 id 列表不能为空");
        }
        if (!(ids instanceof Set)) {
            ids = new HashSet<>(ids);
        }

        super.removeByIds(ids);

        // 删除自定义角色部门数据权限
        roleDeptService.remove(Wrappers.lambdaQuery(SysRoleDeptDataPermission.class)
                .in(SysRoleDeptDataPermission::getRoleId, ids));
    }

    @Override
    public List<SysRole> listByUserId(Long id) {
        return roleMapper.listRoleByUserId(id);
    }

    @Override
    public List<SysRole> listByUserName(String username) {
        return roleMapper.listRoleByUsername(username);
    }

    @Override
    public List<SysRole> listByUserName(String username, String tenantId) {
        return roleMapper.listRoleByUsernameAndTenantId(username, tenantId);
    }

    @Override
    public List<RoleVO> listRoles() {
        List<SysRole> sysRoleList = super.list(Wrappers.lambdaQuery(SysRole.class)
                .select(SysRole::getId, SysRole::getName, SysRole::getRoleCode, SysRole::getRoleDesc));
        return roleConverter.sysRoleListToRoleVoList(sysRoleList);
    }

    @Override
    public List<Long> listMenuIdsByRoleId(Long roleId) {
        return roleMapper.getMenuIdsByRoleId(roleId);
    }

    @Override
    public void removeByTenantIds(Collection<String> tenantIds) {
        if(tenantIds.isEmpty()) {
            throw new BizException("待删除租户 ID 列表不能为空");
        }

        if(!(tenantIds instanceof Set)) {
            tenantIds = new HashSet<>(tenantIds);
        }

        roleMapper.deleteByTenantIds(tenantIds);
    }

    @Override
    public List<SysRole> listByTenantId(String tenantId) {
        return roleMapper.selectByTenantId(tenantId);
    }

    /**
     * 维护自定义部门角色数据权限
     *
     * @param dto     待新增或编辑角色
     * @param sysRole 当前角色
     */
    private void handleCustomDeptRoleDataPermission(RoleDTO dto, SysRole sysRole) {
        if (dto.getCustomDept() == null || dto.getCustomDept().length == 0) {
            throw new BadRequestException(ResponseStatusEnum.REQUEST_PARAM_ERROR, "部门不能为空");
        }

        HashSet<Long> newDeptIds = new HashSet<>(Arrays.asList(dto.getCustomDept()));
        // 新增部门直接添加角色部门数据权限
        if (null == dto.getId()) {
            List<SysRoleDeptDataPermission> toBeSaved = newDeptIds.stream()
                    .map(id -> new SysRoleDeptDataPermission(sysRole.getId(), id))
                    .collect(Collectors.toList());
            roleDeptService.saveBatch(toBeSaved);
            return;
        }

        HashSet<Long> curDeptIds = new HashSet<>(roleDeptService.getDeptIdsByRoleId(sysRole.getId()));
        // 编辑部门且当前没有任何角色部门数据权限，则直接添加
        if (curDeptIds.isEmpty()) {
            List<SysRoleDeptDataPermission> toBeSaved = newDeptIds.stream()
                    .map(id -> new SysRoleDeptDataPermission(sysRole.getId(), id))
                    .collect(Collectors.toList());
            roleDeptService.saveBatch(toBeSaved);
            return;
        }

        // 当前已有角色部门数据权限，找出待新增和待删除记录
        List<SysRoleDeptDataPermission> toBeSaved = newDeptIds.stream()
                .filter(newDeptId -> !curDeptIds.contains(newDeptId))
                .map(newDeptId -> new SysRoleDeptDataPermission(sysRole.getId(), newDeptId))
                .collect(Collectors.toList());
        roleDeptService.saveBatch(toBeSaved);

        Set<Long> toBeRemoved = curDeptIds.stream()
                .filter(id -> !newDeptIds.contains(id))
                .collect(Collectors.toSet());
        roleDeptService.removeByIds(toBeRemoved);
    }
}
