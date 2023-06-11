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
import me.pi.admin.workflow.mapper.ProcessModelMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashSet;

/**
 * @author ZnPi
 * @date 2023-06-05
 */
@SpringBootTest(classes = AdminApplication.class)
public class ProcessModelServiceTest {
    @Autowired
    private ProcessModelMapper processModelMapper;

    @Test
    public void testIsExistsByCategory() {
        HashSet<String> categories = new HashSet<>();
        categories.add("请假类");
        System.out.println(processModelMapper.countByCategory(categories));
    }
}
