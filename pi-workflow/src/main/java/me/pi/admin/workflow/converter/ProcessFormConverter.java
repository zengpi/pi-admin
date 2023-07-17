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
import me.pi.admin.workflow.pojo.dto.FormDTO;
import me.pi.admin.workflow.pojo.po.ActReForm;
import me.pi.admin.workflow.pojo.vo.ProcessDefinitionStartFormVO;
import org.mapstruct.Mapper;

import java.util.List;

/**
 * @author ZnPi
 * @date 2023-04-03
 */
@Mapper(componentModel = "spring")
public interface ProcessFormConverter {
    /**
     * ActReForm -> ProcessFormVO
     * @param form ActReForm
     * @return ProcessFormVO
     */
    ProcessDefinitionStartFormVO poToVo(ActReForm form);

    /**
     * IPage<ActReForm> -> IPage<FormVO>
     * @param actReFormPage IPage<FormVO>
     * @return IPage<FormVO>
     */
    PiPage<ProcessDefinitionStartFormVO> poPageToVoPage(IPage<ActReForm> actReFormPage);

    /**
     * List<ActReForm> -> List<ProcessFormVO>
     * @param forms List<ActReForm>
     * @return List<ProcessFormVO>
     */
    List<ProcessDefinitionStartFormVO> posToVos(List<ActReForm> forms);

    /**
     * FormDTO -> ActReForm
     * @param dto FormDTO
     * @return ActReForm
     */
    ActReForm dtoToPo(FormDTO dto);
}
