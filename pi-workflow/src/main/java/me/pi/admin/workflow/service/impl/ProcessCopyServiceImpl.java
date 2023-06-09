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

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import me.pi.admin.workflow.pojo.po.ActHiCopy;
import me.pi.admin.workflow.mapper.ProcessCopyMapper;
import me.pi.admin.workflow.service.ProcessCopyService;
import org.springframework.stereotype.Service;

/**
 * @author ZnPi
 * @date 2023-04-22
 */
@Service
@RequiredArgsConstructor
public class ProcessCopyServiceImpl extends ServiceImpl<ProcessCopyMapper, ActHiCopy> implements ProcessCopyService {
}
