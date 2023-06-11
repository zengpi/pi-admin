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
import me.pi.admin.core.system.pojo.dto.EnterpriseDTO;
import me.pi.admin.core.system.pojo.po.SysEnterprise;
import me.pi.admin.core.system.pojo.vo.EnterpriseVO;
import org.mapstruct.Mapper;

/**
 * @author ZnPi
 * @date 2023-05-19
 */
@Mapper(componentModel = "spring")
public interface EnterpriseConverter {
    /**
     * IPage<SysEnterprise> -> PiPage<EnterpriseVO>
     *
     * @param page IPage<SysEnterprise>
     * @return PiPage<EnterpriseVO>
     */
    PiPage<EnterpriseVO> poPageToVo(IPage<SysEnterprise> page);

    /**
     * SysEnterprise -> EnterpriseVO
     *
     * @param po SysEnterprise
     * @return EnterpriseVO
     */
    EnterpriseVO poToVo(SysEnterprise po);

    /**
     * EnterpriseDTO -> SysEnterprise
     *
     * @param dto EnterpriseDTO
     * @return SysEnterprise
     */
    SysEnterprise dtoToPo(EnterpriseDTO dto);
}
