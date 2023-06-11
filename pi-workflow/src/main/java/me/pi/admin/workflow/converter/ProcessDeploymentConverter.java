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

import me.pi.admin.workflow.pojo.vo.ProcessDeploymentVO;
import org.flowable.engine.repository.Deployment;
import org.mapstruct.Mapper;

import java.util.List;

/**
 * @author ZnPi
 * @date 2023-03-28
 */
@Mapper(componentModel = "spring")
public interface ProcessDeploymentConverter {
    /**
     * List<Deployment> -> List<ProcessDeploymentVO>
     *
     * @param deploymentList 流程部署列表
     * @return List<ProcessDeploymentVO>
     */
    List<ProcessDeploymentVO> deploymentsToDeploymentVos(List<Deployment> deploymentList);
}
