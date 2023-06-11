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

import me.pi.admin.AdminApplication;
import org.flowable.engine.RepositoryService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * @author ZnPi
 * @date 2023-06-06
 */
@SpringBootTest(classes = AdminApplication.class)
public class RepositoryServiceTest {
    @Autowired
    private RepositoryService repositoryService;

    @Test
    public void modifyTenantIdentifier() {
        repositoryService.changeDeploymentTenantId("7012a2fd-f2e7-11ed-bed7-e86a64b08c3b", "000000");
    }
}
