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
import org.flowable.engine.task.Comment;

import java.util.Date;
import java.util.List;

/**
 * @author ZnPi
 * @date 2023-04-08
 */
@Data
public class ProcessInstanceLogDTO {
    /**
     * 提交时间
     */
    private Date startTime;
    /**
     * 结束时间
     */
    private Date endTime;
    /**
     * 活动 ID
     */
    private String activityId;
    /**
     * 活动名称
     */
    private String activityName;
    /**
     * 活动类型
     */
    private String activityType;
    /**
     * 活动耗时
     */
    private String duration;
    /**
     * 审批人名称
     */
    private String assigneeName;
    /**
     * 候选审批人
     */
    private String candidate;
    /**
     * 意见
     */
    private List<Comment> comments;
}
