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

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author ZnPi
 * @date 2023-03-28
 */
@Data
@Schema(title = "流程部署视图对象")
public class ProcessDeploymentVO implements Serializable {
    /**
     * 唯一标识
     */
    @Schema(description = "唯一标识")
    private String id;
    /**
     * 部署名称
     */
    @Schema(description = "部署名称")
    private String name;
    /**
     * 部署时间
     */
    @Schema(description = "部署时间")
    private Date deploymentTime;
}
