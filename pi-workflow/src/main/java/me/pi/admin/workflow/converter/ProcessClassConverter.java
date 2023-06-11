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

package me.pi.admin.workflow.converter;

import com.baomidou.mybatisplus.core.metadata.IPage;
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.workflow.pojo.dto.ProcessCategoryDTO;
import me.pi.admin.workflow.pojo.po.ActReCategory;
import me.pi.admin.workflow.pojo.vo.ProcessCategoryVO;
import org.mapstruct.Mapper;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
@Mapper(componentModel = "spring")
public interface ProcessClassConverter {
    /**
     * ActReClass -> ProcessClassVO
     * @param processClass ActReClass
     * @return ProcessClassVO
     */
    ProcessCategoryVO classToVo(ActReCategory processClass);

    /**
     * IPage<ActReClass> -> PiPage<ProcessClassVO>
     * @param processClass IPage<ActReClass>
     * @return PiPage<ProcessClassVO>
     */
    PiPage<ProcessCategoryVO> poPageToVoPage(IPage<ActReCategory> processClass);

    /**
     * ProcessClassDTO -> ActReClass
     * @param processCategoryDto ProcessClassDTO
     * @return ActReClass
     */
    ActReCategory dtoToPo(ProcessCategoryDTO processCategoryDto);
}
