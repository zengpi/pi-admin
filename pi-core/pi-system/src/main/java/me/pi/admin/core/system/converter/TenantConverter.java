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
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.core.system.pojo.dto.TenantSaveDTO;
import me.pi.admin.core.system.pojo.dto.TenantUpdateDTO;
import me.pi.admin.core.system.pojo.po.SysTenant;
import me.pi.admin.core.system.pojo.vo.LoginTenantVO;
import me.pi.admin.core.system.pojo.vo.TenantVO;
import org.mapstruct.Mapper;

import java.util.List;

/**
 * @author ZnPi
 * @date 2023-05-22
 */
@Mapper(componentModel = "spring")
public interface TenantConverter {
    /**
     * SysTenant -> TenantVO
     *
     * @param po SysTenant
     * @return TenantVO
     */
    TenantVO poToVo(SysTenant po);

    /**
     * IPage<SysTenant> -> IPage<TenantVO>
     *
     * @param page IPage<SysTenant>
     * @return IPage<TenantVO>
     */
    PiPage<TenantVO> poPageToVo(IPage<SysTenant> page);

    /**
     * TenantSaveDTO -> SysTenant
     *
     * @param dto TenantSaveDTO
     * @return SysTenant
     */
    SysTenant saveDtoToPo(TenantSaveDTO dto);

    /**
     * List<SysTenant> -> List<LoginTenantVO>
     *
     * @param tenantByTenantAccount List<SysTenant>
     * @return List<LoginTenantVO>
     */
    List<LoginTenantVO> posToLoginVos(List<SysTenant> tenantByTenantAccount);

    /**
     * TenantUpdateDTO -> SysTenant
     *
     * @param dto TenantUpdateDTO
     * @return SysTenant
     */
    SysTenant updateDtoToPo(TenantUpdateDTO dto);
}
