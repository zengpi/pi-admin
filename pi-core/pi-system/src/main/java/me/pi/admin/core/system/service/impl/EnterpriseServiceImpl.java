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
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.core.system.converter.EnterpriseConverter;
import me.pi.admin.core.system.pojo.dto.EnterpriseDTO;
import me.pi.admin.core.system.pojo.po.SysEnterprise;
import me.pi.admin.core.system.pojo.vo.EnterpriseVO;
import me.pi.admin.core.system.service.EnterpriseService;
import me.pi.admin.core.system.mapper.EnterpriseMapper;
import me.pi.admin.core.system.service.TenantService;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

/**
 * 针对表【sys_enterprise】的数据库操作 Service 实现
 *
 * @author ZnPi
 * @date 2023-05-19
 */
@Service
@RequiredArgsConstructor
public class EnterpriseServiceImpl extends ServiceImpl<EnterpriseMapper, SysEnterprise>
        implements EnterpriseService {
    private final EnterpriseConverter enterpriseConverter;
    private final TenantService tenantService;

    @Override
    public IPage<EnterpriseVO> getEnterprises(BaseQuery query) {
        IPage<SysEnterprise> page = super.page(query.page(), Wrappers.lambdaQuery(SysEnterprise.class)
                .like(StrUtil.isNotBlank(query.getKeyWord()), SysEnterprise::getName, query.getKeyWord())
                .or()
                .eq(StrUtil.isNotBlank(query.getKeyWord()), SysEnterprise::getUsci, query.getKeyWord())
                .select(SysEnterprise::getId, SysEnterprise::getCreateTime, SysEnterprise::getName,
                        SysEnterprise::getNameEn, SysEnterprise::getShortName,
                        SysEnterprise::getUsci, SysEnterprise::getRegisteredCurrency,
                        SysEnterprise::getRegisteredCapital, SysEnterprise::getLegalPerson,
                        SysEnterprise::getEstablishingTime, SysEnterprise::getBusinessNature,
                        SysEnterprise::getIndustryInvolved, SysEnterprise::getRegisteredAddress,
                        SysEnterprise::getBusinessScope, SysEnterprise::getStaffNumber, SysEnterprise::getState)
                .orderByDesc(SysEnterprise::getCreateTime));
        return enterpriseConverter.poPageToVo(page);
    }

    @Override
    public void saveOrUpdate(EnterpriseDTO dto) {
        if (Objects.isNull(dto.getId())) {
            SysEnterprise enterprise = super.getOne(Wrappers.lambdaQuery(SysEnterprise.class)
                    .eq(SysEnterprise::getName, dto.getName()));
            if (Objects.nonNull(enterprise)) {
                throw new BizException("已存在企业名称为 " + dto.getName() + " 的企业");
            }
        }
        SysEnterprise enterprise = enterpriseConverter.dtoToPo(dto);
        super.saveOrUpdate(enterprise);
    }

    @Override
    public void delete(Collection<Long> ids) {
        if (ids.isEmpty()) {
            throw new BadRequestException("待删除记录的 id 列表不能为空");
        }
        if (!(ids instanceof Set)) {
            ids = new HashSet<>(ids);
        }

        // 已成为租户的企业无法删除
        Boolean isTenant = tenantService.isEnterpriseTenant((Set<Long>) ids);
        if (isTenant) {
            throw new BizException("待删除记录中存在租户企业，请删除指定租户后重试");
        }

        super.removeByIds(ids);
    }
}




