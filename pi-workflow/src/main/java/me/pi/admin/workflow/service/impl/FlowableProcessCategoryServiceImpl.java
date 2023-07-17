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
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.workflow.pojo.dto.ProcessCategoryDTO;
import me.pi.admin.workflow.pojo.po.ActReCategory;
import me.pi.admin.workflow.converter.ProcessClassConverter;
import me.pi.admin.workflow.mapper.ProcessClassMapper;
import me.pi.admin.workflow.pojo.vo.ProcessCategoryVO;
import me.pi.admin.workflow.service.FlowableProcessCategoryService;
import me.pi.admin.workflow.service.FlowableProcessModelService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
@Service
@RequiredArgsConstructor
public class FlowableProcessCategoryServiceImpl extends ServiceImpl<ProcessClassMapper, ActReCategory> implements FlowableProcessCategoryService {
    private final FlowableProcessModelService flowableProcessModelService;
    private final ProcessClassConverter processClassConverter;

    @Override
    public IPage<ProcessCategoryVO> listCategories(BaseQuery baseQuery) {
        IPage<ActReCategory> page = super.page(baseQuery.page(), Wrappers.lambdaQuery(ActReCategory.class)
                .like(StringUtils.hasText(baseQuery.getKeyWord()), ActReCategory::getCode, baseQuery.getKeyWord())
                .or()
                .like(StringUtils.hasText(baseQuery.getKeyWord()), ActReCategory::getName, baseQuery.getKeyWord())
                .select(ActReCategory::getId, ActReCategory::getCode, ActReCategory::getName, ActReCategory::getRemark));

        return processClassConverter.poPageToVoPage(page);
    }

    @Override
    public void saveOrUpdate(ProcessCategoryDTO processCategoryDto) {
        super.saveOrUpdate(processClassConverter.dtoToPo(processCategoryDto));
    }

    @Override
    public void deleteCategories(Collection<Long> ids) {
        if (ids.isEmpty()) {
            throw new BadRequestException("待删除记录的 id 列表不能为空");
        }
        if (!(ids instanceof Set)) {
            ids = new HashSet<>(ids);
        }

        Set<String> categories = super.listByIds(ids)
                .stream()
                .map(ActReCategory::getName)
                .collect(Collectors.toSet());
        Boolean isExists = flowableProcessModelService.isExistsByCategories(categories);
        if(isExists) {
            throw new BizException("待删除记录中存在已使用的分类");
        }

        super.removeByIds(ids);
    }
}
