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
import me.pi.admin.workflow.pojo.po.ActReForm;
import me.pi.admin.workflow.pojo.query.BootableDefinitionQuery;
import me.pi.admin.workflow.pojo.query.ProcessDefQuery;
import me.pi.admin.workflow.pojo.vo.ProcessDefinitionVO;
import me.pi.admin.workflow.pojo.vo.ProcessFormVO;
import me.pi.admin.workflow.pojo.dto.ProcessInstanceLogDTO;
import me.pi.admin.workflow.pojo.vo.MyProcessInstanceVO;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.ProcessDefinition;
import org.mapstruct.Mapper;

/**
 * @author ZnPi
 * @date 2023-04-01
 */
@Mapper(componentModel = "spring")
public interface ProcessDefinitionConverter {
    /**
     * IPage<ProcessDefinition> -> IPage<ProcessDefinitionVO>
     * @param processDefinitionPage IPage<ProcessDefinition>
     * @return IPage<ProcessDefinitionVO>
     */
    PiPage<ProcessDefinitionVO> pageToVoPage(IPage<ProcessDefinition> processDefinitionPage);

    /**
     * ToStartProcessDefinitionQuery -> ProcessDefQuery
     * @param query ToStartProcessDefinitionQuery
     * @return ProcessDefQuery
     */
    ProcessDefQuery toStartProcessDefinitionQueryToProcessDefQuery(BootableDefinitionQuery query);

    /**
     * HistoricProcessInstance -> MyProcessVO
     * @param historicProcessInstance HistoricProcessInstance
     * @return MyProcessVO
     */
    MyProcessInstanceVO historicProcessInstanceToMyProcessVo(HistoricProcessInstance historicProcessInstance);

    /**
     * ActReForm -> ProcessInstanceFormDTO
     * @param form ActReForm
     * @return ProcessInstanceFormDTO
     */
    ProcessFormVO formToProcessInstanceFormDto(ActReForm form);

    /**
     * ProcessInstanceLogDTO -> HistoricActivityInstance
     * @param historicActivityInstance HistoricActivityInstance
     * @return ProcessInstanceLogDTO
     */
    ProcessInstanceLogDTO historicProcessInstanceToProcessInstanceLogDTO(
            HistoricActivityInstance historicActivityInstance);
}
