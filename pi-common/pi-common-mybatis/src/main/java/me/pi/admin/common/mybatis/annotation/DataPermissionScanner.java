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

package me.pi.admin.common.mybatis.annotation;

import lombok.RequiredArgsConstructor;
import me.pi.admin.common.mybatis.handler.PiDataPermissionHandler;
import me.pi.admin.common.util.AnnotationScanner;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.boot.CommandLineRunner;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.Map;

/**
 * 数据权限注解扫描器
 *
 * @author ZnPi
 * @date 2023-05-06
 */
@RequiredArgsConstructor
public class DataPermissionScanner implements CommandLineRunner {
    private final SqlSessionFactory sqlSessionFactory;
    private final PiDataPermissionHandler dataPermissionHandler;

    @Override
    public void run(String... args) {
        Collection<Class<?>> mappers = sqlSessionFactory.getConfiguration().getMapperRegistry().getMappers();
        mappers.forEach(mapper -> {
            Map<Method, Annotation> methodsAnnotation = AnnotationScanner.getMethodsAnnotation(mapper, DataPermission.class);
            methodsAnnotation.forEach((method, annotation) -> {
                String key = method.getDeclaringClass().getName() + "." + method.getName();
                dataPermissionHandler.getAnnotationCaches().put(key, annotation);
            });
        });
    }
}
