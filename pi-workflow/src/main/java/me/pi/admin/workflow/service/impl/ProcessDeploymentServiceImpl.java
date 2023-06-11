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

package me.pi.admin.workflow.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.common.util.SecurityUtils;
import me.pi.admin.workflow.converter.ProcessDeploymentConverter;
import me.pi.admin.workflow.pojo.vo.ProcessDeploymentVO;
import me.pi.admin.workflow.service.ProcessDeploymentService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.DeploymentQuery;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author ZnPi
 * @date 2023-03-28
 */
@Service
@RequiredArgsConstructor
public class ProcessDeploymentServiceImpl implements ProcessDeploymentService {
    private final RepositoryService repositoryService;
    private final ProcessDeploymentConverter processDeploymentConverter;

    @Override
    public IPage<ProcessDeploymentVO> listDeployments(BaseQuery baseQuery) {
        IPage<ProcessDeploymentVO> page = baseQuery.page();

        DeploymentQuery deploymentQuery = repositoryService.createDeploymentQuery()
                .deploymentTenantId(SecurityUtils.getTenantId())
                .orderByDeploymentTime()
                .desc();
        long count = deploymentQuery.count();
        page.setTotal(count);
        if (count <= 0) {
            return page;
        }

        int offset = baseQuery.getPageSize() * (baseQuery.getPageNum() - 1);
        List<Deployment> deployments = deploymentQuery.listPage(offset, baseQuery.getPageSize());
        List<ProcessDeploymentVO> processDeploymentVos = processDeploymentConverter
                .deploymentsToDeploymentVos(deployments);

        page.setRecords(processDeploymentVos);
        return page;
    }

    @Override
    public void deleteDeployments(Collection<String> deployIds) {
        if(deployIds.isEmpty()) {
            throw new BadRequestException("待删除 id 列表不能为空");
        }
        if (!(deployIds instanceof Set)) {
            deployIds = new HashSet<>(deployIds);
        }
        for (String deployId : deployIds) {
            repositoryService.deleteDeployment(deployId, true);
        }
    }
}
