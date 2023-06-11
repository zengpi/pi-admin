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
import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.workflow.pojo.dto.ProcessCategoryDTO;
import me.pi.admin.workflow.pojo.po.ActReCategory;
import me.pi.admin.workflow.pojo.vo.ProcessCategoryVO;

import java.util.Collection;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
public interface ProcessCategoryService extends IService<ActReCategory> {
    /**
     * 查询流程分类
     *
     * @param baseQuery 基础查询参数
     * @return 分类
     */
    IPage<ProcessCategoryVO> listCategories(BaseQuery baseQuery);

    /**
     * 新增或修改
     *
     * @param processCategoryDto 流程分类 DTO
     */
    void saveOrUpdate(ProcessCategoryDTO processCategoryDto);

    /**
     * 删除分类
     *
     * @param ids 待删除 ID
     */
    void deleteCategories(Collection<Long> ids);
}
