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

package me.pi.admin.common.exception;

import lombok.extern.slf4j.Slf4j;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.pojo.vo.ResponseData;
import me.pi.admin.common.util.ThrowableUtil;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 全局异常类
 * @author ZnPi
 * @since 2022-11-04
 */
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
    /**
     * 业务异常
     * @param e /
     * @return /
     */
    @ExceptionHandler(value = BadRequestException.class)
    public ResponseData<Object> badRequestException(BadRequestException e){
        log.error(ThrowableUtil.getStackTrace(e));
        return ResponseData.error(e.getCode(), e.getMessage());
    }

    /**
     * 处理所有不可知异常
     */
    @ExceptionHandler(value = Throwable.class)
    public ResponseData<Object> unknownException(Throwable e){
        log.error(ThrowableUtil.getStackTrace(e));
        return ResponseData.error(ResponseStatusEnum.SYS_ERROR, e.getMessage());
    }
}