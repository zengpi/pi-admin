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

import me.pi.admin.common.enums.ResponseStatusEnum;

/**
 * @author ZnPi
 * @date 2023-07-13
 */
public class NotFoundException extends BaseException {
    private static final long serialVersionUID = 1L;

    public NotFoundException() {
        this(ResponseStatusEnum.RESOURCE_NOT_FOUND);
    }

    public NotFoundException(String message) {
        super(ResponseStatusEnum.RESOURCE_NOT_FOUND.getCode(), message);
    }

    public NotFoundException(String code, String message) {
        super(code, message);
    }

    public NotFoundException(ResponseStatusEnum responseStatusEnum) {
        super(responseStatusEnum);
    }

    public NotFoundException(ResponseStatusEnum responseStatusEnum, String message) {
        super(responseStatusEnum.getCode(), message);
    }
}
