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

package me.pi.admin.common.serialization.desensitization;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.BeanProperty;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.ContextualSerializer;
import me.pi.admin.common.serialization.annotation.Desensitization;
import me.pi.admin.common.serialization.annotation.DesensitizationStrategy;

import java.io.IOException;
import java.util.Objects;

/**
 * @author ZnPi
 * @date 2023-05-12
 */
public class DesensitizationSerializer extends JsonSerializer<String> implements ContextualSerializer {
    private DesensitizationStrategy strategy;

    @Override
    public void serialize(String s, JsonGenerator jsonGenerator, SerializerProvider serializerProvider)
            throws IOException {
        // custom serialization logic
        jsonGenerator.writeString(strategy.getAction().apply(s));
    }

    @Override
    public JsonSerializer<?> createContextual(SerializerProvider serializerProvider, BeanProperty beanProperty) {
        Desensitization annotation = beanProperty.getAnnotation(Desensitization.class);
        if(Objects.nonNull(annotation)) {
            strategy = annotation.value();
        }
        return this;
    }
}
