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

package me.pi.admin.core.log.aspect;

import com.alibaba.fastjson2.JSON;
import lombok.NonNull;
import lombok.SneakyThrows;
import me.pi.admin.core.log.annotation.Log;
import me.pi.admin.core.log.enums.LogType;
import me.pi.admin.core.log.pojo.dto.LogDTO;
import me.pi.admin.core.log.util.LogUtils;
import me.pi.admin.core.log.event.LogEvent;
import me.pi.admin.common.util.SecurityUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.ApplicationEventPublisherAware;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.HashMap;

/**
 * @author ZnPi
 * @date 2022-11-18
 */
@Component
@Aspect
public class LogAspect implements ApplicationEventPublisherAware {
    private ApplicationEventPublisher publisher;

    @Around("@annotation(log)")
    @SneakyThrows
    public Object log(ProceedingJoinPoint pjp, Log log) {
        // 业务执行开始时间
        long start = System.currentTimeMillis();

        Object obj;
        LogDTO logDTO = LogUtils.getDefaultLogDTO();
        logDTO.setTitle(log.value());
        logDTO.setTenantId(SecurityUtils.getTenantId());

        fillLog(pjp, logDTO);

        try {
            obj = pjp.proceed();
        } catch (Throwable e) {
            logDTO.setType(LogType.EXCEPTION.ordinal());
            logDTO.setExceptionDesc(e.getMessage());
            throw e;
        } finally {
            // 业务执行结束时间
            long end = System.currentTimeMillis();
            // 业务执行耗时
            logDTO.setRequestTime(end - start);

            publisher.publishEvent(new LogEvent(logDTO));
        }

        return obj;
    }

    private void fillLog(ProceedingJoinPoint pjp, LogDTO logDTO) {
        MethodSignature signature = (MethodSignature) pjp.getSignature();
        Object[] args = pjp.getArgs();
        String className = pjp.getTarget().getClass().getName();
        Method method = signature.getMethod();
        Parameter[] parameters = method.getParameters();

        logDTO.setMethodName(className + "#" + signature.getName());

        HashMap<String, Object> params = new HashMap<>((int) (args.length / 0.75 + 1));
        for (int i = 0; i < args.length; i++) {
            params.put(parameters[i].getName(), args[i]);
        }
        logDTO.setRequestParam(JSON.toJSONString(params));

        logDTO.setUsername(SecurityUtils.getUserName());
    }

    @Override
    public void setApplicationEventPublisher(@NonNull ApplicationEventPublisher applicationEventPublisher) {
        this.publisher = applicationEventPublisher;
    }
}
