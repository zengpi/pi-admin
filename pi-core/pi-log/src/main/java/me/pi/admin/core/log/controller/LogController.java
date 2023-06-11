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

package me.pi.admin.core.log.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.core.log.pojo.vo.LogVO;
import me.pi.admin.core.log.service.LogService;
import me.pi.admin.core.log.pojo.dto.LogDTO;
import me.pi.admin.core.log.pojo.query.LogQuery;
import org.springframework.http.HttpHeaders;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;

/**
 * @author ZnPi
 * @since 2022-11-19
 */
@RestController
@RequestMapping("/log")
@Tag(name = "日志管理")
@RequiredArgsConstructor
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class LogController {
    private final LogService logService;

    @GetMapping
    @Operation(summary = "获取日志")
    @PreAuthorize("hasAuthority('sys_log_query')")
    public ResponseData<PiPage<LogVO>> getLogs(LogQuery query){
        return ResponseData.ok(logService.getLogs(query));
    }

    @PostMapping
    @Operation(summary = "保存日志")
    public ResponseData<?> saveLog(@RequestBody LogDTO dto) {
        logService.saveLog(dto);
        return ResponseData.ok();
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除日志")
    @PreAuthorize("hasAuthority('sys_log_delete')")
    public ResponseData<?> deleteLogs(@PathVariable String ids){
        logService.deleteLogs(ids);
        return ResponseData.ok();
    }

    @GetMapping("/export")
    @Operation(summary = "导出日志")
    @PreAuthorize("hasAuthority('sys_log_export')")
    public void export(LogQuery query, HttpServletResponse response){
        logService.export(query, response);
    }
}
