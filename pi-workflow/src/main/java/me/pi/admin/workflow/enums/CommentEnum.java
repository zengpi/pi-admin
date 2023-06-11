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

package me.pi.admin.workflow.enums;

/**
 * @author ZnPi
 * @date 2023-04-17
 */
public enum CommentEnum {
    /**
     * 正常
     */
    NORMAL("1", "正常"),
    /**
     * 退回
     */
    RETURN("2", "退回"),
    /**
     * 驳回
     */
    REJECT("3", "驳回"),
    /**
     * 委派
     */
    DELEGATE("4", "委派"),
    /**
     * 转办
     */
    TRANSFER("5", "转办"),
    /**
     * 终止
     */
    STOP("6", "终止"),
    /**
     * 撤回
     */
    REVOKE("7", "撤回");

    private final String code;

    private final String msg;

    CommentEnum(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public String getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
