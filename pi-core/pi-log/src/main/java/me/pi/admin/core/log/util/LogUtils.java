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

package me.pi.admin.core.log.util;

import me.pi.admin.common.util.ServletUtil;
import me.pi.admin.core.log.pojo.dto.LogDTO;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * @author ZnPi
 * @date 2022-11-20
 */
public final class LogUtils {
    private LogUtils() {
    }

    public static LogDTO getDefaultLogDTO() {
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder
                .getRequestAttributes();
        if (requestAttributes != null) {
            HttpServletRequest request = requestAttributes.getRequest();
            return getDefaultLogDTO(request);
        }

        return new LogDTO();
    }

    public static LogDTO getDefaultLogDTO(HttpServletRequest request) {
        LogDTO logDTO = new LogDTO();

        logDTO.setRequestUrl(request.getRequestURI());
        logDTO.setIp(ServletUtil.getClientIp(request));
        logDTO.setRequestMethod(request.getMethod());

        return logDTO;
    }
}
