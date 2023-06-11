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

package me.pi.admin.core.log.service.impl;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import me.pi.admin.common.constant.FileConstants;
import me.pi.admin.common.exception.BadRequestException;
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.common.util.FileUtil;
import me.pi.admin.common.util.SecurityUtils;
import me.pi.admin.core.log.converter.LogConverter;
import me.pi.admin.core.log.pojo.po.SysLog;
import me.pi.admin.core.log.pojo.vo.LogExportVO;
import me.pi.admin.core.log.pojo.vo.LogVO;
import me.pi.admin.core.log.service.LogService;
import me.pi.admin.core.log.pojo.query.LogQuery;
import me.pi.admin.core.log.mapper.LogMapper;
import me.pi.admin.core.log.pojo.dto.LogDTO;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author ZnPi
 * @since 2022-11-19
 */
@Service
@RequiredArgsConstructor
public class LogServiceImpl extends ServiceImpl<LogMapper, SysLog> implements LogService {
    private static final String EXPORT_LOG_FILE_NAME = "日志导出";

    private final LogConverter logConverter;
    private final LogMapper logMapper;

    @Override
    public PiPage<LogVO> getLogs(LogQuery query) {
        LambdaQueryWrapper<SysLog> wrapper = Wrappers.lambdaQuery(SysLog.class);
        PiPage<SysLog> page = new PiPage<>(query.getPageNum(), query.getPageSize());
        if (query.getQueryColumn() != null && StrUtil.isNotBlank(query.getKeyWord())) {
            wrapper.like(LogQuery.LogColumn.TITLE.getColumn().equals(query.getQueryColumn()),
                            SysLog::getTitle, query.getKeyWord())
                    .like(LogQuery.LogColumn.CREATE_BY.getColumn().equals(query.getQueryColumn()),
                            SysLog::getCreateBy, query.getKeyWord())
                    .like(LogQuery.LogColumn.METHOD_NAME.getColumn().equals(query.getQueryColumn()),
                            SysLog::getMethodName, query.getKeyWord())
                    .like(LogQuery.LogColumn.REQUEST_URL.getColumn().equals(query.getQueryColumn()),
                            SysLog::getRequestUrl, query.getKeyWord());
        }

        if (ArrayUtil.isNotEmpty(query.getCreateTime()) && query.getCreateTime().length > 1) {
            wrapper.ge(SysLog::getCreateTime, query.getCreateTime()[0])
                    .le(SysLog::getCreateTime, query.getCreateTime()[1]);
        }
        PiPage<SysLog> rst = logMapper.selectPage(page, wrapper.eq(query.getType() != null, SysLog::getType, query.getType())
                .orderByDesc(SysLog::getCreateTime)
                .select(SysLog::getId, SysLog::getCreateTime, SysLog::getCreateBy, SysLog::getCreateBy,
                        SysLog::getType, SysLog::getIp, SysLog::getTitle, SysLog::getExceptionDesc,
                        SysLog::getRequestMethod, SysLog::getRequestParam, SysLog::getRequestTime,
                        SysLog::getMethodName, SysLog::getRequestUrl));
        return logConverter.pageSysLogToPageLogVo(rst);
    }

    @Override
    public void saveLog(LogDTO dto) {
        SysLog sysLog = logConverter.logDtoToSysLog(dto);
        super.save(sysLog);
    }

    @Override
    public void deleteLogs(String ids) {
        if (StrUtil.isBlank(ids)) {
            throw new BadRequestException("ids 不能为空");
        }
        Set<Long> idSet = Arrays.stream(ids.split(",")).map(Long::valueOf).collect(Collectors.toSet());
        super.removeByIds(idSet);
    }

    @Override
    @SneakyThrows
    public void export(LogQuery queryParam, HttpServletResponse response) {
        PiPage<LogExportVO> page = new PiPage<>(queryParam.getPageNum(), queryParam.getPageSize());
        List<LogExportVO> exportData = logMapper.listExportLog(page, queryParam);
        FileUtil.export(response, EXPORT_LOG_FILE_NAME, FileConstants.XLSX_SUFFIX, () -> {
            try {
                EasyExcel.write(response.getOutputStream(), LogExportVO.class)
                        .sheet(EXPORT_LOG_FILE_NAME).doWrite(exportData);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });
    }
}
