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

package me.pi.admin.core.system.converter;

import org.springframework.stereotype.Component;

/**
 * @author ZnPi
 * @since 2022-12-01
 */
@Component
public class VisibleToHiddenFormat {
    public Boolean toBoolean(Integer visible){
        return visible == 0;
    }

    public Integer toInteger(Boolean hidden){
        if(hidden) {
            return 0;
        }
        return 1;
    }
}
