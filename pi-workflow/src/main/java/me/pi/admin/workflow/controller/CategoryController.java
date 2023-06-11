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

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.common.mybatis.validate.SaveGroup;
import me.pi.admin.common.mybatis.validate.UpdateGroup;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.workflow.pojo.dto.ProcessCategoryDTO;
import me.pi.admin.workflow.pojo.vo.ProcessCategoryVO;
import me.pi.admin.workflow.service.ProcessCategoryService;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
@RestController
@RequestMapping("/workflow/category")
@Tag(name = "流程分类")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class CategoryController {
    private final ProcessCategoryService processCategoryService;

    @GetMapping
    @Operation(summary = "查询流程分类")
    @PreAuthorize("hasAuthority('workflow_category_query')")
    public ResponseData<IPage<ProcessCategoryVO>> listCategories(BaseQuery baseQuery) {
        return ResponseData.ok(processCategoryService.listCategories(baseQuery));
    }

    @PostMapping
    @Operation(summary = "新增分类")
    @PreAuthorize("hasAuthority('workflow_category_save')")
    public ResponseData<?> saveCategory(
            @RequestBody @Validated(SaveGroup.class) ProcessCategoryDTO processCategoryDto) {
        processCategoryService.saveOrUpdate(processCategoryDto);
        return ResponseData.ok();
    }

    @PutMapping
    @Operation(summary = "修改分类")
    @PreAuthorize("hasAuthority('workflow_category_update')")
    public ResponseData<?> updateCategory(
            @RequestBody @Validated(UpdateGroup.class) ProcessCategoryDTO processCategoryDto) {
        processCategoryService.saveOrUpdate(processCategoryDto);
        return ResponseData.ok();
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除分类")
    @PreAuthorize("hasAuthority('workflow_category_delete')")
    public ResponseData<?> deleteCategories(@PathVariable Set<Long> ids) {
        processCategoryService.deleteCategories(ids);
        return ResponseData.ok();
    }
}
