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

package me.pi.admin.workflow.constant;

/**
 * Flowable 常量
 *
 * @author ZnPi
 * @date 2023-04-07
 */
public interface FlowableConstants {
    /**
     * BPMN 文件后缀
     */
    String BPMN_FILE_SUFFIX = ".bpmn";

    /**
     * 角色候选组前缀
     */
    String ROLE_CANDIDATE_GROUP_PREFIX = "ROLE_";

    /**
     * 部门候选组前缀
     */
    String DEPT_CANDIDATE_GROUP_PREFIX = "DEPT_";

    /**
     * 审批候选人
     */
    String APPROVE_CANDIDATES = "candidates";
}
