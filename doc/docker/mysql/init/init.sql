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
CREATE DATABASE IF NOT EXISTS `pi-admin-test` DEFAULT CHARSET utf8mb4;
CREATE DATABASE IF NOT EXISTS `powerjob-daily` DEFAULT CHARSET utf8mb4;
CREATE DATABASE IF NOT EXISTS `powerjob-pre` DEFAULT CHARSET utf8mb4;
CREATE DATABASE IF NOT EXISTS `powerjob-product` DEFAULT CHARSET utf8mb4;

USE `pi-admin-test`;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ACT_APP_APPDEF
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_APPDEF`;
CREATE TABLE `ACT_APP_APPDEF`  (
                                   `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                   `REV_` int(0) NOT NULL,
                                   `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                   `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                   `VERSION_` int(0) NOT NULL,
                                   `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                   `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                   `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                   `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   UNIQUE INDEX `ACT_IDX_APP_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE,
                                   INDEX `ACT_IDX_APP_DEF_DPLY`(`DEPLOYMENT_ID_`) USING BTREE,
                                   CONSTRAINT `ACT_FK_APP_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_APP_DEPLOYMENT` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_APP_APPDEF
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_APP_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_DATABASECHANGELOG`;
CREATE TABLE `ACT_APP_DATABASECHANGELOG`  (
                                              `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                              `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                              `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                              `DATEEXECUTED` datetime(0) NOT NULL,
                                              `ORDEREXECUTED` int(0) NOT NULL,
                                              `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                              `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_APP_DATABASECHANGELOG
-- ----------------------------
INSERT INTO `ACT_APP_DATABASECHANGELOG` VALUES ('1', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-17 17:36:37', 1, 'EXECUTED', '8:496fc778bdf2ab13f2e1926d0e63e0a2', 'createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...', '', NULL, '4.9.1', NULL, NULL, '9045788590');
INSERT INTO `ACT_APP_DATABASECHANGELOG` VALUES ('2', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-17 17:36:39', 2, 'EXECUTED', '8:ccea9ebfb6c1f8367ca4dd473fcbb7db', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_APP_DEPLOYMENT', '', NULL, '4.9.1', NULL, NULL, '9045788590');
INSERT INTO `ACT_APP_DATABASECHANGELOG` VALUES ('3', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-17 17:36:40', 3, 'EXECUTED', '8:f1f8aff320aade831944ebad24355f3d', 'createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF', '', NULL, '4.9.1', NULL, NULL, '9045788590');

-- ----------------------------
-- Table structure for ACT_APP_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_APP_DATABASECHANGELOGLOCK`  (
                                                  `ID` int(0) NOT NULL,
                                                  `LOCKED` bit(1) NOT NULL,
                                                  `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
                                                  `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_APP_DATABASECHANGELOGLOCK
-- ----------------------------
INSERT INTO `ACT_APP_DATABASECHANGELOGLOCK` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for ACT_APP_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_DEPLOYMENT`;
CREATE TABLE `ACT_APP_DEPLOYMENT`  (
                                       `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                       PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_APP_DEPLOYMENT
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_APP_DEPLOYMENT_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_APP_DEPLOYMENT_RESOURCE`;
CREATE TABLE `ACT_APP_DEPLOYMENT_RESOURCE`  (
                                                `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                                `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                `RESOURCE_BYTES_` longblob NULL,
                                                PRIMARY KEY (`ID_`) USING BTREE,
                                                INDEX `ACT_IDX_APP_RSRC_DPL`(`DEPLOYMENT_ID_`) USING BTREE,
                                                CONSTRAINT `ACT_FK_APP_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_APP_DEPLOYMENT` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_APP_DEPLOYMENT_RESOURCE
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_CASEDEF
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_CASEDEF`;
CREATE TABLE `ACT_CMMN_CASEDEF`  (
                                     `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `REV_` int(0) NOT NULL,
                                     `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `VERSION_` int(0) NOT NULL,
                                     `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `HAS_GRAPHICAL_NOTATION_` bit(1) NULL DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                     `DGRM_RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `HAS_START_FORM_KEY_` bit(1) NULL DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     UNIQUE INDEX `ACT_IDX_CASE_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE,
                                     INDEX `ACT_IDX_CASE_DEF_DPLY`(`DEPLOYMENT_ID_`) USING BTREE,
                                     CONSTRAINT `ACT_FK_CASE_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_CMMN_DEPLOYMENT` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_CASEDEF
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_DATABASECHANGELOG`;
CREATE TABLE `ACT_CMMN_DATABASECHANGELOG`  (
                                               `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                               `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                               `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                               `DATEEXECUTED` datetime(0) NOT NULL,
                                               `ORDEREXECUTED` int(0) NOT NULL,
                                               `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                               `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_DATABASECHANGELOG
-- ----------------------------
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:35:24', 1, 'EXECUTED', '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:35:26', 2, 'EXECUTED', '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:35:30', 3, 'EXECUTED', '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:35:32', 4, 'EXECUTED', '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('5', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:12', 5, 'EXECUTED', '8:70349de472f87368dcdec971a10311a0', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_CMMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_CASE_INST; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; modifyDataType columnName=T...', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:13', 6, 'EXECUTED', '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:15', 7, 'EXECUTED', '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:16', 8, 'EXECUTED', '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:17', 9, 'EXECUTED', '8:4cb4782b9bdec5ced2a64c525aa7b3a0', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:20', 10, 'EXECUTED', '8:341c16be247f5d17badc9809da8691f9', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:21', 11, 'EXECUTED', '8:d7c4da9276bcfffbfb0ebfb25e3f7b05', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:22', 12, 'EXECUTED', '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:23', 13, 'EXECUTED', '8:7550626f964ab5518464709408333ec1', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('14', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:24', 14, 'EXECUTED', '8:086b40b3a05596dcc8a8d7479922d494', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('16', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:26', 15, 'EXECUTED', '8:a697a222ddd99dd15b36516a252f1c63', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');
INSERT INTO `ACT_CMMN_DATABASECHANGELOG` VALUES ('17', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-17 17:36:26', 16, 'EXECUTED', '8:d3706c5813a9b97fd2a59d12a9523946', 'createIndex indexName=ACT_IDX_HI_CASE_INST_END, tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '9045688592');

-- ----------------------------
-- Table structure for ACT_CMMN_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_CMMN_DATABASECHANGELOGLOCK`  (
                                                   `ID` int(0) NOT NULL,
                                                   `LOCKED` bit(1) NOT NULL,
                                                   `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
                                                   `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                   PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_DATABASECHANGELOGLOCK
-- ----------------------------
INSERT INTO `ACT_CMMN_DATABASECHANGELOGLOCK` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for ACT_CMMN_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_DEPLOYMENT`;
CREATE TABLE `ACT_CMMN_DEPLOYMENT`  (
                                        `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                        `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
                                        `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                        PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_DEPLOYMENT
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_DEPLOYMENT_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_DEPLOYMENT_RESOURCE`;
CREATE TABLE `ACT_CMMN_DEPLOYMENT_RESOURCE`  (
                                                 `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                                 `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 `RESOURCE_BYTES_` longblob NULL,
                                                 `GENERATED_` bit(1) NULL DEFAULT NULL,
                                                 PRIMARY KEY (`ID_`) USING BTREE,
                                                 INDEX `ACT_IDX_CMMN_RSRC_DPL`(`DEPLOYMENT_ID_`) USING BTREE,
                                                 CONSTRAINT `ACT_FK_CMMN_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_CMMN_DEPLOYMENT` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_DEPLOYMENT_RESOURCE
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_HI_CASE_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_HI_CASE_INST`;
CREATE TABLE `ACT_CMMN_HI_CASE_INST`  (
                                          `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                          `REV_` int(0) NOT NULL,
                                          `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `PARENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `STATE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `START_TIME_` datetime(3) NULL DEFAULT NULL,
                                          `END_TIME_` datetime(3) NULL DEFAULT NULL,
                                          `START_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `CALLBACK_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                          `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `LAST_REACTIVATION_TIME_` datetime(3) NULL DEFAULT NULL,
                                          `LAST_REACTIVATION_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          PRIMARY KEY (`ID_`) USING BTREE,
                                          INDEX `ACT_IDX_HI_CASE_INST_END`(`END_TIME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_HI_CASE_INST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_HI_MIL_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_HI_MIL_INST`;
CREATE TABLE `ACT_CMMN_HI_MIL_INST`  (
                                         `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `REV_` int(0) NOT NULL,
                                         `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `TIME_STAMP_` datetime(3) NULL DEFAULT NULL,
                                         `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                         PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_HI_MIL_INST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_HI_PLAN_ITEM_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_HI_PLAN_ITEM_INST`;
CREATE TABLE `ACT_CMMN_HI_PLAN_ITEM_INST`  (
                                               `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                               `REV_` int(0) NOT NULL,
                                               `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `STATE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `IS_STAGE_` bit(1) NULL DEFAULT NULL,
                                               `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `ITEM_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `ITEM_DEFINITION_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_AVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_ENABLED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_DISABLED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_STARTED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_SUSPENDED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `COMPLETED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `OCCURRED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `TERMINATED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `EXIT_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `ENDED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `START_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                               `ENTRY_CRITERION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `EXIT_CRITERION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `SHOW_IN_OVERVIEW_` bit(1) NULL DEFAULT NULL,
                                               `EXTRA_VALUE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `DERIVED_CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `LAST_UNAVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
                                               PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_HI_PLAN_ITEM_INST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_RU_CASE_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_RU_CASE_INST`;
CREATE TABLE `ACT_CMMN_RU_CASE_INST`  (
                                          `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                          `REV_` int(0) NOT NULL,
                                          `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `PARENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `STATE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `START_TIME_` datetime(3) NULL DEFAULT NULL,
                                          `START_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `CALLBACK_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                          `LOCK_TIME_` datetime(3) NULL DEFAULT NULL,
                                          `IS_COMPLETEABLE_` bit(1) NULL DEFAULT NULL,
                                          `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `LAST_REACTIVATION_TIME_` datetime(3) NULL DEFAULT NULL,
                                          `LAST_REACTIVATION_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          PRIMARY KEY (`ID_`) USING BTREE,
                                          INDEX `ACT_IDX_CASE_INST_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
                                          INDEX `ACT_IDX_CASE_INST_PARENT`(`PARENT_ID_`) USING BTREE,
                                          INDEX `ACT_IDX_CASE_INST_REF_ID_`(`REFERENCE_ID_`) USING BTREE,
                                          CONSTRAINT `ACT_FK_CASE_INST_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_CMMN_CASEDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_RU_CASE_INST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_RU_MIL_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_RU_MIL_INST`;
CREATE TABLE `ACT_CMMN_RU_MIL_INST`  (
                                         `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `TIME_STAMP_` datetime(3) NULL DEFAULT NULL,
                                         `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                         PRIMARY KEY (`ID_`) USING BTREE,
                                         INDEX `ACT_IDX_MIL_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
                                         INDEX `ACT_IDX_MIL_CASE_INST`(`CASE_INST_ID_`) USING BTREE,
                                         CONSTRAINT `ACT_FK_MIL_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_CMMN_CASEDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                         CONSTRAINT `ACT_FK_MIL_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `ACT_CMMN_RU_CASE_INST` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_RU_MIL_INST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_RU_PLAN_ITEM_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_RU_PLAN_ITEM_INST`;
CREATE TABLE `ACT_CMMN_RU_PLAN_ITEM_INST`  (
                                               `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                               `REV_` int(0) NOT NULL,
                                               `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `IS_STAGE_` bit(1) NULL DEFAULT NULL,
                                               `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `STATE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `START_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
                                               `ITEM_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `ITEM_DEFINITION_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `IS_COMPLETEABLE_` bit(1) NULL DEFAULT NULL,
                                               `IS_COUNT_ENABLED_` bit(1) NULL DEFAULT NULL,
                                               `VAR_COUNT_` int(0) NULL DEFAULT NULL,
                                               `SENTRY_PART_INST_COUNT_` int(0) NULL DEFAULT NULL,
                                               `LAST_AVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_ENABLED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_DISABLED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_STARTED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `LAST_SUSPENDED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `COMPLETED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `OCCURRED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `TERMINATED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `EXIT_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `ENDED_TIME_` datetime(3) NULL DEFAULT NULL,
                                               `ENTRY_CRITERION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `EXIT_CRITERION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `EXTRA_VALUE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `DERIVED_CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                               `LAST_UNAVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
                                               PRIMARY KEY (`ID_`) USING BTREE,
                                               INDEX `ACT_IDX_PLAN_ITEM_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
                                               INDEX `ACT_IDX_PLAN_ITEM_CASE_INST`(`CASE_INST_ID_`) USING BTREE,
                                               INDEX `ACT_IDX_PLAN_ITEM_STAGE_INST`(`STAGE_INST_ID_`) USING BTREE,
                                               CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_CMMN_CASEDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                               CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `ACT_CMMN_RU_CASE_INST` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_RU_PLAN_ITEM_INST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CMMN_RU_SENTRY_PART_INST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CMMN_RU_SENTRY_PART_INST`;
CREATE TABLE `ACT_CMMN_RU_SENTRY_PART_INST`  (
                                                 `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                                 `REV_` int(0) NOT NULL,
                                                 `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 `PLAN_ITEM_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 `ON_PART_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 `IF_PART_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 `TIME_STAMP_` datetime(3) NULL DEFAULT NULL,
                                                 PRIMARY KEY (`ID_`) USING BTREE,
                                                 INDEX `ACT_IDX_SENTRY_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
                                                 INDEX `ACT_IDX_SENTRY_CASE_INST`(`CASE_INST_ID_`) USING BTREE,
                                                 INDEX `ACT_IDX_SENTRY_PLAN_ITEM`(`PLAN_ITEM_INST_ID_`) USING BTREE,
                                                 CONSTRAINT `ACT_FK_SENTRY_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_CMMN_CASEDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                                 CONSTRAINT `ACT_FK_SENTRY_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `ACT_CMMN_RU_CASE_INST` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                                 CONSTRAINT `ACT_FK_SENTRY_PLAN_ITEM` FOREIGN KEY (`PLAN_ITEM_INST_ID_`) REFERENCES `ACT_CMMN_RU_PLAN_ITEM_INST` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CMMN_RU_SENTRY_PART_INST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CO_CONTENT_ITEM
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CO_CONTENT_ITEM`;
CREATE TABLE `ACT_CO_CONTENT_ITEM`  (
                                        `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                        `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                        `MIME_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `TASK_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `PROC_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `CONTENT_STORE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `CONTENT_STORE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `FIELD_` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `CONTENT_AVAILABLE_` bit(1) NULL DEFAULT b'0',
                                        `CREATED_` timestamp(6) NULL DEFAULT NULL,
                                        `CREATED_BY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `LAST_MODIFIED_` timestamp(6) NULL DEFAULT NULL,
                                        `LAST_MODIFIED_BY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `CONTENT_SIZE_` bigint(0) NULL DEFAULT 0,
                                        `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        INDEX `idx_contitem_taskid`(`TASK_ID_`) USING BTREE,
                                        INDEX `idx_contitem_procid`(`PROC_INST_ID_`) USING BTREE,
                                        INDEX `idx_contitem_scope`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CO_CONTENT_ITEM
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_CO_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CO_DATABASECHANGELOG`;
CREATE TABLE `ACT_CO_DATABASECHANGELOG`  (
                                             `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `DATEEXECUTED` datetime(0) NOT NULL,
                                             `ORDEREXECUTED` int(0) NOT NULL,
                                             `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CO_DATABASECHANGELOG
-- ----------------------------
INSERT INTO `ACT_CO_DATABASECHANGELOG` VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-03-17 17:34:45', 1, 'EXECUTED', '8:7644d7165cfe799200a2abdd3419e8b6', 'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.9.1', NULL, NULL, '9045683166');
INSERT INTO `ACT_CO_DATABASECHANGELOG` VALUES ('2', 'flowable', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-03-17 17:34:46', 2, 'EXECUTED', '8:fe7b11ac7dbbf9c43006b23bbab60bab', 'addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.9.1', NULL, NULL, '9045683166');

-- ----------------------------
-- Table structure for ACT_CO_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_CO_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_CO_DATABASECHANGELOGLOCK`  (
                                                 `ID` int(0) NOT NULL,
                                                 `LOCKED` bit(1) NOT NULL,
                                                 `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
                                                 `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_CO_DATABASECHANGELOGLOCK
-- ----------------------------
INSERT INTO `ACT_CO_DATABASECHANGELOGLOCK` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for ACT_DMN_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DATABASECHANGELOG`;
CREATE TABLE `ACT_DMN_DATABASECHANGELOG`  (
                                              `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                              `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                              `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                              `DATEEXECUTED` datetime(0) NOT NULL,
                                              `ORDEREXECUTED` int(0) NOT NULL,
                                              `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                              `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                              `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_DMN_DATABASECHANGELOG
-- ----------------------------
INSERT INTO `ACT_DMN_DATABASECHANGELOG` VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-17 17:34:14', 1, 'EXECUTED', '8:c8701f1c71018b55029f450b2e9a10a1', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '9045651709');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-17 17:34:15', 2, 'EXECUTED', '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '9045651709');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-17 17:34:16', 3, 'EXECUTED', '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '9045651709');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-17 17:34:17', 4, 'EXECUTED', '8:f73aabc4529e7292c2942073d1cff6f9', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '9045651709');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` VALUES ('5', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-17 17:34:22', 5, 'EXECUTED', '8:3e03528582dd4eeb4eb41f9b9539140d', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_DMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION; modifyDataType columnName=END_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '9045651709');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-17 17:34:23', 6, 'EXECUTED', '8:646c6a061e0b6e8a62e69844ff96abb0', 'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '9045651709');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-17 17:34:25', 7, 'EXECUTED', '8:215a499ff7ae77685b55355245b8b708', 'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION', '', NULL, '4.9.1', NULL, NULL, '9045651709');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-17 17:34:26', 8, 'EXECUTED', '8:5355bee389318afed91a11702f2df032', 'addColumn tableName=ACT_DMN_DECISION', '', NULL, '4.9.1', NULL, NULL, '9045651709');
INSERT INTO `ACT_DMN_DATABASECHANGELOG` VALUES ('9', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-17 17:34:27', 9, 'EXECUTED', '8:0fe82086431b1953d293f0199f805876', 'createIndex indexName=ACT_IDX_DMN_INSTANCE_ID, tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '9045651709');

-- ----------------------------
-- Table structure for ACT_DMN_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_DMN_DATABASECHANGELOGLOCK`  (
                                                  `ID` int(0) NOT NULL,
                                                  `LOCKED` bit(1) NOT NULL,
                                                  `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
                                                  `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_DMN_DATABASECHANGELOGLOCK
-- ----------------------------
INSERT INTO `ACT_DMN_DATABASECHANGELOGLOCK` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for ACT_DMN_DECISION
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DECISION`;
CREATE TABLE `ACT_DMN_DECISION`  (
                                     `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `VERSION_` int(0) NULL DEFAULT NULL,
                                     `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `DESCRIPTION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `DECISION_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     UNIQUE INDEX `ACT_IDX_DMN_DEC_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_DMN_DECISION
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_DMN_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DEPLOYMENT`;
CREATE TABLE `ACT_DMN_DEPLOYMENT`  (
                                       `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_DMN_DEPLOYMENT
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_DMN_DEPLOYMENT_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_DEPLOYMENT_RESOURCE`;
CREATE TABLE `ACT_DMN_DEPLOYMENT_RESOURCE`  (
                                                `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                                `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                `RESOURCE_BYTES_` longblob NULL,
                                                PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_DMN_DEPLOYMENT_RESOURCE
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_DMN_HI_DECISION_EXECUTION
-- ----------------------------
DROP TABLE IF EXISTS `ACT_DMN_HI_DECISION_EXECUTION`;
CREATE TABLE `ACT_DMN_HI_DECISION_EXECUTION`  (
                                                  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                                  `DECISION_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                  `START_TIME_` datetime(3) NULL DEFAULT NULL,
                                                  `END_TIME_` datetime(3) NULL DEFAULT NULL,
                                                  `INSTANCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                  `EXECUTION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                  `ACTIVITY_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                  `FAILED_` bit(1) NULL DEFAULT b'0',
                                                  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                  `EXECUTION_JSON_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                                                  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                  PRIMARY KEY (`ID_`) USING BTREE,
                                                  INDEX `ACT_IDX_DMN_INSTANCE_ID`(`INSTANCE_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_DMN_HI_DECISION_EXECUTION
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_EVT_LOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_EVT_LOG`;
CREATE TABLE `ACT_EVT_LOG`  (
                                `LOG_NR_` bigint(0) NOT NULL AUTO_INCREMENT,
                                `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                                `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `DATA_` longblob NULL,
                                `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `IS_PROCESSED_` tinyint(0) NULL DEFAULT 0,
                                PRIMARY KEY (`LOG_NR_`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_EVT_LOG
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_FO_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_DATABASECHANGELOG`;
CREATE TABLE `ACT_FO_DATABASECHANGELOG`  (
                                             `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `DATEEXECUTED` datetime(0) NOT NULL,
                                             `ORDEREXECUTED` int(0) NOT NULL,
                                             `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_FO_DATABASECHANGELOG
-- ----------------------------
INSERT INTO `ACT_FO_DATABASECHANGELOG` VALUES ('1', 'activiti', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-17 17:34:33', 1, 'EXECUTED', '8:033ebf9380889aed7c453927ecc3250d', 'createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '9045669191');
INSERT INTO `ACT_FO_DATABASECHANGELOG` VALUES ('2', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-17 17:34:33', 2, 'EXECUTED', '8:986365ceb40445ce3b27a8e6b40f159b', 'addColumn tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '9045669191');
INSERT INTO `ACT_FO_DATABASECHANGELOG` VALUES ('3', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-17 17:34:34', 3, 'EXECUTED', '8:abf482518ceb09830ef674e52c06bf15', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '9045669191');
INSERT INTO `ACT_FO_DATABASECHANGELOG` VALUES ('4', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-17 17:34:38', 4, 'EXECUTED', '8:2087829f22a4b2298dbf530681c74854', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_FO_FORM_DEPLOYMENT; modifyDataType columnName=SUBMITTED_DATE_, tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '9045669191');
INSERT INTO `ACT_FO_DATABASECHANGELOG` VALUES ('5', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-17 17:34:39', 5, 'EXECUTED', '8:b4be732b89e5ca028bdd520c6ad4d446', 'createIndex indexName=ACT_IDX_FORM_DEF_UNIQ, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '9045669191');
INSERT INTO `ACT_FO_DATABASECHANGELOG` VALUES ('6', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-17 17:34:41', 6, 'EXECUTED', '8:384bbd364a649b67c3ca1bcb72fe537f', 'createIndex indexName=ACT_IDX_FORM_TASK, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_PROC, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_SCOPE, tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '9045669191');

-- ----------------------------
-- Table structure for ACT_FO_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_DATABASECHANGELOGLOCK`;
CREATE TABLE `ACT_FO_DATABASECHANGELOGLOCK`  (
                                                 `ID` int(0) NOT NULL,
                                                 `LOCKED` bit(1) NOT NULL,
                                                 `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
                                                 `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_FO_DATABASECHANGELOGLOCK
-- ----------------------------
INSERT INTO `ACT_FO_DATABASECHANGELOGLOCK` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for ACT_FO_FORM_DEFINITION
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_FORM_DEFINITION`;
CREATE TABLE `ACT_FO_FORM_DEFINITION`  (
                                           `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                           `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `VERSION_` int(0) NULL DEFAULT NULL,
                                           `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `DESCRIPTION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           PRIMARY KEY (`ID_`) USING BTREE,
                                           UNIQUE INDEX `ACT_IDX_FORM_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_FO_FORM_DEFINITION
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_FO_FORM_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_FORM_DEPLOYMENT`;
CREATE TABLE `ACT_FO_FORM_DEPLOYMENT`  (
                                           `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                           `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
                                           `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_FO_FORM_DEPLOYMENT
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_FO_FORM_INSTANCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_FORM_INSTANCE`;
CREATE TABLE `ACT_FO_FORM_INSTANCE`  (
                                         `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `FORM_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `TASK_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `PROC_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `PROC_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `SUBMITTED_DATE_` datetime(3) NULL DEFAULT NULL,
                                         `SUBMITTED_BY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `FORM_VALUES_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         PRIMARY KEY (`ID_`) USING BTREE,
                                         INDEX `ACT_IDX_FORM_TASK`(`TASK_ID_`) USING BTREE,
                                         INDEX `ACT_IDX_FORM_PROC`(`PROC_INST_ID_`) USING BTREE,
                                         INDEX `ACT_IDX_FORM_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_FO_FORM_INSTANCE
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_FO_FORM_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_FO_FORM_RESOURCE`;
CREATE TABLE `ACT_FO_FORM_RESOURCE`  (
                                         `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `RESOURCE_BYTES_` longblob NULL,
                                         PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_FO_FORM_RESOURCE
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_GE_BYTEARRAY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_GE_BYTEARRAY`;
CREATE TABLE `ACT_GE_BYTEARRAY`  (
                                     `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                     `REV_` int(0) NULL DEFAULT NULL,
                                     `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `BYTES_` longblob NULL,
                                     `GENERATED_` tinyint(0) NULL DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     INDEX `ACT_FK_BYTEARR_DEPL`(`DEPLOYMENT_ID_`) USING BTREE,
                                     CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_GE_BYTEARRAY
-- ----------------------------
INSERT INTO `ACT_GE_BYTEARRAY` VALUES ('5c0724f8-ddbe-11ed-89c6-e86a64b08c3b', 5, 'source', NULL, 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C62706D6E3A646566696E6974696F6E7320786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A62706D6E3D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A64633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220786D6C6E733A63616D756E64613D22687474703A2F2F63616D756E64612E6F72672F736368656D612F312E302F62706D6E222069643D22446566696E6974696F6E735F50726F636573735F3136383138303430333437383322207461726765744E616D6573706163653D22687474703A2F2F62706D6E2E696F2F736368656D612F62706D6E223E0A20203C62706D6E3A70726F636573732069643D2250726F636573735F3136383138303430333437383322206E616D653D22E8AFB7E58187E6B581E7A88B2220697345786563757461626C653D2274727565223E0A202020203C62706D6E3A73746172744576656E742069643D224576656E745F3063777A71323922206E616D653D22222063616D756E64613A666F726D4B65793D2231223E0A2020202020203C62706D6E3A6F7574676F696E673E466C6F775F3068376D7737633C2F62706D6E3A6F7574676F696E673E0A202020203C2F62706D6E3A73746172744576656E743E0A202020203C62706D6E3A757365725461736B2069643D2241637469766974795F3070683763686122206E616D653D22E9A286E5AFBCE5AEA1E689B9223E0A2020202020203C62706D6E3A696E636F6D696E673E466C6F775F3068376D7737633C2F62706D6E3A696E636F6D696E673E0A2020202020203C62706D6E3A6F7574676F696E673E466C6F775F313672756175643C2F62706D6E3A6F7574676F696E673E0A202020203C2F62706D6E3A757365725461736B3E0A202020203C62706D6E3A73657175656E6365466C6F772069643D22466C6F775F3068376D7737632220736F757263655265663D224576656E745F3063777A71323922207461726765745265663D2241637469766974795F3070683763686122202F3E0A202020203C62706D6E3A757365725461736B2069643D2241637469766974795F31756A6A69386C22206E616D653D22E4BABAE4BA8BE4BC9AE7ADBE222063616D756E64613A61737369676E6565547970653D2233222063616D756E64613A61737369676E65654E616D65733D2234222063616D756E64613A63616E64696461746547726F7570733D22444550545F34223E0A2020202020203C62706D6E3A696E636F6D696E673E466C6F775F313672756175643C2F62706D6E3A696E636F6D696E673E0A2020202020203C62706D6E3A6F7574676F696E673E466C6F775F30786B3573746E3C2F62706D6E3A6F7574676F696E673E0A202020203C2F62706D6E3A757365725461736B3E0A202020203C62706D6E3A73657175656E6365466C6F772069643D22466C6F775F313672756175642220736F757263655265663D2241637469766974795F3070683763686122207461726765745265663D2241637469766974795F31756A6A69386C22202F3E0A202020203C62706D6E3A757365725461736B2069643D2241637469766974795F3066697265656922206E616D653D22E4BABAE4BA8BE5BD92E6A1A3222063616D756E64613A61737369676E6565547970653D2233222063616D756E64613A61737369676E65654E616D65733D2234222063616D756E64613A63616E64696461746547726F7570733D22444550545F34223E0A2020202020203C62706D6E3A696E636F6D696E673E466C6F775F30786B3573746E3C2F62706D6E3A696E636F6D696E673E0A2020202020203C62706D6E3A6F7574676F696E673E466C6F775F316561643367783C2F62706D6E3A6F7574676F696E673E0A202020203C2F62706D6E3A757365725461736B3E0A202020203C62706D6E3A73657175656E6365466C6F772069643D22466C6F775F30786B3573746E2220736F757263655265663D2241637469766974795F31756A6A69386C22207461726765745265663D2241637469766974795F3066697265656922202F3E0A202020203C62706D6E3A656E644576656E742069643D224576656E745F30316C74786B6A223E0A2020202020203C62706D6E3A696E636F6D696E673E466C6F775F316561643367783C2F62706D6E3A696E636F6D696E673E0A202020203C2F62706D6E3A656E644576656E743E0A202020203C62706D6E3A73657175656E6365466C6F772069643D22466C6F775F316561643367782220736F757263655265663D2241637469766974795F3066697265656922207461726765745265663D224576656E745F30316C74786B6A22202F3E0A20203C2F62706D6E3A70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F31223E0A202020203C62706D6E64693A42504D4E506C616E652069643D2242504D4E506C616E655F31222062706D6E456C656D656E743D2250726F636573735F31363831383034303334373833223E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F3063777A7132395F6469222062706D6E456C656D656E743D224576656E745F3063777A713239223E0A20202020202020203C64633A426F756E647320783D223330322220793D22323632222077696474683D22333622206865696768743D22333622202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C64633A426F756E647320783D223238322220793D22333035222077696474683D22373722206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F307068376368615F6469222062706D6E456C656D656E743D2241637469766974795F30706837636861223E0A20202020202020203C64633A426F756E647320783D223433382220793D22323230222077696474683D2231323022206865696768743D2231323022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F31756A6A69386C5F6469222062706D6E456C656D656E743D2241637469766974795F31756A6A69386C223E0A20202020202020203C64633A426F756E647320783D223635382220793D22323230222077696474683D2231323022206865696768743D2231323022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F306669726565695F6469222062706D6E456C656D656E743D2241637469766974795F30666972656569223E0A20202020202020203C64633A426F756E647320783D223837382220793D22323230222077696474683D2231323022206865696768743D2231323022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F30316C74786B6A5F6469222062706D6E456C656D656E743D224576656E745F30316C74786B6A223E0A20202020202020203C64633A426F756E647320783D22313039382220793D22323632222077696474683D22333622206865696768743D22333622202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F3068376D7737635F6469222062706D6E456C656D656E743D22466C6F775F3068376D773763223E0A20202020202020203C64693A776179706F696E7420783D223333382220793D2232383022202F3E0A20202020202020203C64693A776179706F696E7420783D223433382220793D2232383022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F313672756175645F6469222062706D6E456C656D656E743D22466C6F775F31367275617564223E0A20202020202020203C64693A776179706F696E7420783D223535382220793D2232383022202F3E0A20202020202020203C64693A776179706F696E7420783D223635382220793D2232383022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F30786B3573746E5F6469222062706D6E456C656D656E743D22466C6F775F30786B3573746E223E0A20202020202020203C64693A776179706F696E7420783D223737382220793D2232383022202F3E0A20202020202020203C64693A776179706F696E7420783D223837382220793D2232383022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F316561643367785F6469222062706D6E456C656D656E743D22466C6F775F31656164336778223E0A20202020202020203C64693A776179706F696E7420783D223939382220793D2232383022202F3E0A20202020202020203C64693A776179706F696E7420783D22313039382220793D2232383022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F62706D6E3A646566696E6974696F6E733E0A, NULL);
INSERT INTO `ACT_GE_BYTEARRAY` VALUES ('b2efe91b-1578-11ee-9958-024202297294', 1, '请假流程.bpmn', 'b2efe91a-1578-11ee-9958-024202297294', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C62706D6E3A646566696E6974696F6E7320786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A62706D6E3D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A64633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220786D6C6E733A63616D756E64613D22687474703A2F2F63616D756E64612E6F72672F736368656D612F312E302F62706D6E222069643D22446566696E6974696F6E735F50726F636573735F3136383138303430333437383322207461726765744E616D6573706163653D22687474703A2F2F62706D6E2E696F2F736368656D612F62706D6E223E0A20203C62706D6E3A70726F636573732069643D2250726F636573735F3136383138303430333437383322206E616D653D22E8AFB7E58187E6B581E7A88B2220697345786563757461626C653D2274727565223E0A202020203C62706D6E3A73746172744576656E742069643D224576656E745F3063777A71323922206E616D653D22222063616D756E64613A666F726D4B65793D2231223E0A2020202020203C62706D6E3A6F7574676F696E673E466C6F775F3068376D7737633C2F62706D6E3A6F7574676F696E673E0A202020203C2F62706D6E3A73746172744576656E743E0A202020203C62706D6E3A757365725461736B2069643D2241637469766974795F3070683763686122206E616D653D22E9A286E5AFBCE5AEA1E689B9223E0A2020202020203C62706D6E3A696E636F6D696E673E466C6F775F3068376D7737633C2F62706D6E3A696E636F6D696E673E0A2020202020203C62706D6E3A6F7574676F696E673E466C6F775F313672756175643C2F62706D6E3A6F7574676F696E673E0A202020203C2F62706D6E3A757365725461736B3E0A202020203C62706D6E3A73657175656E6365466C6F772069643D22466C6F775F3068376D7737632220736F757263655265663D224576656E745F3063777A71323922207461726765745265663D2241637469766974795F3070683763686122202F3E0A202020203C62706D6E3A757365725461736B2069643D2241637469766974795F31756A6A69386C22206E616D653D22E4BABAE4BA8BE4BC9AE7ADBE222063616D756E64613A61737369676E6565547970653D2233222063616D756E64613A61737369676E65654E616D65733D2234222063616D756E64613A63616E64696461746547726F7570733D22444550545F34223E0A2020202020203C62706D6E3A696E636F6D696E673E466C6F775F313672756175643C2F62706D6E3A696E636F6D696E673E0A2020202020203C62706D6E3A6F7574676F696E673E466C6F775F30786B3573746E3C2F62706D6E3A6F7574676F696E673E0A202020203C2F62706D6E3A757365725461736B3E0A202020203C62706D6E3A73657175656E6365466C6F772069643D22466C6F775F313672756175642220736F757263655265663D2241637469766974795F3070683763686122207461726765745265663D2241637469766974795F31756A6A69386C22202F3E0A202020203C62706D6E3A757365725461736B2069643D2241637469766974795F3066697265656922206E616D653D22E4BABAE4BA8BE5BD92E6A1A3222063616D756E64613A61737369676E6565547970653D2233222063616D756E64613A61737369676E65654E616D65733D2234222063616D756E64613A63616E64696461746547726F7570733D22444550545F34223E0A2020202020203C62706D6E3A696E636F6D696E673E466C6F775F30786B3573746E3C2F62706D6E3A696E636F6D696E673E0A2020202020203C62706D6E3A6F7574676F696E673E466C6F775F316561643367783C2F62706D6E3A6F7574676F696E673E0A202020203C2F62706D6E3A757365725461736B3E0A202020203C62706D6E3A73657175656E6365466C6F772069643D22466C6F775F30786B3573746E2220736F757263655265663D2241637469766974795F31756A6A69386C22207461726765745265663D2241637469766974795F3066697265656922202F3E0A202020203C62706D6E3A656E644576656E742069643D224576656E745F30316C74786B6A223E0A2020202020203C62706D6E3A696E636F6D696E673E466C6F775F316561643367783C2F62706D6E3A696E636F6D696E673E0A202020203C2F62706D6E3A656E644576656E743E0A202020203C62706D6E3A73657175656E6365466C6F772069643D22466C6F775F316561643367782220736F757263655265663D2241637469766974795F3066697265656922207461726765745265663D224576656E745F30316C74786B6A22202F3E0A20203C2F62706D6E3A70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F31223E0A202020203C62706D6E64693A42504D4E506C616E652069643D2242504D4E506C616E655F31222062706D6E456C656D656E743D2250726F636573735F31363831383034303334373833223E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F3063777A7132395F6469222062706D6E456C656D656E743D224576656E745F3063777A713239223E0A20202020202020203C64633A426F756E647320783D223330322220793D22323632222077696474683D22333622206865696768743D22333622202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C64633A426F756E647320783D223238322220793D22333035222077696474683D22373722206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F307068376368615F6469222062706D6E456C656D656E743D2241637469766974795F30706837636861223E0A20202020202020203C64633A426F756E647320783D223433382220793D22323230222077696474683D2231323022206865696768743D2231323022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F31756A6A69386C5F6469222062706D6E456C656D656E743D2241637469766974795F31756A6A69386C223E0A20202020202020203C64633A426F756E647320783D223635382220793D22323230222077696474683D2231323022206865696768743D2231323022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F306669726565695F6469222062706D6E456C656D656E743D2241637469766974795F30666972656569223E0A20202020202020203C64633A426F756E647320783D223837382220793D22323230222077696474683D2231323022206865696768743D2231323022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F30316C74786B6A5F6469222062706D6E456C656D656E743D224576656E745F30316C74786B6A223E0A20202020202020203C64633A426F756E647320783D22313039382220793D22323632222077696474683D22333622206865696768743D22333622202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F3068376D7737635F6469222062706D6E456C656D656E743D22466C6F775F3068376D773763223E0A20202020202020203C64693A776179706F696E7420783D223333382220793D2232383022202F3E0A20202020202020203C64693A776179706F696E7420783D223433382220793D2232383022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F313672756175645F6469222062706D6E456C656D656E743D22466C6F775F31367275617564223E0A20202020202020203C64693A776179706F696E7420783D223535382220793D2232383022202F3E0A20202020202020203C64693A776179706F696E7420783D223635382220793D2232383022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F30786B3573746E5F6469222062706D6E456C656D656E743D22466C6F775F30786B3573746E223E0A20202020202020203C64693A776179706F696E7420783D223737382220793D2232383022202F3E0A20202020202020203C64693A776179706F696E7420783D223837382220793D2232383022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F316561643367785F6469222062706D6E456C656D656E743D22466C6F775F31656164336778223E0A20202020202020203C64693A776179706F696E7420783D223939382220793D2232383022202F3E0A20202020202020203C64693A776179706F696E7420783D22313039382220793D2232383022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F62706D6E3A646566696E6974696F6E733E0A, 0);
INSERT INTO `ACT_GE_BYTEARRAY` VALUES ('b33fdddc-1578-11ee-9958-024202297294', 1, '请假流程.Process_1681804034783.png', 'b2efe91a-1578-11ee-9958-024202297294', 0x89504E470D0A1A0A0000000D49484452000004780000015E0806000000FE3FA8CF000014F24944415478DAEDDD4F6C54776207F03D70C881430E7BD8430F7BC861A55E7288D43DE44095E31E566A648D676C87B192A83610C0552A0BACC86D9185825112924A4E04AACB92DD28B205759752126F4CDDFC29E0DA1BC7F102062FAC1DD7D921D40107C6FC29AFEF473DD5C4D8E15FEC19DE7C3ED2579BB5C996CEF83BFEBEE7E7373FF80100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F8D288A568D8F8FFFF2D8B163B3478E1C897A7B7BE5214F5F5FDFB5FEFEFE63F13FFFD457B8BE89BEE99BBEE91B0040053879F2E4EE782C45F1088EBEF9E69BE8EAD5ABF290273C8F636363D1071F7C306B04EB9BE89BBEE99BBE010054808F3EFA283F313161382630274E9C988E07F0AF7D95EB9BE89BBE89BE0100245CB8E4399FCF1B8C09FD4967FCFCCEF82AD737D1377D137D0300A880016C2C2637E1F9F555AE6FA26FFA26FA06006000FFDF4FCBBE9E8E7E3FD0198DFEE6EF6E25FC73F898916900A36FA26FFA26FA0600F0100CE0D999A9E8F3F75E8A86FFE5AFBF95F0B1F03943D30046DF44DFF44DF40D00A0CC07F0E4E83FDF367E0BF962F4D786A6018CBE89BEE99BE81B0040B90FE013475E5E720087CF199A0630FA26FAA66FA26F0000653E803FEFFD9B250770F89CA16900A36FA26FFA26FA060060008B01AC6FFAA66FE89BE81B00C0720EE0F0AE224B0DE0F03943D30046DF44DFF44DF40D00A0CC07F0E98FFF7EC9011C3E67681AC0E89BE89BBE89BE010094F900BE30F559F4F9FBADB75FBE1E7F2C7CCED03480D137D1377D137D030028F3011C72F63F7F71DB000E1F33320D60F44DF44DDF44DF00001E86013C37179DFEA4E3F6CBD7E38F85CF199A0630FA26FAA66FA26F0000653C806767A6A2B18FDF58F21E05E173E1CF189B0630FAA66FFAA66FA26F0000E53680E7E6A2E9D37DD1C8E1AD4B8EDF42C29F097FD64F3B0D60F44DDFD037D13700803219C077FAA9A69F761AC0E89BE89BBE89BE010094F900BE9B9F6A7ED74F3B0D4F03187DD337F44DF40D00A0C403F87EC76F2186A7018CBEE91BFA26FA060050E2012C0630FA26FAA66FA26F000006B018C0E89BBEA16FA26F000006B018C0FA26FA86BE89BE010018C06200EB9BE89BBE89BE010018C06200A36FA26FFA26FA060060008B018CBEE91BFA26FA060060008B01AC6FA26FE89BE81B0080016C00A36FA26FFA26FA060060008B018CBE89BEE99BE81B0080012C06B0BEE99BBEA16FA26F000006B018C0FA26FA86BE89BE010018C00630FA26FAA66FA26F000006B018C0E89BE89BBE89BE010018C06200EB9BE81BFA26FA060060008B01AC6FA26FE89BBE010060001BC0E89BE89BBE89BE010018C06200A36FA26FFA26FA060060008B01AC6FA26FE89BE81B0080012C06B0BE89BEA16FFA060060001B8A0630FA26FAA66FA26F000006B018C0E89BE89BBE89BE71F7D2E9F493D5D5D5DBE274C63912E7449CB37146E2CFF5868FA752A9964C26F3B8470BE03E4551B4FAF0E1C39B3B3A3A065E7EF9E53FB4B4B45CDCB469D3B5F5EBD75F8FFFF3F2962D5BFEB86DDBB6DFB5B6B6EE6E6A6AFA538F98012C0630FA26FAA66FA26FDC497575F513A9546A773A9DFE2AFEE7E81E3219FF7BAFC6FFDE4F3C8A0077617070B0E68D37DEF8FD860D1B6E6EDEBC397AFBEDB7A3FEFEFE687474349A9A9A8A72B95C343131118D8C8CDCFAF89E3D7BA2C6C6C69BEBD6ADBBF8E28B2FFE43369B7DD4A368008B018CBEE91BFA26FA46B1AAAAAAC7AAABABBBEEF1A4CE62B91E4E10C5FF7B3FF2A8022CE2E4C9937FFEE69B6F4E3CFFFCF3D1BBEFBE7BEB64CEBD181F1F8FF6EEDD1BD5D7D75FDDB871E32BD96CF6118FAA012C0630FAA66FE89BE85B655BB366CDAAF92B6F6E2C3C59B36EDDBA5B3F305EEA07CA7D7D7D51474747148E511639D1938FD3EC1106981745D1AAC3870FFF5378D10C2FAE333333D183989E9E8E5E7FFDF59BF5F5F55FC72FE43FF5081BC06200A36FFA86BE89BE55A670757F2693F9CDC29333E1A4CDD8D8D85D1F63DCB871E3D609A01D3B762C76A2679F1F2E034EEE44D1EA7DFBF69D0A67CEC31538DFA7E1E1E1287EA1CDD7D6D63EE3913680C50046DFF40D7D137DAB2CE15E39994C66BCF8644C5B5B5B74EEDCB9073ACE08277AB66EDDBAF024CF805FD9022AF9E4CEA3BB76EDFA3ABC383EE8553B4B099758AE5FBF3E5F5353F3B71E7103580C60F44DDFD037D1B78A39B9F3C34C26F387C20998F87820DABF7FFFF7769C11AEE8E9ECECBCED248F2B79804A3CB9B36AEFDEBD675E7AE9A5289FCF47CB299C3C6A6868B8984AA56A3CF206B018C0E89BBEA16FA26FC916EEB9934EA7FFAD70E2259BCD46434343CB72AC11EED1134E1E15FFBA966700A828FF1A0BBF96B55C57EE2C7625CF33CF3CF38D7BF218C06200A36FFA86BE89BE255B75757547F1953BE1D60DCB299CE45970258F1B2F0395617070F02FC20D951FF4775FEFD5A79F7E7A237E819F76D9A4012C06B0BEE99BBEA16FA26FC994C9641E2F3ED972F0E0C11539D658F0EB5A79F7E3012AC2AE5DBBBE7AE79D77A252686B6B9B4CA5522D9E0503580C607DF375A96FE89BE85BF2A4D3E9DEC289969D3B77AED87146B8274FF18D97E3638EDD9E0D20D18E1E3DBA295CBD73F9F2E5929CE0096FA15E53533313DE2ED1B361008B01AC6FA26FE89BE85B725457573F55FCAB5961FBAFA4F0EE5A4557F15C0FEFE2E5590112ABBDBDFDFCA14387A2527AEDB5D74EC62FB8DB3C1B06B018C0FA26FA86BE89BE25472A953A5038C1127E65AA1476ECD8517C15CFAB9E152091A6A7A77F1CEE607FE9D2A5929EE03973E6CCE5743A7DD23362008B01AC6FA26FE89BE85B32545555ADAEAEAE9E2B9C5CC9E5722539D6587015CFA4670648A403070EEC6C6D6D8DCA415D5D5D2EFE26F0986765F9859FA4849BDD19C006B036E89BE89BBE89BEB15C7D8BFFCCCF0B27569A9B9B4B769C11EEC5136E4951F8BBDCCDEB04C043E795575E39D7D3D353162778B66FDF3EE2ED0B5746D125AADFF98DD9003680D137D1377D137DE37EFB166E6A5CF873DDDDDD253DD6E8E8E828FE352D6FF002244F4B4BCBA570C96239E8E9E9391EBFE0767A5656EE1BF29DBE311BC00630FA26FAA66FA26FDC6FDFE28F1F297C7E6464A4A4C71A7D7D7DC57F5FC71C40F26CDCB8F1FA4ADFC97E29C78F1F1F096FA1E85959F96FC84B7D6336800D60F44DF44DDF44DFB8DFBEC5FFFD74E1E3A53EE60827980A7F17C71C4022851B2CE7F3F9B238C173F6ECD9A9F80577C4B352BA6FC80BBF311BC00630FA26FAA66FA26FDC6FDFE2FFBC5CF8EFA53EE698989828FEFB39E60092F9C25C2ECE9F3FFF5F77FA46212B1B0338D9F135AE6FA26FFA26FA262B9552BB70E18277D20292ADB6B6F6E6B56BD7CAE50A9E4FE317DB139E95D2FDC425954AFD36BCDB41E1CF19C07EC289BE89BEE99BE81BF7DBB7F8BFE70B1F2FF531C7D4D454F1DFD33107903C8D8D8D5773B95C599CE0397AF4E887E1466C9E9595FF86BC70F8266500C7FF2F2C9AE5FA9C018CBEE99BBEE99BBEE99BBE7DEBCF9C2D7CBED4C71CE18D658AFEBE8E3980E4D9B265CB85727917ADEEEEEE3E77B45FD96FC84B0DDF240DE0A53EB61C9F3380D1377DD3377DD3377DD3B76FFD99FF7F17AD521F73F4F7F77B172D20D95A5A5A8EBDF7DE7B65718267EBD6ADE1466CAD9E95E577A7E16B001BC0E89BBEE99BBEE99BBEF1A07D8BB7FDBEC249959E9E9E921E6BECD9B3A7F804CF36CF209038ADADAD0D6D6D6DE5707E279FC964C68BDFC294D233800D60F44DDFF44DDFF44DDF788093403585932AF17147490F361A1B1B6F16BD4DFA939E1D2071B2D9EC236BD7AEFD9F52BF6DE1993367C2E59B673D2306B0016C00EB9BBEE91BFAA66FFA960C555555ABE38D7FBD7062656666A624C71A636363C557EF4C7B6680C46A6A6AFA6D5F5F5F494FF0B4B4B4FC2A954ABDEAD930800D600358DFF44DDFD0377DD3B7E448A7D3BD85932BDDDDDD2539D6E8E8E828BE19F46ECF0A9058F5F5F57FD6D0D070BD546F5D98CBE53E8E5F6CCFD7D4D4FC8967C30036800D607DD3377D43DFF44DDF127582E7E9C2C995BABABA15BF8AE7DCB9730BDFCAFD09CF0A90689B366DFAA454373EDBB0614377FC42DBEE5930800D600358DFF44DDFD0377DD3B7E489B7FE40E104CB5B6FBDB5A2C71AE17EA3452777BA3C1B40E25555553D565F5F7F3597CBADE80BEEC0C0C0AFC2D53BD96CF651CF82016C001BC0FAA66FFA86BEE99BBE25F204CF9AE2AB683EFCF0C31539D6D8BF7F7FF1C99DEBE198C7B3015484E79E7B6E635353537EA56EB89CCBE5FAE217DAC9383FF3E81BC0CB358017CB727DCE0046DFF44DDFF44DDFF48DC5A552A90385932DD96C361A1F1F5FD6638DA1A1A12893C9DC2CBAF78EFB7D0295E5D9679FFDC5F6EDDBE76EDCB8B1AC2FB857AE5C3915BFE00EC62FB6CD1E7503580C60F44DDFD037D1B7649B7F47AD91C20997868686653BC9333C3C1C85770A2E7A5BF4DE356BD6ACF22C001525BCF0C52F86FFBE6DDBB68BCB75254F2E97EBAFADAD0DBF87DBE9113780C50046DFF40D7D137DAB0CF1FEFF71B83D43F1953CDFF7AF6B1D3C78F05B57EEC439ED761040459FE4A9ABABDBF3C20B2F5CFCBEEFC9333C3CDC157E2D2B954AB578A40D603180D1377D43DF44DF2A4B3A9D7EB2F8244FE1C6CB0FFAEE5AD3D3D3D1CE9D3B17BE63D6D9F8FFDE4F3CEA8017DF74FA2FEBEAEA2E7575757DF5A06FA13E3B3BFB597373F32FC38B792A95FAB947D7001603187DD337F44DF4AD32CD5FC933527C3226BC857A7777F73D9FE8093F90EEECEC5C78D54EC891F878E6871E6D8079E14EF3F10B63F7DAB56BFFFBD0A1435FDCEBAF6DC52FD003EDEDEDFF387F626777FCBFF7238FAA012C0630FAA66FE89BE85BC51F67AC2EBEF172715A5B5BA39E9E9E687474F4D6099CC20F9BC3B148B852676464E4D6C9A0E6E6E668B17F3F4E877BEE002C217E917C22BC00673299CB9B376F3ED5D5D5353A343474FACB2FBFCC155E70AF5CB9F2C5C4C4C467C78E1DFBA4BDBDBDBBAEAEEE78FCEFCDC6D9E72D090D603180D1377D43DF44DF58E43823BC85FAC012276AEE29E166CAF1F1CAE31E5580BB90CD661F09BF62156E901C2E7B0CBFD71A273FFFA21A4EE69C9EFF78479CA79C393780C50046DF44DFF44DF48D3B49A7D34F871334F131C4F57B3CB1939FBF12E8298F220018C00630FA26FAA66FA26F9481F08E57A954AA26FC16C077FD4039DCFE21FCE039FCAA97470D000C6003187D137DD337D137000003580C60F44DF44DDF44DF00000C603180D1377D43DF44DF00000C603180F54DF40D7D137D030030800D60F44DF44DDF44DF00000C603180D137D1377D137D03003080C500D637D137F44DF40D00C000160358DF44DFD0377DF3550E0060001BC0E89BE89BBE89BE010018C06200A36FA26FFA26FA060060008B01AC6FA26FE89BE81B0080012C06B0BE89BEA16FFA060080016C00A36FA26FFA26FA060060008B018CBE89BEE99BE81B0080012C06B0BE89BEA16FA26F000006B018C0FA26FA86BEE91B0080012C0630FA26FAA66FA26F000006B018C0E89BBEA16FA26F000006B018C0FA26FA86BE89BE010018C06200EB9BE81BFAA66F000006B018C0E89BE89BBE89BE010018C06200A36FFA86BE89BE010018C06200EB9BE81BFA26FA060060008B01AC6FA26FFA26FA060060008B018CBE89BEE99BE81B0080012C0630FAA66FE89BE81B0080012C06B0BE89BEA16FA26F000006B0018CBE89BEE99BE81B0080012C0630FA26FAA66FA26F000006B018C0E89BBEA16FA26F000006B018C0FA26FA86BE89BE010018C00630FA26FAA66FA26F000006B018C0E89BE89BBE89BE010018C06200EB9BE81BFA26FA060060008B01AC6FA26FE89BBE010060001BC0E89BE89BBE89BE010018C06200A36FA26FFA26FA0600502E03786E6ECE584C60666767FF237E7E677D95EB9BE89BBE89BE0100245C7F7FFFC5A9A929833181191C1CDC170FE05E5FE5FA26FAA66FA26F000009D7D7D7F757F108FE727272F28F7ED2998CC4CFE3D7A74E9D3AF4FEFBEF4FC6FBF767BECAF54DF44DDFF44DDF00002A403C94D6C743E974B89C5D129391384FFBEAD637D1377DD3377D03000000000000000000000000000000000000000000000000000000000000000000000000000000E0A1F7BF848DD6581EA33BA40000000049454E44AE426082, 1);

-- ----------------------------
-- Table structure for ACT_GE_PROPERTY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_GE_PROPERTY`;
CREATE TABLE `ACT_GE_PROPERTY`  (
                                    `NAME_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `VALUE_` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `REV_` int(0) NULL DEFAULT NULL,
                                    PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_GE_PROPERTY
-- ----------------------------
INSERT INTO `ACT_GE_PROPERTY` VALUES ('batch.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('cfg.task-related-entities-count', 'true', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('common.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('entitylink.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('eventsubscription.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('identitylink.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('job.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('next.dbid', '1', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('schema.history', 'create(6.8.0.0)', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('task.schema.version', '6.8.0.0', 1);
INSERT INTO `ACT_GE_PROPERTY` VALUES ('variable.schema.version', '6.8.0.0', 1);

-- ----------------------------
-- Table structure for ACT_HI_ACTINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ACTINST`;
CREATE TABLE `ACT_HI_ACTINST`  (
                                   `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `REV_` int(0) NULL DEFAULT 1,
                                   `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `ACT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `ACT_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `END_TIME_` datetime(3) NULL DEFAULT NULL,
                                   `TRANSACTION_ORDER_` int(0) NULL DEFAULT NULL,
                                   `DURATION_` bigint(0) NULL DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_ACT_INST_START`(`START_TIME_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_ACT_INST_END`(`END_TIME_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_ACT_INST_PROCINST`(`PROC_INST_ID_`, `ACT_ID_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_ACT_INST_EXEC`(`EXECUTION_ID_`, `ACT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_ACTINST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_HI_ATTACHMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ATTACHMENT`;
CREATE TABLE `ACT_HI_ATTACHMENT`  (
                                      `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                      `REV_` int(0) NULL DEFAULT NULL,
                                      `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `URL_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `CONTENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `TIME_` datetime(3) NULL DEFAULT NULL,
                                      PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_ATTACHMENT
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_HI_COMMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_COMMENT`;
CREATE TABLE `ACT_HI_COMMENT`  (
                                   `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `TIME_` datetime(3) NOT NULL,
                                   `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `ACTION_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `MESSAGE_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `FULL_MSG_` longblob NULL,
                                   PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_COMMENT
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_HI_DETAIL
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_DETAIL`;
CREATE TABLE `ACT_HI_DETAIL`  (
                                  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                  `ACT_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                  `VAR_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                  `REV_` int(0) NULL DEFAULT NULL,
                                  `TIME_` datetime(3) NOT NULL,
                                  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                  `DOUBLE_` double NULL DEFAULT NULL,
                                  `LONG_` bigint(0) NULL DEFAULT NULL,
                                  `TEXT_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                  `TEXT2_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                  PRIMARY KEY (`ID_`) USING BTREE,
                                  INDEX `ACT_IDX_HI_DETAIL_PROC_INST`(`PROC_INST_ID_`) USING BTREE,
                                  INDEX `ACT_IDX_HI_DETAIL_ACT_INST`(`ACT_INST_ID_`) USING BTREE,
                                  INDEX `ACT_IDX_HI_DETAIL_TIME`(`TIME_`) USING BTREE,
                                  INDEX `ACT_IDX_HI_DETAIL_NAME`(`NAME_`) USING BTREE,
                                  INDEX `ACT_IDX_HI_DETAIL_TASK_ID`(`TASK_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_DETAIL
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_HI_ENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_ENTITYLINK`;
CREATE TABLE `ACT_HI_ENTITYLINK`  (
                                      `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                      `LINK_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
                                      `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `PARENT_ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `REF_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `REF_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `ROOT_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `ROOT_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `HIERARCHY_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      PRIMARY KEY (`ID_`) USING BTREE,
                                      INDEX `ACT_IDX_HI_ENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
                                      INDEX `ACT_IDX_HI_ENT_LNK_REF_SCOPE`(`REF_SCOPE_ID_`, `REF_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
                                      INDEX `ACT_IDX_HI_ENT_LNK_ROOT_SCOPE`(`ROOT_SCOPE_ID_`, `ROOT_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
                                      INDEX `ACT_IDX_HI_ENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_ENTITYLINK
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_HI_IDENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_IDENTITYLINK`;
CREATE TABLE `ACT_HI_IDENTITYLINK`  (
                                        `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                        `GROUP_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
                                        `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        INDEX `ACT_IDX_HI_IDENT_LNK_USER`(`USER_ID_`) USING BTREE,
                                        INDEX `ACT_IDX_HI_IDENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        INDEX `ACT_IDX_HI_IDENT_LNK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        INDEX `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        INDEX `ACT_IDX_HI_IDENT_LNK_TASK`(`TASK_ID_`) USING BTREE,
                                        INDEX `ACT_IDX_HI_IDENT_LNK_PROCINST`(`PROC_INST_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_IDENTITYLINK
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_HI_PROCINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_PROCINST`;
CREATE TABLE `ACT_HI_PROCINST`  (
                                    `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `REV_` int(0) NULL DEFAULT 1,
                                    `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `START_TIME_` datetime(3) NOT NULL,
                                    `END_TIME_` datetime(3) NULL DEFAULT NULL,
                                    `DURATION_` bigint(0) NULL DEFAULT NULL,
                                    `START_USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `START_ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `END_ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `SUPER_PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                    `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `CALLBACK_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    UNIQUE INDEX `PROC_INST_ID_`(`PROC_INST_ID_`) USING BTREE,
                                    INDEX `ACT_IDX_HI_PRO_INST_END`(`END_TIME_`) USING BTREE,
                                    INDEX `ACT_IDX_HI_PRO_I_BUSKEY`(`BUSINESS_KEY_`) USING BTREE,
                                    INDEX `ACT_IDX_HI_PRO_SUPER_PROCINST`(`SUPER_PROCESS_INSTANCE_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_PROCINST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_HI_TASKINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_TASKINST`;
CREATE TABLE `ACT_HI_TASKINST`  (
                                    `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `REV_` int(0) NULL DEFAULT 1,
                                    `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `TASK_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `START_TIME_` datetime(3) NOT NULL,
                                    `CLAIM_TIME_` datetime(3) NULL DEFAULT NULL,
                                    `END_TIME_` datetime(3) NULL DEFAULT NULL,
                                    `DURATION_` bigint(0) NULL DEFAULT NULL,
                                    `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `PRIORITY_` int(0) NULL DEFAULT NULL,
                                    `DUE_DATE_` datetime(3) NULL DEFAULT NULL,
                                    `FORM_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                    `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    INDEX `ACT_IDX_HI_TASK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                    INDEX `ACT_IDX_HI_TASK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                    INDEX `ACT_IDX_HI_TASK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                    INDEX `ACT_IDX_HI_TASK_INST_PROCINST`(`PROC_INST_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_TASKINST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_HI_TSK_LOG
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_TSK_LOG`;
CREATE TABLE `ACT_HI_TSK_LOG`  (
                                   `ID_` bigint(0) NOT NULL AUTO_INCREMENT,
                                   `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `TIME_STAMP_` timestamp(3) NOT NULL,
                                   `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `DATA_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                   PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_TSK_LOG
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_HI_VARINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_VARINST`;
CREATE TABLE `ACT_HI_VARINST`  (
                                   `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `REV_` int(0) NULL DEFAULT 1,
                                   `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `VAR_TYPE_` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `DOUBLE_` double NULL DEFAULT NULL,
                                   `LONG_` bigint(0) NULL DEFAULT NULL,
                                   `TEXT_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `TEXT2_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
                                   `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_PROCVAR_NAME_TYPE`(`NAME_`, `VAR_TYPE_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_VAR_SCOPE_ID_TYPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_VAR_SUB_ID_TYPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_PROCVAR_PROC_INST`(`PROC_INST_ID_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_PROCVAR_TASK_ID`(`TASK_ID_`) USING BTREE,
                                   INDEX `ACT_IDX_HI_PROCVAR_EXE`(`EXECUTION_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_VARINST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_ID_BYTEARRAY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_BYTEARRAY`;
CREATE TABLE `ACT_ID_BYTEARRAY`  (
                                     `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                     `REV_` int(0) NULL DEFAULT NULL,
                                     `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `BYTES_` longblob NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_ID_BYTEARRAY
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_ID_GROUP
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_GROUP`;
CREATE TABLE `ACT_ID_GROUP`  (
                                 `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                 `REV_` int(0) NULL DEFAULT NULL,
                                 `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_ID_GROUP
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_ID_INFO
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_INFO`;
CREATE TABLE `ACT_ID_INFO`  (
                                `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                `REV_` int(0) NULL DEFAULT NULL,
                                `USER_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `VALUE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PASSWORD_` longblob NULL,
                                `PARENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_ID_INFO
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_ID_MEMBERSHIP
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_MEMBERSHIP`;
CREATE TABLE `ACT_ID_MEMBERSHIP`  (
                                      `USER_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                      `GROUP_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                      PRIMARY KEY (`USER_ID_`, `GROUP_ID_`) USING BTREE,
                                      INDEX `ACT_FK_MEMB_GROUP`(`GROUP_ID_`) USING BTREE,
                                      CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `ACT_ID_GROUP` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                      CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `ACT_ID_USER` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_ID_MEMBERSHIP
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_ID_PRIV
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_PRIV`;
CREATE TABLE `ACT_ID_PRIV`  (
                                `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                PRIMARY KEY (`ID_`) USING BTREE,
                                UNIQUE INDEX `ACT_UNIQ_PRIV_NAME`(`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_ID_PRIV
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_ID_PRIV_MAPPING
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_PRIV_MAPPING`;
CREATE TABLE `ACT_ID_PRIV_MAPPING`  (
                                        `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                        `PRIV_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                        `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `GROUP_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        INDEX `ACT_FK_PRIV_MAPPING`(`PRIV_ID_`) USING BTREE,
                                        INDEX `ACT_IDX_PRIV_USER`(`USER_ID_`) USING BTREE,
                                        INDEX `ACT_IDX_PRIV_GROUP`(`GROUP_ID_`) USING BTREE,
                                        CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `ACT_ID_PRIV` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_ID_PRIV_MAPPING
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_ID_PROPERTY
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_PROPERTY`;
CREATE TABLE `ACT_ID_PROPERTY`  (
                                    `NAME_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `VALUE_` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `REV_` int(0) NULL DEFAULT NULL,
                                    PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_ID_PROPERTY
-- ----------------------------
INSERT INTO `ACT_ID_PROPERTY` VALUES ('schema.version', '6.8.0.0', 1);

-- ----------------------------
-- Table structure for ACT_ID_TOKEN
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_TOKEN`;
CREATE TABLE `ACT_ID_TOKEN`  (
                                 `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                 `REV_` int(0) NULL DEFAULT NULL,
                                 `TOKEN_VALUE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `TOKEN_DATE_` timestamp(3) NULL DEFAULT NULL,
                                 `IP_ADDRESS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `USER_AGENT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `TOKEN_DATA_` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_ID_TOKEN
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_ID_USER
-- ----------------------------
DROP TABLE IF EXISTS `ACT_ID_USER`;
CREATE TABLE `ACT_ID_USER`  (
                                `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                `REV_` int(0) NULL DEFAULT NULL,
                                `FIRST_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `LAST_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `DISPLAY_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `EMAIL_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PWD_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PICTURE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_ID_USER
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_PROCDEF_INFO
-- ----------------------------
DROP TABLE IF EXISTS `ACT_PROCDEF_INFO`;
CREATE TABLE `ACT_PROCDEF_INFO`  (
                                     `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                     `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                     `REV_` int(0) NULL DEFAULT NULL,
                                     `INFO_JSON_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     UNIQUE INDEX `ACT_UNIQ_INFO_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
                                     INDEX `ACT_IDX_INFO_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
                                     INDEX `ACT_FK_INFO_JSON_BA`(`INFO_JSON_ID_`) USING BTREE,
                                     CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                     CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_PROCDEF_INFO
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RE_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_DEPLOYMENT`;
CREATE TABLE `ACT_RE_DEPLOYMENT`  (
                                      `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                      `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                      `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
                                      `DERIVED_FROM_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `DERIVED_FROM_ROOT_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `ENGINE_VERSION_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RE_DEPLOYMENT
-- ----------------------------
INSERT INTO `ACT_RE_DEPLOYMENT` VALUES ('b2efe91a-1578-11ee-9958-024202297294', '请假流程', '请假类', 'Leave_202304172112', '000000', '2023-06-28 05:57:43.739', NULL, NULL, 'b2efe91a-1578-11ee-9958-024202297294', NULL);

-- ----------------------------
-- Table structure for ACT_RE_MODEL
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_MODEL`;
CREATE TABLE `ACT_RE_MODEL`  (
                                 `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                 `REV_` int(0) NULL DEFAULT NULL,
                                 `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                 `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                 `VERSION_` int(0) NULL DEFAULT NULL,
                                 `META_INFO_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `EDITOR_SOURCE_VALUE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                 PRIMARY KEY (`ID_`) USING BTREE,
                                 INDEX `ACT_FK_MODEL_SOURCE`(`EDITOR_SOURCE_VALUE_ID_`) USING BTREE,
                                 INDEX `ACT_FK_MODEL_SOURCE_EXTRA`(`EDITOR_SOURCE_EXTRA_VALUE_ID_`) USING BTREE,
                                 INDEX `ACT_FK_MODEL_DEPLOYMENT`(`DEPLOYMENT_ID_`) USING BTREE,
                                 CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                 CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                 CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RE_MODEL
-- ----------------------------
INSERT INTO `ACT_RE_MODEL` VALUES ('9991ec96-dd21-11ed-9fda-e86a64b08c3b', 18, '请假流程', 'Leave_202304172112', '请假类', '2023-04-17 21:13:09.849', '2023-04-26 00:23:32.634', 1, '{\"description\":\"\"}', NULL, '5c0724f8-ddbe-11ed-89c6-e86a64b08c3b', NULL, '000000');

-- ----------------------------
-- Table structure for ACT_RE_PROCDEF
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_PROCDEF`;
CREATE TABLE `ACT_RE_PROCDEF`  (
                                   `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `REV_` int(0) NULL DEFAULT NULL,
                                   `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `VERSION_` int(0) NOT NULL,
                                   `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `DGRM_RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `HAS_START_FORM_KEY_` tinyint(0) NULL DEFAULT NULL,
                                   `HAS_GRAPHICAL_NOTATION_` tinyint(0) NULL DEFAULT NULL,
                                   `SUSPENSION_STATE_` int(0) NULL DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                   `ENGINE_VERSION_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `DERIVED_FROM_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `DERIVED_FROM_ROOT_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `DERIVED_VERSION_` int(0) NOT NULL DEFAULT 0,
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   UNIQUE INDEX `ACT_UNIQ_PROCDEF`(`KEY_`, `VERSION_`, `DERIVED_VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RE_PROCDEF
-- ----------------------------
INSERT INTO `ACT_RE_PROCDEF` VALUES ('Process_1681804034783:2:b34004ed-1578-11ee-9958-024202297294', 2, '请假类', '请假流程', 'Process_1681804034783', 2, 'b2efe91a-1578-11ee-9958-024202297294', '请假流程.bpmn', '请假流程.Process_1681804034783.png', NULL, 1, 1, 1, '000000', NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for ACT_RU_ACTINST
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_ACTINST`;
CREATE TABLE `ACT_RU_ACTINST`  (
                                   `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `REV_` int(0) NULL DEFAULT 1,
                                   `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `ACT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `ACT_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                   `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `END_TIME_` datetime(3) NULL DEFAULT NULL,
                                   `DURATION_` bigint(0) NULL DEFAULT NULL,
                                   `TRANSACTION_ORDER_` int(0) NULL DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   INDEX `ACT_IDX_RU_ACTI_START`(`START_TIME_`) USING BTREE,
                                   INDEX `ACT_IDX_RU_ACTI_END`(`END_TIME_`) USING BTREE,
                                   INDEX `ACT_IDX_RU_ACTI_PROC`(`PROC_INST_ID_`) USING BTREE,
                                   INDEX `ACT_IDX_RU_ACTI_PROC_ACT`(`PROC_INST_ID_`, `ACT_ID_`) USING BTREE,
                                   INDEX `ACT_IDX_RU_ACTI_EXEC`(`EXECUTION_ID_`) USING BTREE,
                                   INDEX `ACT_IDX_RU_ACTI_EXEC_ACT`(`EXECUTION_ID_`, `ACT_ID_`) USING BTREE,
                                   INDEX `ACT_IDX_RU_ACTI_TASK`(`TASK_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_ACTINST
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_DEADLETTER_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_DEADLETTER_JOB`;
CREATE TABLE `ACT_RU_DEADLETTER_JOB`  (
                                          `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                          `REV_` int(0) NULL DEFAULT NULL,
                                          `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                          `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
                                          `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                          `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                          `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                          PRIMARY KEY (`ID_`) USING BTREE,
                                          INDEX `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
                                          INDEX `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
                                          INDEX `ACT_IDX_DEADLETTER_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
                                          INDEX `ACT_IDX_DJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                          INDEX `ACT_IDX_DJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                          INDEX `ACT_IDX_DJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                          INDEX `ACT_FK_DEADLETTER_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
                                          INDEX `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
                                          INDEX `ACT_FK_DEADLETTER_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
                                          CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                          CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                          CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                          CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                          CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_DEADLETTER_JOB
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_ENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_ENTITYLINK`;
CREATE TABLE `ACT_RU_ENTITYLINK`  (
                                      `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                      `REV_` int(0) NULL DEFAULT NULL,
                                      `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
                                      `LINK_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `PARENT_ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `REF_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `REF_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `ROOT_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `ROOT_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `HIERARCHY_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      PRIMARY KEY (`ID_`) USING BTREE,
                                      INDEX `ACT_IDX_ENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
                                      INDEX `ACT_IDX_ENT_LNK_REF_SCOPE`(`REF_SCOPE_ID_`, `REF_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
                                      INDEX `ACT_IDX_ENT_LNK_ROOT_SCOPE`(`ROOT_SCOPE_ID_`, `ROOT_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
                                      INDEX `ACT_IDX_ENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_ENTITYLINK
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_EVENT_SUBSCR
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EVENT_SUBSCR`;
CREATE TABLE `ACT_RU_EVENT_SUBSCR`  (
                                        `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                        `REV_` int(0) NULL DEFAULT NULL,
                                        `EVENT_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                        `EVENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `ACTIVITY_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `CONFIGURATION_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                                        `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SUB_SCOPE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                                        `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        INDEX `ACT_IDX_EVENT_SUBSCR_CONFIG_`(`CONFIGURATION_`) USING BTREE,
                                        INDEX `ACT_IDX_EVENT_SUBSCR_SCOPEREF_`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        INDEX `ACT_FK_EVENT_EXEC`(`EXECUTION_ID_`) USING BTREE,
                                        CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_EVENT_SUBSCR
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_EXECUTION
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EXECUTION`;
CREATE TABLE `ACT_RU_EXECUTION`  (
                                     `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                     `REV_` int(0) NULL DEFAULT NULL,
                                     `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `PARENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `SUPER_EXEC_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `ROOT_PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `IS_ACTIVE_` tinyint(0) NULL DEFAULT NULL,
                                     `IS_CONCURRENT_` tinyint(0) NULL DEFAULT NULL,
                                     `IS_SCOPE_` tinyint(0) NULL DEFAULT NULL,
                                     `IS_EVENT_SCOPE_` tinyint(0) NULL DEFAULT NULL,
                                     `IS_MI_ROOT_` tinyint(0) NULL DEFAULT NULL,
                                     `SUSPENSION_STATE_` int(0) NULL DEFAULT NULL,
                                     `CACHED_ENT_STATE_` int(0) NULL DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                     `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `START_ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `START_TIME_` datetime(3) NULL DEFAULT NULL,
                                     `START_USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                                     `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `IS_COUNT_ENABLED_` tinyint(0) NULL DEFAULT NULL,
                                     `EVT_SUBSCR_COUNT_` int(0) NULL DEFAULT NULL,
                                     `TASK_COUNT_` int(0) NULL DEFAULT NULL,
                                     `JOB_COUNT_` int(0) NULL DEFAULT NULL,
                                     `TIMER_JOB_COUNT_` int(0) NULL DEFAULT NULL,
                                     `SUSP_JOB_COUNT_` int(0) NULL DEFAULT NULL,
                                     `DEADLETTER_JOB_COUNT_` int(0) NULL DEFAULT NULL,
                                     `EXTERNAL_WORKER_JOB_COUNT_` int(0) NULL DEFAULT NULL,
                                     `VAR_COUNT_` int(0) NULL DEFAULT NULL,
                                     `ID_LINK_COUNT_` int(0) NULL DEFAULT NULL,
                                     `CALLBACK_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     INDEX `ACT_IDX_EXEC_BUSKEY`(`BUSINESS_KEY_`) USING BTREE,
                                     INDEX `ACT_IDC_EXEC_ROOT`(`ROOT_PROC_INST_ID_`) USING BTREE,
                                     INDEX `ACT_IDX_EXEC_REF_ID_`(`REFERENCE_ID_`) USING BTREE,
                                     INDEX `ACT_FK_EXE_PROCINST`(`PROC_INST_ID_`) USING BTREE,
                                     INDEX `ACT_FK_EXE_PARENT`(`PARENT_ID_`) USING BTREE,
                                     INDEX `ACT_FK_EXE_SUPER`(`SUPER_EXEC_`) USING BTREE,
                                     INDEX `ACT_FK_EXE_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
                                     CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE RESTRICT,
                                     CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                     CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
                                     CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_EXECUTION
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_EXTERNAL_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_EXTERNAL_JOB`;
CREATE TABLE `ACT_RU_EXTERNAL_JOB`  (
                                        `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                        `REV_` int(0) NULL DEFAULT NULL,
                                        `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                        `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                        `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
                                        `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `RETRIES_` int(0) NULL DEFAULT NULL,
                                        `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                        `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        INDEX `ACT_IDX_EXTERNAL_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
                                        INDEX `ACT_IDX_EXTERNAL_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
                                        INDEX `ACT_IDX_EXTERNAL_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
                                        INDEX `ACT_IDX_EJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        INDEX `ACT_IDX_EJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        INDEX `ACT_IDX_EJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        CONSTRAINT `ACT_FK_EXTERNAL_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                        CONSTRAINT `ACT_FK_EXTERNAL_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_EXTERNAL_JOB
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_HISTORY_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_HISTORY_JOB`;
CREATE TABLE `ACT_RU_HISTORY_JOB`  (
                                       `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                       `REV_` int(0) NULL DEFAULT NULL,
                                       `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                       `RETRIES_` int(0) NULL DEFAULT NULL,
                                       `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                       `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                       `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                       `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                       `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                       `ADV_HANDLER_CFG_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                       `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                       PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_HISTORY_JOB
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_IDENTITYLINK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_IDENTITYLINK`;
CREATE TABLE `ACT_RU_IDENTITYLINK`  (
                                        `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                        `REV_` int(0) NULL DEFAULT NULL,
                                        `GROUP_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        INDEX `ACT_IDX_IDENT_LNK_USER`(`USER_ID_`) USING BTREE,
                                        INDEX `ACT_IDX_IDENT_LNK_GROUP`(`GROUP_ID_`) USING BTREE,
                                        INDEX `ACT_IDX_IDENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        INDEX `ACT_IDX_IDENT_LNK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        INDEX `ACT_IDX_IDENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                        INDEX `ACT_IDX_ATHRZ_PROCEDEF`(`PROC_DEF_ID_`) USING BTREE,
                                        INDEX `ACT_FK_TSKASS_TASK`(`TASK_ID_`) USING BTREE,
                                        INDEX `ACT_FK_IDL_PROCINST`(`PROC_INST_ID_`) USING BTREE,
                                        CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                        CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                        CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `ACT_RU_TASK` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_IDENTITYLINK
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_JOB`;
CREATE TABLE `ACT_RU_JOB`  (
                               `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                               `REV_` int(0) NULL DEFAULT NULL,
                               `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                               `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
                               `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `RETRIES_` int(0) NULL DEFAULT NULL,
                               `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                               `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                               `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                               PRIMARY KEY (`ID_`) USING BTREE,
                               INDEX `ACT_IDX_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
                               INDEX `ACT_IDX_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
                               INDEX `ACT_IDX_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
                               INDEX `ACT_IDX_JOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                               INDEX `ACT_IDX_JOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                               INDEX `ACT_IDX_JOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
                               INDEX `ACT_FK_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
                               INDEX `ACT_FK_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
                               INDEX `ACT_FK_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
                               CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                               CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                               CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                               CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                               CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_JOB
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_SUSPENDED_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_SUSPENDED_JOB`;
CREATE TABLE `ACT_RU_SUSPENDED_JOB`  (
                                         `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                         `REV_` int(0) NULL DEFAULT NULL,
                                         `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                         `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
                                         `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `RETRIES_` int(0) NULL DEFAULT NULL,
                                         `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                         `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                         `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                         PRIMARY KEY (`ID_`) USING BTREE,
                                         INDEX `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
                                         INDEX `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
                                         INDEX `ACT_IDX_SUSPENDED_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
                                         INDEX `ACT_IDX_SJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                         INDEX `ACT_IDX_SJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                         INDEX `ACT_IDX_SJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                         INDEX `ACT_FK_SUSPENDED_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
                                         INDEX `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
                                         INDEX `ACT_FK_SUSPENDED_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
                                         CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                         CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                         CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                         CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                         CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_SUSPENDED_JOB
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_TASK
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_TASK`;
CREATE TABLE `ACT_RU_TASK`  (
                                `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                `REV_` int(0) NULL DEFAULT NULL,
                                `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `TASK_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `DELEGATION_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `PRIORITY_` int(0) NULL DEFAULT NULL,
                                `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `DUE_DATE_` datetime(3) NULL DEFAULT NULL,
                                `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `SUSPENSION_STATE_` int(0) NULL DEFAULT NULL,
                                `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                `FORM_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                `CLAIM_TIME_` datetime(3) NULL DEFAULT NULL,
                                `IS_COUNT_ENABLED_` tinyint(0) NULL DEFAULT NULL,
                                `VAR_COUNT_` int(0) NULL DEFAULT NULL,
                                `ID_LINK_COUNT_` int(0) NULL DEFAULT NULL,
                                `SUB_TASK_COUNT_` int(0) NULL DEFAULT NULL,
                                PRIMARY KEY (`ID_`) USING BTREE,
                                INDEX `ACT_IDX_TASK_CREATE`(`CREATE_TIME_`) USING BTREE,
                                INDEX `ACT_IDX_TASK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                INDEX `ACT_IDX_TASK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                INDEX `ACT_IDX_TASK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                INDEX `ACT_FK_TASK_EXE`(`EXECUTION_ID_`) USING BTREE,
                                INDEX `ACT_FK_TASK_PROCINST`(`PROC_INST_ID_`) USING BTREE,
                                INDEX `ACT_FK_TASK_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
                                CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_TASK
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_TIMER_JOB
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_TIMER_JOB`;
CREATE TABLE `ACT_RU_TIMER_JOB`  (
                                     `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                     `REV_` int(0) NULL DEFAULT NULL,
                                     `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                     `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                     `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
                                     `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `RETRIES_` int(0) NULL DEFAULT NULL,
                                     `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                     `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                     `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     INDEX `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
                                     INDEX `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
                                     INDEX `ACT_IDX_TIMER_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
                                     INDEX `ACT_IDX_TIMER_JOB_DUEDATE`(`DUEDATE_`) USING BTREE,
                                     INDEX `ACT_IDX_TJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                     INDEX `ACT_IDX_TJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                     INDEX `ACT_IDX_TJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                     INDEX `ACT_FK_TIMER_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
                                     INDEX `ACT_FK_TIMER_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
                                     INDEX `ACT_FK_TIMER_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
                                     CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                     CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                     CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                     CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                     CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_TIMER_JOB
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_VARIABLE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_VARIABLE`;
CREATE TABLE `ACT_RU_VARIABLE`  (
                                    `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `REV_` int(0) NULL DEFAULT NULL,
                                    `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                    `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `DOUBLE_` double NULL DEFAULT NULL,
                                    `LONG_` bigint(0) NULL DEFAULT NULL,
                                    `TEXT_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    `TEXT2_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    INDEX `ACT_IDX_RU_VAR_SCOPE_ID_TYPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                    INDEX `ACT_IDX_RU_VAR_SUB_ID_TYPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
                                    INDEX `ACT_FK_VAR_BYTEARRAY`(`BYTEARRAY_ID_`) USING BTREE,
                                    INDEX `ACT_IDX_VARIABLE_TASK_ID`(`TASK_ID_`) USING BTREE,
                                    INDEX `ACT_FK_VAR_EXE`(`EXECUTION_ID_`) USING BTREE,
                                    INDEX `ACT_FK_VAR_PROCINST`(`PROC_INST_ID_`) USING BTREE,
                                    CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                    CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                    CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_VARIABLE
-- ----------------------------

-- ----------------------------
-- Table structure for FLW_CHANNEL_DEFINITION
-- ----------------------------
DROP TABLE IF EXISTS `FLW_CHANNEL_DEFINITION`;
CREATE TABLE `FLW_CHANNEL_DEFINITION`  (
                                           `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                           `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `VERSION_` int(0) NULL DEFAULT NULL,
                                           `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
                                           `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `DESCRIPTION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           `IMPLEMENTATION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                           PRIMARY KEY (`ID_`) USING BTREE,
                                           UNIQUE INDEX `ACT_IDX_CHANNEL_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FLW_CHANNEL_DEFINITION
-- ----------------------------

-- ----------------------------
-- Table structure for FLW_EVENT_DEFINITION
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EVENT_DEFINITION`;
CREATE TABLE `FLW_EVENT_DEFINITION`  (
                                         `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `VERSION_` int(0) NULL DEFAULT NULL,
                                         `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `DESCRIPTION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         PRIMARY KEY (`ID_`) USING BTREE,
                                         UNIQUE INDEX `ACT_IDX_EVENT_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FLW_EVENT_DEFINITION
-- ----------------------------

-- ----------------------------
-- Table structure for FLW_EVENT_DEPLOYMENT
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EVENT_DEPLOYMENT`;
CREATE TABLE `FLW_EVENT_DEPLOYMENT`  (
                                         `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                         PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FLW_EVENT_DEPLOYMENT
-- ----------------------------

-- ----------------------------
-- Table structure for FLW_EVENT_RESOURCE
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EVENT_RESOURCE`;
CREATE TABLE `FLW_EVENT_RESOURCE`  (
                                       `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       `RESOURCE_BYTES_` longblob NULL,
                                       PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FLW_EVENT_RESOURCE
-- ----------------------------

-- ----------------------------
-- Table structure for FLW_EV_DATABASECHANGELOG
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EV_DATABASECHANGELOG`;
CREATE TABLE `FLW_EV_DATABASECHANGELOG`  (
                                             `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `DATEEXECUTED` datetime(0) NOT NULL,
                                             `ORDEREXECUTED` int(0) NOT NULL,
                                             `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                             `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FLW_EV_DATABASECHANGELOG
-- ----------------------------
INSERT INTO `FLW_EV_DATABASECHANGELOG` VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-17 17:33:54', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.9.1', NULL, NULL, '9045630171');
INSERT INTO `FLW_EV_DATABASECHANGELOG` VALUES ('2', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-17 17:33:55', 2, 'EXECUTED', '8:0ea825feb8e470558f0b5754352b9cda', 'addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '9045630171');
INSERT INTO `FLW_EV_DATABASECHANGELOG` VALUES ('3', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-17 17:33:56', 3, 'EXECUTED', '8:3c2bb293350b5cbe6504331980c9dcee', 'customChange', '', NULL, '4.9.1', NULL, NULL, '9045630171');

-- ----------------------------
-- Table structure for FLW_EV_DATABASECHANGELOGLOCK
-- ----------------------------
DROP TABLE IF EXISTS `FLW_EV_DATABASECHANGELOGLOCK`;
CREATE TABLE `FLW_EV_DATABASECHANGELOGLOCK`  (
                                                 `ID` int(0) NOT NULL,
                                                 `LOCKED` bit(1) NOT NULL,
                                                 `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
                                                 `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                                 PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FLW_EV_DATABASECHANGELOGLOCK
-- ----------------------------
INSERT INTO `FLW_EV_DATABASECHANGELOGLOCK` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for FLW_RU_BATCH
-- ----------------------------
DROP TABLE IF EXISTS `FLW_RU_BATCH`;
CREATE TABLE `FLW_RU_BATCH`  (
                                 `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                 `REV_` int(0) NULL DEFAULT NULL,
                                 `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                 `SEARCH_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `SEARCH_KEY2_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `CREATE_TIME_` datetime(3) NOT NULL,
                                 `COMPLETE_TIME_` datetime(3) NULL DEFAULT NULL,
                                 `STATUS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `BATCH_DOC_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                 `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                 PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FLW_RU_BATCH
-- ----------------------------

-- ----------------------------
-- Table structure for FLW_RU_BATCH_PART
-- ----------------------------
DROP TABLE IF EXISTS `FLW_RU_BATCH_PART`;
CREATE TABLE `FLW_RU_BATCH_PART`  (
                                      `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                      `REV_` int(0) NULL DEFAULT NULL,
                                      `BATCH_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
                                      `SCOPE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SUB_SCOPE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SCOPE_TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SEARCH_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `SEARCH_KEY2_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `CREATE_TIME_` datetime(3) NOT NULL,
                                      `COMPLETE_TIME_` datetime(3) NULL DEFAULT NULL,
                                      `STATUS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `RESULT_DOC_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
                                      PRIMARY KEY (`ID_`) USING BTREE,
                                      INDEX `FLW_IDX_BATCH_PART`(`BATCH_ID_`) USING BTREE,
                                      CONSTRAINT `FLW_FK_BATCH_PART_PARENT` FOREIGN KEY (`BATCH_ID_`) REFERENCES `FLW_RU_BATCH` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FLW_RU_BATCH_PART
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_copy
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_copy`;
CREATE TABLE `act_hi_copy`  (
                                `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                `create_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发起人',
                                `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
                                `tenant_id` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户',
                                `process_definition_id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '流程定义主键',
                                `process_definition_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程定义名称',
                                `process_instance_id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '流程实例主键',
                                `copy_user` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抄送人',
                                PRIMARY KEY (`id`) USING BTREE,
                                INDEX `fk_def_id`(`process_definition_id`) USING BTREE,
                                INDEX `fk_ins_id`(`process_instance_id`) USING BTREE,
                                CONSTRAINT `fk_def_id` FOREIGN KEY (`process_definition_id`) REFERENCES `ACT_RE_PROCDEF` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
                                CONSTRAINT `fk_ins_id` FOREIGN KEY (`process_instance_id`) REFERENCES `ACT_HI_PROCINST` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_copy
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_category
-- ----------------------------
DROP TABLE IF EXISTS `act_re_category`;
CREATE TABLE `act_re_category`  (
                                    `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                    `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                                    `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
                                    `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                                    `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                                    `code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类编码',
                                    `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
                                    `tenant_id` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户',
                                    `deleted` tinyint(0) UNSIGNED NULL DEFAULT 0 COMMENT '是否删除（0:=未删除，NULL:=已删除）',
                                    `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `uk_code`(`code`, `tenant_id`, `deleted`) USING BTREE COMMENT '编码唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_re_category
-- ----------------------------
INSERT INTO `act_re_category` VALUES (3, '2023-04-17 21:00:55', NULL, 'admin', NULL, 'Leave', '请假类', '000000', 0, NULL);

-- ----------------------------
-- Table structure for act_re_form
-- ----------------------------
DROP TABLE IF EXISTS `act_re_form`;
CREATE TABLE `act_re_form`  (
                                `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                `create_time` datetime(0) NOT NULL COMMENT '创建时间',
                                `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
                                `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                                `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                                `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表单名称',
                                `tenant_id` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户',
                                `is_built_in` tinyint(0) UNSIGNED NULL DEFAULT NULL COMMENT '是否内置',
                                `component_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径（如果为内置表单，则需要填写组件路径）',
                                `deleted` tinyint(0) UNSIGNED NULL DEFAULT 0 COMMENT '是否删除（0:=未删除，NULL:=已删除）',
                                `remark` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_re_form
-- ----------------------------
INSERT INTO `act_re_form` VALUES (1, '2023-04-03 16:59:43', '2023-06-30 07:39:29', 'admin', 'admin', '请假流程发起人表单', '000000', 1, 'Leave', 0, '');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
                             `create_time` datetime(0) NOT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
                             `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                             `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                             `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
                             `tenant_id` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户',
                             `sort` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '排序',
                             `parent_id` bigint(0) UNSIGNED NULL DEFAULT 0 COMMENT '父节点(根节点为 0)',
                             `deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除（0:=未删除, 1:=已删除）',
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE INDEX `uk_dept_name`(`name`, `parent_id`, `deleted`) USING BTREE COMMENT '部门名称唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, '2022-08-16 14:27:55', NULL, 'admin', NULL, '资讯部', '000000', 1, 0, 0);
INSERT INTO `sys_dept` VALUES (2, '2022-09-04 11:39:56', NULL, 'admin', NULL, '硬件组', '000000', 2, 1, 0);
INSERT INTO `sys_dept` VALUES (3, '2022-09-04 11:40:41', NULL, 'admin', NULL, '软件组', '000000', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (4, '2022-12-01 16:08:12', NULL, 'admin', NULL, '人力资源部', '000000', 2, 0, 0);
INSERT INTO `sys_dept` VALUES (5, '2022-12-01 16:17:37', '2022-12-01 16:19:28', 'admin', 'admin', '公共事业部', '000000', 3, 0, 0);
INSERT INTO `sys_dept` VALUES (6, '2022-12-01 16:17:51', NULL, 'admin', NULL, '企宣部', '000000', 1, 5, 0);
INSERT INTO `sys_dept` VALUES (7, '2022-12-01 16:18:16', NULL, 'admin', NULL, '市场部', '000000', 2, 5, 0);
INSERT INTO `sys_dept` VALUES (50, '2023-06-06 17:23:34', NULL, 'admin', NULL, '北京阿里巴巴信息技术有限公司', '059218', 1, 0, 0);

-- ----------------------------
-- Table structure for sys_enterprise
-- ----------------------------
DROP TABLE IF EXISTS `sys_enterprise`;
CREATE TABLE `sys_enterprise`  (
                                   `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                                   `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
                                   `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                                   `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                                   `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '企业名称',
                                   `name_en` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '英文名称',
                                   `short_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简称',
                                   `usci` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
                                   `registered_currency` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注册币种',
                                   `registered_capital` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注册资本',
                                   `legal_person` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '法人',
                                   `establishing_time` datetime(0) NULL DEFAULT NULL COMMENT '成立时间',
                                   `business_nature` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业性质',
                                   `industry_involved` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属行业',
                                   `registered_address` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注册地址',
                                   `business_scope` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经营范围',
                                   `staff_number` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '员工数',
                                   `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
                                   `deleted` tinyint(0) UNSIGNED NULL DEFAULT 0 COMMENT '是否删除（0:=未删除;null:=已删除）',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE INDEX `uk_name`(`name`, `deleted`) USING BTREE COMMENT '企业名称唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 782 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_enterprise
-- ----------------------------
INSERT INTO `sys_enterprise` VALUES (1, '2023-05-31 17:39:51', '2023-05-31 18:02:24', NULL, 'admin', 'xxx有限公司', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, 0);
INSERT INTO `sys_enterprise` VALUES (2, '2023-06-06 17:22:39', NULL, 'admin', NULL, '北京阿里巴巴信息技术有限公司', 'Beijing Alibaba Information and Technology Co.,Ltd.', NULL, '911101057001486120', '人民币', '56000万人民币', '马云', '2019-07-18 00:00:00', '有限责任公司(外商投资企业与内资合资)', '软件和信息技术服务业', '北京市朝阳区西大望路甲12号(国家广告产业园区)B座6层', '技术开发、技术转让、技术咨询、技术服务；计算机技术培训。（企业依法自主选择经营项目，开展经营活动；依法须经批准的项目，经相关部门批准后依批准的内容开展经营活动；不得从事本市产业政策禁止和限制类项目的经营活动。）', NULL, '注销', 0);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
                            `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                            `create_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                            `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
                            `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                            `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                            `type` tinyint(0) NULL DEFAULT 1 COMMENT '类型(0:=异常;1:=正常)',
                            `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
                            `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
                            `tenant_id` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户',
                            `exception_desc` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '异常描述',
                            `request_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求 URL',
                            `request_method` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方式',
                            `request_param` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
                            `request_time` bigint(0) NULL DEFAULT NULL COMMENT '请求耗时',
                            `method_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名称',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 331 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `create_time` datetime(0) NOT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
                             `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                             `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                             `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
                             `path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由路径（浏览器地址栏路径）',
                             `component_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件名称',
                             `component` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径（vue页面完整路径，省略.vue后缀）',
                             `permission` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单权限标识',
                             `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
                             `sort` smallint(0) UNSIGNED NOT NULL COMMENT '排序',
                             `keep_alive` tinyint(1) NULL DEFAULT NULL COMMENT '是否缓存（0:=关闭, 1:=开启）',
                             `type` tinyint(1) NULL DEFAULT NULL COMMENT '菜单类型（1:=目录, 2:=菜单，3:=按钮）',
                             `external_links` tinyint(0) NULL DEFAULT 0 COMMENT '是否外链（0:=否, 1:=是）',
                             `visible` tinyint(1) NULL DEFAULT NULL COMMENT '是否可见（0:=不可见，1：可见）',
                             `redirect` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '重定向路径',
                             `parent_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '父菜单 ID（0表示跟菜单）',
                             `has_children` tinyint(0) NULL DEFAULT 0 COMMENT '是否拥有子节点（0：否；1：是）',
                             `deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除(0:=未删除; null:=已删除)',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 144 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '2022-08-18 08:40:23', '2023-05-13 15:42:35', 'admin', 'admin', '系统', '/system', NULL, 'Navigation', NULL, 'system', 1, 1, 1, 0, 1, '/system/user', 0, 1, 0);
INSERT INTO `sys_menu` VALUES (2, '2022-08-18 08:42:45', '2022-12-06 16:36:34', 'admin', 'admin', '用户管理', 'user', 'SystemUser', 'system/user/Index', NULL, 'user', 1, 1, 2, 0, 1, NULL, 1, 1, 0);
INSERT INTO `sys_menu` VALUES (3, '2022-08-18 08:45:24', '2022-09-26 20:28:58', 'admin', 'admin', '用户新增', '', NULL, '', 'sys_user_add', NULL, 2, 1, 3, 0, 1, NULL, 2, 0, 0);
INSERT INTO `sys_menu` VALUES (4, '2022-08-28 17:48:21', '2022-09-27 07:48:38', 'admin', 'admin', '角色管理', 'role', 'SystemRole', 'system/role/Index', NULL, 'role', 3, 1, 2, 0, 1, NULL, 1, 1, 0);
INSERT INTO `sys_menu` VALUES (5, '2022-09-19 14:17:23', '2022-09-27 07:48:44', 'admin', 'admin', '菜单管理', 'menu', 'SystemMenu', 'system/menu/Index', NULL, 'menu', 2, 1, 2, 0, 1, NULL, 1, 1, 0);
INSERT INTO `sys_menu` VALUES (14, '2022-09-26 20:21:08', '2022-12-06 16:37:02', 'admin', 'admin', '用户查询', NULL, NULL, NULL, 'sys_user_query', NULL, 1, 1, 3, 0, 1, NULL, 2, 0, 0);
INSERT INTO `sys_menu` VALUES (15, '2022-09-26 20:29:37', NULL, 'admin', NULL, '用户删除', NULL, NULL, NULL, 'sys_user_delete', NULL, 3, 1, 3, 0, 1, NULL, 2, 0, 0);
INSERT INTO `sys_menu` VALUES (16, '2022-09-26 20:30:06', '2022-09-26 20:30:14', 'admin', 'admin', '用户修改', NULL, NULL, NULL, 'sys_user_edit', NULL, 4, 1, 3, 0, 1, NULL, 2, 0, 0);
INSERT INTO `sys_menu` VALUES (21, '2022-11-20 16:46:46', '2023-04-28 15:22:17', 'admin', 'admin', '操作日志', 'log', 'Log', 'system/log/Index', NULL, 'log', 6, 1, 2, 0, 1, NULL, 1, 1, 0);
INSERT INTO `sys_menu` VALUES (24, '2022-11-30 21:07:48', '2022-11-30 21:09:44', 'admin', 'admin', '部门管理', 'dept', 'SystemDept', 'system/dept/Index', NULL, 'dept', 5, 1, 2, 0, 1, NULL, 1, 1, 0);
INSERT INTO `sys_menu` VALUES (29, '2022-12-02 14:07:50', '2022-12-06 16:37:35', 'admin', 'admin', '部门查询', NULL, NULL, NULL, 'sys_dept_query', NULL, 1, 1, 3, 0, 1, NULL, 24, 0, 0);
INSERT INTO `sys_menu` VALUES (30, '2022-12-02 14:08:41', '2022-12-06 22:49:33', 'admin', 'admin', '部门新增', NULL, NULL, NULL, 'sys_dept_add', NULL, 2, 1, 3, 0, 1, NULL, 24, 0, 0);
INSERT INTO `sys_menu` VALUES (31, '2022-12-02 14:11:13', NULL, 'admin', NULL, '部门删除', NULL, NULL, NULL, 'sys_dept_delete', NULL, 3, 1, 3, 0, 1, NULL, 24, 0, 0);
INSERT INTO `sys_menu` VALUES (32, '2022-12-02 14:11:34', '2022-12-06 22:49:24', 'admin', 'admin', '部门编辑', NULL, NULL, NULL, 'sys_dept_edit', NULL, 4, 1, 3, 0, 1, NULL, 24, 0, 0);
INSERT INTO `sys_menu` VALUES (33, '2022-12-06 10:54:04', NULL, 'admin', NULL, '用户导出', NULL, NULL, NULL, 'sys_user_export', NULL, 5, 1, 3, 0, 1, NULL, 2, 0, 0);
INSERT INTO `sys_menu` VALUES (34, '2022-12-06 10:54:24', NULL, 'admin', NULL, '用户导入', NULL, NULL, NULL, 'sys_user_import', NULL, 6, 1, 3, 0, 1, NULL, 2, 0, 0);
INSERT INTO `sys_menu` VALUES (35, '2022-12-06 13:39:30', NULL, 'admin', NULL, '密码重置', NULL, NULL, NULL, 'sys_user_pass_reset', NULL, 6, 1, 3, 0, 1, NULL, 2, 0, 0);
INSERT INTO `sys_menu` VALUES (36, '2022-12-06 14:54:51', '2022-12-06 16:37:22', 'admin', 'admin', '菜单查看', NULL, NULL, NULL, 'sys_menu_query', NULL, 1, 1, 3, 0, 1, NULL, 5, 0, 0);
INSERT INTO `sys_menu` VALUES (40, '2022-12-06 16:42:18', NULL, 'admin', NULL, '角色查询', NULL, NULL, NULL, 'sys_role_query', NULL, 1, 1, 3, 0, 1, NULL, 4, 0, 0);
INSERT INTO `sys_menu` VALUES (41, '2022-12-06 16:42:37', NULL, 'admin', NULL, '角色新增', NULL, NULL, NULL, 'sys_role_add', NULL, 2, 1, 3, 0, 1, NULL, 4, 0, 0);
INSERT INTO `sys_menu` VALUES (52, '2022-12-06 20:30:07', NULL, 'admin', NULL, '角色修改', NULL, NULL, NULL, 'sys_role_edit', NULL, 3, 1, 3, 0, 1, NULL, 4, 0, 0);
INSERT INTO `sys_menu` VALUES (53, '2022-12-06 20:30:36', NULL, 'admin', NULL, '角色删除', NULL, NULL, NULL, 'sys_role_delete', NULL, 4, 1, 3, 0, 1, NULL, 4, 0, 0);
INSERT INTO `sys_menu` VALUES (54, '2022-12-06 20:31:18', '2022-12-06 20:31:25', 'admin', 'admin', '角色用户分配', NULL, NULL, NULL, 'sys_role_user_allocation', NULL, 5, 1, 3, 0, 1, NULL, 4, 0, 0);
INSERT INTO `sys_menu` VALUES (55, '2022-12-06 20:31:53', NULL, 'admin', NULL, '角色菜单分配', NULL, NULL, NULL, 'sys_role_menu_allocation', NULL, 999, 1, 3, 0, 1, NULL, 4, 0, 0);
INSERT INTO `sys_menu` VALUES (62, '2022-12-07 14:10:00', '2022-12-07 14:10:29', 'admin', 'admin', '日志查询', NULL, NULL, NULL, 'sys_log_query', NULL, 1, 1, 3, 0, 1, NULL, 21, 0, 0);
INSERT INTO `sys_menu` VALUES (63, '2022-12-07 14:10:21', NULL, 'admin', NULL, '日志删除', NULL, NULL, NULL, 'sys_log_delete', NULL, 2, 1, 3, 0, 1, NULL, 21, 0, 0);
INSERT INTO `sys_menu` VALUES (66, '2023-03-26 16:17:06', '2023-04-28 15:22:24', 'admin', 'admin', '接口文档', 'http://10.30.1.30:9317/swagger-ui/index.html', NULL, NULL, NULL, 'swagger', 7, 1, 2, 1, 1, NULL, 1, 0, 0);
INSERT INTO `sys_menu` VALUES (67, '2023-03-28 14:03:30', '2023-05-15 14:32:13', 'admin', 'admin', '流程管理', 'process-management', NULL, 'ParentView', NULL, 'process', 1, 1, 1, 0, 1, NULL, 80, 1, 0);
INSERT INTO `sys_menu` VALUES (68, '2023-03-28 14:06:53', '2023-05-29 14:22:07', 'admin', 'admin', '流程中心', 'process-center', NULL, 'ParentView', NULL, 'process-center', 2, 1, 1, 0, 1, NULL, 80, 1, 0);
INSERT INTO `sys_menu` VALUES (69, '2023-03-28 14:11:07', '2023-05-14 19:15:48', 'admin', 'admin', '新建流程', 'process-create', 'ProcessCenterProcessCreate', 'process/process-center/process-create/Index', NULL, 'new', 1, 1, 2, 0, 1, NULL, 68, 0, 0);
INSERT INTO `sys_menu` VALUES (70, '2023-03-28 14:13:27', '2023-05-14 19:16:05', 'admin', 'admin', '待办任务', 'task-backlog', 'TaskBackLog', 'process/process-center/task-backlog/Index', NULL, 'backlog', 3, 1, 2, 0, 1, NULL, 68, 0, 0);
INSERT INTO `sys_menu` VALUES (71, '2023-03-28 14:14:59', '2023-05-15 14:32:28', 'admin', 'admin', '已办任务', 'task-done', 'TaskDone', 'process/process-center/task-done/Index', NULL, 'task-done', 5, 1, 2, 0, 1, NULL, 68, 0, 0);
INSERT INTO `sys_menu` VALUES (72, '2023-03-28 14:20:41', '2023-05-14 11:17:12', 'admin', 'admin', '流程部署', 'process-deployment', 'ProcessManagementProcessDeployment', 'process/process-management/process-deployment/Index', NULL, 'deployment', 4, 1, 2, 0, 1, NULL, 67, 1, 0);
INSERT INTO `sys_menu` VALUES (73, '2023-03-29 19:07:31', NULL, 'admin', NULL, '日志导出', NULL, NULL, NULL, 'sys_log_export', NULL, 3, 1, 3, 0, 1, NULL, 21, 0, 0);
INSERT INTO `sys_menu` VALUES (74, '2023-04-03 11:25:08', '2023-05-14 11:16:53', 'admin', 'admin', '表单配置', 'form', 'ProcessManagementForm', 'process/process-management/process-form/Index', NULL, 'form', 2, 1, 2, 0, 1, NULL, 67, 1, 0);
INSERT INTO `sys_menu` VALUES (75, '2023-04-03 17:52:21', '2023-05-14 18:56:52', 'admin', 'admin', '流程建模', 'process-modler', 'ProcessManagementProcessModler', 'process/process-management/process-modler/Index', NULL, 'new', 3, 1, 2, 0, 1, NULL, 67, 1, 0);
INSERT INTO `sys_menu` VALUES (76, '2023-04-06 13:52:29', '2023-05-14 19:15:58', 'admin', 'admin', '我的流程', 'my-process', 'ProcessCenterMyProcess', 'process/process-center/my-process/Index', NULL, 'process', 2, 0, 2, 0, 1, NULL, 68, 0, 0);
INSERT INTO `sys_menu` VALUES (77, '2023-04-17 16:15:24', '2023-05-14 11:16:44', 'admin', 'admin', '流程分类', 'category', 'ProcessCategory', 'process/process-management/process-category/Index', NULL, 'classify', 1, 1, 2, 0, 1, NULL, 67, 1, 0);
INSERT INTO `sys_menu` VALUES (78, '2023-04-23 11:18:57', '2023-05-14 19:16:11', 'admin', 'admin', '抄送我的', 'my-copy', 'MyCopy', 'process/process-center/my-copy/Index', NULL, 'chaosong', 4, 1, 2, 0, 1, NULL, 68, 0, 0);
INSERT INTO `sys_menu` VALUES (80, '2023-05-13 15:43:08', '2023-05-15 14:32:07', 'admin', 'admin', '流程', '/process', NULL, 'Navigation', NULL, 'process-center', 2, 1, 1, 0, 1, NULL, 0, 1, 0);
INSERT INTO `sys_menu` VALUES (86, '2023-05-16 16:33:15', NULL, 'admin', NULL, '租户', '/tenant', NULL, 'Navigation', NULL, 'tenant', 3, 1, 1, 0, 1, NULL, 0, 1, 0);
INSERT INTO `sys_menu` VALUES (87, '2023-05-16 16:33:56', '2023-05-22 17:24:55', 'admin', 'admin', '租户管理', 'tenant', 'Tenant', 'system/tenant/Index', NULL, 'tenant', 3, 1, 2, 0, 1, NULL, 86, 1, 0);
INSERT INTO `sys_menu` VALUES (88, '2023-05-16 16:38:04', '2023-05-22 14:23:57', 'admin', 'admin', '套餐管理', 'system/tenant/package', 'TenantPackage', 'system/tenant/package/Index', NULL, 'package', 2, 1, 2, 0, 1, NULL, 86, 1, 0);
INSERT INTO `sys_menu` VALUES (89, '2023-05-17 21:33:20', '2023-05-19 15:31:00', 'admin', 'admin', '企业管理', 'enterprise', 'TenantEnterprise', 'system/tenant/enterprise/Index', NULL, 'enterprise', 1, 1, 2, 0, 1, NULL, 86, 1, 0);
INSERT INTO `sys_menu` VALUES (90, '2023-05-20 16:45:05', NULL, 'admin', NULL, '企业查询', NULL, NULL, NULL, 'sys_enterprise_query', NULL, 1, 1, 3, 0, 1, NULL, 89, 0, 0);
INSERT INTO `sys_menu` VALUES (91, '2023-05-20 16:45:34', NULL, 'admin', NULL, '企业新增', NULL, NULL, NULL, 'sys_enterprise_add', NULL, 2, 1, 3, 0, 1, NULL, 89, 0, 0);
INSERT INTO `sys_menu` VALUES (92, '2023-05-20 17:30:15', NULL, 'admin', NULL, '企业编辑', NULL, NULL, NULL, 'sys_enterprise_update', NULL, 3, 1, 3, 0, 1, NULL, 89, 0, 0);
INSERT INTO `sys_menu` VALUES (93, '2023-05-22 13:48:16', NULL, 'admin', NULL, '企业删除', NULL, NULL, NULL, 'sys_enterprise_delete', NULL, 3, 1, 3, 0, 1, NULL, 89, 0, 0);
INSERT INTO `sys_menu` VALUES (94, '2023-05-22 16:02:51', NULL, 'admin', NULL, '新增套餐', NULL, NULL, NULL, 'sys_package_query', NULL, 1, 1, 3, 0, 1, NULL, 88, 0, 0);
INSERT INTO `sys_menu` VALUES (95, '2023-05-22 16:15:47', NULL, 'admin', NULL, '新增套餐', NULL, NULL, NULL, 'sys_package_add', NULL, 2, 1, 3, 0, 1, NULL, 88, 0, 0);
INSERT INTO `sys_menu` VALUES (96, '2023-05-22 16:16:08', NULL, 'admin', NULL, '编辑套餐', NULL, NULL, NULL, 'sys_package_update', NULL, 3, 1, 3, 0, 1, NULL, 88, 0, 0);
INSERT INTO `sys_menu` VALUES (97, '2023-05-22 17:22:14', NULL, 'admin', NULL, '删除套餐', NULL, NULL, NULL, 'sys_package_delete', NULL, 4, 1, 3, 0, 1, NULL, 88, 0, 0);
INSERT INTO `sys_menu` VALUES (98, '2023-05-22 20:55:18', NULL, 'admin', NULL, '租户查询', NULL, NULL, NULL, 'sys_tenant_query', NULL, 1, 1, 3, 0, 1, NULL, 87, 0, 0);
INSERT INTO `sys_menu` VALUES (99, '2023-05-23 21:03:53', NULL, 'admin', NULL, '租户新增', NULL, NULL, NULL, 'sys_tenant_add', NULL, 2, 1, 3, 0, 1, NULL, 87, 0, 0);
INSERT INTO `sys_menu` VALUES (102, '2023-05-27 16:23:30', '2023-05-27 16:24:06', 'admin', 'admin', '套餐菜单分配', NULL, NULL, NULL, 'sys_package_menus_allocate', NULL, 5, 1, 3, 0, 1, NULL, 88, 0, 0);
INSERT INTO `sys_menu` VALUES (109, '2023-05-30 11:16:08', NULL, 'admin', NULL, '更新租户', NULL, NULL, NULL, 'sys_tenant_update', NULL, 3, 1, 3, 0, 1, NULL, 87, 0, 0);
INSERT INTO `sys_menu` VALUES (121, '2023-06-03 21:02:38', NULL, 'admin', NULL, '菜单新增', NULL, NULL, NULL, 'sys_menu_add', NULL, 2, 1, 3, 0, 1, NULL, 5, 0, 0);
INSERT INTO `sys_menu` VALUES (122, '2023-06-03 21:06:09', NULL, 'admin', NULL, '菜单编辑', NULL, NULL, NULL, 'sys_menu_update', NULL, 3, 1, 3, 0, 1, NULL, 5, 0, 0);
INSERT INTO `sys_menu` VALUES (123, '2023-06-03 21:06:32', NULL, 'admin', NULL, '菜单删除', NULL, NULL, NULL, 'sys_menu_delete', NULL, 4, 1, 3, 0, 1, NULL, 5, 0, 0);
INSERT INTO `sys_menu` VALUES (124, '2023-06-03 23:10:25', '2023-06-07 10:45:11', 'admin', 'admin', '租户删除', NULL, NULL, NULL, 'sys_tenant_delete', NULL, 4, 1, 3, 0, 1, NULL, 87, 0, 0);
INSERT INTO `sys_menu` VALUES (125, '2023-06-05 16:00:54', NULL, 'admin', NULL, '查询流程分类', NULL, NULL, NULL, 'workflow_category_query', NULL, 1, 1, 3, 0, 1, NULL, 77, 0, 0);
INSERT INTO `sys_menu` VALUES (126, '2023-06-05 16:01:37', NULL, 'admin', NULL, '新增分类', NULL, NULL, NULL, 'workflow_category_save', NULL, 2, 1, 3, 0, 1, NULL, 77, 0, 0);
INSERT INTO `sys_menu` VALUES (127, '2023-06-05 16:02:09', NULL, 'admin', NULL, '修改分类', NULL, NULL, NULL, 'workflow_category_update', NULL, 3, 1, 3, 0, 1, NULL, 77, 0, 0);
INSERT INTO `sys_menu` VALUES (128, '2023-06-05 16:02:38', NULL, 'admin', NULL, '删除分类', NULL, NULL, NULL, 'workflow_category_delete', NULL, 4, 1, 3, 0, 1, NULL, 77, 0, 0);
INSERT INTO `sys_menu` VALUES (129, '2023-06-06 16:08:47', NULL, 'admin', NULL, '获取表单列表', NULL, NULL, NULL, 'workflow_form_list', NULL, 1, 1, 3, 0, 1, NULL, 74, 0, 0);
INSERT INTO `sys_menu` VALUES (130, '2023-06-06 16:09:05', NULL, 'admin', NULL, '新增表单', NULL, NULL, NULL, 'workflow_form_save', NULL, 2, 1, 3, 0, 1, NULL, 74, 0, 0);
INSERT INTO `sys_menu` VALUES (131, '2023-06-06 16:09:24', NULL, 'admin', NULL, '编辑表单', NULL, NULL, NULL, 'workflow_form_update', NULL, 3, 1, 3, 0, 1, NULL, 74, 0, 0);
INSERT INTO `sys_menu` VALUES (132, '2023-06-06 16:09:44', NULL, 'admin', NULL, '删除表单', NULL, NULL, NULL, 'workflow_form_delete', NULL, 4, 1, 3, 0, 1, NULL, 74, 0, 0);
INSERT INTO `sys_menu` VALUES (133, '2023-06-06 16:25:11', NULL, 'admin', NULL, '获取流程模型', NULL, NULL, NULL, 'workflow_model_list', NULL, 1, 1, 3, 0, 1, NULL, 75, 0, 0);
INSERT INTO `sys_menu` VALUES (134, '2023-06-06 16:26:35', '2023-06-06 16:27:28', 'admin', 'admin', '新增流程模型', NULL, NULL, NULL, 'workflow_model_save', NULL, 3, 1, 3, 0, 1, NULL, 75, 0, 0);
INSERT INTO `sys_menu` VALUES (135, '2023-06-06 16:26:55', NULL, 'admin', NULL, '更新流程模型', NULL, NULL, NULL, 'workflow_model_update', NULL, 2, 1, 3, 0, 1, NULL, 75, 0, 0);
INSERT INTO `sys_menu` VALUES (136, '2023-06-06 16:27:20', NULL, 'admin', NULL, '删除流程模型', NULL, NULL, NULL, 'workflow_model_delete', NULL, 4, 1, 3, 0, 1, NULL, 75, 0, 0);
INSERT INTO `sys_menu` VALUES (137, '2023-06-06 16:27:51', '2023-06-06 16:28:31', 'admin', 'admin', '设计流程模型', NULL, NULL, NULL, 'workflow_model_save_design', NULL, 5, 1, 3, 0, 1, NULL, 75, 0, 0);
INSERT INTO `sys_menu` VALUES (138, '2023-06-06 16:28:09', NULL, 'admin', NULL, '部署流程模型', NULL, NULL, NULL, 'workflow_model_deploy', NULL, 6, 1, 3, 0, 1, NULL, 75, 0, 0);
INSERT INTO `sys_menu` VALUES (139, '2023-06-06 17:32:10', NULL, 'admin', NULL, '获取流程部署', NULL, NULL, NULL, 'workflow_deployment_list', NULL, 1, 1, 3, 0, 1, NULL, 72, 0, 0);
INSERT INTO `sys_menu` VALUES (140, '2023-06-06 17:32:30', NULL, 'admin', NULL, '删除流程部署', NULL, NULL, NULL, 'workflow_deployment_delete', NULL, 2, 1, 3, 0, 1, NULL, 72, 0, 0);
INSERT INTO `sys_menu` VALUES (142, '2023-06-06 17:33:28', NULL, 'admin', NULL, '获取历史版本', NULL, NULL, NULL, 'workflow_deployment_list', NULL, 4, 1, 3, 0, 1, NULL, 72, 0, 0);
INSERT INTO `sys_menu` VALUES (143, '2023-06-06 17:54:13', '2023-06-06 17:56:32', 'admin', 'admin', '获取流程定义', NULL, NULL, NULL, 'workflow_definition_list', NULL, 3, 1, 3, 0, 1, NULL, 72, 0, 0);
INSERT INTO `sys_menu` VALUES (144, '2023-06-06 17:54:50', '2023-06-06 17:56:16', 'admin', 'admin', '更改流程状态', NULL, NULL, NULL, 'workflow_definition_update', NULL, 5, 1, 3, 0, 1, NULL, 72, 0, 0);

-- ----------------------------
-- Table structure for sys_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_package`;
CREATE TABLE `sys_package`  (
                                `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                                `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                                `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                                `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                                `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐名称',
                                `enabled` tinyint(0) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0:=禁用; 1:=启用)',
                                `deleted` tinyint(0) UNSIGNED NULL DEFAULT 0 COMMENT '是否删除（0:=未删除;null:=已删除）',
                                `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE INDEX `uk_name`(`name`, `deleted`) USING BTREE COMMENT '套餐名称唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_package
-- ----------------------------
INSERT INTO `sys_package` VALUES (2, '2023-05-22 17:22:55', '2023-06-01 16:16:42', 'admin', 'admin', '默认套餐', 1, 0, '');

-- ----------------------------
-- Table structure for sys_package_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_package_menu`;
CREATE TABLE `sys_package_menu`  (
                                     `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                     `package_id` bigint(0) UNSIGNED NOT NULL COMMENT '套餐标识',
                                     `menu_id` bigint(0) UNSIGNED NOT NULL COMMENT '菜单标识',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     INDEX `fk_package_id`(`package_id`) USING BTREE,
                                     INDEX `fk_menu_id`(`menu_id`) USING BTREE,
                                     CONSTRAINT `fk_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                     CONSTRAINT `fk_package_id` FOREIGN KEY (`package_id`) REFERENCES `sys_package` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 313 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_package_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                             `create_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                             `update_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                             `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
                             `post_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
                             `seq` int(0) NOT NULL COMMENT '排序',
                             `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE INDEX `uk_post_code`(`post_code`) USING BTREE COMMENT '岗位编码唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, '2022-08-18 08:47:21', NULL, 'admin', NULL, 'engineer', '工程师', 1, NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                             `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                             `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                             `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
                             `role_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色编码',
                             `tenant_id` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户',
                             `role_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色描述',
                             `role_scope` tinyint(0) UNSIGNED NULL DEFAULT 1 COMMENT '数据范围（1:=全部;2:=部门;3:=部门及下级部门;4:=自定义部门;5:=本人;）',
                             `deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除（0:=未删除;null:=已删除）',
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE INDEX `uk_role_code`(`role_code`, `tenant_id`, `deleted`) USING BTREE,
                             UNIQUE INDEX `uk_role_name`(`name`, `tenant_id`, `deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '2022-08-18 08:48:32', '2023-05-29 11:45:22', 'admin', 'admin', '超级管理员', 'SUPER_ADMIN', '000000', NULL, 1, 0);
INSERT INTO `sys_role` VALUES (2, '2022-08-18 08:49:06', '2023-05-26 14:30:15', 'admin', 'admin', '普通用户', 'USER', '000000', NULL, 1, 0);
INSERT INTO `sys_role` VALUES (43, '2023-06-06 17:23:33', NULL, 'admin', NULL, '管理员', 'ADMIN', '059218', '租户管理员', 1, 0);

-- ----------------------------
-- Table structure for sys_role_dept_data_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept_data_permission`;
CREATE TABLE `sys_role_dept_data_permission`  (
                                                  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                                  `role_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '角色 ID',
                                                  `dept_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '部门 ID',
                                                  PRIMARY KEY (`id`) USING BTREE,
                                                  UNIQUE INDEX `uk_role_id_dept_id`(`role_id`, `dept_id`) USING BTREE COMMENT '角色 ID 部门 ID 唯一索引',
                                                  INDEX `fk_dept_id`(`dept_id`) USING BTREE,
                                                  CONSTRAINT `fk_dept_id` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                                  CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept_data_permission
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
                                  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                  `role_id` bigint(0) UNSIGNED NOT NULL COMMENT '角色 ID',
                                  `menu_id` bigint(0) UNSIGNED NOT NULL COMMENT '菜单 ID',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE INDEX `uk_role_id_menu_id`(`role_id`, `menu_id`) USING BTREE COMMENT '角色 ID, 菜单 ID 唯一索引',
                                  INDEX `fk_sys_role_menu_menu_id`(`menu_id`) USING BTREE,
                                  CONSTRAINT `fk_sys_role_menu_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                  CONSTRAINT `fk_sys_role_menu_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1188 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (127, 1, 1);
INSERT INTO `sys_role_menu` VALUES (135, 1, 2);
INSERT INTO `sys_role_menu` VALUES (1042, 1, 3);
INSERT INTO `sys_role_menu` VALUES (128, 1, 4);
INSERT INTO `sys_role_menu` VALUES (132, 1, 5);
INSERT INTO `sys_role_menu` VALUES (22, 1, 14);
INSERT INTO `sys_role_menu` VALUES (27, 1, 15);
INSERT INTO `sys_role_menu` VALUES (26, 1, 16);
INSERT INTO `sys_role_menu` VALUES (133, 1, 21);
INSERT INTO `sys_role_menu` VALUES (136, 1, 24);
INSERT INTO `sys_role_menu` VALUES (44, 1, 29);
INSERT INTO `sys_role_menu` VALUES (62, 1, 30);
INSERT INTO `sys_role_menu` VALUES (37, 1, 31);
INSERT INTO `sys_role_menu` VALUES (36, 1, 32);
INSERT INTO `sys_role_menu` VALUES (42, 1, 33);
INSERT INTO `sys_role_menu` VALUES (41, 1, 34);
INSERT INTO `sys_role_menu` VALUES (43, 1, 35);
INSERT INTO `sys_role_menu` VALUES (45, 1, 36);
INSERT INTO `sys_role_menu` VALUES (50, 1, 40);
INSERT INTO `sys_role_menu` VALUES (55, 1, 41);
INSERT INTO `sys_role_menu` VALUES (51, 1, 52);
INSERT INTO `sys_role_menu` VALUES (53, 1, 53);
INSERT INTO `sys_role_menu` VALUES (52, 1, 54);
INSERT INTO `sys_role_menu` VALUES (54, 1, 55);
INSERT INTO `sys_role_menu` VALUES (64, 1, 62);
INSERT INTO `sys_role_menu` VALUES (63, 1, 63);
INSERT INTO `sys_role_menu` VALUES (161, 1, 66);
INSERT INTO `sys_role_menu` VALUES (130, 1, 67);
INSERT INTO `sys_role_menu` VALUES (129, 1, 68);
INSERT INTO `sys_role_menu` VALUES (97, 1, 69);
INSERT INTO `sys_role_menu` VALUES (96, 1, 70);
INSERT INTO `sys_role_menu` VALUES (123, 1, 71);
INSERT INTO `sys_role_menu` VALUES (77, 1, 72);
INSERT INTO `sys_role_menu` VALUES (83, 1, 73);
INSERT INTO `sys_role_menu` VALUES (87, 1, 74);
INSERT INTO `sys_role_menu` VALUES (88, 1, 75);
INSERT INTO `sys_role_menu` VALUES (100, 1, 76);
INSERT INTO `sys_role_menu` VALUES (102, 1, 77);
INSERT INTO `sys_role_menu` VALUES (103, 1, 78);
INSERT INTO `sys_role_menu` VALUES (134, 1, 80);
INSERT INTO `sys_role_menu` VALUES (146, 1, 86);
INSERT INTO `sys_role_menu` VALUES (152, 1, 87);
INSERT INTO `sys_role_menu` VALUES (151, 1, 88);
INSERT INTO `sys_role_menu` VALUES (154, 1, 89);
INSERT INTO `sys_role_menu` VALUES (153, 1, 90);
INSERT INTO `sys_role_menu` VALUES (148, 1, 91);
INSERT INTO `sys_role_menu` VALUES (147, 1, 92);
INSERT INTO `sys_role_menu` VALUES (150, 1, 93);
INSERT INTO `sys_role_menu` VALUES (149, 1, 94);
INSERT INTO `sys_role_menu` VALUES (158, 1, 95);
INSERT INTO `sys_role_menu` VALUES (157, 1, 96);
INSERT INTO `sys_role_menu` VALUES (160, 1, 97);
INSERT INTO `sys_role_menu` VALUES (159, 1, 98);
INSERT INTO `sys_role_menu` VALUES (155, 1, 99);
INSERT INTO `sys_role_menu` VALUES (162, 1, 102);
INSERT INTO `sys_role_menu` VALUES (360, 1, 109);
INSERT INTO `sys_role_menu` VALUES (1048, 1, 121);
INSERT INTO `sys_role_menu` VALUES (1047, 1, 122);
INSERT INTO `sys_role_menu` VALUES (1046, 1, 123);
INSERT INTO `sys_role_menu` VALUES (1060, 1, 124);
INSERT INTO `sys_role_menu` VALUES (1064, 1, 125);
INSERT INTO `sys_role_menu` VALUES (1063, 1, 126);
INSERT INTO `sys_role_menu` VALUES (1062, 1, 127);
INSERT INTO `sys_role_menu` VALUES (1061, 1, 128);
INSERT INTO `sys_role_menu` VALUES (1068, 1, 129);
INSERT INTO `sys_role_menu` VALUES (1069, 1, 130);
INSERT INTO `sys_role_menu` VALUES (1066, 1, 131);
INSERT INTO `sys_role_menu` VALUES (1065, 1, 132);
INSERT INTO `sys_role_menu` VALUES (1070, 1, 133);
INSERT INTO `sys_role_menu` VALUES (1072, 1, 134);
INSERT INTO `sys_role_menu` VALUES (1074, 1, 135);
INSERT INTO `sys_role_menu` VALUES (1073, 1, 136);
INSERT INTO `sys_role_menu` VALUES (1075, 1, 137);
INSERT INTO `sys_role_menu` VALUES (1071, 1, 138);
INSERT INTO `sys_role_menu` VALUES (1169, 1, 139);
INSERT INTO `sys_role_menu` VALUES (1168, 1, 140);
INSERT INTO `sys_role_menu` VALUES (1170, 1, 142);
INSERT INTO `sys_role_menu` VALUES (1182, 1, 143);
INSERT INTO `sys_role_menu` VALUES (1181, 1, 144);
INSERT INTO `sys_role_menu` VALUES (81, 2, 1);
INSERT INTO `sys_role_menu` VALUES (1052, 2, 5);
INSERT INTO `sys_role_menu` VALUES (85, 2, 21);
INSERT INTO `sys_role_menu` VALUES (1053, 2, 36);
INSERT INTO `sys_role_menu` VALUES (86, 2, 62);
INSERT INTO `sys_role_menu` VALUES (82, 2, 66);
INSERT INTO `sys_role_menu` VALUES (69, 2, 68);
INSERT INTO `sys_role_menu` VALUES (68, 2, 69);
INSERT INTO `sys_role_menu` VALUES (71, 2, 70);
INSERT INTO `sys_role_menu` VALUES (70, 2, 71);
INSERT INTO `sys_role_menu` VALUES (84, 2, 73);
INSERT INTO `sys_role_menu` VALUES (99, 2, 76);
INSERT INTO `sys_role_menu` VALUES (104, 2, 78);
INSERT INTO `sys_role_menu` VALUES (112, 2, 80);
INSERT INTO `sys_role_menu` VALUES (1049, 2, 121);
INSERT INTO `sys_role_menu` VALUES (1051, 2, 122);
INSERT INTO `sys_role_menu` VALUES (1050, 2, 123);
INSERT INTO `sys_role_menu` VALUES (1076, 43, 1);
INSERT INTO `sys_role_menu` VALUES (1077, 43, 2);
INSERT INTO `sys_role_menu` VALUES (1079, 43, 3);
INSERT INTO `sys_role_menu` VALUES (1080, 43, 4);
INSERT INTO `sys_role_menu` VALUES (1082, 43, 5);
INSERT INTO `sys_role_menu` VALUES (1088, 43, 14);
INSERT INTO `sys_role_menu` VALUES (1090, 43, 15);
INSERT INTO `sys_role_menu` VALUES (1091, 43, 16);
INSERT INTO `sys_role_menu` VALUES (1093, 43, 21);
INSERT INTO `sys_role_menu` VALUES (1094, 43, 24);
INSERT INTO `sys_role_menu` VALUES (1095, 43, 29);
INSERT INTO `sys_role_menu` VALUES (1096, 43, 30);
INSERT INTO `sys_role_menu` VALUES (1097, 43, 31);
INSERT INTO `sys_role_menu` VALUES (1098, 43, 32);
INSERT INTO `sys_role_menu` VALUES (1099, 43, 33);
INSERT INTO `sys_role_menu` VALUES (1100, 43, 34);
INSERT INTO `sys_role_menu` VALUES (1101, 43, 35);
INSERT INTO `sys_role_menu` VALUES (1102, 43, 36);
INSERT INTO `sys_role_menu` VALUES (1103, 43, 40);
INSERT INTO `sys_role_menu` VALUES (1104, 43, 41);
INSERT INTO `sys_role_menu` VALUES (1105, 43, 52);
INSERT INTO `sys_role_menu` VALUES (1106, 43, 53);
INSERT INTO `sys_role_menu` VALUES (1107, 43, 54);
INSERT INTO `sys_role_menu` VALUES (1108, 43, 55);
INSERT INTO `sys_role_menu` VALUES (1109, 43, 62);
INSERT INTO `sys_role_menu` VALUES (1110, 43, 63);
INSERT INTO `sys_role_menu` VALUES (1078, 43, 66);
INSERT INTO `sys_role_menu` VALUES (1160, 43, 67);
INSERT INTO `sys_role_menu` VALUES (1081, 43, 68);
INSERT INTO `sys_role_menu` VALUES (1083, 43, 69);
INSERT INTO `sys_role_menu` VALUES (1084, 43, 70);
INSERT INTO `sys_role_menu` VALUES (1085, 43, 71);
INSERT INTO `sys_role_menu` VALUES (1161, 43, 72);
INSERT INTO `sys_role_menu` VALUES (1086, 43, 73);
INSERT INTO `sys_role_menu` VALUES (1162, 43, 74);
INSERT INTO `sys_role_menu` VALUES (1163, 43, 75);
INSERT INTO `sys_role_menu` VALUES (1087, 43, 76);
INSERT INTO `sys_role_menu` VALUES (1164, 43, 77);
INSERT INTO `sys_role_menu` VALUES (1089, 43, 78);
INSERT INTO `sys_role_menu` VALUES (1092, 43, 80);
INSERT INTO `sys_role_menu` VALUES (1165, 43, 125);
INSERT INTO `sys_role_menu` VALUES (1166, 43, 126);
INSERT INTO `sys_role_menu` VALUES (1167, 43, 127);
INSERT INTO `sys_role_menu` VALUES (1149, 43, 128);
INSERT INTO `sys_role_menu` VALUES (1150, 43, 129);
INSERT INTO `sys_role_menu` VALUES (1151, 43, 130);
INSERT INTO `sys_role_menu` VALUES (1152, 43, 131);
INSERT INTO `sys_role_menu` VALUES (1153, 43, 132);
INSERT INTO `sys_role_menu` VALUES (1154, 43, 133);
INSERT INTO `sys_role_menu` VALUES (1155, 43, 134);
INSERT INTO `sys_role_menu` VALUES (1156, 43, 135);
INSERT INTO `sys_role_menu` VALUES (1157, 43, 136);
INSERT INTO `sys_role_menu` VALUES (1158, 43, 137);
INSERT INTO `sys_role_menu` VALUES (1159, 43, 138);
INSERT INTO `sys_role_menu` VALUES (1178, 43, 139);
INSERT INTO `sys_role_menu` VALUES (1179, 43, 140);
INSERT INTO `sys_role_menu` VALUES (1180, 43, 142);
INSERT INTO `sys_role_menu` VALUES (1187, 43, 143);
INSERT INTO `sys_role_menu` VALUES (1188, 43, 144);

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
                               `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                               `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                               `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
                               `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
                               `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
                               `tenant_code` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户编码',
                               `enterprise_id` bigint(0) UNSIGNED NOT NULL COMMENT '企业主键',
                               `enterprise_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '企业名称',
                               `admin_id` bigint(0) UNSIGNED NOT NULL COMMENT '租户管理员主键',
                               `contact` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系人',
                               `account` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号',
                               `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机',
                               `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
                               `package_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '租户套餐',
                               `expires` datetime(0) NULL DEFAULT NULL COMMENT '到期时间',
                               `user_quantity` bigint(0) NULL DEFAULT NULL COMMENT '用户数量(-1:=不限制)',
                               `enabled` tinyint(0) NULL DEFAULT NULL COMMENT '状态（0:=禁用; 1:=启用）',
                               `deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除（0:=未删除;null:=已删除）',
                               `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE INDEX `uk_tenant_code`(`tenant_code`, `deleted`) USING BTREE COMMENT '租户编码唯一索引',
                               INDEX `fk_enterprise_id`(`enterprise_id`) USING BTREE,
                               INDEX `fk_package_id_id`(`package_id`) USING BTREE,
                               CONSTRAINT `fk_package_id_id` FOREIGN KEY (`package_id`) REFERENCES `sys_package` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES (1, '2023-05-28 17:05:29', NULL, 'admin', NULL, '000000', 1, 'xxx有限公司', 1, '超级管理员', 'admin', NULL, NULL, NULL, NULL, -1, 1, 0, NULL);
INSERT INTO `sys_tenant` VALUES (7, '2023-06-06 17:23:34', NULL, 'admin', NULL, '059218', 782, '北京阿里巴巴信息技术有限公司', 61, '马芸', 'admin', '', NULL, 2, NULL, 2, 1, 0, NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                             `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'sys' COMMENT '创建人',
                             `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'sys' COMMENT '更新人',
                             `username` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
                             `tenant_id` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户',
                             `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
                             `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
                             `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg' COMMENT '头像',
                             `sex` tinyint(0) UNSIGNED NOT NULL DEFAULT 1 COMMENT '性别 (1:=男，2:=女)',
                             `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机',
                             `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
                             `birthday` date NULL DEFAULT NULL COMMENT '生日',
                             `dept_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '部门 ID',
                             `enabled` tinyint(0) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态（0:=禁用，1:=启用）',
                             `deleted` tinyint(0) UNSIGNED NULL DEFAULT 0 COMMENT '是否删除（0:=未删除，NULL:=已删除）',
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE INDEX `uk_username_deleted`(`username`, `tenant_id`, `deleted`) USING BTREE COMMENT '用户名唯一索引',
                             INDEX `idx_tenant_id`(`tenant_id`) USING BTREE COMMENT '租户索引'
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '2022-08-16 14:29:55', '2023-06-01 14:15:04', 'admin', 'admin', 'admin', '000000', '超级管理员', '{bcrypt}$2a$10$by4agdlzb5vCxVENLtmLuuhmReyAgKbql0b2l.W4/1mvo7fMxMwy6', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 2, '15019013139', NULL, '1960-12-29', 1, 1, 0);
INSERT INTO `sys_user` VALUES (42, '2023-03-25 22:55:59', '2023-05-26 14:39:02', 'admin', 'admin', 'znpi', '000000', 'ZnPi', '{bcrypt}$2a$10$ZNNyoHRYHhiHxNn35IlkuOItxwzIN.rM.8aPo70NM5B9rnK4X5STi', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '15015023432', NULL, '1996-02-15', 3, 1, 0);
INSERT INTO `sys_user` VALUES (43, '2023-04-21 14:03:53', '2023-06-07 11:04:11', 'admin', 'admin', '00001', '000000', '吸血鬼', '{bcrypt}$2a$10$3bATQy14M8Pt7Itxez7ybujGYq7lG0Ez0x3NkZf6BM1gTzAb.rEoe', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, NULL, 4, 1, 0);
INSERT INTO `sys_user` VALUES (44, '2023-04-25 16:59:16', '2023-06-06 21:59:06', 'admin', 'admin', 'aa', '000000', 'aa', '{bcrypt}$2a$10$ooLcYEYUEJ/9I4EgAimw6OAZaIA8uDuOmRBLcH52Wo.P6j0m32dt2', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '13444444444', NULL, '2023-04-17', 1, 1, 0);
INSERT INTO `sys_user` VALUES (45, '2023-04-27 09:12:21', '2023-05-26 14:39:05', 'admin', 'admin', 'lw', '000000', 'lw', '{bcrypt}$2a$10$lSw1Leq.Al3slWACemoqQe3KWgzdML/d8UV61yLDf8leSJ/i2UcX.', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '13511111111', NULL, '2023-03-28', 5, 1, 0);
INSERT INTO `sys_user` VALUES (61, '2023-06-06 17:23:34', NULL, 'admin', NULL, 'admin', '059218', '马芸', '{bcrypt}$2a$10$O53YCsbAFHnS83wynmUoz.e/4n8VzZRFOmuYIfsE2q26x46lY8NTS', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '', NULL, NULL, 50, 1, 0);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
                                  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户 ID',
                                  `post_id` bigint(0) NULL DEFAULT NULL COMMENT '岗位 ID',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE INDEX `uk_user_id_post_id`(`user_id`, `post_id`) USING BTREE COMMENT '用户 ID, 岗位 ID 唯一索引'
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
                                  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                  `user_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '用户 ID',
                                  `role_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '角色 ID',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE INDEX `uk_user_id_role_id`(`user_id`, `role_id`) USING BTREE COMMENT '用户 ID，角色 ID 唯一索引',
                                  INDEX `fk_sys_user_role_role_id`(`role_id`) USING BTREE,
                                  CONSTRAINT `fk_sys_user_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
                                  CONSTRAINT `fk_sys_user_role_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (40, 1, 1);
INSERT INTO `sys_user_role` VALUES (42, 42, 2);
INSERT INTO `sys_user_role` VALUES (61, 43, 2);
INSERT INTO `sys_user_role` VALUES (60, 44, 1);
INSERT INTO `sys_user_role` VALUES (41, 45, 1);
INSERT INTO `sys_user_role` VALUES (59, 61, 43);

SET FOREIGN_KEY_CHECKS = 1;
