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
import lombok.Setter;
import me.pi.admin.common.enums.ResponseStatusEnum;

/**
 * Base exception for all exceptions
 *
 * @author ZnPi
 * @date 2023-07-13
 */
public class BaseException extends RuntimeException {
    private static final long serialVersionUID = -1L;

    @Getter
    @Setter
    protected String code;

    public BaseException() {
        super();
    }

    public BaseException(ResponseStatusEnum responseStatusEnum) {
        super(responseStatusEnum.getMsg());
        this.code = responseStatusEnum.getCode();
    }

    public BaseException(String code, String message) {
        super(message);
        this.code = code;
    }

    public BaseException(String code, Throwable cause) {
        super(cause);
        this.code = code;
    }

    public BaseException(String code, String message, Throwable cause) {
        super(message, cause);
        this.code = code;
    }
}
