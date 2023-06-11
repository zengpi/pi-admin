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

package me.pi.admin.common.util;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * @author ZnPi
 * @date 2023-05-06
 */
public final class AnnotationScanner {
    private AnnotationScanner() {
    }

    /**
     * 获取指定类上的方法上标注了指定注解的方法以及注解
     *
     * @param clazz      指定类的字节码
     * @param annotation 注解
     * @return 定类上的方法上标注了指定注解的方法以及注解
     */
    public static Map<Method, Annotation> getMethodsAnnotation(
            Class<?> clazz, Class<? extends Annotation> annotation) {
        Map<Method, Annotation> methodAnnotationMap = new HashMap<>(16);
        Method[] declaredMethods = clazz.getDeclaredMethods();
        for (Method method : declaredMethods) {
            if (method.isAnnotationPresent(annotation)) {
                methodAnnotationMap.put(method, method.getAnnotation(annotation));
            }
        }
        return methodAnnotationMap;
    }
}
