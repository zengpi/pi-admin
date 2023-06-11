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
import me.pi.admin.common.constant.PiConstants;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.core.system.converter.PackageConverter;
import me.pi.admin.core.system.mapper.PackageMenuMapper;
import me.pi.admin.core.system.pojo.dto.PackageDTO;
import me.pi.admin.core.system.pojo.po.SysPackage;
import me.pi.admin.core.system.pojo.po.SysPackageMenu;
import me.pi.admin.core.system.pojo.query.PackageQuery;
import me.pi.admin.core.system.pojo.vo.PackageVO;
import me.pi.admin.core.system.service.PackageService;
import me.pi.admin.core.system.mapper.PackageMapper;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 针对表【sys_package】的数据库操作 Service 实现
 *
 * @author ZnPi
 * @date 2023-05-22
 */
@Service
@RequiredArgsConstructor
public class PackageServiceImpl extends ServiceImpl<PackageMapper, SysPackage>
        implements PackageService {
    private final PackageConverter packageConverter;
    private final PackageMapper packageMapper;

    @Override
    public IPage<PackageVO> getPackages(PackageQuery query) {
        IPage<SysPackage> page = super.page(query.page(), Wrappers.lambdaQuery(SysPackage.class)
                .eq(Objects.nonNull(query.getEnabled()), SysPackage::getEnabled, query.getEnabled())
                .like(StrUtil.isNotBlank(query.getKeyWord()), SysPackage::getName, query.getKeyWord())
                .select(SysPackage::getId, SysPackage::getCreateTime, SysPackage::getName, SysPackage::getEnabled,
                        SysPackage::getRemark)
                .orderByDesc(SysPackage::getCreateTime));
        return packageConverter.poPageToVo(page);
    }

    @Override
    public void saveOrUpdate(PackageDTO dto) {
        if (Objects.isNull(dto.getId())) {
            // 新增时判断套餐名称是否重复
            SysPackage pack = super.getOne(Wrappers.lambdaQuery(SysPackage.class)
                    .eq(SysPackage::getName, dto.getName()));
            if (Objects.nonNull(pack)) {
                throw new BizException("套餐名称 " + dto.getName() + " 已存在");
            }
        }
        SysPackage packageV = packageConverter.dtoToPo(dto);
        super.saveOrUpdate(packageV);
    }

    @Override
    public void delete(Collection<Long> ids) {
        if (ids.isEmpty()) {
            throw new BadRequestException("待删除记录的 id 列表不能为空");
        }
        if (!(ids instanceof Set)) {
            ids = new HashSet<>(ids);
        }
        if (isPackageUsed((Set<Long>) ids)) {
            throw new BizException("待删除记录中存在已使用的套餐，执行删除失败");
        }
        super.removeByIds(ids);
    }

    @Override
    public Boolean isExists(Long packageId) {
        long count = super.count(Wrappers.lambdaQuery(SysPackage.class)
                .eq(SysPackage::getId, packageId));
        return count > 0;
    }

    private boolean isPackageUsed(Set<Long> packageIds) {
        int count = packageMapper.selectUsedPackageCount(packageIds);
        return count > 0;
    }
}




