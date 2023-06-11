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

package me.pi.admin.common.mybatis.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import me.pi.admin.common.mybatis.annotation.DataPermissionScanner;
import me.pi.admin.common.mybatis.handler.PiDataPermissionHandler;
import me.pi.admin.common.mybatis.handler.PiTenantLineHandler;
import me.pi.admin.common.mybatis.interceptor.PiDataPermissionInterceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author ZnPi
 * @since 2023-03-24
 */
@Configuration
@MapperScan("${mybatis-plus.mapper-scan}")
@EnableConfigurationProperties(TenantProperties.class)
public class MyBatisPlusConfig {
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor(TenantProperties tenantProperties) {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(new TenantLineInnerInterceptor(new PiTenantLineHandler(tenantProperties)));
        interceptor.addInnerInterceptor(new PiDataPermissionInterceptor(dataPermissionHandler()));
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
        return interceptor;
    }

    @Bean
    public DataPermissionScanner dataPermissionScanner(SqlSessionFactory sqlSessionFactory) {
        return new DataPermissionScanner(sqlSessionFactory, dataPermissionHandler());
    }

    @Bean
    public PiDataPermissionHandler dataPermissionHandler() {
        return new PiDataPermissionHandler();
    }
}
