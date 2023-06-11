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

package me.pi.admin.core.log.service;

import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.common.mybatis.PiPage;
import me.pi.admin.core.log.pojo.vo.LogVO;
import me.pi.admin.core.log.pojo.dto.LogDTO;
import me.pi.admin.core.log.pojo.po.SysLog;
import me.pi.admin.core.log.pojo.query.LogQuery;

import javax.servlet.http.HttpServletResponse;

/**
 * @author ZnPi
 * @since 2022-11-19
 */
public interface LogService extends IService<SysLog> {
    /**
     * 保存日志
     * @param dto /
     */
    void saveLog(LogDTO dto);

    /**
     * 获取日志
     * @param queryParam /
     * @return /
     */
    PiPage<LogVO> getLogs(LogQuery queryParam);

    /**
     * 删除日志
     * @param ids /
     */
    void deleteLogs(String ids);

    /**
     * 导出日志
     * @param queryParam /
     * @param response /
     */
    void export(LogQuery queryParam, HttpServletResponse response);
}
