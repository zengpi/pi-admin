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

import lombok.Getter;
import me.pi.admin.common.enums.ResponseStatusEnum;

/**
 * @author ZnPi
 * @since 2022-08-16
 */
@Getter
public class BadRequestException extends BaseException {
    private static final long serialVersionUID = -1528006679211572586L;

    public BadRequestException() {
        this(ResponseStatusEnum.REQUEST_PARAM_ERROR);
    }

    public BadRequestException(String message){
        super(ResponseStatusEnum.REQUEST_PARAM_ERROR.getCode(), message);
    }

    public BadRequestException(String code, String message) {
        super(code, message);
    }

    public BadRequestException(ResponseStatusEnum responseStatusEnum){
        super(responseStatusEnum);
    }

    public BadRequestException(ResponseStatusEnum responseStatusEnum, String message){
        super(responseStatusEnum.getCode(), message);
    }
}