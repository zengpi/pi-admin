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

package me.pi.admin.common.mybatis.handler;

import cn.hutool.extra.spring.SpringUtil;
import com.baomidou.mybatisplus.extension.plugins.handler.DataPermissionHandler;
import lombok.Getter;
import me.pi.admin.common.enums.ResponseStatusEnum;
import me.pi.admin.common.exception.BizException;
import me.pi.admin.common.mybatis.annotation.DataPermission;
import me.pi.admin.common.mybatis.annotation.DataPermissionColumn;
import me.pi.admin.common.mybatis.annotation.DataPermissionItem;
import me.pi.admin.common.mybatis.annotation.DataPermissionScanner;
import me.pi.admin.common.mybatis.enums.DataPermissionTypeEnum;
import me.pi.admin.common.mybatis.enums.JoinTypeEnum;
import me.pi.admin.common.pojo.dto.AuthenticatedRole;
import me.pi.admin.common.pojo.dto.AuthenticatedUser;
import me.pi.admin.common.util.SecurityUtils;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.Parenthesis;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import org.springframework.context.expression.BeanFactoryResolver;
import org.springframework.expression.BeanResolver;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.ParserContext;
import org.springframework.expression.common.TemplateParserContext;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import java.lang.annotation.Annotation;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 数据权限处理器
 * <p>
 * annotationCaches 中的数据由 {@link DataPermissionScanner} 填充
 *
 * @author ZnPi
 * @date 2023-05-01
 * @see DataPermissionScanner
 */
public class PiDataPermissionHandler {
    @Getter
    private final Map<String, Annotation> annotationCaches = new HashMap<>(16);
    private final ExpressionParser expressionParser = new SpelExpressionParser();
    private final ParserContext parserContext = new TemplateParserContext();
    private final BeanResolver beanResolver = new BeanFactoryResolver(SpringUtil.getBeanFactory());

    public Expression getSqlSegment(Expression where, String mappedStatementId, JoinTypeEnum joinType) {
        String sqlStatement = getSqlStatement(mappedStatementId, joinType);

        if (!StringUtils.hasText(sqlStatement)) {
            return where;
        }

        try {
            Expression expression = CCJSqlParserUtil.parseExpression(sqlStatement);
            Parenthesis parenthesis = new Parenthesis(expression);
            if (Objects.nonNull(where)) {
                return new AndExpression(where, parenthesis);
            } else {
                return parenthesis;
            }
        } catch (JSQLParserException e) {
            throw new BizException(ResponseStatusEnum.BIZ_EXCEPTION, "数据权限表达式解析异常：" + e.getMessage());
        }
    }

    private String getSqlStatement(String mappedStatementId, JoinTypeEnum joinType) {
        HashSet<String> sqlConditions = getSqlConditions(mappedStatementId, joinType);

        if (sqlConditions.isEmpty()) {
            return "";
        }
        String sqlStatement = String.join(" ", sqlConditions);
        return sqlStatement.substring(joinType.name().length());
    }

    private HashSet<String> getSqlConditions(String mappedStatementId, JoinTypeEnum joinType) {
        AuthenticatedUser user = SecurityUtils.getUser();
        Assert.notNull(user, "用户信息获取失败");

        DataPermissionData dataPermissionData = new DataPermissionData();
        dataPermissionData.setUserId(user.getId());
        dataPermissionData.setDeptId(user.getDeptId());

        HashSet<String> sqlConditions = new HashSet<>();
        DataPermission annotation = (DataPermission) annotationCaches.get(mappedStatementId);
        if (null == annotation || annotation.value().length == 0) {
            return sqlConditions;
        }

        StandardEvaluationContext standardEvaluationContext = new StandardEvaluationContext();
        standardEvaluationContext.setBeanResolver(beanResolver);
        standardEvaluationContext.setVariable("data", dataPermissionData);

        for (AuthenticatedRole role : user.getRoles()) {
            DataPermissionTypeEnum dataPermissionType = DataPermissionTypeEnum
                    .getDataPermissionType(role.getDataScope());
            Assert.notNull(dataPermissionType, "数据范围不存在" + role.getDataScope());

            if (dataPermissionType == DataPermissionTypeEnum.ALL) {
                continue;
            }

            // 获取数据权限项
            List<DataPermissionItem> dataPermissionItems = Arrays.stream(annotation.value())
                    .filter(dataPermissionItem ->
                            dataPermissionType.getCode().equals(dataPermissionItem.type().getCode()))
                    .collect(Collectors.toList());
            if (dataPermissionItems.isEmpty()) {
                continue;
            }

            dataPermissionData.setRoleId(role.getId());

            String sqlTemplate;

            DataPermissionItem dataPermissionItem = dataPermissionItems.get(0);
            if (!StringUtils.hasText(dataPermissionItem.column().key())) {
                // 未指定列，使用默认值
                sqlTemplate = dataPermissionType.getDefaultSqlTemplate();
            } else {
                // 设置的 key 与模板不匹配
                if (!dataPermissionType.getSqlTemplate().contains(dataPermissionItem.column().key())) {
                    continue;
                }

                sqlTemplate = dataPermissionType.getSqlTemplate();
                standardEvaluationContext.setVariable(dataPermissionItem.column().key(),
                        dataPermissionItem.column().value());
            }

            String sqlCondition = expressionParser.parseExpression(sqlTemplate, parserContext)
                    .getValue(standardEvaluationContext, String.class);
            sqlConditions.add(joinType.name() + " " + sqlCondition);
        }
        return sqlConditions;
    }

    public boolean isValid(String mappedStatementId) {
        return annotationCaches.containsKey(mappedStatementId);
    }
}
