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

package me.pi.admin.workflow.pojo.dto;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author ZnPi
 * @date 2023-04-23
 */
@Data
public class ApproveRejectDTO {
    /**
     * 任务ID
     */
    @NotNull(message = "任务 ID 不能为空")
    private String taskId;
    /**
     * 流程实例 ID
     */
    @NotNull(message = "流程实例 ID 不能为空")
    private String processInstanceId;
    /**
     * 审批意见
     */
    private String comment;
    /**
     * 抄送人
     */
    private List<String> copyUsers;
}
