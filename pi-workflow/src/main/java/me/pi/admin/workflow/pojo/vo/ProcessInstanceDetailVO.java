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

package me.pi.admin.workflow.pojo.vo;

import lombok.Data;
import me.pi.admin.workflow.pojo.dto.ProcessInstanceLogDTO;
import me.pi.admin.workflow.pojo.dto.ViewerElementDTO;

import java.util.List;

/**
 * @author ZnPi
 * @date 2023-04-07
 */
@Data
public class ProcessInstanceDetailVO {
    /**
     * 表单数据
     */
    private List<ProcessFormVO> forms;
    /**
     * 日志
     */
    private List<ProcessInstanceLogDTO> logs;
    /**
     * BPMN Xml
     */
    private String bpmnXml;
    /**
     * 查看器节点
     */
    private ViewerElementDTO viewerElement;
}
