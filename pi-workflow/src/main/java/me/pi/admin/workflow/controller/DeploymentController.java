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

package me.pi.admin.workflow.controller;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.workflow.pojo.vo.ProcessDeploymentVO;
import me.pi.admin.workflow.service.ProcessDeploymentService;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

/**
 * 流程部署
 *
 * @author ZnPi
 * @date 2023-03-28
 */
@Tag(name = "流程部署")
@RestController
@RequestMapping("/workflow/deployment")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class DeploymentController {
    private final ProcessDeploymentService processDeploymentService;

    @GetMapping
    @Operation(summary = "获取流程部署")
    @PreAuthorize("hasAuthority('workflow_deployment_list')")
    public ResponseData<IPage<ProcessDeploymentVO>> listDeployments(BaseQuery baseQuery) {
        return ResponseData.ok(processDeploymentService.listDeployments(baseQuery));
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除流程部署")
    @PreAuthorize("hasAuthority('workflow_deployment_delete')")
    public ResponseData<?> deleteDeployments(@PathVariable Set<String> ids) {
        processDeploymentService.deleteDeployments(ids);
        return ResponseData.ok();
    }
}
