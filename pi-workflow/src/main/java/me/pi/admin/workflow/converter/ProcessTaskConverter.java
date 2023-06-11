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
import me.pi.admin.workflow.pojo.po.ActHiCopy;
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.workflow.pojo.po.ActReForm;
import me.pi.admin.workflow.pojo.vo.*;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.mapstruct.Mapper;

/**
 * @author ZnPi
 * @date 2023-04-20
 */
@Mapper(componentModel = "spring")
public interface ProcessTaskConverter {
    /**
     * Task -> TodoTaskVO
     *
     * @param task Task
     * @return TodoTaskVO
     */
    TodoTaskVO taskToTodoTaskVo(Task task);

    /**
     * ActReForm -> ProcessFormVO
     *
     * @param form ActReForm
     * @return ProcessFormVO
     */
    ProcessFormVO formPoToProcessFormVo(ActReForm form);

    /**
     * HistoricTaskInstance -> DoneTaskVO
     *
     * @param historicTaskInstance HistoricTaskInstance
     * @return DoneTaskVO
     */
    DoneTaskVO historicTaskInstanceToDoneTaskVo(HistoricTaskInstance historicTaskInstance);

    /**
     * IPage<ActHiCopy> -> PiPage<CopyVO>
     *
     * @param actHiCopyPage IPage<ActHiCopy>
     * @return CopyVO PiPage<CopyVO>
     */
    PiPage<CopyVO> copyToCopyVo(IPage<ActHiCopy> actHiCopyPage);
}
