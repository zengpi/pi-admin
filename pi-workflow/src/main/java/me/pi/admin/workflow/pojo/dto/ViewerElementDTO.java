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

import java.util.Set;

/**
 * @author ZnPi
 * @date 2023-04-09
 */
@Data
public class ViewerElementDTO {
    /**
     * 已完成任务节点
     */
    private Set<String> finishedTasks;
    /**
     * 已完成序列流
     */
    private Set<String> finishedSequenceFlows;
    /**
     * 待完成任务节点
     */
    private Set<String> todoTasks;
    /**
     * 已拒绝任务节点
     */
    private Set<String> rejectedTasks;
}
