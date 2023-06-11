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
import me.pi.admin.core.system.pojo.dto.PackageDTO;
import me.pi.admin.core.system.pojo.po.SysPackage;
import me.pi.admin.core.system.pojo.vo.PackageVO;
import org.mapstruct.Mapper;

/**
 * @author ZnPi
 * @date 2023-05-22
 */
@Mapper(componentModel = "spring")
public interface PackageConverter {

    /**
     * PackageDTO ->
     * @param dto PackageDTO
     * @return SysPackage
     */
    SysPackage dtoToPo(PackageDTO dto);

    /**
     * IPage<SysPackage> -> PiPage<PackageVO>
     * @param page IPage<SysPackage>
     * @return PiPage<PackageVO>
     */
    PiPage<PackageVO> poPageToVo(IPage<SysPackage> page);
}
