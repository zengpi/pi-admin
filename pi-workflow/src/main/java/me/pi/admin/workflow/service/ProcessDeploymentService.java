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

package me.pi.admin.workflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.workflow.pojo.vo.ProcessDeploymentVO;

import java.util.Collection;

/**
 * @author ZnPi
 * @date 2023-03-28
 */
public interface ProcessDeploymentService {
    /**
     * 获取流程部署
     *
     * @param baseQuery 查询参数
     * @return 流程部署
     */
    IPage<ProcessDeploymentVO> listDeployments(BaseQuery baseQuery);

    /**
     * 删除流程部署
     *
     * @param deployIds 流程部署 ID 列表
     */
    void deleteDeployments(Collection<String> deployIds);
}
