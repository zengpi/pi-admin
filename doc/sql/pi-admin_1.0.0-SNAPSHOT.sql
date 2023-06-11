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

/*
 Navicat Premium Data Transfer

 Source Server         : ZnPi
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : 10.30.1.30:3306
 Source Schema         : pi-admin-test

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 08/06/2023 15:11:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
INSERT INTO `sys_dept` VALUES (44, '2023-05-28 08:49:02', NULL, 'admin', NULL, '江西志浩电子科技有限公司', '250531', 1, 0, NULL);
INSERT INTO `sys_dept` VALUES (45, '2023-06-01 14:08:27', NULL, 'admin', NULL, 'a', '619889', 1, 0, NULL);
INSERT INTO `sys_dept` VALUES (46, '2023-06-02 16:43:11', NULL, 'admin', NULL, '东莞市安泰彩钢板有限公司', '964367', 1, 0, NULL);
INSERT INTO `sys_dept` VALUES (48, '2023-06-03 19:37:58', NULL, 'admin', NULL, '东莞市川硕光电科技有限公司', '854554', 1, 0, NULL);
INSERT INTO `sys_dept` VALUES (49, '2023-06-03 23:48:44', NULL, 'admin', NULL, '深圳市大族超能激光科技有限公司', '473118', 1, 0, NULL);
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
INSERT INTO `sys_enterprise` VALUES (6, '2023-05-31 17:39:53', NULL, NULL, NULL, '江西志浩电子科技有限公司', NULL, NULL, '91360727MA35LGHK7K', '人民币', '300000000', '蔡志浩', '2016-11-30 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '计算机、通信和其他电子设备制造业', '江西省赣州市龙南市龙南经济技术开发区新圳工业园（深商产业园）', '生产、销售及研发：双面、多层及HDI线路板、柔性线路板、IC载板及电子产品；自动化设备的研发、生产制造及销售；货物进出口(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (201, NULL, NULL, NULL, NULL, '东莞市丰吉电子有限公司', NULL, NULL, '91441900MA51XAPG4N', '人民币', '100万人民币', '向艳', '2018-06-28 00:00:00', '有限责任公司(自然人独资)', '零售业', '东莞市厚街镇桥头社区莲涌西路二十五巷7号之二', '销售：电子材料、五金交电、自动化设备、绝缘材料、防静电用品、劳保用品、包装制品、鞋材。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (202, NULL, NULL, NULL, NULL, '罗门哈斯电子材料（上海）有限公司', 'Rohm and Haas Electronic Materials(Shanghai)Co.,Ltd.', NULL, '91310000749589822W', '美元', '6700万美元', '尹志欣', '2003-05-15 00:00:00', '有限责任公司(港澳台法人独资)', '批发业', '中国（上海）自由贸易试验区富特西一路139号1110室', '区内仓储、分拨业务（除危险品），国际贸易、转口贸易、区内企业间的贸易及区内贸易代理，区内商业性简单加工及商品展示，化工原料及产品（危险化学品详见许可证）、金属材料及制品、水性涂料、电子产品、农药（危险化学品详见许可证）、食品添加剂、建材、润滑剂、纸浆和纸制品、塑料及制品、包装材料、水处理材料和设备的批发、佣金代理（拍卖除外）、进出口及相关配套服务，商务信息咨询，市场营销策划咨询，从事化工科技领域内的技术开发、技术转让、技术咨询、技术服务。【依法须经批准的项目，经相关部门批准后方可开展经营活动】', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (203, NULL, NULL, NULL, NULL, '深圳新广行检测技术有限公司', NULL, NULL, '91440300687553882K', '人民币', '1050万人民币', '王宁', '2009-05-05 00:00:00', '有限责任公司', '专业技术服务业', '深圳市光明区玉塘街道田寮社区田湾路5号D栋厂房春和昌电器有限公司301', '一般经营项目是：仪器检测、校准；检测技术开发（不含生产、加工）；电子仪器、电子产品的技术开发、销售及相关技术咨询；国内贸易；货物及技术进出口。（法律、行政法规、国务院决定规定在登记前须批准的项目除外），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (204, NULL, NULL, NULL, NULL, '东莞市东翔机械设备有限公司', NULL, NULL, '91441900595871672M', '人民币', '1000万人民币', '陈妙玲', '2012-05-18 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市石碣镇西南村庆丰东路12号', '生产、加工、销售：机械设备、五金制品；销售：机电设备、电子设备、楼宇自控设备、金属材料、绝缘材料；消防器材销售及安装；技术服务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (205, NULL, NULL, NULL, NULL, '东莞市石碣鑫达印刷厂', NULL, NULL, NULL, '人民币', '90万人民币', '李福利', '2004-10-27 00:00:00', '个体工商户', '印刷和记录媒介复制业', '东莞市石碣镇横滘村兴龙路', '其它印刷品印刷。', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (206, NULL, NULL, NULL, NULL, '东莞市博晨塑料科技有限公司', 'Dongguan Bochen Plastic Technology Co.,Ltd', NULL, '914419007838907074', '人民币', '2000万人民币', '李洪河', '2006-01-06 00:00:00', '其他有限责任公司', '橡胶和塑料制品业', '广东省东莞市高埗镇莞潢北路8号10号楼', '研发、产销：塑料薄膜、复合包装材料；销售：电子材料、五金材料、五金及通用机械设备、日用口罩（非医用）、日用品、劳保用品；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '50-99人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (207, NULL, NULL, NULL, NULL, '广东炜田环保新材料股份有限公司', 'Guangdong Weitian Environmental Materials Technology Co.,Ltd.', '炜田新材', '91441900673087948F', '人民币', '8223.57万人民币', '黄真英', '2008-04-07 00:00:00', '股份有限公司(非上市、自然人投资或控股)', '橡胶和塑料制品业', '东莞市石碣镇刘屋村美工业区', '生态环境材料、纳米材料制造；生产、加工、销售：塑胶托盘、塑料周转箱、中空板、中空板箱；生产、加工、销售：纳米纤维棉、吸油毡、熔喷布、吹塑板、吹塑罐、环保垃圾桶（袋）和防静电、五金制品；托盘租赁；新材料技术研发；货物进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '100-499人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (208, NULL, NULL, NULL, NULL, '东莞市川硕光电科技有限公司', NULL, NULL, '9144190059408399XP', '人民币', '350万人民币', '严娟', '2012-04-23 00:00:00', '有限责任公司(自然人投资或控股)', '研究和试验发展', '广东省东莞市黄江镇旺盛街37号101室', '研发、生产、销售：光电设备、机电设备、电子机械设备、电子原材料、电子辅材料、电子产品、电子配件、五金制品、塑胶制品、包装制品、包装材料、环境保护设备及材料、仪器；维修：光电设备、机电设备、电子机械设备、环境保护设备；环保设备租赁；废气、废水、噪声治理工程；机电设备安装；通用机械设备安装工程；装修工程；室内水电安装；货物及技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (209, NULL, NULL, NULL, NULL, '东莞市柏林自动化设备科技有限公司', NULL, NULL, '91441900579734475C', '人民币', '1000万人民币', '黄江梅', '2011-08-10 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广东省东莞市南城街道莞太路南城段305号701室', '研发、销售及技术转让：自动化设备、计算机软硬件、电子产品、实验仪器设备；销售及维修：工业自动化设备、工业照明设备、非标配电设备、通用机械设备、五金交电、电工器材、通信器材、计算机及配件、电子仪器仪表、电动工具；销售：工业皮带及配件、重型纸箱及包装材料、冷却液、润滑油。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (210, NULL, NULL, NULL, NULL, '东莞市安泰彩钢板有限公司', 'Dongguan antai choi steel co.,LTD', NULL, '914419000960308799', '人民币', '2000万人民币', '黄祥刚', '2014-03-28 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '金属制品业', '东莞市塘厦镇128工业区一街2号', '产销：彩钢板、金属制品；设计生产、安装：净化设备；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (211, NULL, NULL, NULL, NULL, '东莞市昱谷电子有限公司', NULL, NULL, '914419006770531639', '人民币', '100万人民币', '甘延涛', '2008-06-17 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市谢岗镇泰园社区光明北路三巷24号一楼', '销售：电子元器件、五金制品、塑胶制品、马达、丝印器材、电子材料（不含危险化学品）。', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (212, NULL, NULL, NULL, NULL, '东莞市叶兴包装制品有限公司', NULL, NULL, '91441900771862020H', '人民币', '150万人民币', '叶志荣', '2005-02-01 00:00:00', '有限责任公司(自然人投资或控股)', '橡胶和塑料制品业', '东莞市塘厦镇振兴围村东兴路', '包装装潢印刷品和其他印刷品印刷；产销：胶纸、胶袋；货物进出口、技术进出口。', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (213, NULL, NULL, NULL, NULL, '深圳市佳辉云天科技有限公司', NULL, NULL, '91440300319705854F', '人民币', '100万人民币', '张雪峰', '2014-12-10 00:00:00', '有限责任公司', '软件和信息技术服务业', '深圳市龙岗区平湖街道平湖社区平安大道1号华南城铁东物流区13栋512', '一般经营项目是：线路板电镀生产线及周边机械设备、周边设备零配件、烤箱的销售；电子元器件的销售；机器设备的租赁及上门维修；货物及技术进出口。（法律、行政法规禁止的项目除外；法律、行政法规限制的项目须取得许可后方可经营），许可经营项目是：道路普通货运。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (214, NULL, NULL, NULL, NULL, '东莞市杰华塑胶制品有限公司', NULL, NULL, '91441900560849061W', '人民币', '528万人民币', '岳爱华', '2010-08-27 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市石碣镇横滘村兴横路5号一楼', '销售：塑胶制品、包装材料、木制品、金属制品、模具。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (215, NULL, NULL, NULL, NULL, '东莞联茂电子科技有限公司', 'Dongguan ITEQ Technology Co., Ltd.', NULL, '914419007361924129', '美元', '2000万美元', '蔡馨暳', '2002-04-04 00:00:00', '有限责任公司(外国法人独资)', '计算机、通信和其他电子设备制造业', '东莞市虎门镇北栅村', '生产和销售元器件专用材料（多层电路芯板、铜箔基板、半固化片等）、新型电子元器件（含片式元器件）。（上述产品涉证除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '500-999人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (216, NULL, NULL, NULL, NULL, '东莞科耀机电设备有限公司', 'Dongguan Keyao Electromechanical Equipment Co.,Ltd.', NULL, '914419007510984591', '港元', '1900万港元', '彭伟彰', '2003-07-23 00:00:00', '有限责任公司(港澳台法人独资)', '电气机械和器材制造业', '广东省东莞市虎门镇路东东环二路12号', '研发、生产和销售电路板设备、电子组件、液压组件、气动组件、工业机器人与自动化设备、自动化立体仓库、自动化仓储物流设备、自动化系统设备、自动化生产线、软件；信息化技术开发及其维修服务；从事公司生产的同类商品的批发、进出口及相关配套服务（不设店铺，涉及配额许可证管理、专项规定管理的商品按照国家有关规定办理）。（以上项目不涉及外商投资准入特别管理措施）(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '100-499人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (217, NULL, NULL, NULL, NULL, '东莞市中原保温绝缘材料有限公司', NULL, NULL, '9144190078576814XN', '人民币', '50万人民币', '金茜', '2006-02-27 00:00:00', '有限责任公司(自然人独资)', '批发业', '东莞市莞城区八达路１８６号', '销售、安装：橡塑、石棉、保温绝缘电工材料。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (218, NULL, NULL, NULL, NULL, '东莞佑能工具有限公司', 'Dongguan Union Tool Ltd.', NULL, '91441900744461299T', '美元', '1890万美元', '川上巌', '2002-11-07 00:00:00', '有限责任公司(外国法人独资)', '专用设备制造业', '广东省东莞市洪梅镇洪金路5号', '生产加工、销售精密数控加工用高速超硬刀具（超硬钻头、超硬铣刀）、钻头研磨机以及工模具。电子专用设备、测试仪器、工模具、五金电子零件、钻头研磨机的批发及进出口业务并提供上述产品的售后服务（不设店铺经营，涉及配额、许可证管理商品的，按照国家有关规定办理申请）（以上项目不涉及外商投资准入特别管理措施）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '100-499人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (219, NULL, NULL, NULL, NULL, '广东鼎泰高科技术股份有限公司', 'Guangdong Dtech Technology Co.,Ltd', NULL, '91441900076699698P', '人民币', '36000万人民币', '王馨', '2013-08-08 00:00:00', '其他股份有限公司(非上市)', '金属制品业', '广东省东莞市厚街镇赤岭工业一环路12号之一2号楼102室', '研发、产销：数控工具、钨钢刀具、钨钢刀片、锯片、通用机械设备及配件、模具配件、五金制品、铣刀、钻针、无机非金属材料及制品（特种陶瓷、氧化钛纳米陶瓷、氮化铝钛纳米陶瓷、金刚石纳米陶瓷）；货物进出口、技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '500-999人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (220, NULL, NULL, NULL, NULL, '广东鼎泰机器人科技有限公司', 'GUANGDONG UCAN ROBOT TECHNOLOGY CO.,LTD', NULL, '91441900559166685T', '人民币', '5000万人民币', '王俊锋', '2010-07-15 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '科技推广和应用服务业', '广东省东莞市厚街镇赤岭工业一环路12号之一2号楼101室', '研发、产销：自动化设备、机器人及配件、精密刀具、钻针、无机非金属材料及制品（特种陶瓷、氧化钛纳米陶瓷、氮化铝钛纳米陶瓷、金刚石纳米陶瓷）、加工：真空镀膜产品；货物进出口、技术进出口；计算机软件、自动化设备软件的研发与销售、技术服务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '100-499人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (221, NULL, NULL, NULL, NULL, '东莞宇宙电路板设备有限公司', NULL, NULL, '91441900749190184U', '人民币', '14714.2572万人民币', '陈德和', '2003-05-09 00:00:00', '有限责任公司（港澳台投资、非独资）', '电气机械和器材制造业', '广东省东莞市凤岗镇浸校塘振塘路1号', '生产和销售电路板设备及其周边辅助设备、工业焗炉、上述产品的配件。电路板设备控制软件的开发与销售；设立研发机构，研究和开发电路板设备控制软件。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '1000-4999人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (222, NULL, NULL, NULL, NULL, '江西省江铜耶兹铜箔有限公司', NULL, NULL, '913600007485469191', '人民币', '125360万人民币', '吴晓光', '2003-06-02 00:00:00', '有限责任公司(中外合资)', '有色金属冶炼和压延加工业', '江西省南昌市南昌高新技术产业开发区高新大道1129号', '生产、销售电解铜箔产品；产品的售后服务及相关的技术咨询服务和业务；研究和发展新产品。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (223, NULL, NULL, NULL, NULL, '南昌盛华有色金属制品厂', 'Nanchang Shenghua Non-Ferrous Metal Products Factory', NULL, '9136010570561861XA', '人民币', '600万人民币', '李东华', '1999-07-29 00:00:00', '股份合作制', '电气机械和器材制造业', '江西省南昌市湾里区罗亭工业园南安公路以北', '化工原料、工业金银制品、电子元件加工、自营和代理各类商品和技术进出口业务(依法须经批准的项目，经相关部门批准后方可开展经营活动)', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (224, NULL, NULL, NULL, NULL, '江西恒正电气有限公司', NULL, NULL, '91360100581635476G', '人民币', '200万人民币', '项雪峰', '2011-09-15 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省南昌市西湖区解放西路26号天佑国际公寓1号楼A座1003室（第10层）', '电气产品研发、销售；自动化系统及工控产品系统集成；机电产品安装与销售；计算机硬件、五金交电、仪器仪表、通信设备的批发及零售（以上项目依法需经批准的项目，需经相关部门批准后方可开展经营活动）***', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (225, NULL, NULL, NULL, NULL, '吉安同宇电子科技有限公司', NULL, NULL, '91360802MA38K2WG9X', '人民币', '1000万人民币', '郭惠芬', '2019-04-26 00:00:00', '有限责任公司(自然人独资)', '批发业', '江西省吉安市吉州区白塘街道江子头村125栋', '电子产品研发；自动化控制系统安装；电子原件及其它电子产品、五金制品、化工产品（不含危险化学品）销售；环境保护设备、吸尘设备、废气处理设备、印制电路板生产设备、钻机、机械主轴销售、改造及维修(依法须经批准的项目,经相关部门批准后方可开展经营活动)。**', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (226, NULL, NULL, NULL, NULL, '信丰联旺达电子有限公司', NULL, NULL, '91360722MA36YYB570', '人民币', '500万人民币', '黎明文', '2017-12-13 00:00:00', '有限责任公司(自然人投资或控股)', '其他制造业', '江西省赣州市信丰县工业园绿源大道（信达电路科技园六栋四楼）', '线路板生产、加工及销售。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (227, NULL, NULL, NULL, NULL, '龙南县三和丰五金机电设备有限公司', NULL, NULL, '91360727MA35H6XT33', '人民币', '100万人民币', '何志荣', '2016-04-08 00:00:00', '有限责任公司(自然人独资)', '零售业', '江西省赣州市龙南市龙南镇新都安置区', '五金交电、空气动力设备、空气净化设备、环保设备、水处理设备、机电节能改造设备、空压机余热回收设备、工程机械设备、仓储物流设备、液压动力设备、工矿机电设备、制冷设备、电子器材、消防器材、管材、通讯终端设备、仪表仪器、塑料制品、包装材料、劳保及办公用品、废气处理设备、污水处理设备及污水处理材料、化工原料及产品(除危险品)、建筑机械及材料、装潢材料的销售、安装、维修及技术服务；管道工程设计、施工。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (228, NULL, NULL, NULL, NULL, '龙南德亿建材有限公司', NULL, NULL, '9136072733299905XA', '人民币', '500万人民币', '叶亦德', '2015-03-19 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市龙南市东江乡晓坑村黄石迳老中学处', '塑料制品、五金交电、建筑材料批发、零售（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (229, NULL, NULL, NULL, NULL, '龙南鸿宇泰科技有限公司', NULL, NULL, '91360727332976210J', '人民币', '100万人民币', '肖华', '2015-04-01 00:00:00', '有限责任公司(自然人投资或控股的法人独资)', '批发业', '江西省赣州市龙南县富康工业园', '许可项目：硝酸（含量≤68%）、氯酸钠、过硫酸钠、过硫酸铵、过硫酸钾批发、零售（带仓储）；盐酸（含量≤37%）、硫酸（含量≤98%）、过氧化氢（双氧水 浓度≤27.5）、硫酸钠、氢氧化钠、过硫酸钠、氨溶液（含氨>10%）、工业酒精、高锰酸钾、次氯酸钠溶液（含有效氯>5%）、氟绷酸、甲酸、乙酸、正磷酸、氨基磺酸、氢氧化钾、漂白粉、过硫酸铵、重络酸钾、亚硝酸钠、三氯化铁、次氯酸钙、氟化氢铵、硝酸铁、硫脲、甲醇溶液（浓度≤20%）、甲醛批发、零售（不带仓储）（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：化工产品生产（不含许可类化工产品），化工产品销售（不含许可类化工产品），电子产品销售，金属材料销售，照明器具销售，生物化工产品技术研发（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (230, NULL, NULL, NULL, NULL, '江西景宏化工有限公司', NULL, NULL, '91360727MA38QC805G', '人民币', '200万人民币', '郑栋福', '2019-07-24 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市龙南市东江乡新圳石龙围安置区', '许可项目：危险化学品经营（仅包括危险化学品经营许可证所列的危险化学品）；道路货物运输（不含危险货物）（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (231, NULL, NULL, NULL, NULL, '龙南县彩龙印刷有限公司', NULL, NULL, '91360727693748854U', '人民币', '228万人民币', '刘建', '2009-10-10 00:00:00', '有限责任公司(自然人投资或控股)', '其他服务业', '江西省龙南市龙南经济技术开发区大罗工业园区17号地左侧A栋', '其他印刷品印刷。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (232, NULL, NULL, NULL, NULL, '赣州昌兴包装制品有限公司', NULL, NULL, '91360727MA35H3171L', '人民币', '500万人民币', '廖家伟', '2016-03-31 00:00:00', '有限责任公司(自然人投资或控股)', '印刷和记录媒介复制业', '江西省赣州市龙南市龙南经济技术开发区工业园区会龙小区3号厂房', '纸质、塑料包装产品的加工与销售(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (233, NULL, NULL, NULL, NULL, '赣州中金化工有限公司', NULL, NULL, '91360728MA35HBQ80D', '人民币', '500万人民币', '曾威', '2016-04-18 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市定南县中沙村仙岭大道154号', '除剧毒、成品油、易制爆危险化学品以外的其他危险化学品种经营【不带仓储】（凭危险化学品经营许可证经营）(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (234, NULL, NULL, NULL, NULL, '赣州中盛隆电子有限公司', NULL, NULL, '9136070257877546XD', '人民币', '6000万人民币', '王鹏', '2011-07-25 00:00:00', '有限责任公司(自然人投资或控股)', '计算机、通信和其他电子设备制造业', '江西省赣州市章贡区水西有色冶金基地', '高精密度多层线路板、电子电路元件、电子产品的生产和销售（依法须经批准的项目，经相关部门批准后方可开展经营活动）****', '50-99人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (235, NULL, NULL, NULL, NULL, '江西腾飞包装有限公司', NULL, NULL, '91360782314724749G', '人民币', '200万人民币', '匡远高', '2014-11-17 00:00:00', '有限责任公司(自然人投资或控股)', '其他制造业', '江西省赣州市大余县新城工业小区', '瓦楞纸板、瓦楞纸箱、纸制品加工、销售（依法须经批准的项目,经相关部门批准后方可开展经营活动）※', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (236, NULL, NULL, NULL, NULL, '赣州松茂电子科技有限公司', NULL, NULL, '913607000992633877', '人民币', '300万人民币', '黄运真', '2014-04-30 00:00:00', '有限责任公司(自然人投资或控股)', '零售业', '江西省赣州市经济技术开发区迎宾大道希雨北路8号办公楼二楼201室', '自动化控制设备、五金交电、电线电缆、办公用品、包装材料、安防监控设备、电脑及外围设备、供暖设备、机械设备、电气设备、仪器仪表、高低压成套设备、消防设备、净水设备、传动部件、阀门、管道设备、稀有金属新材料的销售；工程设备维修服务；电力设备维修；管道安装工程（不含压力管道）、电子自动化工程设计、施工。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (237, NULL, NULL, NULL, NULL, '赣州逸豪新材料股份有限公司', 'Gan Zhou Yi Hao New Materials  Co.,Ltd', NULL, '91360700754225484B', '人民币', '12680万人民币', '张剑萌', '2003-10-22 00:00:00', '股份有限公司(台港澳与境内合资、未上市)', '有色金属冶炼和压延加工业', '江西省赣州市章贡区冶金路16号', '研发、生产、销售：铜箔、覆铜板新材料；电子元器件制造。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (238, NULL, NULL, NULL, NULL, '信丰利裕达电子科技有限公司', NULL, NULL, '91360722063471846B', '人民币', '2000万人民币', '曾裕锋', '2013-03-06 00:00:00', '有限责任公司(自然人投资或控股)', '计算机、通信和其他电子设备制造业', '江西省赣州市信丰县工业园区（电子器件产业基地线路板集控区）', '电路板生产、销售；进出口贸易;厂房租赁（依法须经批准的项目,经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (239, NULL, NULL, NULL, NULL, '深圳市蒲江机电有限公司', 'Shenzhen Pujiang Mechanical&Electrical Co.,Ltd.', NULL, '91440300746619731H', '人民币', '500万人民币', '唐小兵', '2003-02-17 00:00:00', '有限责任公司', '批发业', '深圳市南山区南山大道1088号南园枫叶大厦13L-14L', '一般经营项目是：机电配件、机电设备、电子产品及塑料制品的购销（不含专营、专控、专卖商品）。通用设备修理；专用设备修理；电气设备修理；仪器仪表修理。（除依法须经批准的项目外，凭营业执照依法自主开展经营活动），许可经营项目是：', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (240, NULL, NULL, NULL, NULL, '惠州市铭晟达电子科技有限公司', NULL, NULL, '9144130231527791XN', '人民币', '500万人民币', '黄志刚', '2014-11-07 00:00:00', '有限责任公司(自然人独资)', '零售业', '惠州市惠城区水口街道办事处育才北二路29号一楼', '加工及销售：电子产品、五金、电子材料、软件。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (241, NULL, NULL, NULL, NULL, '震坤行工业超市（上海）有限公司', 'Zhenkunxing Industry Supermarket (Shanghai) Co.,Ltd.', NULL, '91310118632206381P', '人民币', '5301.4361万人民币', '陈龙', '1996-05-27 00:00:00', '有限责任公司(中外合资)', '批发业', '青浦区练塘镇朱枫公路3424号2144室', '许可项目：危险化学品经营；第三类医疗器械经营；食品经营；第二类增值电信业务；货物进出口；技术进出口；成品油零售（不含危险化学品）。（依法须经批准的项目，经相关部门批准后方可开展经营活动，具体经营项目以相关部门批准文件或许可证件为准）一般项目：计算机、信息、网络、通信技术专业领域内的技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广；通信工程；设计、代理各类广告，广告发布（非广播电台、电视台、报刊出版单位）；机电设备（除特种设备）的调试、安装、维修、保养及租赁；专业保洁、清洗、消毒服务，特种设备出租；包装服务，仓储服务（除危险化学品），装卸搬运；非居住房地产租赁；互联网销售（除销售需要许可的商品）；销售：化工产品（不含许可类化工产品），劳防用品，特种劳防用品，汽配，汽车新车，建材，金属材料、金属制品，管道配件，机械设备，机电产品，润滑油、润滑剂（油膏），清洁用品，文化用品、办公用品，家用电器，电子产品，电线电缆，工具刀具，仪器仪表，化妆品，体育用品，安防设备，消防设备及产品，软硬件及辅助设备，食品添加剂，农副产品，通讯设备，特种设备，网络设备，电气设备，专用设备（不含许可类专业设备销售）、通用设备，针纺织品，日用百货，日用玻璃制品，电子元器件，照明器具，，成品油批发（不含危险化学品），销售一类医疗器械，二类医疗器械；信息咨询服务（不含许可类信息咨询服务）；会议及展览服务；生产、制造、研发：紧固件、五金产品。（除依法须经批准的项目外，凭营业执照依法自主开展经营活动）', '1000-4999人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (242, NULL, NULL, NULL, NULL, '深圳胜盛照明科技有限公司', NULL, NULL, '91440300MA5F7B0X8K', '人民币', '100万人民币', '梁瑞玲', '2018-07-05 00:00:00', '有限责任公司(自然人独资)', '软件和信息技术服务业', '深圳市南山区南山街道前海路0101号丽湾大厦A座南区620室', '一般经营项目是：LED灯具、照明灯具、灯饰、辅配件的研发与销售；照明产品、设备及周边辅配件的设计、研发及销售；经营电子商务；国内贸易；货物及技术进出口。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (243, NULL, NULL, NULL, NULL, '东莞市创跃自动化设备有限公司', NULL, NULL, '914419007929344171', '人民币', '200万人民币', '叶汉宏', '2006-08-25 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市南城街道宏图片区宏七路西北侧万科大厦1205室', '工业自动化设备的技术开发；销售：工业控制器材及自动化设备、电脑周边设备、电子产品、五金材料。', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (244, NULL, NULL, NULL, NULL, '深圳市晖腾精密机电有限公司', NULL, NULL, '91440300664190863W', '人民币', '100万人民币', '黄定战', '2007-07-19 00:00:00', '有限责任公司', '通用设备制造业', '深圳市宝安区石岩街道水田社区第四工业区赛联工业园B栋厂房一楼C', '一般经营项目是：高频空气主轴、空气轴承、机械零件的开发设计、销售及维修服务；数控钻孔机配件、数控自动化设备的开发设计与销售；数控设备的维修保养服务；铝型材的设计、技术开发与销售（以上均不含专营、专控、专卖商品及限制项目，维修仅限上门服务）；新能源汽车及配件、汽车及家庭光伏移动储能电源的销售；口罩熔喷布、熔喷布机器、口罩机、精密熔喷模具、精密喷丝板的设计与销售；国内贸易；经营进出口业务。（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营），许可经营项目是：高频空气主轴、空气轴承、机械零件、铝型材的生产；口罩熔喷布、熔喷布机器、口罩机、精密熔喷模具、精密喷丝板的生产。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (245, NULL, NULL, NULL, NULL, '深圳市慧通自动化技术有限公司', 'Shenzhen Huitong Automatic Technology Co.,Ltd.', NULL, '914403007865843779', '人民币', '100万人民币', '杜家财', '2006-04-07 00:00:00', '有限责任公司', '科技推广和应用服务业', '深圳市宝安区沙井街道中心路8-28号创业大厦308室', '一般经营项目是：变频器及相关设备、节能产品、变频恒压供水设备、自动化设备、机械设备、机电设备、通讯设备、仪器仪表的销售，能源技术开发（不含生产加工，以上均不含法律、行政法规、国务院决定规定需前置审批项目及禁止项目）。，许可经营项目是：普通货运。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (246, NULL, NULL, NULL, NULL, '深圳市海蓝智能科技有限公司', NULL, NULL, '91440300MA5FXB632J', '人民币', '1000万人民币', '叶卫港', '2019-11-11 00:00:00', '有限责任公司', '批发业', '深圳市龙华区观湖街道观城社区环观南路105-13号201-203', '一般经营项目是：机电、自动化产品、机械设备、电子、电器、工控类产品的销售,监控设备、仪器仪表、电动机传动系统、电气耗材、照明器材、工具、测试仪器及户外设备、气动工具、物料搬运设备、安全生产用品的销售,金属制品、焊接和车间供气设备、泵及管件、采暖、通风设备及空调产品的销售,从事货物、技术进出口业务(不含分销、国家专营专控商品)。工业自动化元器件及设备的销售,工业自动化软件研发。计算机软件销售及技术咨询。工业自动化配件的研发。销售。；，许可经营项目是：机械设备、五金产品、电子产品类:仪器仪表、办公设备的销售、生产、加工；第二类医疗器械销售。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (247, NULL, NULL, NULL, NULL, '深圳瑞成信电子科技有限公司', NULL, NULL, '91440300580098971L', '人民币', '100万人民币', '石先云', '2011-08-05 00:00:00', '有限责任公司', '批发业', '深圳市宝安区沙井街道民主社区海怡苑B栋107', '一般经营项目是：PCB、FPC自动化设备维护保养及备件销售，特种光源及光学玻璃的销售，国内贸易。（法律、行政法规、国务院决定规定在登记前须批准的项目除外），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (248, NULL, NULL, NULL, NULL, '东莞市钢太贸易有限公司', NULL, NULL, '91441900338349699J', '人民币', '200万人民币', '杨振超', '2015-05-14 00:00:00', '有限责任公司(自然人投资或控股)', '零售业', '东莞市高埗镇凌屋村工业园A栋1楼11号', '销售：金属材料。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (249, NULL, NULL, NULL, NULL, '东莞市司毛特工业皮带有限公司', 'Dongguan Simaote Industry Leather Belt Co.,Ltd.', NULL, '91441900776921392B', '人民币', '500万人民币', '向星静', '2005-06-22 00:00:00', '有限责任公司(自然人独资)', '橡胶和塑料制品业', '广东省东莞市厚街镇古坑运河西路15号2号楼', '加工、销售：工业皮带、橡胶制品、齿轮、自动化设备、机械配件、陶瓷配件。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (250, NULL, NULL, NULL, NULL, '广州衡辉电子设备有限公司', NULL, NULL, '91440101058939934G', '人民币', '2000万人民币', '刘爱萍', '2012-12-25 00:00:00', '有限责任公司(自然人投资或控股)', '专用设备制造业', '广州市南沙区金岭南路11号之五', '电工机械专用设备制造;劳动防护用品批发;建筑物排水系统安装服务;机械配件零售;建筑钢结构、预制构件工程安装服务;机电设备安装服务;电工器材零售;五金零售;电子工业专用设备制造;电镀设备及装置制造;日用化工专用设备制造;电子产品零售;化工产品零售（危险化学品除外）;货物进出口（专营专控商品除外）;电子产品批发;电气设备修理;电力输送设施安装工程服务;商品批发贸易（许可审批类商品除外）;电工器材的批发;化工产品批发（危险化学品除外）;电子元器件批发;通用机械设备销售;通信系统工程服务;通信工程设计服务;', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (251, NULL, NULL, NULL, NULL, '深圳市翔盛鸿科技有限公司', NULL, NULL, '91440300056199303H', '人民币', '500万人民币', '姜春琴', '2012-10-29 00:00:00', '有限责任公司', '批发业', '深圳市宝安区石岩街道水田社区第四工业区祝龙田路50号赛联工业园B栋厂房一楼A', '一般经营项目是：电子产品、塑胶制品、五金制品、机械设备零配件的研发与销售；国内贸易；货物及技术进出口。（不含再生资源非回收经营及法律、行政法规、国务院决定规定在登记前须经批准的项目），许可经营项目是：电子产品、塑胶制品、五金制品、机械设备零配件的生产。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (252, NULL, NULL, NULL, NULL, '深圳相模电子材料有限公司', 'Shenzhen Xiangmo Electronic Materials Co.,Ltd.', NULL, '91440300676692481U', '人民币', '500万人民币', '乔月明', '2008-06-10 00:00:00', '有限责任公司', '批发业', '深圳市南山区南头街道金鸡路1号田厦翡翠明珠花园3栋2108单元', '一般经营项目是：电子材料、机电产品、机械设备、仪器仪表、影像设备及配件、五金交电、金属材料、化工材料、计算机软硬件及配件的销售（以上均不含易燃易爆、有毒危险化学品及其他限制商品）；展会设备及器材的租赁；企业海外市场开拓咨询；企业会议策划及会务服务；经营进出口业务（以上法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营）。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (253, NULL, NULL, NULL, NULL, '梅州市晟飞电子有限公司', NULL, NULL, '91441402MA535A2T35', '人民币', '368万人民币', '吴海艳', '2019-04-18 00:00:00', '有限责任公司(自然人独资)', '计算机、通信和其他电子设备制造业', '梅州市梅江区东升工业园AD13区梅州市清泰文具有限公司内2-2号厂房', '电子产品生产；线路板研发、销售；销售：电子元件、五金交电、机械设备及配件、塑料制品。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (254, NULL, NULL, NULL, NULL, '东莞市辉华轴承有限公司', NULL, NULL, '914419003249327288', '人民币', '100万人民币', '何中生', '2015-01-15 00:00:00', '有限责任公司(自然人独资)', '批发业', '东莞市石碣镇水南村民丰路422号', '销售：轴承、油封、润滑油、五金配件；货物进出口及技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (255, NULL, NULL, NULL, NULL, '广东硕成科技有限公司', 'Guangdong Shuo Cheng Technology Co.Ltd', NULL, '914402320684889549', '人民币', '8088万人民币', '曾庆明', '2013-05-08 00:00:00', '其他有限责任公司', '化学原料和化学制品制造业', '乳源县乳城镇侯公渡经济开发区氯碱特色产业基地', '胶粘剂、特殊功能复合材料及胶粘制品、各类胶带的生产、研发及销售；生产、销售：电子化学品及相关产品（危险化学品除外）；销售：化工原料及化工产品（不含危险、剧毒品）、树脂相关产品、电子设备及零配件；从事特殊功能复合材料及制品、功能性薄膜、合成树脂胶粘剂、胶带、电子产品的批发及进出口业务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (256, NULL, NULL, NULL, NULL, '广东企华工业设备有限公司', 'Guangdong Qeehua Industry Equipment Co.,Ltd.', NULL, '91441900557335545B', '人民币', '1000万人民币', '赖庆仪', '2010-07-06 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广东省东莞市厚街镇厚街陈屋东路8号2号楼', '产销：过滤设备、废水废气污泥处理设备、五金零配件、自动化生产设备；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (257, NULL, NULL, NULL, NULL, '广州天至环保科技有限公司', 'Tantz Environmental Technologies Ltd', NULL, '91440105764030031E', '人民币', '200万人民币', '王朝霞', '2004-07-19 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广州市海珠区广州大道南敦和路189号海珠科技产业基地敦和园区一号楼204、206号', '环保技术开发服务;环保技术咨询、交流服务;新材料技术开发服务;生物技术开发服务;环境污染处理专用药剂材料制造（监控化学品、危险化学品除外）（仅限分支机构经营）;专项化学用品制造（监控化学品、危险化学品除外）（仅限分支机构经营）;其他日用化学产品制造（监控化学品、危险化学品除外）（仅限分支机构经营）;化工产品零售（危险化学品除外）;技术进出口;货物进出口（专营专控商品除外）;', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (258, NULL, NULL, NULL, NULL, '广东天展纸业有限公司', NULL, NULL, '91441900MA4W2P5A6W', '人民币', '1000万人民币', '殷雄', '2016-12-14 00:00:00', '其他有限责任公司', '造纸和纸制品业', '东莞市寮步镇西溪社区金兴路鸿业街7号一楼', '纸制品的加工及销售；化工专用设备、机械设备的制造、销售、技术咨询、技术服务；化工原料（不含危险化学品）、针纺织品、金属材料、电子产品、木制品、塑料制品、五金交电、包装材料、玻璃制品、电子元器件的销售；物业管理；实业投资；货物进出口、技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (259, NULL, NULL, NULL, NULL, '上海联和实业有限公司', 'Shanghai Lianhe Industrial Co.,Ltd.', NULL, '91310114607712936T', '人民币', '500万人民币', '蔡泓', '1994-03-17 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '上海市嘉定区封周路655号14幢201室J959', '印制板设备及配件、化工产品（除危险化学品、监控化学品、烟花爆竹、民用爆炸物品、易制毒化学品）、建材、家用电器、汽车零部件、摩托车零部件、金属材料、办公用品、日用百货的销售，从事化工技术领域内的技术开发、技术转让、技术咨询、技术服务，企业管理咨询，商务咨询，会务服务，展览展示服务，产品设计，机械设备（除特种设备）的安装、维修，从事货物及技术进出口业务。【依法须经批准的项目，经相关部门批准后方可开展经营活动】', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (260, NULL, NULL, NULL, NULL, '东莞市亮阳精密机械加工有限公司', NULL, NULL, '91441900MA51DLPX4G', '人民币', '300万人民币', '谢丽霞', '2018-03-13 00:00:00', '有限责任公司(自然人投资或控股)', '通用设备制造业', '广东省东莞市万江街道万江创新路11号201室', '研发、加工、销售：精密机械设备及配件；销售：五金制品、不锈钢制品、塑胶制品，橡胶制品，模具、金属材料、电子产品。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (261, NULL, NULL, NULL, NULL, '东莞市正软软件有限公司', NULL, NULL, '91441900071938370Y', '人民币', '200万人民币', '陈茂珍', '2013-06-27 00:00:00', '有限责任公司(自然人投资或控股)', '研究和试验发展', '东莞市东城街道主山东纵路208号东城万达广场C区20幢办公1413号房', '研发、销售：计算机软硬件，办公用品；软件技术服务及技术咨询。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (262, NULL, NULL, NULL, NULL, '东莞市协成电子有限公司', NULL, NULL, '91441900678835511E', '人民币', '100万人民币', '姜勇', '2008-08-19 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市万江街道水蛇涌社区商业街32-1号', '研发、销售及技术转让：电子产品，机电设备；产销、维修、加工：线路板，工控电路板，工控自动化设备，仪表仪器以及其零部件；销售：线路板耗材，电子产品，五金制品，塑料制品。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (263, NULL, NULL, NULL, NULL, '东莞市川田贸易有限公司', 'Dongguan Chuantian Trade Co.,Ltd.', NULL, '914419006633326551', '人民币', '580万人民币', '张冲翔', '2007-06-05 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广东省东莞市南城街道宏图路18号177室', '销售：不锈钢阀门、热油泵、电控阀、锅炉配件、气动元件、电器开关、仪器仪表、电机、高温油、不锈钢管材、不锈钢板材、五金配件、燃烧机、定型机配件；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (264, NULL, NULL, NULL, NULL, '广东耀文智能科技有限公司', NULL, NULL, '91441900MA4WJW397K', '人民币', '2000万人民币', '谭周莲', '2017-05-16 00:00:00', '有限责任公司(自然人投资或控股)', '计算机、通信和其他电子设备制造业', '东莞市万江街道石美社区石美二路六巷八号', '研发、生产、销售：智能设备、发光二极管产品、节能设备、铝制品、通用机械设备、电子元器件及相关耗材；批发业、零售业；货物及技术进出口；销售：其他化工产品（不含危险化学品）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (265, NULL, NULL, NULL, NULL, '深圳市原川岛科技有限公司', NULL, NULL, '9144030019234726XD', '人民币', '100万人民币', '袁鸣鸣', '1995-06-07 00:00:00', '有限责任公司', '化学原料和化学制品制造业', '深圳市龙岗区龙城街道嶂背社区嶂背路181号厂房201', '一般经营项目是：国内贸易。，许可经营项目是：导电碳浆、电子产品的研发、生产及销售。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (266, NULL, NULL, NULL, NULL, '东莞市鸿膜电子材料有限公司', NULL, NULL, '91441900315088027C', '人民币', '100万人民币', '王爱军', '2014-09-23 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广东省东莞市万江街道泰新路113号泰库产业园7号楼309室', '销售：电子产品材料、感光材料、塑料薄膜；印制电路板辅助材料研发及技术转让；货物及技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (267, NULL, NULL, NULL, NULL, '深圳市鼎极天电子有限公司', 'Shenzhen Dingjitian Electronics Co.,Ltd.', NULL, '914403006658967299', '人民币', '100万人民币', '汤志坚', '2007-08-09 00:00:00', '有限责任公司', '科技推广和应用服务业', '深圳市宝安区松岗街道潭头社区松岗大道7号汉海达大厦201', '一般经营项目是：电子机械、仪器设备的技术开发、组装及销售；机械仪器设备的维修（上门服务）；国内贸易；货物及技术进出口。（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (268, NULL, NULL, NULL, NULL, '江西吉力物流设备有限公司', NULL, NULL, '91360121063461488R', '人民币', '200万人民币', '刘光武', '2013-03-06 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省南昌市南昌县小蓝经济开发区邓埠村', '许可项目：特种设备安装改造修理（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：物料搬运装备销售，机械设备租赁，电气机械设备销售，机械设备销售，电子、机械设备维护（不含特种设备），矿山机械销售，液压动力机械及元件销售，高速精密齿轮传动装置销售，金属链条及其他金属制品销售，气压动力机械及元件销售，智能仓储装备销售，电子元器件与机电组件设备销售，齿轮及齿轮减、变速箱销售，金属结构销售，智能物料搬运装备销售，衡器销售，蓄电池租赁，仪器仪表销售，金属丝绳及其制品销售，洗涤机械销售，金属制品销售，液气密元件及系统销售，电池销售，紧固件销售，高速精密重载轴承销售，装卸搬运，特种设备出租，特种设备销售，塑料制品销售，手推车辆及牲畜牵引车辆销售，建筑工程用机械销售，轮胎销售，五金产品零售（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (269, NULL, NULL, NULL, NULL, '深圳市鹏亚商贸有限公司', 'Shenzhen Pengya Commerce&Trade Co.,Ltd.', NULL, '9144030075250421XL', '人民币', '1000万人民币', '胡水平', '2003-07-09 00:00:00', '有限责任公司', '批发业', '深圳市龙岗区龙岗街道新生村丰田路209号', '一般经营项目是：国内商业、物资供销业（不含专营、专卖、专控商品）；普通货运（《道路运输经营许可证》有效期至2015年5月22日）。，许可经营项目是：', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (270, NULL, NULL, NULL, NULL, '东莞市南方消防器材有限公司', NULL, NULL, '91441900759200024Y', '人民币', '80万人民币', '姜慧军', '2004-02-18 00:00:00', '有限责任公司(自然人投资或控股)', '金属制品业', '东莞市东城区桑园龙樟路27号3号铺', '销售：消防设备、电子产品、安防产品；消防设备、消防系统安装、维修、保养。', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (271, NULL, NULL, NULL, NULL, '东莞市世诺五金制品有限公司', NULL, NULL, '91441900MA4UN2RG52', '人民币', '500万人民币', '谭玉文', '2016-03-29 00:00:00', '有限责任公司(自然人独资)', '批发业', '广东省东莞市莞城街道创业新苑南街五巷46号101室', '销售：金属制品、水暖阀门、消防器材、机电设备、五金交电、建筑材料、灯饰、润滑油、橡胶制品、劳保用品、电子产品、仪器仪表。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (272, NULL, NULL, NULL, NULL, '深圳市科尔曼科技有限公司', 'Shenzhen Ke Er Man Technology Co.,Ltd.', NULL, '91440300568524050K', '人民币', '200万人民币', '王延华', '2011-01-25 00:00:00', '有限责任公司', '批发业', '深圳市坪山区坪山街道和平社区兰金四路19号华瀚科技工业园1号厂房303', '一般经营项目是：电子产品、光电产品、光学制品、机械设备、电子设备、五金机电产品、照明产品、塑胶产品、橡胶制品、胶类制品、玻璃制品、光学玻璃仪器、气动元件、真空设备、曝光机、PCB半导体设备及配件、耗材的研发及购销。，许可经营项目是：机械设备的维修和技术服务。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (273, NULL, NULL, NULL, NULL, '深圳市创优鞋业有限公司', NULL, NULL, '91440300692519523Y', '人民币', '50万人民币', '郑小琼', '2009-08-06 00:00:00', '有限责任公司', '橡胶和塑料制品业', '深圳市龙华新区观澜街道新城社区竹村福庭工业区第十栋三楼', '一般经营项目是：安全鞋，防护鞋，职业鞋，绝缘鞋，工作皮鞋，防静电鞋的技术开发，生产及销售；劳保用品的销售；（以上均不含法律、行政法规、国务院决定禁止及规定需前置审批项目），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (274, NULL, NULL, NULL, NULL, '赣州众泰鑫业家具有限公司', NULL, NULL, '91360703322584301E', '人民币', '5000万人民币', '彭修潜', '2014-12-30 00:00:00', '有限责任公司(自然人投资或控股)', '零售业', '江西省赣州市赣州经济技术开发区金龙路50号C2厂房', '家具、办公用品及设备、酒店用品及设备、保险设备、钢木门、体育器材、五金产品、建材(除危险化学品)、玻璃钢制品、机电设备、电子电控教学设备生产、设计、批发及零售; 钢制品、不锈钢制品生产、设计、批发及零售（不含喷漆业务）;日用百货、玩具、教学仪器设备、实验室仪器设备、厨房设备、服装、图书（凭有效许可证经营）、窗帘、广告牌、家用电器、广播系统设备、门禁系统、电脑、电子产品、机电设备、电器设备、安防产品、汽车、预包装食品、苗木、花卉的销售；园林绿化工程设计与施工。（依法须经批准的项目,经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (275, NULL, NULL, NULL, NULL, '北京太敬三益自动化科技有限公司', 'Beijing Taijing Sanyi Automation Technology Co.,Ltd.', NULL, '911101065731663077', '人民币', '380万人民币', '吴颜华', '2011-04-27 00:00:00', '有限责任公司(自然人独资)', '科技推广和应用服务业', '北京市北京经济技术开发区地盛北街1号院23号楼2层1单元201-4室', '技术咨询、技术服务、技术开发；销售机械设备、五金交电、电子产品；货物进出口、技术进出口。（企业依法自主选择经营项目，开展经营活动；依法须经批准的项目，经相关部门批准后依批准的内容开展经营活动；不得从事本市产业政策禁止和限制类项目的经营活动。）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (276, NULL, NULL, NULL, NULL, '通标标准技术服务有限公司深圳分公司', NULL, NULL, '91440300X18859593N', '人民币', '20万人民币', '杜佳斌', '1994-10-31 00:00:00', '非公司外商投资企业分支机构', '商务服务业', '深圳市龙岗区坂田街道吉华路430号江灏（坂田）工业厂区厂房4号整栋', '一般经营项目是：根据客户的委托，承担检查、检验、鉴定、监督、货物查验、评定和其他技术服务；管理体系认证、认证培训；在国际标准和检验实验室的建立、评价以及产品信息化方面提供技术咨询服务（不含认证咨询）；检验设备、技术及方法的研究和开发；有关标准化和产品鉴定的其他业务；根据业务需要颁发合营公司证明文件。标准化服务；技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广。（除依法须经批准的项目外，凭营业执照依法自主开展经营活动），许可经营项目是：检验检测服务；认证服务。（依法须经批准的项目，经相关部门批准后方可开展经营活动，具体经营项目以相关部门批准文件或许可证件为准）', '1000-4999人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (277, NULL, NULL, NULL, NULL, '高盛光电（深圳）有限公司', 'Gold Sun Photonics (Shenzhen) Corporation Limited', NULL, '9144030058563768X4', '人民币', '1891.64万人民币', '顾鲲鹏', '2011-12-31 00:00:00', '有限责任公司（法人独资）', '批发业', '深圳市南山区南海大道3003号阳光华艺大厦1栋17B-01、C-03、C-02、C-01、D-03', '一般经营项目是：光电产品技术研发；光电产品及其原料、晶体切片、电子元器件、电子产品及其零组件、太阳能电池及浆料、化工原料、五金交电产品、机械设备及零件、焊接设备及材料、通讯设备、半导体照明产业关键材料、封装器件、照明产品、关键设备的批发、佣金代理（不含拍卖）、经营进出口业务；半导体照明产业与电子产品领域相关的解决方案和技术咨询；企业管理咨询。（以上不含法律、行政法规、国务院决定需要前置审批和禁止的项目，依法须经批准的项目，经相关部门批准后方可开展经营活动），许可经营项目是：危险化学品的销售；', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (278, NULL, NULL, NULL, NULL, '陕西生益科技有限公司', 'Shaanxi Shengyi Technology Co., Ltd.', NULL, '9161040071976874XX', '人民币', '135488.35万人民币', '曾旭棠', '2000-12-28 00:00:00', '有限责任公司(外商投资企业法人独资)', '计算机、通信和其他电子设备制造业', '陕西省咸阳市秦都区永昌路8号', '覆铜板、绝缘板、粘结片及系列化工、电子、电工材料、覆铜板专用设备开发、研制、销售、技术咨询及服务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '1000-4999人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (279, NULL, NULL, NULL, NULL, '江西联茂电子科技有限公司', 'ITEQ (JIANGXI) ELECTRONIC TECHNOLOGIES CO., LTD', NULL, '91360700MA37WY1M2F', '美元', '16080万美元', '蔡馨暳', '2018-05-17 00:00:00', '有限责任公司(中外合资)', '计算机、通信和其他电子设备制造业', '江西省龙南市龙南经济技术开发区赣州电子信息产业科技城', '玻璃纤维半固化胶片、覆铜板（软板、硬板）、高导热基板、新型电子元器件覆铜板、新型电子元器件（含片式元器件）生产和销售；玻璃纤维半固化胶片、覆铜板（软板、硬板）加工；背胶膜、半导体封装载板及高密度印刷电路板电子专用材料研发、生产和销售；自营和代理各类产品的进出口（实行国营贸易管理的货物除外）道路货物运输（不含危险货物运输）(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (280, NULL, NULL, NULL, NULL, '东莞科摩电气有限公司', NULL, NULL, '91441900595802706H', '人民币', '100万人民币', '姚复生', '2012-04-25 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市南城街道黄金路1号东莞天安数码城C1-1001A', '电气设备及配件、自动化设备的销售及技术咨询服务；销售：其他化工产品。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (281, NULL, NULL, NULL, NULL, '赣州市北业建材有限公司', NULL, NULL, '91360727MA364NX88H', '人民币', '500万人民币', '蔡明志', '2017-07-25 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '江西省龙南市御龙城3＃楼13、14、15号商铺', '水电工程施工、消防工程、钢结构工程、土石方工程、管道工程、建筑及装修工程的施工；通信线路、设备安装；建筑、装修、水电管道的技术咨询与服务；消防器材、给排水设备与配件、水暖设备与配件、机电设备与配件、五金配件、建筑材料、装修材料、通讯设备、电子设备、办公设备、文化用品的批发、零售(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (282, NULL, NULL, NULL, NULL, '赣州林亿科技有限公司', NULL, NULL, '91360702MA360FR94N', '人民币', '100万人民币', '宋国平', '2017-05-25 00:00:00', '有限责任公司(自然人独资)', '零售业', '江西省赣州市章贡区八一四大道2号2楼C17-E场地', '计算机软硬件开发、销售；办公设备及耗材、安防监控设备、电子产品、电教设备、家用电器、体育器材、音乐器材、教学用品、办公桌椅、舞台灯光音响设备、电子显示屏、投影机批发、零售；触摸屏排队叫号系统、楼宇对讲系统、会议广播视频系统安装、维护；城市亮化工程（不含电力设施的承装、承修、承试）、综合布线工程、校园文化建设工程、弱电工程设计、施工。(依法须经批准的项目,经相关部门批准后方可开展经营活动)****', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (283, NULL, NULL, NULL, NULL, '梅州市明晨贸易有限公司', NULL, NULL, '91441403MA541HY836', '人民币', '100万人民币', '陈雄', '2019-11-12 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '梅州市梅县区华侨城科技路D区57号', '研发、销售：电子产品、线路板；销售：五金产品、塑料制品、包装材料、纸制品、日用百货、办公用品、化工产品、农副产品；机械设备销售及维修；再生物资回收。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (284, NULL, NULL, NULL, NULL, '深圳市鑫台创电机有限公司', 'SHENZHEN XINTAICHUANG MOTOR CO.,LTD.', NULL, '91440300661044553U', '人民币', '500万人民币', '马先华', '2007-05-05 00:00:00', '有限责任公司', '汽车制造业', '深圳市宝安区松岗街道潭头第一工业区20栋', '一般经营项目是：减速机、马达的生产和销售；变频器、离合器、控制器、变速器、铝壳电机、鼓风机、离心风机、水泵、马达配件、小型机械设备、伺服电机、行星减速机、直交轴减速电机、电机刹车离合器的销售。（法律、行政法规、国务院决定规定在登记前须批准的项目除外），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (285, NULL, NULL, NULL, NULL, '东莞市君胜机械设备有限公司', NULL, NULL, '91441900MA512XFL5Q', '人民币', '100万人民币', '吴碧君', '2017-11-30 00:00:00', '有限责任公司(自然人独资)', '通用设备制造业', '东莞市万江街道石美社区甘元大道工业区2号厂房', '产销：机械设备、自动化设备、自动化配件、电子配件、电气配件、电缆电线、五金制品、紧固件；钣金加工(不含电镀）。', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (286, NULL, NULL, NULL, NULL, '南阳鼎泰高科有限公司', 'NANYANG DTECH CO .,LTD.', NULL, '91411329MA44GXEUX8', '人民币', '15000万人民币', '王馨', '2017-10-20 00:00:00', '有限责任公司（自然人投资或控股的法人独资）', '计算机、通信和其他电子设备制造业', '河南省南阳市新野县中兴路与河园路交叉口', '研发生产销售钻针、槽刀、铣刀电子产品、电子线路板元件及其辅助材料；从事货物或技术进出口业务*涉及许可经营项目，应取得相关部门许可后方可经营', '1000-4999人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (287, NULL, NULL, NULL, NULL, '深圳市宏大利包装材料有限公司', 'Shenzhen Hongdali Packing Material Co.,Ltd.', NULL, '91440300754280838D', '人民币', '150万人民币', '吕伯齐', '2003-09-26 00:00:00', '有限责任公司', '批发业', '深圳市宝安区松岗街道红星社区港联鱼塘格布第二工业区C栋', '一般经营项目是：胶袋、拉伸膜、胶粘带、纸品的销售；国内贸易。(法律、行政法规、国务院决定规定在登记前须经批准的项目除外），许可经营项目是：胶袋、拉伸膜、胶粘带、纸品的生产；包装装潢印刷品印刷；普通货运。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (288, NULL, NULL, NULL, NULL, '深圳富邦盛世科技有限公司', NULL, NULL, '914403005990575209', '人民币', '10万人民币', '张一轩', '2012-06-28 00:00:00', '有限责任公司', '批发业', '深圳市宝安区沙井北环路与中心路交汇处卓越时代大厦4-10楼的507之1室', '一般经营项目是：机械设备、五金配件、电子产品、电子材料、通讯产品、建材、木材、化工产品（不含危险化学品、易制毒化学品、成品油）、金属材料、机械设备的销售；货物及技术进出口。（以上均不含再生资源回收经营及法律、行政法规、国务院决定规定在登记前须经批准的项目），许可经营项目是：机械设备、五金配件、电子产品的生产及覆铜板的钻孔加工。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (289, NULL, NULL, NULL, NULL, '深圳市松柏实业发展有限公司', 'Shenzhen Songbai Industry Development Co.,Ltd', NULL, '91440300741206516W', '人民币', '500万人民币', '饶猛', '2002-07-16 00:00:00', '有限责任公司', '批发业', '深圳市宝安区沙井街道沙四社区帝堂路蓝天科技园8栋二层、一层，12栋一层', '一般经营项目是：化工原料及产品（不含危险化学品、易制毒化学品、成品油）的销售；从事化工领域内的技术开发、技术咨询、技术服务；电子信息新材料和设备的研发、销售；新材料技术、节能技术的技术推广和技术服务；货物及技术进出口。（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营），，许可经营项目是：化工产品(许可类项目除外）生产；电子信息新材料和设备的生产。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (290, NULL, NULL, NULL, NULL, '东洋通电工材料（深圳）有限公司', 'TOYOTSU DENKO MATERIAL（SHENZHEN）LIMITED', NULL, '9144030079797475XW', '人民币', '100万人民币', '姜琪', '2007-03-19 00:00:00', '有限责任公司(台港澳自然人独资)', '批发业', '深圳市龙华区龙华街道清华社区清龙路6号港之龙科技园商务中心C栋501、503', '一般经营项目是：包装材料、绝缘材料、橡胶制品、塑胶制品、五金制品的批发、进出口及相关配套业务（涉及配额许可证管理、专项规定管理的商品按国家有关规定办理）。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (291, NULL, NULL, NULL, NULL, '广东省斯威莱科技有限公司', NULL, NULL, '91440300MA5G663331', '人民币', '500万人民币', '肖小雪', '2020-05-09 00:00:00', '有限责任公司', '批发业', '深圳市坪山区龙田街道龙田社区龙兴北路63号-C栋201', '一般经营项目是：国内贸易（不含专营、专卖、专控商品）；经营进出口业务（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营）。，许可经营项目是：过滤器、测量控制系统、管阀及配件、非标设备的研发与生产。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (292, NULL, NULL, NULL, NULL, '迅康贸易（深圳）有限公司', NULL, NULL, '9144030079048028X6', '港元', '100万港元', '刘少云', '2006-07-27 00:00:00', '有限责任公司(台港澳自然人独资)', '批发业', '深圳市宝安区新桥街道寮丰路9号广场1号1504', '一般经营项目是：印刷线路板、电子产品原材料、耗材及相关设备的进出口、批发（不含危险化学品，涉及配额许可证管理、专项规定管理的商品按照国家有关规定办理）。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (293, NULL, NULL, NULL, NULL, '深圳市甘井高新材料有限公司', 'Shenzhen Ganjing New High-Tech Materials Co.,Ltd.', NULL, '91440300793874962A', '人民币', '1000万人民币', '罗东升', '2006-09-26 00:00:00', '有限责任公司', '计算机、通信和其他电子设备制造业', '深圳市福田区沙头街道天安社区泰然九路盛唐商务大厦西座1808', '一般经营项目是：化工高新材料、电子零配件、线路板、机电设备的技术开发和购销；国内商业、物资供销业（不含专营、专控、专卖商品）；兴办实业（具体项目另行申报）；经营进出口业务（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营）；定型包装食品批发（食品卫生许可证有效期至2013年2月23日）。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (294, NULL, NULL, NULL, NULL, '东莞市京海电子科技有限公司', NULL, NULL, '914419006731009546', '人民币', '500万人民币', '胡扬平', '2008-04-07 00:00:00', '有限责任公司(自然人投资或控股)', '零售业', '东莞市樟木头镇圩镇泰安路167号C座一楼', '生产、研发、销售：电子测试针及辅助材料；设计、销售：线路板。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (295, NULL, NULL, NULL, NULL, '龙南县坚美家具店', NULL, NULL, '92360727L641612442', '人民币', '60万人民币', '廖若昕', '2010-11-16 00:00:00', '个体工商户', '零售业', '赣州市龙南市龙南县金水大道中段', '家具、窗帘、五金、灯具、厨房用品、床上用品零售（依法须经批准的项目，经相关部门批准后方可开展经营活动）', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (296, NULL, NULL, NULL, NULL, '江西科华电气有限公司', 'Jiangxi Kehua Electric Co., Ltd.', NULL, '91360700327710653G', '人民币', '900万人民币', '肖海姣', '2015-01-29 00:00:00', '有限责任公司(自然人投资或控股)', '零售业', '江西省赣州市赣州经济技术开发区金岭西路105号办公研发楼1楼', '许可项目：电力设施承装、承修、承试，建设工程设计，各类工程建设活动，建筑智能化系统设计，建筑智能化工程施工，建筑劳务分包（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：配电开关控制设备制造，变压器、整流器和电感器制造，智能输配电及控制设备销售，配电开关控制设备销售，电线、电缆经营，电力设施器材销售，金属制品销售（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (297, NULL, NULL, NULL, NULL, '龙南达福迩科技有限公司', NULL, NULL, '91360727MA3607WD7J', '人民币', '360万人民币', '邹圣明', '2017-05-23 00:00:00', '有限责任公司(自然人独资)', '零售业', '江西省赣州市龙南市龙南经济技术开发区龙翔国际65-2S', '计算机软硬件及配件、电子产品、仪器仪表、电子元件、自动化办公设备、办公配件及耗材、网络通讯设备、安防设备、智能终端软件、日用百货、家用电器、五金灯饰、劳保防护用品销售（含网上销售）；网络技术咨询服务；软件安装；弱电综合布线安装；货物及技术进出口。（依法须经批准的项目,经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (298, NULL, NULL, NULL, NULL, '东莞市五株电子科技有限公司', 'Dongguan Wuzhu Electronic Technology Co.,Ltd.', NULL, '914419005666057541', '人民币', '40000万人民币', '蔡诚', '2010-12-02 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '计算机、通信和其他电子设备制造业', '东莞市石碣镇刘屋科技中路161号', '生产、销售：双面、多层及HDI线路板、柔性线路板、电子产品；厂房租赁；设备租赁；产销、加工、研发：电子产品；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (299, NULL, NULL, NULL, NULL, '江西威力固智能设备有限公司', NULL, NULL, '91360727MA361L035Q', '人民币', '3000万人民币', '蔡志浩', '2017-06-13 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '专用设备制造业', '江西省赣州市龙南市龙南经济技术开发区电子信息产业科技城', '电子工业专用设备的研发、生产、销售(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (300, NULL, NULL, NULL, NULL, '赣州宏瑞劳保包装材料有限公司', NULL, NULL, '91360700556012955T', '人民币', '50万人民币', '甘继祥', '2010-05-26 00:00:00', '有限责任公司(自然人投资或控股)', '零售业', '江西省赣州市赣州经济技术开发区纬十路1号2#车间二楼', '劳动保障用品、包装材料的批发、零售及加工；道路交通设施标志的批发、零售及制作；日用百货、办公用品、特种劳保用品、五金产品的批发及零售；家用电器、厨房用品、电气机械设备、建筑用钢筋产品、金属材料、建筑材料、喷码机、塑料喷涂油墨零售；2-丁酮、丙酮零售（以上两项不带仓储，凭危险化学品经营许可证经营，有效期至2020年11月26日）。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (401, NULL, NULL, NULL, NULL, '东莞市伟臻装修材料有限公司', NULL, NULL, '91441900MA4X8JB504', '人民币', '50万人民币', '陈玉巧', '2017-10-23 00:00:00', '有限责任公司(自然人独资)', '其他制造业', '东莞市寮步镇泉塘社区中围村162号', '生产、销售：装修材料、包装材料、塑胶制品。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (402, NULL, NULL, NULL, NULL, '深圳市盛佳环保设备有限公司', 'Shenzhen Shengjia Environmental Protection Equipment Co.,Ltd.', NULL, '914403006785696983', '人民币', '100万人民币', '殷卫红', '2008-07-29 00:00:00', '有限责任公司', '批发业', '深圳市坪山区坑梓街道龙田龙兴北路61号日达产业园（B区）', '一般经营项目是：塑料阀门和管道的销售，不锈钢板和管件的销售，五金工具的销售（不含禁止、限制项目）。，许可经营项目是：耐酸碱泵、过滤器的生产加工；化工泵、过滤器的生产和销售。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (403, NULL, NULL, NULL, NULL, '广州锋明电子科技有限公司', 'GUANGZHOU FENGMING ELECTRONIC TECHNOLOGY CO.,LTD.', NULL, '914401137910353053', '人民币', '20万人民币', '宋剑锋', '2006-08-10 00:00:00', '有限责任公司(自然人投资或控股)', '研究和试验发展', '广州市番禺区沙湾镇福龙公路83号1座首层', '电子、通信与自动控制技术研究、开发;信息电子技术服务;电子产品批发;电子产品零售;软件零售;电力电子技术服务;软件开发;软件批发;光电子器件及其他电子器件制造;货物进出口（专营专控商品除外）;技术进出口;电子工业专用设备制造;计算机应用电子设备制造;电子设备工程安装服务;', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (404, NULL, NULL, NULL, NULL, '东莞市东历机电有限公司', 'DONGGUAN DONGLI MECHANICAL&ELECTRICAL CO.,LTD', NULL, '91441900762904567E', '人民币', '500万人民币', '黄小慧', '2004-05-17 00:00:00', '有限责任公司(自然人投资或控股)', '软件和信息技术服务业', '东莞市东城区长泰路556号中信德方斯花园协和大厦1701-1702号', '研发、设计、销售、网上销售、技术转让：机电产品；机器人系统研发、设计、技术服务；工业自动化技术咨询、技术服务；软件网络技术开发、技术服务；机电设备安装；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (405, NULL, NULL, NULL, NULL, '东莞市崚茂五金包装制品有限公司', NULL, NULL, '91441900MA4UP3HR5W', '人民币', '200万人民币', '董映林', '2016-04-28 00:00:00', '有限责任公司(自然人投资或控股)', '零售业', '东莞市万江街道振兴路220号', '加工：五金（不含电镀）、鞋材、模具、电子配件、塑胶、纸品、包装材料、治具、不干胶。', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (406, NULL, NULL, NULL, NULL, '广州市道申紧固标准件有限公司', NULL, NULL, '914401165505871177', '人民币', '301万人民币', '李军', '2010-02-08 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广州市黄埔区云埔工业区观达路20号2栋1F-05', '紧固件销售;金属制品销售;金属材料销售;五金产品批发;五金产品零售;电线、电缆经营;塑料制品销售;工程塑料及合成树脂销售;金属工具销售;金属链条及其他金属制品销售;金属包装容器及材料销售;金属密封件销售;金属丝绳及其制品销售;电子产品销售;电子元器件批发;电力电子元器件销售;电工器材销售;电工仪器仪表销售;风动和电动工具销售;电气设备销售;电气机械设备销售;办公设备耗材销售;办公设备销售;通信设备销售;橡胶制品销售;建筑材料销售;化工产品销售（不含许可类化工产品）;玻璃纤维增强塑料制品销售;特种劳动防护用品销售;包装专用设备销售;消防器材销售;电子元器件零售;润滑油销售;隔热和隔音材料销售;电力设施器材销售;配电开关控制设备销售;特种陶瓷制品销售;建筑陶瓷制品销售;金属基复合材料和陶瓷基复合材料销售;移动通信设备销售;建筑用金属配件销售;建筑装饰材料销售;自行车及零配件批发;助动自行车、代步车及零配件销售;家用电器零配件销售;家用电器销售;石墨烯材料销售;灯具销售;模具销售;', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (407, NULL, NULL, NULL, NULL, '深圳市创赢汇通科技有限公司', NULL, NULL, '91440300349616633H', '人民币', '300万人民币', '杨竹梅', '2015-07-16 00:00:00', '有限责任公司', '计算机、通信和其他电子设备制造业', '深圳市宝安区沙井街道沙头社区沙头工业区金沙二路4-2号一层', '一般经营项目是：PCB板、FPC板、电子元器件、SMT产品的技术开发与销售；国内贸易，货物及技术进出口。，许可经营项目是：PCB板、FPC板、电子元器件、SMT产品的加工。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (408, NULL, NULL, NULL, NULL, '深圳市杰翔信科技有限公司', NULL, NULL, '91440300MA5F6RYD9X', '人民币', '100万人民币', '王友生', '2018-06-25 00:00:00', '有限责任公司(自然人独资)', '批发业', '深圳市坪山区马峦街道坪环社区黄沙坑北九巷2号102', '一般经营项目是：线路板沉铜电镀添加剂的销售；电子商务；国内贸易；货物及技术进出口。，许可经营项目是：双面、多层线路板、电子产品、电子元器件的研发、生产及销售。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (409, NULL, NULL, NULL, NULL, '江西旭昇电子有限公司', 'Jiangxi Xusheng Electronics Co Ltd', NULL, '91360822MA36WYH97U', '人民币', '10510万人民币', '卢重阳', '2017-11-06 00:00:00', '其他有限责任公司', '计算机、通信和其他电子设备制造业', '江西省吉安市吉水县吉水工业园区城西工业园金工大道东侧、黄金大道南侧', '印制电路板研发、印制、生产、加工及销售；集成电路、电子元件、电子设备生产及销售；货物及技术进出口；预包装食品、酒、烟草制品、日用百货、果品、文体用品销售；餐饮服务(依法须经批准的项目,经相关部门批准后方可开展经营活动)*', '500-999人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (410, NULL, NULL, NULL, NULL, '佛山市壹行机电有限公司', 'Foshan Yixing Electromechanical Co.,Ltd.', NULL, '91440604776901519J', '人民币', '110万人民币', '戴文胜', '2005-06-20 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '佛山市禅城区塱沙路179号安东尼国际大厦326-330（住所申报）', '批发、零售：轴承，五金商品，电机，减速机，日用百货，陶瓷机械及配件。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (411, NULL, NULL, NULL, NULL, '上海嘉谌机械设备有限公司', NULL, NULL, '91310118569631245X', '人民币', '100万人民币', '陈建', '2011-03-03 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '青浦区赵巷镇沪青平公路3398号1幢2层A区299室', '销售机械设备及配件、机电设备及配件、五金交电、仪器仪表、电子产品、金属材料、日用百货，计算机软硬件及辅助设备，货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外），机械设备、机电设备、计算机科技领域内的技术服务、技术咨询、技术开发，机械设备、机电设备安装及维修。【依法须经批准的项目，经相关部门批准后方可开展经营活动】', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (412, NULL, NULL, NULL, NULL, '梅州市格兰沃电子有限公司', 'Grandwork Electronics Co.,Ltd.', NULL, '91441400781161578T', '人民币', '2000万人民币', '徐康明', '2005-09-27 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '梅州市梅江区东升工业园AD8区开发区五路1号', '制造、销售：电路板、电子显示屏、照明产品、电子元器件、LED灯及其它电子数码产品的研发；印刷电路板耗材、设备经销；机电设备研发、制造、销售，进出口业务(国家法律法规禁止经营的不得经营；国家法律法规规定需取得前置审批或许可证的项目，未取得审批或许可证之前不得经营)。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '100-499人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (413, NULL, NULL, NULL, NULL, '东莞市精顺机电设备工程有限公司', NULL, NULL, '91441900MA4UR4LY1D', '人民币', '1000万人民币', '许小敏', '2016-06-29 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广东省东莞市寮步镇霞边元下路3号1栋203室', '销售、安装、维修：机电设备、自动化设备、计算机网络设备、制冷设备、机械设备及配件；室内外装修装饰工程；货物及技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (414, NULL, NULL, NULL, NULL, '江西国能电气工程有限公司', NULL, NULL, '91360700MA35J5N949', '人民币', '1280万人民币', '叶兴祯', '2016-06-06 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市赣州经济技术开发区金岭西路105号办公研发楼2楼', '许可项目：电力设施承装、承修、承试，建设工程设计，各类工程建设活动，建筑智能化系统设计，建筑智能化工程施工，建筑劳务分包（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：输配电及控制设备制造，变压器、整流器和电感器制造，电线、电缆经营，电气机械设备销售，电气设备修理（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (415, NULL, NULL, NULL, NULL, '龙南虔商建设工程有限公司', NULL, NULL, '91360727MA36X1EH9J', '人民币', '500万人民币', '李建龙', '2017-11-07 00:00:00', '有限责任公司(自然人投资或控股)', '房屋建筑业', '江西省赣州市龙南市龙南镇水东村仙岩大道122号', '建筑工程、土木工程、市政基础工程、环保工程、建筑装饰装潢工程及园林绿化工程、电力工程、土石方工程施工；钢结构件加工与安装；企业营销策划；保洁服务、楼宇清洗、外墙清洗；广告设计、制作发布。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (416, NULL, NULL, NULL, NULL, '江西锦盛建筑工程有限公司', NULL, NULL, '91360700083943214C', '人民币', '2990万人民币', '李凡', '2013-12-10 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '江西省赣州市赣州经济技术开发区香江大道北侧、华坚北路西侧国际企业中心B10号楼5层办公', '许可项目：建设工程施工，建设工程监理，建设工程设计，公路工程监理，建筑智能化系统设计，水利工程建设监理，住宅室内装饰装修，文物保护工程施工，建筑劳务分包，施工专业作业，建筑物拆除作业（爆破作业除外），林木种子生产经营（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：体育场地设施工程施工，土石方工程施工，园林绿化工程施工，市政设施管理，住宅水电安装维护服务，工程管理服务，光通信设备销售，建筑防水卷材产品销售，保温材料销售，交通设施维修，工业工程设计服务，建筑材料销售，金属结构销售，建筑用钢筋产品销售，规划设计管理，专业设计服务（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (417, NULL, NULL, NULL, NULL, '广东建安消防机电工程有限公司江西分公司', NULL, NULL, '91360102698462708J', '人民币', '0人民币', '樊其亮', '2008-08-21 00:00:00', '有限责任公司分公司(自然人投资或控股)', '建筑安装业', '江西省南昌市青云谱区江西省南昌市青云谱区施尧路1111号水榭花都大厦B栋-613室', '为隶属公司联系接洽业务（依法须经批准的项目，经相关部门批准后方可开展经营活动）***', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (418, NULL, NULL, NULL, NULL, '深圳市三和汇鑫净化科技有限公司', 'Shenzhen Sanhe Huixin Purifying Technology Co.,Ltd.', NULL, '91440300788317985W', '人民币', '5018万人民币', '黄永霞', '2006-04-27 00:00:00', '有限责任公司', '科技推广和应用服务业', '深圳市龙岗区坂田街道岗头社区岗头村上小坑山地江南时代大厦2号楼1401-08', '一般经营项目是：机电设备、中央空调系统、空气净化系统、防静电产品、超净无尘室的上门安装、设计与销售；防腐工程的设计与施工；国内贸易。（法律、行政法规、国务院决定规定在登记前须经批准的项目除外），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (419, NULL, NULL, NULL, NULL, '万镕建工集团有限公司', NULL, NULL, '91441900091794693U', '人民币', '10033万人民币', '钟坤仪', '2014-02-14 00:00:00', '有限责任公司(自然人投资或控股)', '土木工程建筑业', '广东省东莞市道滘镇南阁商业街86号109室', '土石方工程施工，装饰工程施工，市政工程施工，建筑工程施工，城市及道路照明工程施工，消防设施工程施工，钢结构工程施工，园林绿化工程施工,体育场地设施工程施工,环保工程施工，水利水电工程施工（不含承装，承修、承试电力设施），建筑幕墙工程施工，公路工程施工，机电工程施工；建筑劳务分包；加工、销售：门窗；实业投资。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '50-99人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (420, NULL, NULL, NULL, NULL, '东莞市伟利建筑工程有限公司', NULL, NULL, '91441900766598405D', '人民币', '1000万人民币', '叶绍波', '2004-09-16 00:00:00', '有限责任公司(自然人投资或控股)', '房屋建筑业', '东莞市石排镇埔心碧水云天地铺G区6-7号', '房屋建筑工程；室内外装饰工程；金属门窗制造。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (421, NULL, NULL, NULL, NULL, '深圳市坪荣建筑工程有限公司', NULL, NULL, '914403002792599084', '人民币', '5000万人民币', '刘继发', '1996-08-07 00:00:00', '有限责任公司', '土木工程建筑业', '深圳市龙岗区坪地街道教育中路22号', '一般经营项目是：房屋建筑工程施工总承包、土石方工程专业承包、钢结构工程专业承包、建筑幕墙工程专业承包、地基基础工程专业承包、模板脚手架专业承包、地基基础工程专业承包、建筑装修装饰工程专业承包、市政公用工程施工总承包、城市及道路照明工程专业承包；建材的购销；公路养护；园林绿化类工程施工；体育场地设施工程或体育场地工程；水利水电类工程；机械设备租赁。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (422, NULL, NULL, NULL, NULL, '江西省泰鼎机械有限公司', NULL, NULL, '91360121MA38D1R80F', '人民币', '200万人民币', '杨峰', '2019-02-25 00:00:00', '有限责任公司(自然人投资或控股)', '租赁业', '江西省南昌市南昌县小蓝经济技术开发区汇仁大道1888号恒大城剧场商铺2-017', '机械设备、电子设备及配件的销售、安装、租赁、维修及技术咨询服务；五金、建筑材料、消防器材、日用百货销售；自营和代理各类商品和技术的进出口业务，但国家限定或禁止公司经营的商品和技术除外。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (423, NULL, NULL, NULL, NULL, '深圳市广发环境净化工程有限公司', 'Shenzhen Guangfa Environment Purifying Engineering Co.,Ltd.', NULL, '91440300571962633E', '人民币', '3018万人民币', '邓小芳', '2011-04-11 00:00:00', '有限责任公司', '批发业', '深圳市宝安区沙井街道马安山社区马安山锦胜财富广场AB栋A1710-A1720', '一般经营项目是：中央空调设备、空压系统设备、纯水处理设备、净化处理设备、实验室工程设备、环保工程设备、通风工程设备的销售、设计与上门安装；空气净化系统、中央空调系统、恒温恒湿系统、环保节能系统、电气照明系统、设备动力系统的研发与设计；建筑材料的销售；国内贸易，货物及技术进出口。（法律、行政法规或者国务院决定禁止和规定在登记前须经批准的项目除外）医院手术室、ICU等特殊科室的医疗专项工程的设计、咨询、施工。，许可经营项目是：建筑机电安装工程、洁净装修装饰工程、环氧树脂自流平、PVC地坪、金刚砂固化地坪的安装工程的设计与施工。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (424, NULL, NULL, NULL, NULL, '深圳市朗奥洁净科技股份有限公司', 'Shenzhen Laun Clean Technology Co., Ltd.', NULL, '91440300306066555G', '人民币', '7500万人民币', '刘永', '2014-05-05 00:00:00', '其他股份有限公司(非上市)', '批发业', '深圳市南山区粤海街道深圳湾科技生态园三区10栋A座28楼', '一般经营项目是：建筑材料、机电工程设备、机电工程材料、净化工程设备、净化工程材料、实验室工程设备、清洁服务、保洁服务、保洁产品的销售（不含限制项目）、洁净室清洁、环保工程设备的销售，国内贸易；经营进出口业务。(法律、行政法规、国务院决定规定在登记前须经批准的项目除外，涉及行政许可的，须取得行政许可后方可经营），许可经营项目是：机电工程的设计与施工、建筑工程的设计与施工、建筑机电安装工程专业承包、电子与智能化工程专业承包、机电设备安装工程专业承包、消防设施工程专业承包、建筑装修装饰工程专业承包、钢结构工程专业承包、实验室工程、环保工程，提供上述工程相关的项目管理、技术服务；各类洁净室工程的设计；国外机电工程的设计与施工、国外建筑工程的设计与施工；国内外建筑劳务分包；第三类医疗器械经营。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (425, NULL, NULL, NULL, NULL, '赣州荣辉建设工程有限公司', NULL, NULL, '91360700553544155D', '人民币', '30000万人民币', '魏婷', '2010-05-12 00:00:00', '有限责任公司(自然人投资或控股)', '土木工程建筑业', '江西省赣州市赣州经济技术开发区香江大道北侧、华坚北路西侧赣州国际企业中心B13幢3层1#办公', '许可项目：市政公用工程施工总承包；建筑工程施工总承包；城市及道路照明工程专业承包；电力工程施工总承包；石油化工工程施工总承包；公路工程施工总承包；桥梁工程、隧道工程、水利水电工程、消防设施工程、机电工程、输变电工程（凭有效许可证经营）、通信工程、防水防腐保温工程、铁路工程、公路交通工程、矿山工程、环保工程、特种工程、建筑装修装饰工程、建筑幕墙工程、钢结构工程、园林绿化工程、古建筑工程、地基基础工程、水电安装工程、暖通工程、电子与智能化工程、公路路面工程、公路路基工程、土石方工程设计、施工；电力设施承装、承修、承试（凭有效许可证经营）；公路管理与养护（凭有效许可证经营）；房地产开发；体育设施安装施工；苗木销售；建筑劳务分包；特种设备安装改造修理；建筑物拆除作业（爆破作业除外）；工程造价咨询业务（依法须经批准的项目，经相关部门批准后方可开展经营活动） 一般项目：机械设备租赁；专用设备修理；建筑工程用机械销售；生产性废旧金属回收；工程管理服务；物业管理（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '50-99人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (426, NULL, NULL, NULL, NULL, '广东龙祥涂料科技有限公司', NULL, NULL, '914419007657458484', '人民币', '2688万人民币', '单玉龙', '2004-08-18 00:00:00', '有限责任公司(自然人投资或控股)', '研究和试验发展', '东莞市东城街道主山高田坊莞温路100号聚富商业中心B座420', '研发及技术转让、生产、销售：水性建筑涂料、防静电材料，防水、防腐、防火化工材料（不含危险化学品，生产另设分支机构经营）；货物进出口；环氧树脂地坪工程，室内装饰工程，防静电工程，体育设施安装，室内水电安装。', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (427, NULL, NULL, NULL, NULL, '龙南县鑫塔建设有限公司', NULL, NULL, '913607276859764514', '人民币', '2000万人民币', '廖文青', '2009-04-03 00:00:00', '有限责任公司(自然人独资)', '建筑安装业', '江西省赣州市龙南县龙南镇民主街槐花树下1号', '土木工程，公路、桥梁、涵道工程建筑安装***', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (428, NULL, NULL, NULL, NULL, '赣州智源电力勘测设计有限公司龙南分公司', NULL, NULL, '91360727058816010D', '人民币', '0人民币', '彭瑜', '2012-12-07 00:00:00', '有限责任公司分公司(非自然人投资或控股的法人独资)', '专业技术服务业', '江西省赣州市龙南县龙定大道61号', '35KV以下输变配电工程勘测设计及相应配套的土建工程勘测设计(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (429, NULL, NULL, NULL, NULL, '苏州迪比德地坪材料有限公司', NULL, NULL, '91320509339087678E', '人民币', '1000万人民币', '肖吾楠', '2015-05-26 00:00:00', '有限责任公司(自然人独资)', '批发业', '吴江区同里镇屯村东路526号', '环氧地坪材料、PVC地板、水性涂料、建筑材料销售；五金配件生产、加工、销售；地坪工程。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (430, NULL, NULL, NULL, NULL, '常州朗逊防静电地板有限公司', 'CHANGZHOU LUCENT ANTI-STATIC FLOORING CO.,LTD.', NULL, '913204120534716826', '人民币', '2008万人民币', '吴俊杰', '2012-09-06 00:00:00', '有限责任公司(自然人投资或控股)', '木材加工和木、竹、藤、棕、草制品业', '武进区横林镇崔北村', '防静电地板、架空活动地板、硫酸钙地板、钢地板、铝合金地板、铝蜂窝地板、木地板、吊顶板、护墙板及配件制造，加工；板材、办公家具及配件、金属制品、机房设备、建筑装饰材料、五金产品、家用电器销售；地板工程铺设，安装；机房工程施工，安装；自营和代理各类商品及技术的进出口业务，但国家限定企业经营或禁止进出口的商品及技术除外。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (431, NULL, NULL, NULL, NULL, '广东鸿宇建筑与工程设计顾问有限公司河源分公司', NULL, NULL, '91441602086791324B', '人民币', '0人民币', '邬坚良', '2013-12-10 00:00:00', '其他有限责任公司分公司', '专业技术服务业', '河源市新市区凯丰路东面河源市人才大厦旁第三层', '为隶属公司联系业务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (432, NULL, NULL, NULL, NULL, '河源市梓州基础工程有限公司', NULL, NULL, '91441602MA4WWE1E73', '人民币', '100万人民币', '江祖州', '2017-07-24 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '河源市区东城西片区黄沙大道西边、纬十四路北面河源雅居乐花园金榈名都E1-2幢*层B038号一楼', '承接土木基础工程；建筑劳务分包；强夯基础工程；桩基检测；市政工程；边坡支护工程。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (433, NULL, NULL, NULL, NULL, '龙南县东江荣华苗甫', NULL, NULL, '92360727L41216329E', '人民币', '100万人民币', '曾宪荣', '2009-08-25 00:00:00', '个体工商户', '林业', '龙南县东江乡中和村105国道', '果苗、花苗、绿化苗种植  林木种籽生产  园林绿化、中介服务( 依法须经批准的项目，经相关部门批准后方可开展经营活动）※', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (434, NULL, NULL, NULL, NULL, '赣州市锦业建设有限公司', NULL, NULL, '91360700553531725Y', '人民币', '2160万人民币', '吴正圣', '2010-04-28 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '江西省赣州市章贡区水南镇南桥新村东一区49号二楼', '房屋建筑工程、市政工程、公路工程、园林古建筑工程、园林绿化工程、土石方工程、建筑装修装饰工程、体育场地及设施工程、城市及道路照明工程（不含电力设施承装、承修、承试）、钢结构工程施工；机电设备安装（不含特种设备）。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (435, NULL, NULL, NULL, NULL, '广州市耐迪装饰工程有限公司', NULL, NULL, '91440101094090544G', '人民币', '2000万人民币', '邓思伟', '2014-03-21 00:00:00', '有限责任公司(自然人投资或控股)', '商务服务业', '广州市天河区燕岭路89号2809-2812房', '室内装饰、装修;工程环保设施施工;基坑支护服务;接受委托从事劳务外包服务;劳务承揽;涂料零售;基坑监测服务;工程排水施工服务;土石方工程服务;工程围栏装卸施工;建筑工程后期装饰、装修和清理;室内装饰设计服务;涂料批发;提供施工设备服务;桩基检测服务;建筑劳务分包;建筑结构防水补漏;建材、装饰材料批发;商品批发贸易（许可审批类商品除外）;', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (436, NULL, NULL, NULL, NULL, '龙南市正晟建筑规划设计有限公司', NULL, NULL, '91360727MA35HDH03N', '人民币', '10万人民币', '钟剑锋', '2016-04-21 00:00:00', '有限责任公司(自然人独资)', '商务服务业', '江西省赣州市龙南市中央城商务大厦B座20楼2009号', '建筑工程、园林景观工程、市政工程、道路工程、室内外装饰装修工程、幕墙工程、钢结构工程设计、施工；工程测量；建筑方案设计及咨询；工程造价咨询；各类广告设计、制作、代理、发布；建材销售。（依法须经批准的项目,经相关部门批准后方可开展经营活动）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (437, NULL, NULL, NULL, NULL, '东莞市源丰装修工程有限公司', NULL, NULL, '914419007417309408', '人民币', '800万人民币', '李文波', '2002-07-17 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '东莞市石碣镇石碣村崇焕中路183号华科城石碣创新科技园15楼1513室', '室内外设计装修；机电安装。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (438, NULL, NULL, NULL, NULL, '江西泰盛建设工程有限公司龙南分公司', NULL, NULL, '91360727MA35PXM2X2', '人民币', '0人民币', '蔡欣', '2017-02-15 00:00:00', '有限责任公司分公司(自然人投资或控股)', '房屋建筑业', '江西省赣州市龙南市龙南镇腾龙路腾龙实业办公楼三楼', '在授权范围内为上级公司联系业务(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (439, NULL, NULL, NULL, NULL, '江西华勋环保科技有限公司', NULL, NULL, '913601023276772246', '人民币', '200万人民币', '刘甫曦', '2015-04-02 00:00:00', '有限责任公司(自然人投资或控股)', '商务服务业', '江西省南昌市东湖区青山南路78号蓝天碧水公寓楼1408室（第14层）', '环保工程、建筑工程；环保技术研究、开发、咨询、服务；环保项目运营；环保设备及仪器的销售。（依法须经批准的项目，经相关部门批准后方可开展经营活动）***', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (440, NULL, NULL, NULL, NULL, '佛山市禅城区聚梦五金经营部', NULL, NULL, '92440604L68327141C', '人民币', '1万人民币', '黄灿焕', '2014-01-13 00:00:00', '个体工商户', '零售业', '佛山市禅城区规划华远东路西侧、澜石二马路南侧自编D座5号', '零售：五金配件、不锈钢配件。', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (441, NULL, NULL, NULL, NULL, '龙南供水有限责任公司', NULL, NULL, '91360727160561296A', '人民币', '775万人民币', '李荣', '1987-10-28 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '零售业', '江西省赣州市龙南县龙南镇金钩塔下', '制水、供水服务。（依法须经批准的项目,经相关部门批准后方可开展经营活动)', '50-99人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (442, NULL, NULL, NULL, NULL, '龙南县新农村电力工程服务有限责任公司', NULL, NULL, '91360727664795395P', '人民币', '850万人民币', '王文飞', '2007-09-17 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '电力、热力生产和供应业', '江西省赣州市龙南市龙南镇金水大道361号龙南供电公司四楼', '电力服务业务的承揽和劳务代理（农村电网代维护、乡村用电抄表、催费、农户用电维修有偿服务、小水电发电运行值班、工矿企业电工事务）、电力技术咨询服务；10KV及以下电气工程安装服务；承装（修、试）电力设施业务；电器销售；售电业务；电力工程施工（依法须经批准的项目，经相关部门批准后方可开展经营活动）', NULL, '注销', 0);
INSERT INTO `sys_enterprise` VALUES (443, NULL, NULL, NULL, NULL, '梅州市梅江区军诚装饰装潢服务部', NULL, NULL, '92441402MA4W2H7215', '人民币', '2万人民币', '刘军', '2013-08-08 00:00:00', '个体工商户', '零售业', '梅州市梅江区定民路教师村14-74号', '室内装修、室内水电安装、集装箱活动板房安装；不锈钢、铁器、装饰材料批发兼零售', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (444, NULL, NULL, NULL, NULL, '龙南伟群建材贸易有限公司', NULL, NULL, '91360727MA36848N10', '人民币', '600万人民币', '邹伟群', '2017-08-28 00:00:00', '有限责任公司(自然人投资或控股)', '零售业', '江西省赣州市龙南市龙南经济技术开发区金虎村东湖新区', '水电安装材料、建筑装修装饰材料、消防器材及设备、安全安检器材及设备、水泥预制品构件、钢材、钢管及钢结构配件、五金配件的销售；市政公用工程、房建建筑工程、钢结构工程、消防设施工程、水利水电工程、建筑装修装饰工程、园林绿化工程、公路工程、其他道路工程、防腐保温工程、土石方工程施工；建筑劳务分包。（依法须经批准的项目,经相关部门批准后方可开展经营活动）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (445, NULL, NULL, NULL, NULL, '东莞市梅龙装饰设计工程有限公司', NULL, NULL, '91441900MA4W2DNF9K', '人民币', '500万人民币', '温钦奇', '2016-12-12 00:00:00', '有限责任公司(自然人独资)', '建筑装饰、装修和其他建筑业', '东莞市石碣镇刘屋村刘沙路蔚城酒店2号', '室内外装饰工程设计；机电工程、园林绿化工程；销售：建筑材料、装饰材料、家私。', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (446, NULL, NULL, NULL, NULL, '深圳市腾达机电工程有限公司', NULL, NULL, '91440300691189147C', '人民币', '1050万人民币', '杨小飞', '2009-07-06 00:00:00', '有限责任公司', '批发业', '深圳市宝安区沙井街道步涌社区沙井路613号大润科技大厦8801、8802、8803、8805', '一般经营项目是：机电设备、管道空调设备、净化处理设备、不锈钢设备、PCB机械设备、无尘车间设备的销售、设计与上门安装。（以上不含电力设施安装，不含法律、行政法规、国务院决定禁止及规定需前置审批项目），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (447, NULL, NULL, NULL, NULL, '梅州市强泰建筑有限公司', NULL, NULL, '9144140331503765X9', '人民币', '800万人民币', '曾凤兰', '2014-10-20 00:00:00', '有限责任公司(自然人独资)', '土木工程建筑业', '梅州市梅县区剑英大道北梅县富力城A区S1栋11号单层店', '房屋建筑业；公路工程建筑；市政工程；水利工程；消防设施工程；环保工程；土石方工程；园林绿化工程；建筑装饰业；建筑安装业；城市道路照明设施管理；施工劳务分包；承装、承修、承试供电设施和受电设施；广告的设计、制作、发布；河沙开采；建筑工程机械设备租赁；销售：建筑材料、装饰材料、家具、日用品、五金、门。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (448, NULL, NULL, NULL, NULL, '龙南县东锦装饰设计工程有限公司', NULL, NULL, '91360727MA35NJT097', '人民币', '100万人民币', '王显东', '2017-01-05 00:00:00', '有限责任公司(自然人独资)', '专业技术服务业', '江西省赣州市龙南市龙南镇龙泽居东区15座16号', '室内外装饰设计；土木建筑工程、室内外装饰工程、土石方工程、水电安装工程施工；建筑劳务分包；橱柜制作及安装、家用电器销售(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (449, NULL, NULL, NULL, NULL, '江西省陛快管道科技有限公司', NULL, NULL, '91360321MA36WB3F4P', '人民币', '5600万人民币', '陈伟', '2017-10-25 00:00:00', '其他有限责任公司', '研究和试验发展', '江西省萍乡市莲花县工业园B区', '工程和技术研究和试验发展；压力管道及配件的制造；汽车生产专用设备制造；液压和气压动力机械及元件制造；坚固件制造；金属压力容器制造；金属软管制造；防水嵌缝密封条（带）制造；塑料板、管、型材制造；压力管道元件的制造；金属制品修理；国内贸易；管道安装工程。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (450, NULL, NULL, NULL, NULL, '赣州汉宸建设工程有限公司', NULL, NULL, '91360703MA3606XG55', '人民币', '5000万人民币', '曾军', '2017-05-24 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '江西省赣州市赣州经济技术开发区华坚北路59号赣州建筑业总部大楼405#办公室', '工业与民用建筑工程、机电设备安装工程、装饰装修工程、市政工程、公路桥梁工程、水利水电工程(不含电力设施承装、承修、承试)、园林绿化工程、古建筑工程、地基基础工程、钢结构工程、电力工程、石油化工工程（危险品化学品除外）、城市及道路照明工程(不含电力设施承装、承修、承试)、环保工程、模板脚手架工程、建筑幕墙工程、输变电工程（凭有效许可证经营）、隧道工程、消防工程、防水防腐保温工程、金属门窗工程、建筑智能化工程、堤防工程、管道工程（不含压力管道）、河湖整治工程施工；建筑劳务分包(不含劳务派遣)；起重机械设备安装、维修（凭有效许可证经营）；(依法须经批准的项目,经相关部门批准后方可开展经营活动)。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (451, NULL, NULL, NULL, NULL, '瑞金市泰顺建设工程有限公司龙南分公司', NULL, NULL, '91360727MA385C1W8U', '人民币', '0人民币', '刘永春', '2018-09-25 00:00:00', '有限责任公司分公司(自然人投资或控股)', '房屋建筑业', '江西省赣州市龙南市中央城商务大厦A-413A号', '在授权范围内为上级公司联系业务(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (452, NULL, NULL, NULL, NULL, '东莞诚溢厨房工程有限公司', NULL, NULL, '91441900314947002M', '人民币', '1200万人民币', '赖婉芬', '2014-09-03 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广东省东莞市石碣镇崇焕东路70号102室', '厨房油烟处理排放工程施工；研发、设计、产销、安装、维修：厨房设备、环保设备、不锈钢制品、电热食品加工设备、智能洗碗机、厨房通风设备、冷冻设备、水处理系统、人工智能硬件及软件；研发、设计、销售：燃气燃烧器具；燃气燃烧器具安装、维修；建筑装饰装修工程设计与施工；废水、废气、噪音治理设备安装工程施工。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (453, NULL, NULL, NULL, NULL, '东莞市石碣阳阳文体用品店', NULL, NULL, '92441900MA4WMWPA1P', '人民币', '5人民币', '朱立文', '2017-06-07 00:00:00', '个体工商户', '批发业', '东莞市石碣镇城中社区政文东路67号一楼', '批发、零售：文体用品。', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (454, NULL, NULL, NULL, NULL, '东莞市绿泉环境工程有限公司', NULL, NULL, '914419005724489356', '人民币', '100万人民币', '刘少贞', '2011-04-28 00:00:00', '有限责任公司(自然人独资)', '生态保护和环境治理业', '广东省东莞市南城街道鸿福西路南城段76号3栋603室', '环境工程施工，环保治理工程，废水治理、废气治理、环保技术服务；环境工程施工、安装、调试；室内水电安装；室内环境检测；园林绿化服务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (455, NULL, NULL, NULL, NULL, '浙江铭晨膜结构工程有限公司', NULL, NULL, '91330304MA286559XK', '人民币', '1000万人民币', '李卫斌', '2016-10-10 00:00:00', '有限责任公司(自然人投资或控股)', '建筑安装业', '浙江省温州市瓯海区南白象街道新象街西26号第一层第二间', '膜结构工程、钢结构工程的设计、施工；加工车棚零部件；安装、销售、维修：雨棚、门窗、护栏、遮阳棚、停车棚、景观棚、棚房、旗杆、电动伸缩门(以上涉及资质的凭资质经营）；销售：膜材料、钢材（以上不含危险化学品）。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (456, NULL, NULL, NULL, NULL, '深圳市海卓联节能科技有限公司', NULL, NULL, '91440300342905600J', '人民币', '500万人民币', '刘南平', '2015-06-24 00:00:00', '有限责任公司', '批发业', '深圳市宝安区沙井街道中心路万新商业街B栋D大堂2楼2C3', '一般经营项目是：节能科技领域内的技术咨询、技术服务；空调设备、空压设备及其零配件、真空设备、环保设备、机械设备销售、维修、保养、租赁；润滑油、五金配件、钢材、管道、建筑材料销售；合同能源管理服务；管道安装工程、节能净化工程、热泵及热水系统工程、工业设备热能工程、空调系统安装工程、环保安装工程、机电设备安装工程、节能改造工程的设计与施工。(依法须经批准的项目,经相关部门批准后方可开展经营活动)，许可经营项目是：热泵、余热回收设备组装。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (457, NULL, NULL, NULL, NULL, '厦门达尔新型材料有限公司', NULL, NULL, '91350211MA31NXJ691', '人民币', '100万人民币', '刘仕俊', '2018-05-08 00:00:00', '有限责任公司(自然人独资)', '科技推广和应用服务业', '厦门市集美区杏林湾商务营运中心1号楼2201单元', '新材料技术推广服务；其他技术推广服务；其他未列明科技推广和应用服务业；经营各类商品和技术的进出口（不另附进出口商品目录），但国家限定公司经营或禁止进出口的商品及技术除外；涂料零售；建材批发；五金零售；灯具零售；木质装饰材料零售；陶瓷、石材装饰材料零售；其他室内装饰材料零售；建筑装饰业；建设工程勘察设计；园林景观和绿化工程设计；专业化设计服务；其他未列明土木工程建筑（不含须经许可审批的事项）。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (458, NULL, NULL, NULL, NULL, '江西省恒信建设工程监理咨询有限公司赣州恒信分公司', NULL, NULL, '913607003146617843', '人民币', '0人民币', '何建平', '2014-07-31 00:00:00', '有限责任公司分公司(自然人投资或控股)', '专业技术服务业', '江西省赣州经济技术开发区迎宾大道以南、工业四路西侧综合楼', '为隶属公司联系业务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', NULL, '注销', 0);
INSERT INTO `sys_enterprise` VALUES (459, NULL, NULL, NULL, NULL, '陕西宇泰建筑设计有限公司江西分公司', NULL, NULL, '91360103MA37UNY796', '人民币', '0人民币', '李晶', '2018-04-26 00:00:00', '有限责任公司分公司(自然人投资或控股)', '专业技术服务业', '江西省赣州市赣州经济技术开发区华坚路76号绿洲康城8号楼703室', '为隶属公司联系业务（依法须经批准的项目，经相关部门批准后方可开展经营活动）**', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (460, NULL, NULL, NULL, NULL, '南昌绿色京诚检测服务有限公司', NULL, NULL, '91360111578797925B', '人民币', '50万人民币', '钟昌洋', '2011-08-15 00:00:00', '有限责任公司(自然人独资)', '商务服务业', '江西省南昌市青山湖区洪都中大道187号16栋3楼', '电子仪器检测及技术咨询服务；企业管理咨询；会展服务；环保设备销售、维护；建筑工程；园林绿化工程。（以上项目国家有专项规定的除外）**', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (461, NULL, NULL, NULL, NULL, '百翼涂料（广州）股份有限公司', NULL, NULL, '91440112304485473Y', '人民币', '686万人民币', '刘列国', '2014-05-04 00:00:00', '股份有限公司(非上市、自然人投资或控股)', '研究和试验发展', '广州市黄埔区黄埔东路3766号A栋303房（仅限办公用途）', '商品零售贸易（许可审批类商品除外）;建材、装饰材料批发;有机化学原料制造（监控化学品、危险化学品除外）;建筑材料设计、咨询服务;室内装饰设计服务;环保技术开发服务;环保技术咨询、交流服务;新材料技术开发服务;工程环保设施施工;工程围栏装卸施工;', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (462, NULL, NULL, NULL, NULL, '东莞市镁丰机械设备有限公司', NULL, NULL, '91441900095446696X', '人民币', '101万人民币', '施亚琴', '2014-03-25 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市寮步镇泉塘社区石大路311号', '批发、零售：液压机械设备、搬运机械设备、仓储物流机械设备及其零配件；机械设备维修。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (463, NULL, NULL, NULL, NULL, '深圳前海欧达科技有限公司', NULL, NULL, '91440300MA5D9TJL9A', '人民币', '500万人民币', '蔡纯华', '2016-03-31 00:00:00', '有限责任公司(自然人独资)', '批发业', '深圳市前海深港合作区前湾一路1号A栋201室（入驻深圳市前海商务秘书有限公司）', '一般经营项目是：电子产品、机械设备、电子测量仪器、电子材料、工业自动化、化工材料、影像转移材料、PCB印制线路板、新能源产品的技术开发与销售；仪器仪表及零部件、计算机软硬件、机械电子产品整机、半导体集成电路生产设备、触摸屏生产设备、印制线路板生产设备、电子元器件、汽车零配件、通讯器材、科学研究及分析测试的相关仪器设备和耗材、生物试剂、化学试剂（除危险、监控、易制毒化学品，民用爆炸品）的销售；机电设备、仪器仪表的维修技术服务；机械设备的租赁； 国内贸易；经营进出口业务。（依法须经批准的项目，经相关部门批准后方可开展经营活动），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (464, NULL, NULL, NULL, NULL, '东莞市快特电子科技有限公司', 'Dongguan kingtech  Electronics Technology Co., Ltd.', NULL, '914419006824993891', '人民币', '500万人民币', '陈霖', '2009-01-06 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市万江区新城社区金鳌大道9号葡萄庄园3号楼1712号', '研发、销售：电子产品、机电设备、机械设备、五金制品、塑料制品、橡胶制品；维修：机械设备配件；自动化设备的技术开发及咨询服务；货物进出口、技术进出口。', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (465, NULL, NULL, NULL, NULL, '江西幸福绿通新能源电动车有限公司', NULL, NULL, '91360703MA35K11N3J', '人民币', '200万人民币', '周帅辉', '2016-08-05 00:00:00', '有限责任公司(自然人投资或控股)', '零售业', '江西省赣州市赣州经济技术开发区香江大道杨梅村紫荆康居小区15栋5-6号店面', '新能源电动车及其零配件销售、租赁、维修。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (466, NULL, NULL, NULL, NULL, '江西中逸电梯设备有限公司', NULL, NULL, '91360700563806358B', '人民币', '1000万人民币', '朱建生', '2010-10-25 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市章贡区沙河工业园内人和路同远科技办公楼', '电梯批发、零售；机械式停车设备销售；乘客电梯、杂物电梯、载货电梯、自动扶梯、自动人行道安装、维修（凭有效特种设备安装改造维修许可证经营）。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (467, NULL, NULL, NULL, NULL, '江西省上宾机电工程有限公司', NULL, NULL, '91360702083928276A', '人民币', '500万人民币', '刘亮', '2013-12-04 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市章贡区沙河工业园沿湖路中段4#厂房', '机电工程、环保工程、废气废水治理工程、暖通工程、环氧地坪工程设计、施工；电梯的销售、安装、维修、保养及电梯技术咨询、技术服务（凭有效特种设备安装改造维修许可证经营）；电梯零配件、办公设施、电脑、打印机、智能化系统、学生课桌椅、空气净化设备、机电产品、装饰材料、五金交电批发；冷库的销售、安装；空调安装；机电设备维修（除特种设备）；空气净化装备、机电设备（除特种设备）制造、加工。(依法须经批准的项目，经相关部门批准后方可开展经营活动)****', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (468, NULL, NULL, NULL, NULL, '东莞市迈同机械设备有限公司', 'Dongguan Maitong Machinery Equipment Co.,LTD', NULL, '91441900696424417R', '人民币', '1200万人民币', '谢八妹', '2009-10-27 00:00:00', '有限责任公司(自然人投资或控股)', '其他制造业', '东莞市大岭山镇杨屋第二工业区田锋路189号01栋', '生产、销售：风机、集尘机、五金制品、塑胶制品、管道、法兰、水处理设备、空气净化设备、环保设备、制冷设备、空压设备；销售：空调；环保工程；管道工程；水处理工程；粉尘处理工程；设备维护与维修；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (469, NULL, NULL, NULL, NULL, '东莞市新桦南锅炉有限公司', NULL, NULL, '91441900553675438U', '人民币', '1000万人民币', '张柱宁', '2010-04-27 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市寮步镇凫山村金兴路', '销售：锅炉、锅炉辅机、锅炉配件、保温材料、五金电器、水暖器材；安装、保养：锅炉；压力管道安装。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (470, NULL, NULL, NULL, NULL, '赣州腾兴电器销售有限公司', 'Ganzhou Tengxing Electric Appliance Sales Co.,Ltd.', NULL, '9136070269095840XG', '人民币', '51万人民币', '黄开涛', '2009-06-29 00:00:00', '有限责任公司(自然人独资)', '批发业', '江西省赣州市章贡区杨公路10号越秀花苑馨秀轩40#店铺', '空气能热泵、水源地源热泵、空调、饮水机、净水机、家电、照明灯具、电脑网络设备的批发兼零售；承接太阳能工程、风能工程、冷热水工程、中央空调工程、地暖工程、建筑工程；旧家电回收、电器安装及维修 （依法须经批准的项目,经相关部门批准后方可开展经营活动）****', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (471, NULL, NULL, NULL, NULL, '龙南县东诚电器店', NULL, NULL, '92360727L59147923D', '人民币', '70万人民币', '袁东升', '2013-05-22 00:00:00', '个体工商户', '零售业', '赣州市龙南市龙翔广场水岸新城小区', '家用电器及配件、电脑、电脑配件及耗材、电子数码产品、计算机软件，手机及配件，音响及灯具、办公家俱、厨柜、厨卫电器、五金交电、太阳能热水器、安防设备、办公设备、机电设备、体育用品、文化用品、不锈钢制品批发零售，家电维修服务（依法须经批准的项目，经相关部门批准后方可开展经营活动）', NULL, '注销', 0);
INSERT INTO `sys_enterprise` VALUES (472, NULL, NULL, NULL, NULL, '赣州市力帮工程机械设备有限公司', NULL, NULL, '91360702098963541L', '人民币', '100万人民币', '刘道盛', '2014-05-06 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市章贡区站北区赣州金属产业商贸物流城4栋5号', '叉车、工程机械销售、租赁服务；二手工程机械销售、维修；工程机械零配件批发、零售（依法须经批准的项目，经相关部门批准后方可开展经营活动）****', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (473, NULL, NULL, NULL, NULL, '深圳市伟力低碳股份有限公司', 'Shenzhen Weili Low-carbon Co.,ltd.', '伟力低碳', '91440300683763137A', '人民币', '3000万人民币', '江耀纪', '2009-03-24 00:00:00', '股份有限公司(非上市)', '科技推广和应用服务业', '深圳市龙岗区坂田街道环城南路5号坂田国际中心D栋301、302、303室', '一般经营项目是：节能改造工程；制冰机、静态蓄冰空调、动态蓄冰空调、区域供冷系统设备的研发及销售；合同能源管理、购售电业务、节能项目投资（具体项目另行申报）；国内贸易（不含专营、专卖、专控商品）；信息咨询；货物及技术进出口。，许可经营项目是：节能产品研发、生产及销售；制冰机、静态蓄冰空调、动态蓄冰空调、区域供冷系统设备的研发、制造及销售。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (474, NULL, NULL, NULL, NULL, '广东捷西中央空调设备有限公司', NULL, NULL, '914418810930540901', '人民币', '3880万人民币', '盛佑清', '2014-02-26 00:00:00', '有限责任公司(自然人投资或控股)', '通用设备制造业', '英德市英红镇英红工业园红星三路1号', '制冷、空调设备制造；非居住房地产租赁；居民日常生活服务；批发和零售业。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (475, NULL, NULL, NULL, NULL, '深圳市兰创家具有限公司', NULL, NULL, '91440300342854276J', '人民币', '100万人民币', '莫家华', '2015-07-03 00:00:00', '有限责任公司', '批发业', '深圳市龙华区民治街道北站社区樟坑华侨新村彩悦大厦712', '一般经营项目是：办公环境设计；办公家具、酒店家具、民用家具、钢质家具、办公用品、办公饰品、办公电器的设计与销售；家具维修及上门安装服务；铝合金门窗与隔断的设计与销售;建筑工程设计与安装；国内贸易（不含专营、专卖、专控商品）；货物及技术进出口。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (476, NULL, NULL, NULL, NULL, '江西赣州腾旺能源发展有限公司', NULL, NULL, '91360700787267250N', '人民币', '100万人民币', '郭晔慧', '2006-03-24 00:00:00', '有限责任公司(自然人投资或控股)', '电气机械和器材制造业', '江西省赣州市章贡区红旗大道51号10楼', '太阳能热水器、空气能热泵热水器的生产、销售、安装和服务；空调的销售、安装和服务；节能饮水机的销售、安装和服务；光电产品的生产、销售、安装和服务；新能源的开发与应用；环保节能产品的开发与应用；工程机械设备租赁；文体用品销售；塑胶球场、跑道设计与施工；建筑防水材料销售；建筑防水工程设计与施工；地坪工程设计与施工。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (477, NULL, NULL, NULL, NULL, '浙江安浦科技有限公司', 'ZHEJIANG AMPLE TECHNOLOGY CO., LTD.', NULL, '91330502796478519M', '人民币', '500万人民币', '金玉成', '2006-12-12 00:00:00', '有限责任公司(自然人投资或控股)', '专用设备制造业', '浙江省湖州市吴兴区东林镇工业功能区北区', '一般项目：技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广；机械设备研发；电子专用材料研发；电子专用设备制造；工业机器人制造；物料搬运装备制造；环境保护专用设备制造；农业机械制造；农林牧副渔业专业机械的制造；电子专用材料制造(除依法须经批准的项目外，凭营业执照依法自主开展经营活动)。许可项目：货物进出口；技术进出口(依法须经批准的项目，经相关部门批准后方可开展经营活动，具体经营项目以审批结果为准)。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (478, NULL, NULL, NULL, NULL, '韩邦电路板供应链（深圳）有限公司', NULL, NULL, '914403003591872115', '人民币', '200万人民币', '古肇勤', '2015-10-29 00:00:00', '有限责任公司', '批发业', '深圳市宝安区西乡街道鸿盛商务大厦213', '一般经营项目是：工控软件及辅助设备的销售；货物进出口。(法律、行政法规、国务院决定规定在登记前须经批准的项目除外），许可经营项目是：电子产品、机械设备及配件、电器设备、通讯设备的生产。', '小于50人', '注销', 0);
INSERT INTO `sys_enterprise` VALUES (479, NULL, NULL, NULL, NULL, '奥宝亚洲有限公司', NULL, NULL, NULL, '人民币', NULL, NULL, '1999-10-22 00:00:00', NULL, NULL, NULL, NULL, NULL, '仍注册', 0);
INSERT INTO `sys_enterprise` VALUES (480, NULL, NULL, NULL, NULL, '深圳市五株科技股份有限公司', 'Shenzhen Wuzhu Technology Co.,Ltd.', NULL, '91440300715284684M', '人民币', '23577万人民币', '蔡志浩', '2000-03-29 00:00:00', '股份有限公司(非上市)', '计算机、通信和其他电子设备制造业', '深圳市宝安区西乡镇钟屋工业区', '一般经营项目是：经营进出口业务（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营）；房屋租赁。，许可经营项目是：生产、加工单、双面多层线路板、精密仪器加工（不含国家限制项目）。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (481, NULL, NULL, NULL, NULL, '特灵空调系统（中国）有限公司', 'Trane Air Conditioning Systems (China) Co., Ltd', NULL, '91320000607984640P', '美元', '5908.537万美元', '颜培荣', '1995-10-05 00:00:00', '有限责任公司(外国法人独资)', '研究和试验发展', '江苏省太仓市苏州东路88号', '研究、开发、设计、生产采暖、通风、大型中央空调产品、中小型商用及家用空调产品、空调控制及楼宇自动化控制产品及相关零部件，加工销售空调产品及其相关零部件；从事上述产品，以及食品和水产品的贮藏、保鲜、运输设备，运输用发电机组，冷藏、冷却、冷冻设备，冷藏展示陈列设备，制热设备，空气调节设备，节能设备，相关制冷和控制系统及其相关产品的批发、零售、佣金代理（拍卖除外）及进出口业务；提供检测、调试、工程、安装、培训、咨询、维修等售后服务和技术服务；上述产品的租赁服务；空调设备及空调系统相关的清洗及水处理服务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '500-999人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (482, NULL, NULL, NULL, NULL, '东莞市金唐水处理设备有限公司', 'Dongguan Jin Tang water treatment equipment Co., Ltd.', NULL, '91441900559122017U', '人民币', '5000万人民币', '宋惠敏', '2010-07-19 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广东省东莞市东城街道东城光明工业一路8号2栋102室', '生产、加工、研发、销售：工业用水处理设备，中水回用设备，家用净水设备，环保设备及材料，废水废气、垃圾渗滤液处理设备、粉尘及噪音处理设备，水处理专用化学品、化工原料及产品（除危险化学品）五金制品、仪表仪器、水泵及配件管道、阀门，电子设备配件。承接安装：环保工程、水电、无尘、机电工程，循环冷却水工程、工业管道维护清洗工程，锅炉工程，中央空调水处理工程，导热系统工程以及提供相关技术咨询、技术服务；货物进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (483, NULL, NULL, NULL, NULL, '菱王电梯有限公司', 'WINONE ELEVATOR COMPANY LIMITED', NULL, '91440600736162184J', '人民币', '20200万人民币', '管金伟', '2002-02-08 00:00:00', '有限责任公司(自然人投资或控股)', '通用设备制造业', '佛山市南海区狮山镇狮山科技工业园北园', '制造：乘客电梯、载货电梯、杂物电梯、自动扶梯、自动人行道；安装、维修：乘客电梯、载货电梯、杂物电梯、液压电梯、自动扶梯、自动人行道；改造：乘客电梯、载货电梯、杂物电梯、自动人行道（以上项目持有效的特种设备制造许可证及特种设备安装改造维修许可证经营）；制造、维修、安装、销售：五金机械、电梯配件、普通机械设备；销售：电梯；货物进出口、技术进出口（法律、行政法规禁止的项目除外；法律、行政法规限制的项目须取得许可后方可经营）。（依法须经批准的项目，经相关部门批准后方可开展经营活动。）(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '500-999人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (484, NULL, NULL, NULL, NULL, '广东广俊机械设备有限公司', NULL, NULL, '9144140268060742X6', '人民币', '1000万人民币', '钟梅云', '2008-10-16 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '梅州市江北环市路（宏源大厦6、7、8号）', '销售：机械设备、叉车及配件、汽车、摩托车零配件、机械电子设备；电子产品、货物堆放架，国内贸易；建筑工程机械与设备租赁；智能仓储装备销售；通用设备修理；智能家庭消费设备销售；智能机器人销售。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (485, NULL, NULL, NULL, NULL, '东莞达程电子有限公司', NULL, NULL, '91441900070211284C', '美元', '100万美元', '陈俊程', '2013-06-25 00:00:00', '有限责任公司(中外合资)', '批发业', '广东省东莞市松山湖园区科技二路10号1栋1单元604室', '从事精密轴承、各种主机专用轴承、三轴以上联动的数控机床、精密仪器；数控设备及其元部件、耗材；计算器软件产品、印制电路板产业类耗材的批发和进出口业务，从事精密轴承、各种主机专用轴承、三轴以上联动的数控机床、计算器软件产品的开发、设计，以上产品的售后服务和咨询服务，承接激光精密钻孔的加工业务，设备租赁业务。（以上项目不涉及外商投资准入特别管理措施）(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (486, NULL, NULL, NULL, NULL, '广州中望龙腾软件股份有限公司', 'ZWCAD Software Co.,Ltd', '中望软件', '91440101712408557U', '人民币', '6194.3857万人民币', '杜玉林', '1998-08-24 00:00:00', '股份有限公司(上市、自然人投资或控股)', '软件和信息技术服务业', '广州市天河区珠江西路15号32层自编01-08房', '软件开发;业务培训（不含教育培训、职业技能培训等需取得许可的培训）;教育咨询服务（不含涉许可审批的教育培训活动）;信息技术咨询服务;技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广;计算机软硬件及辅助设备零售;软件销售;非居住房地产租赁;货物进出口;技术进出口;第二类增值电信业务', '500-999人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (487, NULL, NULL, NULL, NULL, '深圳市鑫煜辉环保科技有限公司', NULL, NULL, '91440300MA5D8L0845', '人民币', '2000万人民币', '贺喜', '2016-03-16 00:00:00', '有限责任公司', '专用设备制造业', '深圳市宝安区福永街道凤凰社区广深路福永段109号锦灏大厦615', '一般经营项目是：废气处理设备、环保水处理设备、电镀设备、线路板设备、的技术开发、技术咨询、技术转让、技术服务、上门安装；环保工程的设计与安装。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (488, NULL, NULL, NULL, NULL, '江门必发精磨钢板有限公司', 'Jiangmen Bifa Precise Grinding Armor Plate Co.,Ltd.', NULL, '91440700708039146Q', '美元', '105万美元', '凌伟诚', '1998-08-13 00:00:00', '有限责任公司(港澳台法人独资)', '批发业', '江门市西区工业区', '生产加工销售印刷线路板及其产品、层压模板、定位系统，冲压模具、铸造及塑料机械设备及配件，塑料类和橡胶类制品，纸、石、布、木、玻璃、陶瓷等及其制品，幕墙工程配套产品，LED灯及灯条，模具板及其配件、机器设备及其配件、铸模机设备及其配件，合金钢及不锈钢棒材和板板材和贱金属类材料及其制品，及从事上述同类型商品的批发、零售，进出口及维修业务，品牌销售代理、佣金代理（拍卖除外）。（以上项目不涉及外商投资准入特别管理措施）(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (489, NULL, NULL, NULL, NULL, '苏州源卓光电科技有限公司', 'ADVANCED MICRO OPTICS.INC', NULL, '91320594MA1MX4QC3R', '人民币', '1824.3724万人民币', '张雷', '2016-10-12 00:00:00', '有限责任公司(自然人投资或控股)', '研究和试验发展', '苏州工业园区汀兰巷192号C5幢102室', '从事光机电系统、智能设备及配套系统软件、光电设备及配件、光学产品及配件、高速数据处理传输板、计算机软件及智能视觉系统、半导体芯片、印刷专用设备及配件、印刷专用材料及相关产品的销售及技术开发、技术转让、技术咨询和技术服务，并提供上述商品及技术的进出口业务；生产：机械设备及相关产品（限分支机构经营）。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (490, NULL, NULL, NULL, NULL, '深圳市旭日东自动化设备工程有限公司', 'Shenzhen XuRiDong Automechanism Engineering Co.,Ltd.', NULL, '91440300775598378Q', '人民币', '5000万人民币', '刘建云', '2005-06-23 00:00:00', '有限责任公司', '仪器仪表制造业', '深圳市龙华区观澜街道牛湖社区裕昌路95号1栋101', '一般经营项目是：自动化设备、电子产品、办公设备、机械设备、制冷设备、环保设备、口罩机械设备、安防设备、仪器设备、医护人员防护用品、劳动保护用、日用口罩(非医用)、计算机软硬件及外围设备的技术开发、销售；机电工程、环保工程、净化工程、管道工程、消防工程、安防工程、隔音工程、建筑工程、装饰工程、市政工程、噪音工程、景观工程的设计及施工；国内贸易，货物及技术进出口。，许可经营项目是：自动化设备、电子产品、办公设备、机械设备、制冷设备、环保设备、安防设备、口罩机械设备、仪器设备、医用口罩、二类医疗器械、劳动保护用品、医护人员防护用品、计算机软硬件及外围设备的生产。二类医疗器械的销售。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (491, NULL, NULL, NULL, NULL, '上海柏毅试验设备有限公司', 'Shanghai Bo Yi Test Equipment Co,Ltd', NULL, '913101145618904535', '人民币', '2050万人民币', '彭伶丽', '2010-09-07 00:00:00', '有限责任公司（自然人独资）', '批发业', '嘉定区安亭镇杨木桥支路8号6幢A区', '一般项目：机械设备及配件、供应用仪表及其他通用仪器（除计量器具）、制冷、空调设备、电子元器件的制造、销售，制冷、空调设备维修，机械设备安装、维修（除特种设备），从事机械设备、汽车检测设备技术领域内的技术开发、技术转让、技术咨询、技术服务，软件开发，软件销售。（除依法须经批准的项目外，凭营业执照依法自主开展经营活动）许可项目：货物进出口；技术进出口。（依法须经批准的项目，经相关部门批准后方可开展经营活动，具体经营项目以相关部门批准文件或许可证件为准）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (492, NULL, NULL, NULL, NULL, '深圳市东日电子有限公司', NULL, NULL, '914403007341811979', '人民币', '200万人民币', '陈林', '2002-01-28 00:00:00', '有限责任公司', '批发业', '深圳市龙岗区布吉街道宝丽路7号京宝综合楼三楼', '一般经营项目是：自动识别系统工程、设备、耗材、包装产品、软件的技术开发及其相关的技术咨询和技术服务；电脑外部设备、电子配件、电子元件、智能化电源、电子保健器械的购销（不含专营、专卖、专控商品）。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (493, NULL, NULL, NULL, NULL, '深圳基亚环境治理有限公司', NULL, NULL, '914403003593585787', '人民币', '550万人民币', '侯翠平', '2015-11-19 00:00:00', '有限责任公司(自然人独资)', '生态保护和环境治理业', '深圳市宝安区松岗街道沙浦社区沙二小区5栋102', '一般经营项目是：环保设备的销售与上门安装;环保工程设计、施工；水处理技术开发及技术服务。（法律、行政法规或者国务院决定禁止和规定在登记前须经批准的项目除外），许可经营项目是：污水处理.', '50-99人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (494, NULL, NULL, NULL, NULL, '深圳市荣福电子科技有限公司', NULL, NULL, '914403003194982857', '人民币', '500万人民币', '柏地', '2014-11-14 00:00:00', '有限责任公司(自然人独资)', '批发业', '深圳市福田区莲花街道景田南路瑞达苑13D', '一般经营项目是：国内贸易（不含专营、专卖、专控商品）；经营进出口业务（不含限制项目）；电子产品的技术开发、维修。（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营），许可经营项目是：', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (495, NULL, NULL, NULL, NULL, '深圳捷讯智能系统有限公司', NULL, NULL, '91440300360263912G', '人民币', '3000万人民币', '李志刚', '2016-03-04 00:00:00', '有限责任公司', '软件和信息技术服务业', '深圳市宝安区沙井街道后亭茅洲山工业园工业大厦全至科技创新园科创大厦9层C、9层D', '一般经营项目是：计算机编程；计算机软件设计；计算机管理软件、工业控制系统、工业机器人、智能装备技术开发、销售；计算机及工业自动系统集成；市场营销策划。（法律、行政法规或者国务院决定禁止和规定在登记前须经批准的项目除外） ，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (496, NULL, NULL, NULL, NULL, '江西天意环保工程有限公司', NULL, NULL, '91360125MA364U7Q9G', '人民币', '500万人民币', '杨烨', '2017-07-27 00:00:00', '有限责任公司(自然人投资或控股)', '科技推广和应用服务业', '江西省南昌市南昌经济技术开发区瑞香路900号唐人科技产业园项目2#厂房第2层207室', '许可项目：建设工程设计（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：环境保护监测，物联网技术服务，信息系统集成服务，数据处理和存储支持服务，网络设备销售，电子产品销售，通讯设备销售，仪器仪表销售，环境监测专用仪器仪表销售，终端计量设备销售，软件开发，软件销售，环保咨询服务，环境保护专用设备销售，技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广，环境监测专用仪器仪表制造，工业自动控制系统装置制造，工业自动控制系统装置销售，环境保护专用设备制造，通用设备修理，专用设备修理，电子、机械设备维护（不含特种设备），食品销售（仅销售预包装食品）（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (497, NULL, NULL, NULL, NULL, '深圳市贝嘉技术有限公司', 'Shenzhen Beijia Technology Co.,Ltd.', NULL, '9144030078923011X3', '人民币', '500万人民币', '黄彬强', '2006-05-26 00:00:00', '有限责任公司', '批发业', '深圳市福田区园岭街道华林社区八卦路29号八卦岭工业区513栋东302-304', '一般经营项目是：显微镜、工具显微镜、数码摄像系统、精密仪器的研发，销售和技术服务；电脑及配件的技术开发与销售、上门安装（以上不含限制项目）；软件开发与销售；信息技术咨询；国内贸易；货物和技术进出口。（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (498, NULL, NULL, NULL, NULL, '珠海宝丰堂电子科技有限公司', 'BOFFOTTO  LIMITED', NULL, '91440400787961947Q', '港元', '1800万港元', '赵芝强', '2006-05-17 00:00:00', '有限责任公司(港澳台自然人独资)', '计算机、通信和其他电子设备制造业', '珠海市金湾区红旗镇东成路118号2号厂房一至三层之一', '研发、加工、生产、销售及租赁自产的等离子设备、电子产品、电子元器件，相关技术开发；维修等离子设备及相关零配件；电子行业生产设备及相关零配件、耗材、铜箔的批发、零售及进出口业务（不设店铺，涉及配额许可证管理、专项规定管理的商品按国家有关规定办理）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (499, NULL, NULL, NULL, NULL, '东莞市高升电子精密科技有限公司', NULL, NULL, '91441900065144507M', '人民币', '100万人民币', '计娟珍', '2013-04-01 00:00:00', '有限责任公司(自然人投资或控股)', '科技推广和应用服务业', '广东省东莞市大朗镇松柏朗新园一路6号2栋101室', '研发、生产、维修、销售:电子精密仪器、仪表、通用机械设备、电子制品、试验室设备;检测技术的技术开发、技术服务、技术咨询、技术转让;销售:检测设备、通讯设备及相关产品、机电设备、机械设备、电器设备、五金交电、仪器仪表、环保材料、环境试验箱、轴承配件、电子产品、电动工具、计算机、软件及辅助设备(除计算机信息系统安全专用产品) ;货物或技术进出口(国家禁止或涉及行政审批的货物和技术进出口除外)。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (500, NULL, NULL, NULL, NULL, '深圳市凯丰德科学实验室设备有限公司', NULL, NULL, '91440300791724530L', '人民币', '1008万人民币', '刘群芳', '2006-07-21 00:00:00', '有限责任公司（法人独资）', '研究和试验发展', '深圳市南山区西丽街道西丽社区文苑街35号西丽新源工业厂区3栋(聚创金谷创意园C栋)306', '一般经营项目是：实验室系统工程规划、设计及施工，实验室整体建设及相关设备的信息咨询，实验室家具及基础配套设备、实验室仪器仪表及耗材的设计及销售，技术用房的整体工程设计和施工，实验室通风净化系统、实验室变风量控制系统、实验室自控系统、特种气体配送系统、废水废气净化处理系统的研发、设计、上门安装及销售，净化工程系统、空调系统及设备的设计、技术开发、调试维护及销售，实验室装修工程、净化工程的设计与施工，机电设备的销售和上门安装，实验室系统工作软件的技术研发、销售及上门维修，经营进出口业务。化学试剂、化工产品销售及批发（不含危险化学品及限制项目）。，许可经营项目是：加工、生产实验室设备、家具、通风净化设备（限分支机构经营）。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (501, NULL, NULL, NULL, NULL, '昆山济展金属科技有限公司', 'Kunshan Jizhan Metal Technology Co.,Ltd.', NULL, '91320583796541485R', '美元', '1210万美元', '王清汗', '2007-01-23 00:00:00', '有限责任公司(外国法人独资)', '有色金属冶炼和压延加工业', '江苏省昆山市张浦镇南港沪光路', '生产有色金属复合合金材料，不锈钢、铍铜、铝等新型材料的精压延加工；销售自产产品。从事与本企业生产同类产品及各类刀具、厨房生活用具的商业批发及进出口业务。（不涉及国营贸易管理商品，涉及配额、许可证管理商品的，按国家有关规定办理申请）。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '50-99人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (502, NULL, NULL, NULL, NULL, '东莞市中旺精密仪器有限公司', 'Sinowon Innovation Metrology Manufacture Limited', NULL, '914419005573288636', '人民币', '300万人民币', '郑春平', '2010-07-05 00:00:00', '有限责任公司(自然人投资或控股)', '仪器仪表制造业', '东莞市南城街道白马社区先锋一路2号凯崧科技园A1栋', '研发、产销：自动化设备、测量仪器设备、金属及非金属测试用硬度计、金相制样设备、金相分析设备、精密光学仪器、机电设备及其配件；货物及技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (503, NULL, NULL, NULL, NULL, '东莞市寮步智鸿自动门经营部', NULL, NULL, '92441900L42628042H', '人民币', '3人民币', '林新结', '2011-08-23 00:00:00', '个体工商户', '零售业', '东莞市寮步镇良边村石大路13号', '销售、安装：自动门、门禁设备、监控设备、五金配件、劳保用品。', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (504, NULL, NULL, NULL, NULL, '赣州财门智能科技有限公司', NULL, NULL, '91360703MA368GAQ1B', '人民币', '100万人民币', '肖彬', '2017-09-01 00:00:00', '有限责任公司(自然人独资)', '软件和信息技术服务业', '江西省赣州市赣州经济技术开发区赞贤路黄金康居2栋302室', '计算机软硬件、电子产品、网络科技领域内的技术开发、技术服务、技术咨询、技术转让；门控设备、工业自动化设备、五金配件、家用电器的批发、零售；旗杆、道闸、伸缩门、护栏的加工、销售、维修；门禁系统、安防系统、停车场地设施工程设计、安装；建筑智能化系统设计、安装。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (505, NULL, NULL, NULL, NULL, '东莞市鹏利节能设备有限公司', 'DongGuan PengLi Energy -saving Equipment Co.,Ltd', NULL, '91441900096569129H', '人民币', '2000万人民币', '江秀青', '2014-04-02 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市横沥镇田坑村五二队食堂对面', '产销：环保节能设备、丝印机械、网印机械、线路板PCB印刷设备、制版设备、烘干设备、辅助材料、集成电路专用设备；货物进出口、技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (506, NULL, NULL, NULL, NULL, '东莞市吉宏五金科技有限公司', NULL, NULL, '91441900553688079R', '人民币', '1000万人民币', '许兴祥', '2010-04-30 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市长安镇涌头社区宏业北路10号C仓B区', '研发、产销：五金制品、电子设备；销售：塑胶制品、电子产品的软硬件及技术转让。', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (507, NULL, NULL, NULL, NULL, '赣州安兴机电设备有限公司', NULL, NULL, '91360702MA35F320X3', '人民币', '100万人民币', '孙勇', '2015-09-29 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市章贡区沙河镇赣州金属产业商贸物流城17幢15#店面', '叉车及叉车配件、发电机组、工矿设备、润滑油、电器开关、配电柜、橡胶制品销售；叉车维修（依法须经批准的项目，经相关部门批准后方可开展经营活动）****', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (508, NULL, NULL, NULL, NULL, '广东台冷空调制造有限公司', NULL, NULL, '91440605MA4UKGTH8C', '人民币', '1000万人民币', '王传周', '2015-12-09 00:00:00', '有限责任公司(自然人投资或控股)', '通用设备制造业', '佛山市南海区丹灶镇塱心村樵丹路西地段江润潮厂房之五（住所申报）', '安装、加工、产销：空调制冷设备及配件，冷冻设备，五金制品；设计、销售：各种空调机组，各种低环境温度空气源热泵组，各种环保空气处理机组，通风设备；调试和售后服务。（依法须经批准的项目，经相关部门批准后方可开展经营活动。）(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (509, NULL, NULL, NULL, NULL, '深圳麦逊电子有限公司', 'Shenzhen Mason Electronics Co.,Ltd.', NULL, '91440300715240331A', '人民币', '2580万人民币', '杨朝辉', '1999-11-17 00:00:00', '有限责任公司（法人独资）', '计算机、通信和其他电子设备制造业', '深圳市宝安区福海街道和平社区重庆路12号智造中心园3栋厂房602三栋3层整层、三栋1、6层部分场地', '一般经营项目是：，许可经营项目是：生产经营用于电路板和液晶片的检测机、工业自动化设备及相关测试夹具，以及从事计算机辅助软件、检测机软件、单片机软件及电子工模具的开发业务。销售自主开发的软件及生产的产品，从事货物的进出口业务（不含进口分销）。提供检测机售后维修、保养服务（以上仅限上门服务）以及电路板的测试服务；自有房产租赁（苏州灵岩街16号11号-1厂房第四层）及普通货运（仅限自货自运）。电路板和液晶片检测机的批发、进出口、佣金代理（不含拍卖）及相关配套业务（不涉及国营贸易管理商品，涉及配额、许可证管理及其它专项规定管理的商品，按照国家有关规定办理申请），机械设备租赁。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (510, NULL, NULL, NULL, NULL, '九江历源整流设备有限公司', NULL, NULL, '91360421784127666T', '人民币', '1005万人民币', '黄瑞炉', '2006-02-09 00:00:00', '有限责任公司(自然人投资或控股)', '仪器仪表制造业', '江西省九江市柴桑区沙城工业园', '电解、电化学、冶炼、电镀、氧化、着色、电泳整流器制造、安装、销售、维修及元件销售；高频开关电源、SCR可控硅电源、脉冲电源制造、安装、销售、维修及元件的销售；自动化控制系统及自动化设备制造、安装、销售、维修及元件的销售（国家有专项规定的除外）***', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (511, NULL, NULL, NULL, NULL, '广东博海计量科技有限公司', NULL, NULL, '91440101MA5AX4Q52F', '人民币', '3000万人民币', '王国明', '2018-06-08 00:00:00', '其他有限责任公司', '仪器仪表制造业', '博罗县石湾镇科技北二路南侧地段环球通高新产业园D栋', '衡器制造;五金配件制造、加工;机械配件零售;计量器具零售;计量技术咨询服务;光电子器件及其他电子器件制造;电子产品零售;机电设备安装服务;工业自动控制系统装置制造;软件零售;软件开发;五金零售;货物进出口（专营专控商品除外）;技术进出口;(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (512, NULL, NULL, NULL, NULL, '海鸿电气有限公司', 'Haihong Electric Co., Ltd.', NULL, '91440783707548387R', '人民币', '10700万人民币', '许凯旋', '1998-02-19 00:00:00', '有限责任公司(自然人投资或控股)', '科技推广和应用服务业', '开平市翠山湖新区环翠西路3号', '电力行业高效节能技术研发；变压器、整流器和电感器制造；电气设备销售；配电开关控制设备研发；配电开关控制设备制造；配电开关控制设备销售；软件开发；技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广；智能输配电及控制设备销售；机械设备研发；机械电气设备制造；电气机械设备销售；电力设施器材制造；电工器材制造；电工器材销售；通用设备制造（不含特种设备制造）；电工机械专用设备制造；通用零部件制造；机械零件、零部件加工；机械零件、零部件销售；通用设备修理；专用设备修理；电力设施器材销售；智能仪器仪表制造；人工智能公共数据平台；智能仪器仪表销售；智能控制系统集成；信息系统集成服务；工业设计服务；工程技术服务（规划管理、勘察、设计、监理除外）；节能管理服务；运行效能评估服务；电子、机械设备维护（不含特种设备）；在线能源监测技术研发；机械设备租赁；销售代理；非居住房地产租赁；合同能源管理；电力设施承装、承修、承试；技术进出口；货物进出口；检验检测服务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '500-999人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (513, NULL, NULL, NULL, NULL, '广东正业科技股份有限公司', 'Guangdong Zhengye Technology Co.,Ltd.', '正业科技', '91441900617994922G', '人民币', '37384.5506万人民币', '徐地华', '1997-11-14 00:00:00', '其他股份有限公司(上市)', '仪器仪表制造业', '广东省东莞市松山湖园区南园路6号', '研发、生产、加工、销售：机器人、电子仪器设备及其软件、电子材料、日用口罩（非医用）、医疗器械（第二类医疗器械）；生产线装备系统集成；设备租赁；货物的进出口业务；物业租赁；物业管理。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '1000-4999人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (514, NULL, NULL, NULL, NULL, '广州市一鼎机械设备有限公司', NULL, NULL, '91440101MA5AND3800', '人民币', '100万人民币', '金可波', '2017-12-25 00:00:00', '有限责任公司(自然人投资或控股)', '废弃资源综合利用业', '广东从化经济开发区高技术产业园丰盈二巷12号之4（自编1号）', '生产性废旧金属回收;再生资源销售;再生物资回收与批发;国内贸易代理;再生资源回收（除生产性废旧金属）;再生资源加工;普通机械设备安装服务;', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (515, NULL, NULL, NULL, NULL, '深圳市方辉鹏机电设备有限公司', NULL, NULL, '914403000812694656', '人民币', '50万人民币', '刘小梅', '2013-10-24 00:00:00', '有限责任公司(自然人独资)', '批发业', '深圳市南山区南头街道马家龙社区大新路198号创新大厦B座1901AD7', '一般经营项目是：机电设备的销售及上门安装与上门维修；办公用品、日用品的销售；建筑装修装饰工程、水利水电工程的施工；国内贸易，货物及技术进出口。，许可经营项目是：', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (516, NULL, NULL, NULL, NULL, '深圳市锦龙科技有限公司', 'SHENZHEN GALLON TECHNOLOGY CO.,LTD.', NULL, '914403007663841839', '人民币', '200万人民币', '徐向西', '2004-09-14 00:00:00', '有限责任公司', '软件和信息技术服务业', '深圳市宝安区西乡街道固戍社区下围园经发智造园B栋301、B栋1-3层', '一般经营项目是：测试机软件技术的开发与销售；测试夹具及软件、周边材料、辅料的技术开发与销售（不含生产、加工）;视觉检测与视觉定位自动化设备及系统、机器人及系统的研发及销售;非标精密自动化的研发及销售;国内商业、物资供销业;经营进出口业务测试机的生产、上门维修；非标精密自动化设备、视觉自动检测设备、机器人的上门维修。(法律、行政法规、国务院决定规定在登记前须经批准的项目除外），许可经营项目是：测试机的生产；视觉检测与视觉定位自动化设备及系统、机器人及系统的生产;非标精密自动化的生产。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (517, NULL, NULL, NULL, NULL, '东莞市深镀环保科技有限公司', NULL, NULL, '91441900560824374L', '人民币', '100万人民币', '罗艳萍', '2010-08-18 00:00:00', '有限责任公司(自然人投资或控股)', '研究和试验发展', '东莞市万江区新村社区汾新沿河路3号', '研发、设计、产销：环保设备、节能减排设备、机电设备及配件、印制电路板设备及配件；机电设备安装工程、环境污染防治专用设备安装工程及设备维修；环保工程设计及施工；废气处理工程设计、施工；环保技术研发及技术转让。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (518, NULL, NULL, NULL, NULL, '深圳市微印科技有限公司', NULL, NULL, '91440300MA5ERU34X8', '人民币', '500万人民币', '谢志航', '2017-10-17 00:00:00', '有限责任公司', '计算机、通信和其他电子设备制造业', '深圳市宝安区西乡街道兴业路3012号老兵大厦西座二楼', '一般经营项目是：数字化高速工业喷印设备、高精密图形检测设备及零部件的研发、销售、租赁和技术服务；自控软件的研发、销售和技术咨询、技术服务；信息系统设计、集成、上门维护；经营进出口业务。（法律、行政法规或者国务院决定禁止和规定在登记前须经批准的项目除外），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (519, NULL, NULL, NULL, NULL, '广州学视广告有限公司', NULL, NULL, '91440106065807454M', '人民币', '500万人民币', '丘胜海', '2013-04-07 00:00:00', '有限责任公司(自然人投资或控股)', '商务服务业', '广州市天河区车陂西路212号之一406室-06（仅限办公）', '广告业;企业形象策划服务;市场调研服务;策划创意服务;市场营销策划服务;企业管理咨询服务;', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (520, NULL, NULL, NULL, NULL, 'KraftPowercon Hong Kong Limited', NULL, NULL, NULL, '人民币', NULL, NULL, '1994-11-24 00:00:00', NULL, NULL, NULL, NULL, NULL, '仍注册', 0);
INSERT INTO `sys_enterprise` VALUES (521, NULL, NULL, NULL, NULL, '深圳市龙德兴业科技有限公司', 'Shenzhen Longde Industrial Technology Co.,Ltd', NULL, '91440300MA5DAJFJ5Q', '人民币', '500万人民币', '郭套龙', '2016-04-13 00:00:00', '有限责任公司', '批发业', '深圳市宝安区松岗街道东方社区广深路松岗段135号广深路松岗段135-3', '一般经营项目是：节能环保净化设备及耗材、工业管道设备工程服务技术、机械电气设备、技术维修及咨询服务、五金电子产品、化工产品（不含易燃、易爆、易制毒、危险化学品及成品油）的销售；经营电子商务（涉及前置性行政许可的，须取得前置性行政许可文件后方可经营）；国内贸易，货物及技术进出口。(法律、行政法规、国务院决定规定在登记前须经批准的项目除外；涉及行政许可的，须取得行政许可文件后方可经营，许可经营项目是：无', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (522, NULL, NULL, NULL, NULL, '中山市华智达企业管理咨询有限公司', NULL, NULL, '9144200005682878XY', '人民币', '300万人民币', '吴吞', '2012-11-07 00:00:00', '有限责任公司(自然人投资或控股)', '商务服务业', '中山市西区富华道32号天悦广场商业办公楼803室之一', '企业管理咨询，环境信息咨询，产品检测，环境监测；计量仪器及设备技术服务，环境评估，节能技术服务及咨询；软件服务，安全生产标准化咨询、实验室筹建，实验室管理服务。（依法须经批准的项目，经相关部门批准后方可开展经营活动。）(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (523, NULL, NULL, NULL, NULL, '亚亚电路板设备（深圳）有限公司', 'Ya ya dian lu she bei shen zheng limited', NULL, '91440300796631704P', '美元', '8.007万美元', '陈礼煜', '2007-03-01 00:00:00', '有限责任公司(外国法人独资)', '批发业', '深圳市宝安区新安街道兴东社区71区宗泰绿凯智荟园102', '一般经营项目是：电路板检测设备、计算机、计算机周边设备及相关零配件的批发、上门安装、进出口、佣金代理（拍卖除外）及相关的售后服务、技术咨询服务（涉及配额许可证管理、专项规定管理的商品按国家有关规定办理）。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (524, NULL, NULL, NULL, NULL, '龙南县财富苗木场', NULL, NULL, '92360727MA376LT54H', '人民币', '20万人民币', '曾宪财', '2008-08-27 00:00:00', '个体工商户', '农业', '赣州市龙南市桃江乡清源村上围', '花卉苗木种植及销售（依法须经批准的项目，经相关部门批准后方可开展经营活动）', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (525, NULL, NULL, NULL, NULL, '昆山盛晶软件科技有限公司', 'KunShan ESM Software CO.,LTD', NULL, '913205835677679158', '人民币', '200万人民币', '汪佑宏', '2011-01-05 00:00:00', '有限责任公司(自然人独资)', '批发业', '周市镇民管路25号', '软件研发、销售；线路板耗材及设备、电子产品、五金制品、机电设备、计算机及周边产品、橡塑制品、包装材料、办公文具及耗材、劳保用品的销售；线路板设计；货物及技术的进出口业务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (526, NULL, NULL, NULL, NULL, '河源市台衡顶尖称重设备有限公司', NULL, NULL, '914416023042403370', '人民币', '1000万人民币', '胡淑娟', '2014-07-23 00:00:00', '有限责任公司(自然人独资)', '批发业', '河源市江东新区临江工业园园岭大道与工业三路交汇处往南一百米河源恒泰科技发展有限公司办公楼一楼（东）', '称重设备、衡器、地磅、电子汽车衡销售及租赁；仪器仪表、电子配件销售及服务；计算机软硬件、电子称重系统集成。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (527, NULL, NULL, NULL, NULL, '苏州微影激光技术有限公司', 'Suzhou Microfilm Laser Technology Co., Ltd.', NULL, '91320582586663601R', '人民币', '4800万人民币', '蔡志国', '2011-11-29 00:00:00', '有限责任公司（自然人投资或控股的法人独资）', '研究和试验发展', '苏州高新区火炬路85号', '激光、光学、光电设备的研发、组装、测试、销售和相关技术服务；软件开发与销售；自营和代理各类商品及技术的进出口业务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '50-99人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (528, NULL, NULL, NULL, NULL, '赣州宸锐建设工程有限责任公司', NULL, NULL, '91360727MA38KRE52M', '人民币', '300万人民币', '月华明', '2019-05-10 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '江西省赣州市龙南市龙南镇龙翔广场南侧新世界购物公园C1-207', '工业与民用建筑工程、机电设备安装工程、装饰装修工程、市政工程、水利水电工程、园林绿化工程、地基基础工程、钢结构工程、电力工程、模板脚手架工程、消防工程、防腐保温工程、安防工程、金属门窗工程、建筑智能化工程施工；建筑劳务分包。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (529, NULL, NULL, NULL, NULL, '东莞市信远无纺布有限公司', 'Dong Guan City Xin Yuan Non-woven Co.,Ltd', NULL, '91441900742983026D', '人民币', '2000万人民币', '谢铁冬', '2002-08-19 00:00:00', '有限责任公司(自然人投资或控股)', '纺织业', '东莞市寮步镇西溪村', '研发、生产：高分子纤维材料、非织造布、日用口罩、防护服（非医用）；第二类医疗器械（医用卫生材料、医用口罩、防护服）、农业环境防护类隔离复合材料、无纺布超声波粘合设备（非医用）；货物或技术进出口（国家禁止或涉及行政审批的货物进出口除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (530, NULL, NULL, NULL, NULL, '赣州鑫昊机电有限公司', NULL, NULL, '913607826724087977', '人民币', '200万人民币', '谭礼文', '2008-03-10 00:00:00', '有限责任公司(自然人独资)', '批发业', '江西省赣州市南康区东山街道办事处文峰大道文峰花园8栋107号', '机电设备安装工程；机电设备及零配件、五金、电器、电器元件、润滑油（危化品除外）、润滑脂批发、零售；机电设备安装、保养、租赁、维修服务；管道安装、维修服务；机电设备节能改造、技术咨询及技术服务（依法须经批准的项目,经相关部门批准后方可开展经营活动）※', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (531, NULL, NULL, NULL, NULL, '广东龙天智能仪器股份有限公司', 'Guangdong Longtian Smart Instrument Co., Ltd.', NULL, '91441900MA4UWNU854', '人民币', '1000万人民币', '李熙龙', '2016-10-21 00:00:00', '股份有限公司(非上市、自然人投资或控股)', '专用设备制造业', '广东省东莞市桥头镇雅堤南一路8号', '研发、产销：影像测量仪、视觉测量设备、坐标测量机、检测仪器设备、机电设备、机械设备、自动化设备、智能机器、电子产品及其配件、五金制品及其配件；电子专业领域内的技术开发、技术服务、计算机软硬件研发；货物进出口、技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (532, NULL, NULL, NULL, NULL, '杭州海康智能科技有限公司', 'Hangzhou Hikrobot Intelligent Technology Co., Ltd.', NULL, '91330108MA28W4TE2Y', '人民币', '10000万人民币', '贾永华', '2017-07-19 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '科技推广和应用服务业', '浙江省杭州市滨江区丹枫路399号2号楼B楼305室', '许可项目：货物进出口；技术进出口(依法须经批准的项目，经相关部门批准后方可开展经营活动，具体经营项目以审批结果为准)。一般项目：工业机器人制造；工业机器人销售；服务消费机器人制造；服务消费机器人销售；特殊作业机器人制造；智能机器人的研发；智能机器人销售；智能无人飞行器制造；智能无人飞行器销售；工业控制计算机及系统制造；工业控制计算机及系统销售；照相机及器材制造；照相机及器材销售；光学仪器制造；光学仪器销售；物联网设备制造；物联网设备销售；通信设备制造；通讯设备销售；通讯设备修理；计算机软硬件及外围设备制造；计算机软硬件及辅助设备批发；技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广；软件开发；计算机系统服务；信息系统集成服务；机械设备租赁；电子、机械设备维护（不含特种设备）(除依法须经批准的项目外，凭营业执照依法自主开展经营活动)。', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (533, NULL, NULL, NULL, NULL, '广东特凯电子科技有限公司', 'Guangdong Tekai Technology Co., Ltd.', NULL, '91441900081074473T', '人民币', '1000万人民币', '顾照义', '2013-10-12 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市常平镇九江水村中信路98号', '研发、生产、加工、销售：电子产品、五金制品（不含电镀）、数控机床、检测设备、塑料加工专用设备、工业自动化设备；开发、销售：工业自动化控制软件；货物进出口、技术进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (534, NULL, NULL, NULL, NULL, '深圳普分科技有限公司', 'Shenzhen census Division Technology Co.Ltd.', NULL, '91440300559889437C', '人民币', '106万人民币', '岳炎国', '2010-08-10 00:00:00', '有限责任公司', '批发业', '深圳市宝安区宝民二路亚尼斯大厦A411室', '一般经营项目是：电子产品、电子元器件、电子数码产品销售；实验仪器仪表、实验室设备、实验台、实验耗材、通风柜、试验家具、化工产品、办公家具的技术开发、设计与销售；国内贸易、货物及技术进出口。（法律、行政法规、国务院决定规定在登记前须经批准的项目除外），许可经营项目是：仪器仪表修理；化学试剂销售（不含危险化学品）.', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (535, NULL, NULL, NULL, NULL, '东莞市硕鼎工业自动化设备有限公司', NULL, NULL, '91441900MA4UHBHG3Q', '人民币', '200万人民币', '胡斌', '2015-09-13 00:00:00', '有限责任公司(自然人独资)', '批发业', '东莞市樟木头镇柏地社区东城路二巷8号一楼', '研发、生产：工业自动化设备、电子器件、工业制冷空调；环保工程、机电工程、钢结构工程、防腐保温工程、照明工程、建筑装饰工程，安防工程、消防工程、废气抽风工程施工；电路板机械设备安装维护；承装、承修、承试供电设施和受电设施；研发、销售：线路板自动化设备、光电设备、医疗设备、气动产品、机电设备、机械设备、五金交电、办公设备、仪器仪表、金属材料及制品、塑胶材料及制品、医疗设备、电气设备及配件、电子产品、通讯器材、超声波清洗机、安防器材、消防器材、线路板设备、线路板、五金制品及其配件、电子产品及其配件；工控自动化设备销售及技术服务；工业机器人研发、销售及技术服务；安装线路板设备；仓储服务（不含危险品）；国内货运代理；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）；光电技术开发、技术转让、技术咨询。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (536, NULL, NULL, NULL, NULL, '东莞市展威电子科技有限公司', NULL, NULL, '91441900669868952D', '人民币', '50万人民币', '蒋国光', '2007-12-25 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广东省东莞市松山湖园区工业西路12号1栋234室、235室', '研发、生产、销售：半导体切割设备、半导体封装设备、精密切割设备、封装设备、检测设备、精密自动化设备、数控机械、自动化系统软件、电路板设备；电路板加工；电路板移植；智能电子产品、半导体封装新材料、光学膜材、光学胶、特种高温环氧胶的技术咨询和技术服务；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (537, NULL, NULL, NULL, NULL, '东莞市鹏轩机电科技有限公司', NULL, NULL, '914419005556250981', '人民币', '1000万人民币', '胡建军', '2010-05-20 00:00:00', '有限责任公司(自然人投资或控股)', '通用设备制造业', '东莞市横沥镇隔坑忠亚科技园A03栋1楼', '研发、加工、销售：机电设备、机电设备配件、机器设备；自动化控制系统软件的技术开发、设计和销售。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (538, NULL, NULL, NULL, NULL, '福建政庆建设有限公司', NULL, NULL, '91350823096757234X', '人民币', '1000万人民币', '刘满连', '2014-04-11 00:00:00', '有限责任公司(自然人投资或控股)', '房屋建筑业', '上杭县临城镇金山路城东新村112号A1-01幢601室', '房屋建筑工程、市政公用工程、钢结构工程、城市及道路照明工程、地基与基础工程、建筑装修装饰工程、园林古建筑工程、消防工程、水利水电工程、公路工程、公路路面工程、公路路基工程、环保工程、电力工程、送变电工程、体育场地设施工程、水利水电机电设备安装工程的施工；园林绿化工程施工；电力工程施工。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (539, NULL, NULL, NULL, NULL, '兴国县佳安防雷工程有限公司', NULL, NULL, '91360732598875505P', '人民币', '600万人民币', '王富扬', '2012-07-12 00:00:00', '有限责任公司(自然人独资)', '专业技术服务业', '江西省赣州市兴国县潋江镇潋江大道', '防雷工程、房屋建筑工程、市政公用工程、土石方工程、园林绿化工程、消防设施工程、建筑装修装饰工程设计、施工；防雷技术信息咨询服务；安防设备、防雷设备、水电材料批发、零售；工程机械设备租赁。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (540, NULL, NULL, NULL, NULL, '赣州确誉达企业管理顾问有限公司', NULL, NULL, '91360782071849001R', '人民币', '50万人民币', '陈新兰', '2013-07-12 00:00:00', '有限责任公司(自然人投资或控股)', '商务服务业', '江西省赣州市南康区东山街道办事处南水新区沿江路国际公馆H栋601', '企业认证咨询服务；知识产权、两化融合管理体系、安全生产标准化、贯标咨询服务（不含自营培训及教育业务）；软件开发与支持服务；企业形象策划；企业管理咨询；环境评估服务、环保产业咨询服务；农业项目申报代理；广告设计（依法须经批准的项目,经相关部门批准后方可开展经营活动）※', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (541, NULL, NULL, NULL, NULL, '中山市川松智能设备有限公司', NULL, NULL, '91442000MA51EUYD8C', '人民币', '300万人民币', '黎达营', '2018-03-21 00:00:00', '有限责任公司(自然人投资或控股)', '专用设备制造业', '中山市东升镇龙成路1号B12幢', '研发、设计、生产：隧道炉、精密自动化干燥设备；UV半自动及全自动生产线；以及印刷设备的相关智能自动化设备；销售本公司所生产的产品并提供相关技术和售后服务(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (542, NULL, NULL, NULL, NULL, '南昌金轩知识产权代理有限公司', NULL, NULL, '91360103MA35TM0J07', '人民币', '100万人民币', '夏军', '2017-03-24 00:00:00', '有限责任公司(自然人投资或控股)', '科技推广和应用服务业', '江西省南昌市西湖区银环路298号万豪城3#写字楼-1906室', '专利代理、商标代理；翻译服务；企业管理咨询；计算机软件的技术服务（以上项目依法须经批准的项目，经相关部门批准后方可开展经营活动）**', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (543, NULL, NULL, NULL, NULL, '深圳市馨园城装饰工程有限公司', NULL, NULL, '91440300093991893P', '人民币', '120万人民币', '王仕青', '2014-03-20 00:00:00', '有限责任公司', '建筑装饰、装修和其他建筑业', '深圳市宝安区西乡街道钟屋三路140号', '一般经营项目是：室内外装饰装修工程的施工（取得行政主管部门颁发的资质证书方可经营）。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (544, NULL, NULL, NULL, NULL, '江西旺发建设有限公司', NULL, NULL, '91360983591817046D', '人民币', '600万人民币', '陈勇', '2012-03-14 00:00:00', '有限责任公司(自然人投资或控股)', '房屋建筑业', '江西省赣州市安远县欣山镇日豪脐橙市场19-201号', '建筑工程施工总承包、专业承包。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (545, NULL, NULL, NULL, NULL, '海通恒信国际融资租赁股份有限公司', NULL, '海通恒信', '91310000764705772U', '人民币', '823530万人民币', '丁学清', '2004-07-09 00:00:00', '股份有限公司(台港澳与境内合资、上市)', '租赁业', '上海市黄浦区中山南路599号', '融资租赁业务；租赁业务；向国内外购买租赁财产；租赁财产的残值处理及维修；租赁交易咨询和担保；兼营与主营业务有关的商业保理业务。【依法须经批准的项目，经相关部门批准后方可开展经营活动】', '1000-4999人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (546, NULL, NULL, NULL, NULL, '东莞市群胜五金电子科技有限公司', NULL, NULL, '91441900MA4UHT7J3E', '人民币', '200万人民币', '张娟峰', '2015-09-30 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市石碣镇四甲村叶屋基庆丰西路84号一楼1-2', '研发、加工、销售：五金塑胶零部件、电子材料、自动化设备、塑胶、五金模具。', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (547, NULL, NULL, NULL, NULL, '昆山卓远环保科技有限公司', NULL, NULL, '91320583MA1N3J3U2F', '人民币', '2000万人民币', '董黎平', '2016-12-14 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '昆山市千灯镇千石商业中心5号', '环保科技领域内的技术开发、技术咨询、技术转让、技术服务；环境检测服务；冶金化工技术咨询服务；环保工程的施工；环保设备、化工产品、机电产品、五金产品、建筑材料、金属材料、塑料制品、仪器仪表的销售；货物及技术的进出口业务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：终端测试设备销售；电子元器件与机电组件设备销售；电气机械设备销售；机械设备销售；气体、液体分离及纯净设备销售；电子专用设备销售；冶金专用设备销售；半导体器件专用设备销售；安防设备销售；特种设备销售；安全咨询服务；消防器材销售（除依法须经批准的项目外，凭营业执照依法自主开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (548, NULL, NULL, NULL, NULL, '东莞市骏宏叉车有限公司', NULL, NULL, '91441900MA51Y11P6X', '人民币', '100万人民币', '蒋竹连', '2018-07-03 00:00:00', '有限责任公司(自然人独资)', '批发业', '东莞市石碣镇刘屋村科技中路268号一楼', '销售：叉车整车、叉车配件；叉车租赁、二手叉车经销；代办机动车业务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (549, NULL, NULL, NULL, NULL, '东莞市新际通讯设备有限公司', NULL, NULL, '914419000766679607', '人民币', '100万人民币', '阳小燕', '2013-08-12 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市南城区元美路东侧商业中心D座606号', '销售、维修：通讯设备、办公用品、电子产品、通用机械设备、摄影器材。', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (550, NULL, NULL, NULL, NULL, '龙南县工程建设有限责任公司', NULL, NULL, '91360727160563726X', '人民币', '604万人民币', '肖志忠', '1993-12-01 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '房屋建筑业', '江西省赣州市龙南市龙翔大道建设局院内', '房屋建筑工程、市政公用工程、建筑装修装饰工程、建筑幕墙工程、消防设施工程、土石方工程、管道工程、地基基础工程、城市及道路照明工程、钢结构工程、园林绿化工程、建筑防水工程、机电设备安装工程勘察、设计、施工、安装；建筑建材、建筑机械配件、水泥预制品销售；机械设备租赁；建筑劳务分包。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (552, NULL, NULL, NULL, NULL, '上海上贾电子有限公司', NULL, NULL, '913101123243167302', '人民币', '100万人民币', '郑皎妍', '2015-01-04 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '上海市闵行区庙泾路66号K549室', '电子设备、金属制品、劳防用品、机电产品、五金交电、电子产品、机械设备及配件、针纺织品、工艺礼品、化工产品及原料（除危险化学品、监控化学品、烟花爆竹、民用爆炸物品、易制毒化学品）、金属材料、汽摩配件的销售，从事电子科技领域内的技术开发、技术咨询、技术转让、技术服务，电子产品及配件的安装、维修（除专控），从事货物及技术的进出口业务。【依法须经批准的项目，经相关部门批准后方可开展经营活动】', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (553, NULL, NULL, NULL, NULL, '东莞市嘉腾仪器仪表有限公司', 'Dongguan Jiateng Instrument Co., Ltd.', NULL, '914419007730865202', '人民币', '5000万人民币', '彭雄良', '2005-04-06 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '广东省东莞市东城街道松浪街28号', '一般项目：智能基础制造装备制造；电子专用材料销售；仪器仪表销售；仪器仪表制造；仪器仪表修理；智能仪器仪表制造；智能仪器仪表销售；电工仪器仪表销售；电工仪器仪表制造；橡胶制品销售；通用零部件制造；机械设备销售；机械设备研发；机械设备租赁；通用设备制造（不含特种设备制造）；日用口罩（非医用）销售；技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广；货物进出口；技术进出口；第二类医疗器械销售。（除依法须经批准的项目外，凭营业执照依法自主开展经营活动）', '50-99人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (554, NULL, NULL, NULL, NULL, '深圳市铭思拓技术有限公司', 'MINSETO (SHENZHEN) TECHNICAL SERVICE CO.,LTD', NULL, '914403003116056641', '人民币', '2000万人民币', '杨武', '2014-09-23 00:00:00', '有限责任公司', '批发业', '深圳市光明区公明街道下村社区第三工业区5号201', '一般经营项目是：PCB线路板、FPC软板、IC载板、SMC贴装、TP触摸屏、半导体的技术研发与销售；工业自动化设备的技术开发、上门安装及维护、销售；软件研发与销售；国内贸易，货物及技术进出口；房地产经纪。，许可经营项目是：工业自动化设备的生产。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (555, NULL, NULL, NULL, NULL, '深圳市恒达友创网印设备有限公司', NULL, NULL, '91440300561529692Q', '人民币', '230万人民币', '裴雪菊', '2010-09-16 00:00:00', '有限责任公司', '计算机、通信和其他电子设备制造业', '深圳市宝安区沙井街道沙四东宝工业区O栋', '一般经营项目是：自动化设备的研发设计、技术服务；计算机软硬件的设计、开发和销售；自有物业租赁；物业管理；国内贸易；货物及技术进出口。（法律、行政法规、国务院决定规定在登记前须批准的项目除外，许可经营项目是：自动化设备、机械设备、网印设备、线路板设备的生产和加工。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (556, NULL, NULL, NULL, NULL, '威太（苏州）智能科技有限公司', 'WEITAI (SUZHOU) INTELLIGENT TECHNOLOGY CO.,LTD', NULL, '91320583MA1TC9R74W', '人民币', '500万人民币', '段景盛', '2017-11-27 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '昆山市玉山镇玉杨路1001号1幢401', '智能科技领域内的技术开发、技术咨询、技术转让；自动化设备、电子设备、仪器仪表、通讯设备（不含卫星电视广播地面接收设施）、机械设备、测试设备、实验室设备及零部件、音响设备的销售、租赁及上门维修、上门安装；电子元器件、电线电缆、防静电产品、电动五金工具、机床配件、计算机及配件、化工产品（不含危险化学品、易制毒制品及监控化学品）、治具、板材的销售；网络工程、安防监控工程；计算机软件的开发、销售及售后服务；货物及技术的进出口业务。(依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：电子专用设备制造；通用设备制造（不含特种设备制造）（除依法须经批准的项目外，凭营业执照依法自主开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (557, NULL, NULL, NULL, NULL, '深圳市乐维机械有限公司', 'LEVEL Shenzhen Co.,Ltd', NULL, '914403000638696949', '人民币', '350万人民币', '李德浩', '2013-03-13 00:00:00', '有限责任公司', '金属制品业', '深圳市宝安区新桥街道新桥社区北环路110号1209', '一般经营项目是：五金配件工具及周边产品的销售；从事货物及技术进出口业务。（法律、行政法规或者国务院决定禁止和规定在登记前须经批准的项目除外），许可经营项目是：机械设备的研发、生产、销售及维修、软件开发。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (558, NULL, NULL, NULL, NULL, '日东智能装备科技（深圳）有限公司', NULL, NULL, '91440300745168860K', '港元', '2500万港元', '林晓新', '2003-01-31 00:00:00', '有限责任公司(台港澳法人独资)', '批发业', '深圳市宝安区福永街道白石厦厂房G1栋第二、三、四层', '一般经营项目是：无，许可经营项目是：生产经营回流焊机、丝印机、贴片生产设备、工业自动化生产设备、PCB检查系统、材料搬运自动化设备、上下料机;生产经营波峰焊机、点胶机、焊线机、固晶机、半导体检测设备、液晶模组IC封装设备（COG）、FPC热压设备、直线电机;提供自产产品的技术支持、技术咨询以及产品销售前及销后服务;软件开发及转让自行开发的技术成果;经营货物及技术进出口业务;机电设备、SMT设备与半导体设备智能装备的租赁业务;道路普通货运;货物配送;货物搬运装卸服务。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (559, NULL, NULL, NULL, NULL, '深圳市瑞荣自动化有限公司', NULL, NULL, '91440300MA5FT19P2Q', '人民币', '500万人民币', '易运连', '2019-09-06 00:00:00', '有限责任公司', '金属制品、机械和设备修理业', '深圳市宝安区松岗街道潭头社区第三工业区C12栋201', '一般经营项目是：PCB、LCD周边设备的技术开发；垂直涂布机软件的开发与销售；耗材、自动化机械、工业机械、电器控制件的销售；国内贸易。(法律、行政法规、国务院决定规定在登记前须经批准的项目除外），许可经营项目是：PCB、LCD周边设备、自动化机械、工业机械的生产，机械相关配件的加工。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (560, NULL, NULL, NULL, NULL, '东莞市物移整合自动化机械有限公司', NULL, NULL, '9144190007190594XT', '人民币', '200万人民币', '林家青', '2013-06-28 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '东莞市长安镇沙头社区靖海东路5号', '产销：自动化机械、五金机械及配件、电子机械及配件；通用机械的维修及技术服务；货物进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (561, NULL, NULL, NULL, NULL, '江苏汉印机电科技股份有限公司', 'Jiangsu Hi-print Technology Co.,Ltd.', '汉印股份', '913209005911411540', '人民币', '4099.9999万人民币', '文成', '2012-03-02 00:00:00', '股份有限公司(非上市、自然人投资或控股)', '研究和试验发展', '盐城市高新技术产业区凤凰南路18号', '数字化高速工业喷印设备及零部件的研发、生产、销售、租赁和技术服务，数字化高速工业喷印设备配套产品的研发、销售，印制电子制造设备及控制系统、印制电路板、新型电子元器件、电子标签、薄膜太阳能电池系统、印制电子设备墨水研发与销售，精密机电设备及零部件、工业自动化生产线的研发、生产、销售、租赁和技术服务，自控软件的研发、销售和技术咨询、技术服务，自营和代理各类商品和技术的进出口业务（国家限定企业经营或禁止进出口的商品和技术除外）。（D）（依法须经批准的项目，经相关部门批准的方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (562, NULL, NULL, NULL, NULL, '深圳盟星科技股份有限公司', 'Shenzhen Mengxing Technology Co.,Ltd.', '盟星科技', '91440300788341926M', '人民币', '2277.7777万人民币', '王占良', '2006-06-27 00:00:00', '股份有限公司(中外合资、未上市)', '软件和信息技术服务业', '深圳市龙华区福城街道章阁社区大富路35号10栋101', '一般经营项目是：从事货物及技术进出口（不含分销、国家专营专控商品）。（以上经营范围不含国家规定实施准入特别管理措施的项目，涉及备案许可资质的需取得相关证件后方可实际经营。），许可经营项目是：生产经营研磨机、机械设备及其零配件、电脑配件及电脑软件、非标自动化设备、自动化设备、五金制品、塑胶制品及其零配件；从事上述产品的研发、批发、技术咨询、进出口及相关配套业务（不涉及国营贸易管理商品，涉及配额、许可证管理及其它专项规定管理的商品，按国家有关规定办理申请），转让自行研发的技术成果，从事上述产品的售后服务。（以上经营范围不含国家规定实施准入特别管理措施的项目，涉及备案许可资质的需取得相关证件后方可实际经营。）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (563, NULL, NULL, NULL, NULL, '深圳市微卓通科技有限公司', NULL, NULL, '914403000807979955', '人民币', '1000万人民币', '罗钒', '2013-10-16 00:00:00', '有限责任公司', '批发业', '深圳市宝安区松岗街道潭头社区富比伦科技厂区4号厂房501', '一般经营项目是：机械设备及相关零配件的研发和销售；机械设备及相关零配件的维修、改造、售后服务、技术服务；国内贸易，经营进出口业务。，许可经营项目是：机械设备及相关零配件的生产。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (564, NULL, NULL, NULL, NULL, '深圳宜美智科技股份有限公司', 'SHENZHEN IMAGE TECHNOLOGY CO., LTD.', NULL, '91440300680365416P', '人民币', '4500万人民币', '林咏华', '2008-10-23 00:00:00', '其他股份有限公司(非上市)', '计算机、通信和其他电子设备制造业', '深圳市宝安区松岗街道潭头社区潭头树边坑路与松岗大道交汇处2号厂房201及第2、3、4层', '一般经营项目是：自动光学检测仪软件的技术开发，自动光学检测仪设备的销售；自动光学检测仪设备的租赁；自动光学检测仪设备相关的零配件销售及售后服务；国内商业、物资供销业，货物及技术进出口。（以上均不含法律、行政法规、国务院决定禁止及规定需前置审批项目），许可经营项目是：自动光学检测仪设备的生产。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (565, NULL, NULL, NULL, NULL, '深圳市奥高德科技有限公司', NULL, NULL, '91440300326447179E', '人民币', '200万人民币', '李宗凡', '2015-01-19 00:00:00', '有限责任公司（港澳台投资、非独资）', '零售业', '深圳市宝安区石岩街道龙腾社区石环路137号圳宝工业区4号厂房二层', '一般经营项目是：PCB测试软件、硬件及技术的开发与销售，PCB测试机的销售；国内贸易，货物及技术进出口。，许可经营项目是：PCB测试机的生产。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (566, NULL, NULL, NULL, NULL, '广州锐尔信息科技有限公司', NULL, NULL, '914401016915247858', '人民币', '100万人民币', '刘崇伟', '2009-07-13 00:00:00', '有限责任公司(自然人投资或控股)', '软件和信息技术服务业', '广州市海珠区新港中路艺影街7号1906房（仅作写字楼功能用）', '软件开发;信息技术咨询服务;企业管理咨询服务;计算机零配件批发;电子产品批发;电子产品零售;软件批发;计算机技术开发、技术服务;软件零售;计算机零配件零售;', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (567, NULL, NULL, NULL, NULL, '广东丰伟建设有限公司', NULL, NULL, '9144142459898009XX', '人民币', '10038万人民币', '钟镇', '2012-07-10 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '五华县河东镇长乐东路邮电局侧', '建筑工程施工总承包；市政公用工程施工总承包；电力工程施工总承包；输变电工程专业承包；建筑机电安装工程专业承包；建筑装修装饰工程专业承包及设计；电子与智能化工程专业承包；钢结构工程专业承包；城市及道路照明工程专业承包；防水防腐保温工程专业承包；消防设施工程专业承包及设计；建筑幕墙工程专业承包及设计；环保工程专业承包；建筑劳务分包；国内广告设计、制作、代理、发布、安装；建筑机械设备租赁；会议及展览服务；环保技术推广服务；预制构件工程安装服务；市政设施管理服务；工程排水施工服务；清洁服务；水处理安装服务；水处理设备技术开发；室外体育设施工程施工；土石方工程施工；园林绿化工程施工；植树造林；水工金属结构防腐蚀专业施工；地基与基础工程施工；特种工程施工；拆除工程施工；石油化工工程施工；洁净净化工程设计和施工；空调制冷、供暖、通风设备系统安装工程；体育场建设工程；计算机网络系统工程；计算机网络系统技术开发、技术服务；安全技术防范系统工程；隔声工程服务；建筑结构加固补强；门窗安装工程；林业有害生物防治服务；环保节能技术推广、技术开发、技术咨询、技术交流、技术转让；专用设备修理；安防产品、厨具加工、安装、销售；体育用品及器材、露天游乐场所设施、日用百货、家用电器、五金制品、电梯、燃料油（不含成品油）、石油制品（成品油、危险化学品除外）、建筑材料（不含河砂）、装饰材料、家具、空调销售。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (568, NULL, NULL, NULL, NULL, '梅州同盟广告传媒有限公司', NULL, NULL, '91441403325025361E', '人民币', '110万人民币', '王梅康', '2015-01-21 00:00:00', '有限责任公司(自然人投资或控股)', '商务服务业', '梅州市梅县区大新路83号店', '广告业；平面设计；企业管理咨询、企业营销策划、企业形象策划服务；物业管理；建筑业；灯光亮化工程；工程设计服务；承装、承修、承试供电设施和受电设施。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (569, NULL, NULL, NULL, NULL, '江西自立环保科技有限公司', 'Jiangxi Self-Independence Environmental Protection Technology Co.,Ltd.', NULL, '91361000787294953H', '人民币', '50000万人民币', '许来平', '2006-05-30 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '研究和试验发展', '江西省抚州市临川区抚北工业园区', '再生废旧物资回收利用（含生产性废旧金属）、加工、销售；金属材料、五金、化工产品（除危险品）、机械、电子设备的购销、自营及代理各类商品和技术的进出口（国家限制或禁止进出口的商品和技术除外））（以上经营项目国家有专项规定的除外，凡涉及行政许可的须凭许可证经营）****', '1000-4999人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (570, NULL, NULL, NULL, NULL, '赣州市新锦旺物资回收有限公司', NULL, NULL, '91360727MA38Q3FJ0A', '人民币', '500万人民币', '蔡洪亮', '2019-07-19 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市龙南市龙南经济技术开发区新圳工业园I1-02、I1-03部分地块', '生产性、非生产性废旧物资回收、利用。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (571, NULL, NULL, NULL, NULL, '东莞市嘉福康餐饮管理有限公司', NULL, NULL, '91441900MA52XXE078', '人民币', '50万人民币', '何春兰', '2019-03-05 00:00:00', '有限责任公司(自然人投资或控股)', '餐饮业', '广东省东莞市石碣镇石碣科技中路57号4栋101室', '餐饮服务；膳食管理服务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (572, NULL, NULL, NULL, NULL, '国网江西省电力有限公司龙南市供电分公司', NULL, NULL, '91360727MA35GGJY7M', '人民币', '2537万人民币', '康毅', '2016-02-05 00:00:00', '有限责任公司分公司(非自然人投资或控股的法人独资)', '电力、热力生产和供应业', '江西省龙南市金水大道361号', '电力供应、电力生产、普通机械、电器机械及器材、仪器仪表、电力设备安装调试、运行检修、电力信息服务、电力通信服务。电力技术服务、技术咨询、机械设备维修、电力工程设计与施工、电动汽车充换电服务网络建设、运营维护及相关配套服务。节能诊断、咨询、设计、研发及新能源开发与技术服务。（以上主兼营项目国家有专项规定的除外）(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (573, NULL, NULL, NULL, NULL, '深圳市新厨帮科技有限公司', 'Shenzhen Xinchubang Technology Co.,Ltd.', NULL, '914403006700090984', '人民币', '6000万人民币', '桂诗勇', '2008-01-03 00:00:00', '有限责任公司(自然人独资)', '电气机械和器材制造业', '深圳市宝安区松岗街道沙浦围大地工业区大地路8号B栋', '一般经营项目是：节能环保厨具、智能厨房设备、食品加工设备的销售；建筑材料、装饰材料的销售；初级农产品的销售；畜禽产品销售（不含活禽）；鸡蛋、蔬菜的销售；为餐饮企业提供管理服务；现代农业开发；机电设备上门安装（不含特种设备）；国内贸易，货物及技术进出口。（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营），许可经营项目是：节能环保厨具、智能厨房设备、食品加工设备的生产；中西餐制售；粮油加工及销售；农产品加工；鸡蛋的生产及销售；蔬菜种植及销售；预包装食品的销售；餐饮人才培训及输出；劳务派遣；建筑劳务分包；市政工程、消防工程、路桥工程、输变电工程、钢结构及水利工程、河湖整治工程、建筑工程、室内外装饰装修工程、水电安装工程、空调安装工程、土石方工程、园林绿化工程、净化车间工程、玻璃幕墙工程的施工、设计；食材配送；餐饮服务； 为企业及校园提供餐饮服务；校园超市经营。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (574, NULL, NULL, NULL, NULL, '赣州市科正建设工程施工图设计审查中心', NULL, NULL, '913607007567643507', '人民币', '300万人民币', '刘水石', '2001-10-20 00:00:00', '股份合作制', '商务服务业', '江西省赣州市章贡区南河路2号', '建筑工程施工图设计审查、咨询服务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (575, NULL, NULL, NULL, NULL, '五株科技（香港）有限公司', NULL, NULL, NULL, '人民币', NULL, NULL, '2010-12-21 00:00:00', NULL, NULL, NULL, NULL, NULL, '仍注册', 0);
INSERT INTO `sys_enterprise` VALUES (576, NULL, NULL, NULL, NULL, '深圳市通科机电有限公司', NULL, NULL, '91440300073396069A', '人民币', '200万人民币', '张华芳', '2013-07-08 00:00:00', '有限责任公司', '批发业', '深圳市龙华新区龙华街道东环二路与民清路交界处龙华公寓A栋2003', '一般经营项目是：机电设备的上门维修；电子材料的销售；进出口业务；机械设备工程上门安装及维修。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (577, NULL, NULL, NULL, NULL, '费用', NULL, NULL, NULL, '人民币', NULL, '费用', '2014-11-04 00:00:00', '个体工商户', '零售业', '郑州路市场内', '零售：文具用品(依法须经批准的项目，经相关部门批准后方可开展经营活动）', NULL, '注销', 0);
INSERT INTO `sys_enterprise` VALUES (578, NULL, NULL, NULL, NULL, '上海潜利电子科技有限公司', 'Shanghai Qianli Electronic Technology Co.,Ltd.', NULL, '913101166855477882', '人民币', '500万人民币', '李祖青', '2009-03-20 00:00:00', '有限责任公司（自然人独资）', '科技推广和应用服务业', '上海市金山区金山卫镇南阳湾路1068号2幢140室', '许可项目：危险化学品（详见许可证）经营（不带储存设施）。（依法须经批准的项目，经相关部门批准后方可开展经营活动，具体经营项目以相关部门批准文件或许可证件为准）一般项目：技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广；计算机及办公设备维修；电子产品销售；包装材料及制品销售；机械设备销售；计算机软硬件及辅助设备批发；家用电器销售；办公设备销售；办公用品销售；工业自动控制系统装置销售；机械设备租赁；信息系统集成服务；计算机系统服务。（除依法须经批准的项目外，凭营业执照依法自主开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (579, NULL, NULL, NULL, NULL, '赣州优泰环保设备有限公司', NULL, NULL, '91360727MA38U7KXXA', '人民币', '100万人民币', '邱婷', '2019-09-09 00:00:00', '有限责任公司(自然人投资或控股)', '其他制造业', '江西省赣州市龙南市龙南经济技术开发区东江乡大稳村新屋下小组上圳头门面一楼、二楼', '环保设备及配件的加工、销售、安装、维护、设计；环保信息技术服务、技术咨询。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (580, NULL, NULL, NULL, NULL, '深圳市欧铠智能机器人股份有限公司', 'SHENZHEN OKAGV CO.,LTD.', NULL, '91440300075800301L', '人民币', '500万人民币', '何建忠', '2013-07-29 00:00:00', '股份有限公司(非上市)', '批发业', '深圳市宝安区福永街道大洋开发区福安工业城二期厂房14栋二层、三层', '一般经营项目是：机器人AGV运载车、全自动上下板机、贴片机电子设备的研发、设计与销售；电子设备、输送系统的技术咨询、上门安装、上门维护与上门保养；货物及技术进出口。（以上均不含法律、行政法规、国务院决定规定须经批准的项目），许可经营项目是：机器人AGV运载车、全自动上下板机、贴片机电子设备的生产。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (581, NULL, NULL, NULL, NULL, '昆山金博达起重搬运有限公司', NULL, NULL, '91320583MA1Q4FQ439', '人民币', '500万人民币', '张艳芳', '2017-08-22 00:00:00', '有限责任公司(自然人独资)', '装卸搬运和仓储业', '昆山市玉山镇萧林西路110号', '机械设备起重、吊装搬运、装卸服务；普通货物搬运、装卸服务；机械设备上门安装；普通货物包装服务；水电安装工程。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (582, NULL, NULL, NULL, NULL, '深圳市恋恋科技有限公司', NULL, NULL, '91440300MA5DC28W1T', '人民币', '500万人民币', '谢永海', '2016-05-05 00:00:00', '有限责任公司(自然人独资)', '批发业', '深圳市福田区华强北街道华航社区华强北路1005、1007、1015号华强电子世界3号楼2层32C159', '一般经营项目是：电子元器件、电子材料、手机及周边设备、通讯配件、电脑配件、计算机及配件销售；国内贸易；经营进出口业务。（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (583, NULL, NULL, NULL, NULL, '深圳市铭达技术有限公司', 'Shenzhen Mintek Technology Co., Ltd.', NULL, '9144030007800073X3', '人民币', '1000万人民币', '肖清明', '2013-09-09 00:00:00', '有限责任公司', '批发业', '深圳市光明区公明街道下村社区第三工业区6号201', '一般经营项目是：工业自动化设备技术开发和销售；国内贸易；货物及技术进出口。，许可经营项目是：工业自动化设备的生产；厂房租赁。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (584, NULL, NULL, NULL, NULL, '广东标顶电子有限公司', NULL, NULL, '91440300562779212U', '人民币', '3000万人民币', '沈春波', '2010-10-14 00:00:00', '有限责任公司', '电气机械和器材制造业', '深圳市坪山区龙田街道兰竹东路8号同力兴工业厂区2号厂房1-5层', '一般经营项目是：电线、电缆的技术研发及销售；电器连接器的技术研发及销售：电子产品的技术开发及销售：国内贸易、货物及技术进出口（法律、行政法规、国务院决定规定在登记前须经批准的项目除外）。，许可经营项目是：电器连接器的生产及加工；电线、电缆的生产加工；普通货运。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (585, NULL, NULL, NULL, NULL, '东莞市仨腾五金科技有限公司', NULL, NULL, '91441900MA5241NGXE', '人民币', '500万人民币', '伍伟金', '2018-08-08 00:00:00', '有限责任公司(自然人独资)', '批发业', '广东省东莞市石碣镇涌口田心街12号101室', '研发、生产、销售：自动化设备配件、机电设备配件、线路板设备配件、模具配件、五金塑胶制品、钢材（不含钢铁冶炼）、铝材、五金交电耗材、水暖管件、电子产品；货物或技术进出口(国家禁止或涉及行政审批的货物和技术进出口除外)。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (586, NULL, NULL, NULL, NULL, '昆山力盟国际货运有限公司', 'Kunshan Limeng International Freight Co.,Ltd.', NULL, '91320583765138191H', '人民币', '2000万人民币', '刘然', '2004-09-10 00:00:00', '有限责任公司(自然人投资或控股)', '道路运输业', '昆山开发区保通路2号物流服务楼102-103室', '普通货运；国际陆路货运代理业务，包括：揽货、订舱、仓储、中转、集装箱拼装拆箱、结算运杂费、报关、报验、保险、相关的运输信息咨询服务；国内货运代理；物流方案的策划；货物及技术进出口业务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：无船承运业务（除依法须经批准的项目外，凭营业执照依法自主开展经营活动）', '50-99人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (587, NULL, NULL, NULL, NULL, '中国石化销售股份有限公司江西赣州石油分公司', NULL, NULL, '91360700705714329Q', '人民币', '0人民币', '聂志群', '2000-06-15 00:00:00', '外商投资企业分公司', '批发业', '江西省赣州市章贡区青年路2号', '以下所有项目涉及许可证的，凭有效许可证经营：油（气）库、加油（气）站的规划、设计和建设；石油管道及相关设施的投资（不得从事吸收存款、集资收款、受托贷款、发放贷款等国家金融、证券、期货及财政信用业务）、建设、维护；石油石化原辅材料，机械设备及零部件，化妆品，农、林、牧、渔产品，建材，家具，医疗器械，润滑油，燃料油，沥青（以上三项除危险化学品），文化用品，体育用品及器材，汽车整车及二手车，摩托车及零配件，轮胎，药品，蔬菜，农副产品，化肥，种子，劳保用品，工艺礼品，消防器材，电线，电缆，计算机，软件及辅助设备，通讯设备的销售；农资（除危化品）销售、储运；日用百货便利店经营、计生用品经营；汽车清洗服务；洗染服务、摄影扩印服务、复印传真打印服务；汽车综合服务；汽车装饰；国内、国际旅游业务；景区管理；餐饮服务；酒店经营；广告位出租；设备、汽车、房屋、场地租赁；汽车维修；道路普通货物运输；危险货物运输（2类一项）、危险货物运输（第3类）（凭道路运输经营许可证经营，有效期至2022年07月26日）；食品经营，报刊、杂志、图书、音像制品零售，委托代理收取水电费、票务代理服务，成品油（汽油、柴油）零售，石油、石油化工、化纤及其他化工产品的销售、储运，燃气经营（从“食品经营”至“燃气经营”仅限网点取得相关前置许可后方可经营，经营项目及有效期以许可证为准）；卷烟、雪茄烟、保健食品、纺织、服装、五金、家用电器及电子产品、充值卡零售；设计制作、代理、发布广告；与经营业务有关的咨询服务、技术应用研究和计算机软件开发；与经营业务有关的培训；货物进出口、技术进出口、代理进出口；保险代理；水果批发及零售；网上贸易代理；房地产开发经营；装修工程施工；售电；仓储（危险化学品及易燃易爆物品的仓储除外）；商务咨询服务；会务会展服务；仓单质押；物流货运信息服务；货物装卸、包装、装置、信息处理；冷链服务；居民其他代理服务；电信增值服务；光伏设备及元器件销售、安装；充电桩服务；钢铁钢材、有色金属、一般矿产品（除稀土、锑、钨、锡、萤石原矿以外的矿产品）、型钢、热轧圆盘条、塑料制品、家庭用品、室内装饰材料、皮箱、皮包、皮制品、模具、饲料、粮食、乳制品（含婴幼儿配方奶粉）、煤炭的销售。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '1000-4999人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (588, NULL, NULL, NULL, NULL, '深圳彩翔精密机械有限公司', NULL, NULL, '9144030039849584X4', '人民币', '1000万人民币', '江北', '2014-07-03 00:00:00', '有限责任公司', '专用设备制造业', '深圳市光明区公明街道下村社区第三工业区6号101', '一般经营项目是：涂布机、隧道式烤箱、紫外线UV机、箱型烤箱、精密自动化干燥设备的研发与销售；国内贸易、货物及技术进出口。（法律、行政法规或者国务院决定禁止和规定在登记前须经批准的项目除外） ，许可经营项目是：涂布机、隧道式烤箱、紫外线UV机、箱型烤箱、精密自动化干燥设备的生产。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (589, NULL, NULL, NULL, NULL, '江西云滇膜结构工程有限公司', NULL, NULL, '91360721MA37QP5A2N', '人民币', '510万人民币', '李平', '2018-03-09 00:00:00', '有限责任公司(自然人投资或控股)', '金属制品业', '江西省赣州市赣县区茅店镇黄龙村李屋组19号', '钢材膜结构技术开发；膜结构工程设计、施工、维护，景观棚工程的施工。室内外装饰工程、建筑工程、安防工程、建筑防水工程、园林绿化工程、钢结构工程、门窗工程。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (590, NULL, NULL, NULL, NULL, '蚂蚁工业（深圳）有限公司', NULL, NULL, '91440300MA5FD5JF8E', '人民币', '100万人民币', '高欢', '2018-11-15 00:00:00', '有限责任公司', '批发业', '深圳市龙岗区龙岗街道五联社区爱联工业区16栋101', '一般经营项目是：自动化设备、自动化零用件、机械加工配件、传动零配件的销售；国内贸易；经营进出口业务。，许可经营项目是：', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (591, NULL, NULL, NULL, NULL, '深圳市华研鑫精密五金有限公司', NULL, NULL, '91440300398565596C', '人民币', '500万人民币', '王强', '2014-07-22 00:00:00', '有限责任公司(自然人独资)', '批发业', '深圳市宝安区沙井街道北环路（与宝安大道交汇处）十渡闸三友工业城一层K103', '一般经营项目是：电子产品、五金产品及配件的销售；机械设备的上门维修；国内贸易、货物及技术进出口。（法律、行政法规或者国务院决定禁止和规定在登记前须经批准的项目除外），许可经营项目是：电子产品、五金产品及配件的生产、加工。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (592, NULL, NULL, NULL, NULL, '郑州未已来信息科技有限公司', NULL, NULL, '91410100MA457U6X7F', '人民币', '500万人民币', '陈鹏', '2018-05-11 00:00:00', '有限责任公司(自然人独资)', '科技推广和应用服务业', '郑州高新技术产业开发区长椿路11号国家大学科技园西区Y09栋2层', '计算机软硬件技术开发、技术转让、技术咨询、技术服务；自动化技术开发、技术转让、技术咨询、技术服务；通信技术开发、技术转让、技术咨询、技术服务；大数据采集、咨询、应用及相关技术开发；云计算技术开发、技术服务；计算机系统集成；计算机网络工程；企业管理咨询；商务信息咨询；销售：计算机及辅助设备、计算机软硬件、办公用品、电子产品、通讯器材、自动化设备、电子元器件、日用百货、预包装食品、果品蔬菜、初级农产品；经济贸易信息咨询。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (593, NULL, NULL, NULL, NULL, '赣州大鼎环保设备有限公司', NULL, NULL, '91360727MA35JAM597', '人民币', '50万人民币', '赖宾宾', '2016-06-17 00:00:00', '有限责任公司(自然人投资或控股)', '其他服务业', '江西省赣州市龙南市龙南经济技术开发区马牯塘镇大罗村', '环保化粪池、环保沼气池、鱼箱、排风设备、电镀槽、电镀设备、环保净化塔加工及销售(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (594, NULL, NULL, NULL, NULL, '深圳鑫隆工业地坪有限公司', NULL, NULL, '91440300MA5FNDUX1R', '人民币', '1188万人民币', '邹碧琼', '2019-06-19 00:00:00', '有限责任公司', '批发业', '深圳市宝安区松岗街道松岗社区红花沙头新区2号502', '一般经营项目是：专业施工无尘环氧地坪漆；环氧自流平地坪、耐磨防滑地坪、环氧防静电地坪、PCB车间重防腐地坪、重防腐水池腐蚀处理施工；各类PVC防静电地坪、金刚砂地坪、硬化耐磨地坪、透水地坪、密封固化剂地坪、停车场耐磨防滑地坪、弹性球场地坪、跑道地坪施工。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (595, NULL, NULL, NULL, NULL, '龙南县恒万建设工程有限公司', NULL, NULL, '91360727MA396R5X9Y', '人民币', '50万人民币', '曾国平', '2020-04-03 00:00:00', '有限责任公司(自然人投资或控股)', '土木工程建筑业', '江西省赣州市龙南市龙南经济技术开发区奥园迎宾花园一楼A23-1号商铺', '一般项目：土石方工程、市政工程、房屋建筑工程、钢结构工程、建筑工程、环保工程、水利水电工程、室内外装饰装修工程、市政公用工程、网络工程、园林绿化工程、景观工程设计、施工；工程信息咨询服务；室内外保洁服务；智能化停车场设计、施工；建筑装饰材料、家用电器、安防监控设备、机电机械设备及配件、金属材料、木材及其制品销售；交通设施、环卫设施设计、安装、维修及技术售后服务；工程设备租赁服务。（依法须经批准的项目,经相关部门批准后方可开展经营活动）（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (596, NULL, NULL, NULL, NULL, '赣州市栋楠防水工程有限公司', NULL, NULL, '91360702MA3873954C', '人民币', '488万人民币', '刘永发', '2018-10-26 00:00:00', '有限责任公司(自然人独资)', '批发业', '江西省赣州市章贡区黄屋坪路31号永康锦园12号楼703房', '防水工程、防腐工程、保温工程、建筑物防水补漏工程、内外墙涂料工程、地坪漆工程、混泥土预制构件工程、园林绿化工程、体育场地设施工程、小区智能化工程、办公网络智能化工程、弱电工程设计与施工；铝合金及不锈钢制作；防水材料、建筑材料销售。(依法须经批准的项目,经相关部门批准后方可开展经营活动)****', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (597, NULL, NULL, NULL, NULL, '中国人寿保险股份有限公司赣州分公司', 'China Life Insurance Company Limited', NULL, '91360700962507494F', '人民币', '0人民币', '黄萍', '2000-03-16 00:00:00', '股份有限公司分公司(上市、国有控股)', '保险业', '江西省赣州市章贡区兴国路22号', '人寿保险、健康保险、意外伤害保险等各类人身保险业务；人身保险的再保险业务；国家法律法规允许的或国务院批准的资金运用业务；各类人身保险服务、咨询和代理业务；国家保险监督管理部门批准的其他业务（以上项目凭保险业务许可证经营）。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (598, NULL, NULL, NULL, NULL, '东莞市恒升环保科技有限公司', NULL, NULL, '91441900698183178X', '人民币', '2500万人民币', '王仁才', '2009-12-25 00:00:00', '有限责任公司(自然人投资或控股)', '科技推广和应用服务业', '东莞市沙田镇斜西工业区', '研发、产销、安装：污水处理设备、中央集尘设备、废气处理设备、中水回用设备、纯净水设备、节电节能设备；销售：环境污染处理专用药剂、塑胶产品、橡胶产品、合成树脂、风机专用润滑油。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (599, NULL, NULL, NULL, NULL, '龙南县龙跃水电工程有限公司', NULL, NULL, '91360727MA386NB807', '人民币', '100万人民币', '王文东', '2018-10-19 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '江西省赣州市龙南市龙翔广场南侧新世界购物公园C1-207', '市政工程、水电安装工程、机电设备安装工程、网络布线工程、土石方工程、建筑装修工程、建筑防水工程、建设智能化工程施工；水利管道安装与维修(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (600, NULL, NULL, NULL, NULL, '赣州市佳腾工程机械租赁有限公司', NULL, NULL, '91360727MA38RQFP8P', '人民币', '100万人民币', '赖建星', '2019-08-16 00:00:00', '有限责任公司(自然人独资)', '租赁业', '江西省赣州市龙南市龙南镇水东安置区', '建筑工程机械租赁、维修；塔式起重机、施工升隆机安装、维修、租赁；土石方工程、市政工程、水利工程、路桥工程施工。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (601, NULL, NULL, NULL, NULL, '核工业鹰潭工程勘察院河源分院', NULL, NULL, '91441602MA520UQPXB', '人民币', '10万人民币', '卞国林', '2018-07-17 00:00:00', '内资非法人企业、非公司私营企业', '专业技术服务业', '河源市区东城西片区黄沙大道西边、纬十四路北面河源雅居乐花园M-5栋D1051房', '工程勘察专业类(岩土工程（勘察）、水文地质勘察、工程测量)甲级；劳务类（凿井、工程钻探）；土工实验；测绘；地质灾害危险性评估甲级；地质灾害治理工程设计乙级；地质灾害治理工程勘查乙级；地质灾害治理工程监理丙级；土地规划乙级；土地整治工程规划。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (602, NULL, NULL, NULL, NULL, '东莞市兴盛胶粘制品有限公司', 'Dongguan Hing Shing Adhesive Product Co Ltd', NULL, '91441900694799469T', '人民币', '500万人民币', '唐树林', '2009-09-18 00:00:00', '有限责任公司(自然人投资或控股)', '橡胶和塑料制品业', '广东省东莞市高埗镇高埗莲花街5号', '产销：胶粘制品、包装材料、文具、胶袋；货物进出口。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '50-99人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (603, NULL, NULL, NULL, NULL, '龙南建达建材有限公司', NULL, NULL, '91360727MA381KHAXQ', '人民币', '500万人民币', '廖文建', '2018-07-19 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市龙南市龙南经济技术开发区大罗工业区稻濂路', '装饰材料、钢材、型材、不锈钢加工、批发、零售；五金化工（危险化学品除外）批发、零售(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (604, NULL, NULL, NULL, NULL, '孚诺泰（广州）高新技术工程顾问有限公司', NULL, NULL, '914401065876244015', '人民币', '488万人民币', '梁劲', '2011-12-16 00:00:00', '有限责任公司(自然人投资或控股)', '研究和试验发展', '广州市天河区健明四路16号402房（不可作厂房）', '建筑工程后期装饰、装修和清理;家具安装;建材、装饰材料批发;电子自动化工程安装服务;监控系统工程安装服务;电子设备工程安装服务;智能化安装工程服务;建筑物空调设备、通风设备系统安装服务;商品零售贸易（许可审批类商品除外）;节能技术开发服务;节能技术咨询、交流服务;节能技术转让服务;商品批发贸易（许可审批类商品除外）;综合管廊的建设、运营、维护、管理（不含许可经营项目）;室外体育设施工程施工;电力电子元器件制造;电器辅件、配电或控制设备的零件制造;电气信号设备装置制造;电气机械制造;电气器材制造;铁路专用设备及器材、配件制造;计算机信息安全设备制造;安全智能卡类设备和系统制造;密钥管理类设备和系统制造;射频识别（RFID）设备制造;通信系统设备制造;通信终端设备制造;半导体分立器件制造;集成电路制造;电子元件及组件制造;电子白板制造;图书防盗设备制造;电子测量仪器制造;通用和专用仪器仪表的元件、器件制造;软件批发;射频识别（RFID）设备销售;通讯设备及配套设备批发;通讯终端设备批发;无源器件、有源通信设备、干线放大器、光通信器件、光模块的销售;软件开发;信息系统集成服务;信息技术咨询服务;数据处理和存储服务;集成电路设计;通信信号技术的研究开发;机器人的技术研究、技术开发;通信技术研究开发、技术服务;互联网区块链技术研究开发服务;物联网技术研究开发;射频识别（RFID）设备的研究开发;人工智能算法软件的技术开发与技术服务;频谱监测技术的研究、开发;机动车检测系统及设备的研究、开发;智能联网汽车相关技术研究、技术开发服务;电梯技术的研究、开发;建筑材料检验服务;机动车检测系统及设备的安装、维护;数据处理和存储产品设计;计算机信息安全产品设计;', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (605, NULL, NULL, NULL, NULL, '龙南市嘉喜装饰工程有限公司', NULL, NULL, '91360727MA39A21E1Q', '人民币', '20万人民币', '王喜', '2020-08-17 00:00:00', '有限责任公司(自然人独资)', '建筑装饰、装修和其他建筑业', '江西省龙南市东江乡大稳村新屋下（105国道线西广高五金机电二楼）', '许可项目：住宅室内装饰装修，各类工程建设活动，建设工程设计，房屋建筑和市政基础设施项目工程总承包（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：金属门窗工程施工（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (606, NULL, NULL, NULL, NULL, '赣州永达建设工程有限公司龙南分公司', NULL, NULL, '91360727MA37Y4RA9R', '人民币', '0人民币', '刘龙江', '2018-06-05 00:00:00', '有限责任公司分公司(自然人投资或控股)', '房屋建筑业', '江西省赣州市龙南市龙南经济技术开发区马牯塘小区', '为隶属企业联系业务(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (607, NULL, NULL, NULL, NULL, '江西睿创工程监理有限公司赣州分公司', NULL, NULL, '91360727MA35H7076B', '人民币', '0人民币', '廖东亮', '2016-04-08 00:00:00', '有限责任公司分公司(自然人投资或控股)', '商务服务业', '江西省赣州市龙南市金水社区圆角楼', '企业管理咨询、工程造价咨询、招标代理、建筑工程监理、建筑工程咨询、建筑工程的设计(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (608, NULL, NULL, NULL, NULL, '横琴金投国际融资租赁有限公司', NULL, NULL, '91440400310589412H', '美元', '20000万美元', '鲁志云', '2014-08-07 00:00:00', '有限责任公司(台港澳与境内合资)', '货币金融服务', '珠海市横琴新区环岛东路1889号17栋501房间', '章程记载的经营范围：融资租赁业务；租赁业务；向国内外购买租赁财产；租赁财产的残值处理及维修；租赁交易咨询和担保。兼营与主营业务有关的商业保理业务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (609, NULL, NULL, NULL, NULL, '赣州江钨有色冶金机械特种设备安装有限公司', NULL, NULL, '91360700685978844D', '人民币', '100万人民币', '饶成富', '2009-04-07 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市赣州经济技术开发区迎宾大道北侧辅助车间南跨', '许可项目：特种设备检验检测服务，检验检测服务，特种设备安装改造修理（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：再生资源回收（除生产性废旧金属），特种设备销售，普通机械设备安装服务（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (610, NULL, NULL, NULL, NULL, '东莞市千诺包装材料有限公司', NULL, NULL, '91441900MA51N5C882', '人民币', '100万人民币', '陈燕尔', '2018-05-10 00:00:00', '有限责任公司(自然人投资或控股)', '橡胶和塑料制品业', '东莞市塘厦镇莲湖社区环市东路176号', '产销：包装用塑料用品、金属制品、拉伸膜、双面胶。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (611, NULL, NULL, NULL, NULL, '江西友信消防技术咨询有限公司', NULL, NULL, '91360702MA37NL1248', '人民币', '200万人民币', '罗顺平', '2018-01-04 00:00:00', '有限责任公司(自然人投资或控股)', '专业技术服务业', '江西省赣州市章贡区长征大道17号中廷广场西1302', '消防技术咨询、技术服务；教育咨询（不含自营培训及教育业务）；计算机软件开发；机电设备安装工程、建筑智能化工程、消防工程、综合布线工程、水电安装工程、暖通工程、给排水工程的设计、安装、调试、维修；消防器材的销售、维修。(依法须经批准的项目,经相关部门批准后方可开展经营活动)****', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (612, NULL, NULL, NULL, NULL, '东莞市石碣致诚厨具经营部', NULL, NULL, '92441900MA4WYEFG37', '人民币', '1人民币', '赖旭培', '2017-08-08 00:00:00', '个体工商户', '批发业', '东莞市石碣镇水南崇焕东路180号邦口北星铁平房B04A区厂房', '销售：厨具设备、电器、日用品。', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (613, NULL, NULL, NULL, NULL, '广州市利文建筑模型设计有限公司', NULL, NULL, '91440106MA59CQQJ1C', '人民币', '100万人民币', '王光坤', '2016-05-06 00:00:00', '有限责任公司(自然人独资)', '专业技术服务业', '广州市增城区新塘镇官湖村石新大道260号五楼', '模型设计服务;多媒体设计服务;数字动漫制作;模具制造;建筑模板制造;园林绿化工程服务;教学用模型及教具制造;室内装饰设计服务;美术图案设计服务;', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (614, NULL, NULL, NULL, NULL, '深圳市鑫美日柴油机维修服务有限公司', 'Shenzhen Xinmeiri Diesel Engine Maintenance Service Co.,Ltd.', NULL, '9144030074122284XT', '人民币', '200万人民币', '何亚平', '2002-07-29 00:00:00', '有限责任公司', '批发业', '深圳市宝安区石岩街道塘头社区石新社区洲石路明金海科技园厂房1栋一层西南侧', '一般经营项目是：柴油机的上门维修（凭资格证经营维修服务），柴油机零配件的销售（不含专营、专控、专卖商品）；国内贸易，经营进出口业务。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (615, NULL, NULL, NULL, NULL, '深圳市海源鸿科技有限公司', 'Shen Zhen City sea source swan goose science and technology Ltd.', NULL, '91440300795404462R', '人民币', '100万人民币', '胡桂荣', '2006-10-26 00:00:00', '有限责任公司', '计算机、通信和其他电子设备制造业', '深圳市宝安区沙井街道共和社区同富裕工业区湾厦工业园1号厂房二层', '一般经营项目是：国内贸易，货物及技术进出口。（法律、行政法规、国务院决定规定在登记前须经批准的项目除外），许可经营项目是：线路板的钻孔、锣边加工；五金件加工。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (616, NULL, NULL, NULL, NULL, '广东臻鼎环境科技有限公司', 'Huizhou Zhending Environmental Protectiong  Technology.,Ltd', NULL, '91441302314953162A', '人民币', '3076.9231万人民币', '李强', '2014-09-05 00:00:00', '有限责任公司(自然人投资或控股)', '研究和试验发展', '惠州市东江高新区东兴片区东新大道106号东江创新大厦内16楼1602室', '印刷电路工艺废蚀刻液在线循环再生及其他废液在线循环再生环保设备的技术应用服务及运营管理；环保设备及配件的研发、制造、销售及维修；环保工程、再生资源的回收经营；环保设施的配套服务及运营管理；智能传感器开发，物联网技术开发，人工智能网络开发；金属材料、电子产品、化工产品（非危险品）的技术开发及销售；五金交电产品的销售；技术开发、技术服务、技术咨询；软件开发；国内贸易、货物及技术进出口业务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '100-499人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (617, NULL, NULL, NULL, NULL, '广东天承科技股份有限公司', NULL, NULL, '9144010156396708XL', '人民币', '4200万人民币', '童茂军', '2010-11-19 00:00:00', '股份有限公司（外商投资、未上市）', '研究和试验发展', '广东从化经济开发区太源路8号（厂房）首层', '工程和技术研究和试验发展;化学试剂和助剂制造（监控化学品、危险化学品除外）;金属表面处理剂制造（监控化学品、危险化学品除外）;工业自动控制系统装置制造;新材料技术咨询、交流服务;新材料技术推广服务;新材料技术开发服务;新材料技术转让服务;专项化学用品制造（监控化学品、危险化学品除外）;', '50-99人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (618, NULL, NULL, NULL, NULL, '南亚新材料科技（江西）有限公司', 'Nanya  New Material Technology Jiangxi  Co.Ltd.', NULL, '91360805MA36933G5K', '人民币', '23330万人民币', '张东', '2017-09-11 00:00:00', '有限责任公司（非自然人投资或控股的法人独资）', '计算机、通信和其他电子设备制造业', '江西省吉安市井冈山经济技术开发区深圳大道226号', '各类覆铜板及粘结片材料的生产、销售、研发、技术开发及技术咨询服务；经营进出口业务。***(依法须经批准的项目,经相关部门批准后方可开展经营活动)。', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (619, NULL, NULL, NULL, NULL, '深圳市骏利精密刀具有限公司', NULL, NULL, '91440300071774900B', '人民币', '200万人民币', '廖振华', '2013-06-14 00:00:00', '有限责任公司', '电气机械和器材制造业', '深圳市宝安区沙井街道和二一路34号', '一般经营项目是：电路板刀具的销售（不含管制刀具）（以上均不含法律、行政法规、国务院决定规定须经批准的项目），许可经营项目是：电路板刀具的生产（不含管制刀具）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (626, NULL, NULL, NULL, NULL, '深圳市华中泰和科技有限公司', 'ShenZhen JinHaiTong Electronic Technology Co.Ltd.', NULL, '9144030075048338X9', '人民币', '3000万人民币', '池静芳', '2003-06-18 00:00:00', '有限责任公司（法人独资）', '计算机、通信和其他电子设备制造业', '深圳市福田区天安车公庙天经大厦F3.8栋4B座B1', '一般经营项目是：电子产品的技术开发与购销；国内商业、物资供销业（以上不含限制外商投资项目；专营、专控、专卖商品及限制项目）;印刷设备及周边设备的批发；经营进出口业务。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (677, NULL, NULL, NULL, NULL, '广州市番禺期远电子设备厂', 'QIYUAN ELECTRONICS LTD', NULL, '92440101L26479227G', '人民币', '10人民币', '张伟', '2009-05-20 00:00:00', '个体工商户', '专用设备制造业', '广州市番禺区大龙街市莲路新桥村段240号（2号厂房）103-1', '电子工业专用设备制造;电子元件及组件制造;其他办公设备维修;家用电子产品修理;日用电器修理;电气设备零售;电子设备工程安装服务;货物进出口（专营专控商品除外）;技术进出口;', NULL, '在业', 0);
INSERT INTO `sys_enterprise` VALUES (678, NULL, NULL, NULL, NULL, '江西企华流体科技有限公司', NULL, NULL, '91360703MA3AETPY4M', '人民币', '200万人民币', '曾庆文', '2021-07-29 00:00:00', '有限责任公司(自然人投资或控股)', '专用设备制造业', '江西省赣州市赣州经济技术开发区湖边大道北侧立昌科技（赣州）有限公司厂房（研发大楼一楼）', '一般项目：泵及真空设备销售，通用设备制造（不含特种设备制造）（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', NULL, '存续', 0);
INSERT INTO `sys_enterprise` VALUES (680, NULL, NULL, NULL, NULL, '东莞市航明电子有限公司', NULL, NULL, '9144190005677032XE', '人民币', '500万人民币', '李青燕', '2012-10-24 00:00:00', '有限责任公司(自然人独资)', '批发业', '广东省东莞市松山湖园区科技九路1号1栋317室', '销售、维修：电子产品、仪器仪表、五金机电设备；销售：防静电产品、机械配件、其他化工产品（不含危险化学品）、劳保用品；高分子材料、纤维材料的研发和销售；从事水处理领域的技术开发、技术咨询；电镀设备、电镀溶液净化系统、电镀过滤系统的研发及销售。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (681, NULL, NULL, NULL, NULL, '东莞市锐翔测控技术有限公司', NULL, NULL, '91441900MA53LTC68D', '人民币', '500万人民币', '罗贤林', '2019-08-15 00:00:00', '其他有限责任公司', '研究和试验发展', '广东省东莞市松山湖园区工业西路12号1栋203室', '研发、生产、销售：测量设备、光学检测设备、计算机设备及其配件（生产外包）；自动化测控技术的研发及技术服务；计算机软件的开发与销售；销售：电子元器件；自动化设备、自动化生产系统集成、工业机器人及其组件的研发、设计、生产和销售（生产外包）；自动化产品的维修、安装与调试；自动化产品的软件开发及技术咨询服务、技术转让；货物或技术进出口（国家禁止或涉及行政审批的货物和技术进出口除外）(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '小于50人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (682, NULL, NULL, NULL, NULL, '赣州市雪龙智能设备有限公司', NULL, NULL, '91360727MA3937MB6L', '人民币', '1000万人民币', '黄任龙', '2019-12-25 00:00:00', '其他有限责任公司', '批发业', '江西省赣州市龙南市龙南经济技术开发区赣州电子信息产业科技园比邦产业园三号厂房', '连线追溯码钻孔机、连线二次钻孔机、多轴数控钻孔机、CCD补偿成型机、多轴数控成型机及PCB干制程智能设备研发、制造及销售；PCB板钻孔及成型加工；设备的五金件机械加工、生产及销售；嵌入式软件的开发及销售；软件的开发销售及提供产品售后服务。(依法须经批准的项目,经相关部门批准后方可开展经营活动)', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (683, NULL, NULL, NULL, NULL, '深圳市哈福实业有限公司', NULL, NULL, '91440300708483220T', '人民币', '100万人民币', '李明军', '1999-02-14 00:00:00', '有限责任公司', '金属制品业', '深圳市宝安区松岗街道沙江路中海西岸华府南区5栋C单元15B', '一般经营项目是：锡条、锡丝的销售（不含加工生产项目）；国内商业、物资供销业（不含专营、专控、专卖商品）；普通货运（凭有效的许可证经营）。，许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (684, NULL, NULL, NULL, NULL, '东莞光恒星辉建筑有限公司', NULL, NULL, '91441900MA54UD7N1N', '人民币', '100万人民币', '陈就开', '2020-06-16 00:00:00', '有限责任公司(自然人独资)', '专业技术服务业', '广东省东莞市南城街道宏远路8号472室', '建筑工程设计；建筑工程施工；室内外装修装饰工程设计及施工；钢结构工程设计及施工；水利工程设计及施工；研发、技术服务、技术咨询、技术转让：建筑材料（不含危险化学品）；工程咨询；租赁：机械设备。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (685, NULL, NULL, NULL, NULL, '赣州市安而优建设工程有限公司', NULL, NULL, '91360727MA39A73Q62', '人民币', '200万人民币', '丁良文', '2020-08-25 00:00:00', '有限责任公司(自然人独资)', '土木工程建筑业', '江西省龙南市东江乡新圳村石龙围83号', '许可项目：各类工程建设活动，建设工程勘察，建设工程设计，公路工程监理，住宅室内装饰装修，建筑劳务分包（依法须经批准的项目，经相关部门批准后方可开展经营活动）一般项目：土石方工程施工，园林绿化工程施工，建筑用钢筋产品销售，建筑工程用机械销售，机械设备租赁，建筑材料销售，轻质建筑材料销售（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (686, NULL, NULL, NULL, NULL, '湖南五江高科技材料有限公司', NULL, NULL, '91431300MA4P8Y2J1M', '人民币', '28000万人民币', '肖志义', '2017-11-22 00:00:00', '其他有限责任公司', '研究和试验发展', '湖南省娄底市经济技术开发区群乐街北侧、南北三路西侧', '感光干膜的研究、生产和销售；感光材料、化工材料销售；及上述领域的技术咨询；自营商品的进出口业务（国家法律法规规定应经审批方可经营或禁止进出口的货物和技术除外）。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '100-499人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (687, NULL, NULL, NULL, NULL, '东莞市丰邦环氧地坪材料有限公司', NULL, NULL, '91441900MA51NEMB0G', '人民币', '5000万人民币', '吴双保', '2018-05-11 00:00:00', '有限责任公司(自然人独资)', '批发业', '广东省东莞市塘厦镇诸佛岭路111号311室', '销售：水性环氧地坪材料、环氧地坪材料、高分子材料、混泥土密封固化剂、环氧树脂固化剂、水性涂料、集合物彩色防滑路面、建筑材料（以上产品均不含危险化学品）；地坪工程施工；道路标线工程施工；建筑标牌工程施工；停车场交通标识安装工程。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', '-', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (688, NULL, NULL, NULL, NULL, '江西吉尔化工科技有限公司', NULL, NULL, '91360727MA37U3WY2B', '人民币', '600万人民币', '陈巍', '2018-04-18 00:00:00', '有限责任公司(自然人投资或控股)', '批发业', '江西省赣州市龙南市龙南经济技术开发区富康工业园D1-03', '许可项目：危险化学品经营（仅包括危险化学品经营许可证所列的危险化学品），非药品类易制毒化学品经营（仅包括非药品类易制毒化学品经营备案证明里所列的项目）(依法须经批准的项目,经相关部门批准后方可开展经营活动)一般项目：化工产品生产（不含许可类化工产品），化工产品销售（不含许可类化工产品），金属材料销售，生物化工产品技术研发（除许可业务外，可自主依法经营法律法规非禁止或限制的项目）', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (689, NULL, NULL, NULL, NULL, '深圳市鑫锦龙科技有限公司', NULL, NULL, '91440300MA5DRC4M30', '人民币', '300万人民币', '陈丽萍', '2016-12-27 00:00:00', '有限责任公司(自然人独资)', '批发业', '深圳市宝安区新安街道新安六路海语西湾C09商铺', '一般经营项目是：五金制品、PCB设备及耗材、电子元器件、电子产品、计算机及配件、仪器仪表、通信设备、家用电器、日用百货、保健用品（药品、食品、审批类医疗器械除外）、建筑装饰材料、建筑声学光学材料、卫浴用具、家具、木制品、玩具、橡胶塑料制品、汽车零配件、照明用具的技术开发与销售；纺织品、服装服饰、鞋、帽、饰品、工艺品的的设计及销售；国内贸易，货物及技术进出口（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营）；企业管理咨询（不含人才中介服务）。（法律、行政法规或者国务院决定禁止和规定在登记前须经批准的项目除外），许可经营项目是：预包装食品（不含复热）的销售。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (690, NULL, NULL, NULL, NULL, '深圳市住友电子材料有限公司', NULL, NULL, '91440300MA5ET5B278', '人民币', '1000万人民币', '洪叶', '2017-10-23 00:00:00', '有限责任公司', '批发业', '深圳市龙岗区坪地街道坪西社区西元路92号', '一般经营项目是：电子功能材料、电子设备、电子产品的技术开发及相关产品的销售；国内贸易、经营进出口业务（不含专营、专控、专卖商品）。，许可经营项目是：电子功能材料（以上不含易燃、易爆、危险化学品）的生产。', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (691, NULL, NULL, NULL, NULL, '深圳市港神机械有限公司', NULL, NULL, '91440300MA5G9G1348', '人民币', '100万人民币', '邓召兵', '2020-07-06 00:00:00', '有限责任公司', '零售业', '深圳市龙华区观澜街道桂香社区桂圆路34号迈丰工业区厂房101', '一般经营项目是：无，许可经营项目是：五金、塑料、滚轮的加工。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (692, NULL, NULL, NULL, NULL, '安徽环友科技有限公司', NULL, NULL, '91341502MA2RKATKXP', '人民币', '5000万人民币', '刘武庆', '2018-03-23 00:00:00', '有限责任公司(自然人投资或控股)', '科技推广和应用服务业', '六安市集中示范园区新安大道（莱伊得光电标饰有限公司内）', '电子科技领域内的技术研发、技术咨询、技术转让、技术服务；数控机床、五金刀具、机械零配件、金属制品的生产、加工及销售。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (693, NULL, NULL, NULL, NULL, '江西久丰暖通设备工程有限公司', NULL, NULL, '91360702MA3890A966', '人民币', '300万人民币', '袁育胜', '2018-11-27 00:00:00', '有限责任公司(自然人投资或控股)', '建筑装饰、装修和其他建筑业', '江西省赣州市章贡区通天岩路9号金城华府7号楼803室', '建筑装修装饰工程、空气净化工程、水电工程、除尘工程、通风工程设计施工；中央空调、空气能热水器 、家用电器销售、安装、维修、清洗； 铝合金、五金交电、太阳能设备、机电设备、制冷设备、电控设备、空气能设备、机电配件、水暖五金、电线电缆销售。(依法须经批准的项目,经相关部门批准后方可开展经营活动)****', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (694, NULL, NULL, NULL, NULL, '皓飞电子科技（昆山）有限公司', NULL, NULL, '913205835653423589', '人民币', '100万人民币', '黄中利', '2010-11-30 00:00:00', '有限责任公司', '批发业', '昆山市巴城镇东平路301号2#厂房213-2室', '电子科技领域内的技术开发、技术转让、技术咨询、技术服务；电子设备及配件、机械设备及配件、机电设备及配件的研发、生产、销售、维修；化工原料及化工产品（不含危险性化学品及易制毒化学品）、橡塑制品的销售；货物及技术的进出口业务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (695, NULL, NULL, NULL, NULL, '吉安宏达秋科技有限公司', 'Ji an Hotchain Technology Co., Ltd.', NULL, '913608270910821511', '人民币', '500万人民币', '彭小英', '2014-02-20 00:00:00', '有限责任公司(自然人投资或控股)', '化学原料和化学制品制造业', '遂川县工业园区（东区）', '化学镍金系列、OSP（铜面机保护膜）、电镀锡、棕化、除胶渣、化学沉铜、PCB辅料所涉及危险化学品的生产、批发（许可证有效期至2023年6月14日）及其产品的设计。国内商业、物资供销业、货物及技术的进出口（国家规定禁止、限制、前置许可的项目除外）。化工产品生产（不含许可类化工产品），专用化学产品制造（不含危险化学品），贵金属冶炼。（依法须经批准的项目，经相关部门批准后方可开展经营活动）', '小于50人', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (696, NULL, NULL, NULL, NULL, '番禺南沙殷田化工有限公司', NULL, NULL, '91440101618708203T', '美元', '3360万美元', '李兆辉', '1995-12-27 00:00:00', '有限责任公司(外国法人独资)', '研究和试验发展', '广州市南沙区广意路26号', '信息化学品制造（监控化学品、危险化学品除外）;涂料制造（监控化学品、危险化学品除外）;油墨及类似产品制造（监控化学品、危险化学品除外）;电子元件及组件制造;印制电路板制造;化学试剂和助剂销售（监控化学品、危险化学品除外）;涂料批发;电子元器件批发;销售本公司生产的产品（国家法律法规禁止经营的项目除外；涉及许可经营的产品需取得许可证后方可经营）;光伏设备及元器件制造;初级形态塑料及合成树脂制造（监控化学品、危险化学品除外）;其他合成材料制造（监控化学品、危险化学品除外）;粘合剂制造（监控化学品、危险化学品除外）;光电子器件及其他电子器件制造;锂离子电池制造;塑料薄膜制造;化工产品批发（危险化学品除外）;塑料制品批发;树脂及树脂制品批发;金属制品批发;电子专用材料开发与制造（光纤预制棒开发与制造除外）;商品批发贸易（涉及外资准入特别管理规定和许可审批的商品除外）;自有房地产经营活动;房屋租赁;场地租赁（不含仓储）;软件产品开发、生产;普通劳动防护用品制造;软件批发;软件服务;软件零售;化工产品批发（含危险化学品；不含成品油、易制毒化学品）;道路货物运输;卫生材料及医药用品制造;特种劳动防护用品制造', '100-499人', '在业', 0);
INSERT INTO `sys_enterprise` VALUES (697, NULL, NULL, NULL, NULL, '广东硕成科技股份有限公司', 'Guangdong Shuo Cheng Technology Co.Ltd', NULL, '914402320684889549', '人民币', '8088万人民币', '曾庆明', '2013-05-08 00:00:00', '其他股份有限公司(非上市)', '化学原料和化学制品制造业', '乳源县乳城镇侯公渡经济开发区氯碱特色产业基地', '胶粘剂、特殊功能复合材料及胶粘制品、各类胶带的生产、研发及销售；生产、销售：电子化学品及相关产品（危险化学品除外）；销售：化工原料及化工产品（不含危险、剧毒品）、树脂相关产品、电子设备及零配件；从事特殊功能复合材料及制品、功能性薄膜、合成树脂胶粘剂、胶带、电子产品的批发及进出口业务。(依法须经批准的项目，经相关部门批准后方可开展经营活动)〓', NULL, '开业', 0);
INSERT INTO `sys_enterprise` VALUES (698, NULL, NULL, NULL, NULL, '广东炎墨方案科技有限公司', NULL, NULL, '91441900MA57EK556P', '人民币', '500万人民币', '李明辉', '2021-11-10 00:00:00', '有限责任公司(自然人投资或控股)', NULL, '广东省东莞市茶山镇庵前街10号', '一般项目：电子专用材料研发；专用化学产品制造（不含危险化学品）；电子专用设备制造；油墨制造（不含危险化学品）；工业设计服务；技术服务、技术开发、技术咨询、技术交流、技术转让、技术推广；货物进出口；技术进出口。（除依法须经批准的项目外，凭营业执照依法自主开展经营活动）', NULL, '开业', 0);
INSERT INTO `sys_enterprise` VALUES (699, NULL, NULL, NULL, NULL, '普科达维（深圳）科技有限公司', NULL, NULL, '91440300MA5G08BD9B', '人民币', '100万人民币', '魏文军', '2019-12-12 00:00:00', '有限责任公司', '批发业', '深圳市宝安区新桥街道新桥社区下西新村四巷1号606', '一般经营项目是：层压设备、烘烤设备、贴膜设备、丝印设备、电路板设备、光电设备、通用设备及配件、线路板相关耗材、电子产品的研发与销售、上门维修安装；二手PCB设备的销售；国内贸易，货物及技术进出口。（法律、行政法规、国务院决定禁止的项目除外，限制的项目须取得许可后方可经营），许可经营项目是：', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (700, NULL, NULL, NULL, NULL, '深圳市大族超能激光科技有限公司', 'Hans MP Laser Technology Co.,Ltd.', NULL, '9144030031162681XB', '人民币', '5000万人民币', '高云峰', '2014-09-18 00:00:00', '有限责任公司（法人独资）', '批发业', '深圳市宝安区福永街道永福路101号', '一般经营项目是：工业激光设备及周边产品、机电一体化设备的技术开发与销售；国内贸易，货物及技术进出口。（以上均不含法律、行政法规、国务院决定规定须经批准的项目），许可经营项目是：工业激光设备及周边产品、机电一体化设备的生产。', '-', '存续', 0);
INSERT INTO `sys_enterprise` VALUES (775, '2023-06-01 08:35:38', '2023-06-01 13:50:50', 'admin', 'admin', 'ab', 'c', 'a', 'a', 'a', 'a', 'a', '2023-06-06 00:00:00', 'a', 'a', 'a', 'aaaa', '22', 'a', NULL);
INSERT INTO `sys_enterprise` VALUES (779, '2023-06-01 13:47:49', '2023-06-01 13:50:50', 'admin', 'admin', 'b', 'b', 'b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_enterprise` VALUES (780, '2023-06-01 13:50:56', '2023-06-03 23:45:27', 'admin', 'admin', 'a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_enterprise` VALUES (781, '2023-06-01 14:14:01', '2023-06-01 14:14:10', 'admin', 'admin', 'b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_enterprise` VALUES (782, '2023-06-06 17:22:39', NULL, 'admin', NULL, '北京阿里巴巴信息技术有限公司', 'Beijing Alibaba Information and Technology Co.,Ltd.', NULL, '911101057001486120', '人民币', '56000万人民币', '马云', '2019-07-18 00:00:00', '有限责任公司(外商投资企业与内资合资)', '软件和信息技术服务业', '北京市朝阳区西大望路甲12号(国家广告产业园区)B座6层', '技术开发、技术转让、技术咨询、技术服务；计算机技术培训。（企业依法自主选择经营项目，开展经营活动；依法须经批准的项目，经相关部门批准后依批准的内容开展经营活动；不得从事本市产业政策禁止和限制类项目的经营活动。）', NULL, '注销', 0);

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
  `ip` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `tenant_id` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户',
  `exception_desc` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '异常描述',
  `request_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求 URL',
  `request_method` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方式',
  `request_param` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `request_time` bigint(0) NULL DEFAULT NULL COMMENT '请求耗时',
  `method_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 290 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, '2023-05-29 16:00:16', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 396, '-');
INSERT INTO `sys_log` VALUES (2, '2023-05-29 16:00:35', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 111, '-');
INSERT INTO `sys_log` VALUES (3, '2023-05-29 19:47:23', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 286, '-');
INSERT INTO `sys_log` VALUES (4, '2023-05-29 19:52:30', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 125, '-');
INSERT INTO `sys_log` VALUES (5, '2023-05-29 20:13:26', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 307, '-');
INSERT INTO `sys_log` VALUES (6, '2023-05-29 20:14:34', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 117, '-');
INSERT INTO `sys_log` VALUES (7, '2023-05-29 20:15:03', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 144, '-');
INSERT INTO `sys_log` VALUES (8, '2023-05-29 20:15:23', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 117, '-');
INSERT INTO `sys_log` VALUES (9, '2023-05-29 20:21:47', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 132, '-');
INSERT INTO `sys_log` VALUES (10, '2023-05-29 20:35:36', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 121, '-');
INSERT INTO `sys_log` VALUES (11, '2023-05-29 20:40:16', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 132, '-');
INSERT INTO `sys_log` VALUES (12, '2023-05-29 21:43:46', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 297, '-');
INSERT INTO `sys_log` VALUES (13, '2023-05-29 21:44:21', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 131, '-');
INSERT INTO `sys_log` VALUES (14, '2023-05-29 21:44:51', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 130, '-');
INSERT INTO `sys_log` VALUES (15, '2023-05-29 21:47:16', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 152, '-');
INSERT INTO `sys_log` VALUES (16, '2023-05-29 21:47:43', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (17, '2023-05-29 21:49:41', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 286, '-');
INSERT INTO `sys_log` VALUES (18, '2023-05-29 21:50:29', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 113, '-');
INSERT INTO `sys_log` VALUES (19, '2023-05-29 21:51:19', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 124, '-');
INSERT INTO `sys_log` VALUES (20, '2023-05-29 21:56:35', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 123, '-');
INSERT INTO `sys_log` VALUES (21, '2023-05-29 21:57:11', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 114, '-');
INSERT INTO `sys_log` VALUES (22, '2023-05-29 21:58:24', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 113, '-');
INSERT INTO `sys_log` VALUES (23, '2023-05-30 10:37:51', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 156, '-');
INSERT INTO `sys_log` VALUES (24, '2023-05-30 11:16:34', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 259, '-');
INSERT INTO `sys_log` VALUES (25, '2023-05-30 11:16:47', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 210, '-');
INSERT INTO `sys_log` VALUES (26, '2023-05-30 11:16:59', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 117, '-');
INSERT INTO `sys_log` VALUES (27, '2023-05-30 11:17:37', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 127, '-');
INSERT INTO `sys_log` VALUES (28, '2023-05-30 11:19:03', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 145, '-');
INSERT INTO `sys_log` VALUES (29, '2023-05-30 11:19:22', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 126, '-');
INSERT INTO `sys_log` VALUES (30, '2023-05-30 11:24:55', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 301, '-');
INSERT INTO `sys_log` VALUES (31, '2023-05-30 11:33:45', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 131, '-');
INSERT INTO `sys_log` VALUES (32, '2023-05-30 11:33:55', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 116, '-');
INSERT INTO `sys_log` VALUES (33, '2023-05-30 11:34:11', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 154, '-');
INSERT INTO `sys_log` VALUES (34, '2023-05-30 11:34:27', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 122, '-');
INSERT INTO `sys_log` VALUES (35, '2023-05-30 11:51:08', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 317, '-');
INSERT INTO `sys_log` VALUES (36, '2023-05-30 11:51:28', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 119, '-');
INSERT INTO `sys_log` VALUES (37, '2023-05-30 11:51:47', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 140, '-');
INSERT INTO `sys_log` VALUES (38, '2023-05-30 11:52:32', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 145, '-');
INSERT INTO `sys_log` VALUES (39, '2023-05-30 11:53:07', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 119, '-');
INSERT INTO `sys_log` VALUES (40, '2023-05-30 16:47:28', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 161, '-');
INSERT INTO `sys_log` VALUES (41, '2023-05-30 16:47:36', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 121, '-');
INSERT INTO `sys_log` VALUES (42, '2023-05-30 17:11:39', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 300, '-');
INSERT INTO `sys_log` VALUES (43, '2023-05-30 17:12:22', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 142, '-');
INSERT INTO `sys_log` VALUES (44, '2023-05-30 17:12:53', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 133, '-');
INSERT INTO `sys_log` VALUES (45, '2023-05-30 17:13:08', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 122, '-');
INSERT INTO `sys_log` VALUES (46, '2023-05-30 17:13:49', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 173, '-');
INSERT INTO `sys_log` VALUES (47, '2023-05-30 17:14:11', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 168, '-');
INSERT INTO `sys_log` VALUES (48, '2023-05-30 17:14:27', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 125, '-');
INSERT INTO `sys_log` VALUES (49, '2023-05-30 17:17:36', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 110, '-');
INSERT INTO `sys_log` VALUES (50, '2023-05-30 17:27:59', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 257, '-');
INSERT INTO `sys_log` VALUES (51, '2023-05-30 17:28:13', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 132, '-');
INSERT INTO `sys_log` VALUES (52, '2023-05-30 17:28:36', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 130, '-');
INSERT INTO `sys_log` VALUES (53, '2023-05-30 17:28:51', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 109, '-');
INSERT INTO `sys_log` VALUES (54, '2023-05-30 17:29:17', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 108, '-');
INSERT INTO `sys_log` VALUES (55, '2023-05-30 17:29:40', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 182, '-');
INSERT INTO `sys_log` VALUES (56, '2023-05-30 17:29:57', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 116, '-');
INSERT INTO `sys_log` VALUES (57, '2023-05-30 17:31:23', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 145, '-');
INSERT INTO `sys_log` VALUES (58, '2023-05-30 17:31:41', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 146, '-');
INSERT INTO `sys_log` VALUES (59, '2023-05-30 17:32:35', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 125, '-');
INSERT INTO `sys_log` VALUES (60, '2023-05-30 17:32:56', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 116, '-');
INSERT INTO `sys_log` VALUES (61, '2023-05-30 22:40:42', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 364, '-');
INSERT INTO `sys_log` VALUES (62, '2023-05-30 22:41:18', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 160, '-');
INSERT INTO `sys_log` VALUES (63, '2023-05-30 22:41:33', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 164, '-');
INSERT INTO `sys_log` VALUES (64, '2023-05-30 23:10:54', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 383, '-');
INSERT INTO `sys_log` VALUES (65, '2023-05-30 23:12:09', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 123, '-');
INSERT INTO `sys_log` VALUES (66, '2023-05-30 23:12:23', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 142, '-');
INSERT INTO `sys_log` VALUES (67, '2023-05-30 23:13:16', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 114, '-');
INSERT INTO `sys_log` VALUES (68, '2023-05-30 23:13:28', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 129, '-');
INSERT INTO `sys_log` VALUES (69, '2023-05-30 23:13:52', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 127, '-');
INSERT INTO `sys_log` VALUES (70, '2023-05-30 23:14:04', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 148, '-');
INSERT INTO `sys_log` VALUES (71, '2023-05-30 23:14:24', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 110, '-');
INSERT INTO `sys_log` VALUES (72, '2023-05-30 23:14:36', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 142, '-');
INSERT INTO `sys_log` VALUES (73, '2023-05-30 23:14:56', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 123, '-');
INSERT INTO `sys_log` VALUES (74, '2023-05-30 23:15:28', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 121, '-');
INSERT INTO `sys_log` VALUES (75, '2023-05-30 23:15:44', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 125, '-');
INSERT INTO `sys_log` VALUES (76, '2023-05-30 23:15:58', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 128, '-');
INSERT INTO `sys_log` VALUES (77, '2023-05-30 23:16:26', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 114, '-');
INSERT INTO `sys_log` VALUES (78, '2023-05-30 23:16:38', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 125, '-');
INSERT INTO `sys_log` VALUES (79, '2023-05-30 23:16:53', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (80, '2023-05-30 23:17:13', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (81, '2023-05-30 23:17:36', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 133, '-');
INSERT INTO `sys_log` VALUES (82, '2023-05-31 09:00:10', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 177, '-');
INSERT INTO `sys_log` VALUES (83, '2023-05-31 09:40:28', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 225, '-');
INSERT INTO `sys_log` VALUES (84, '2023-05-31 09:49:34', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 381, '-');
INSERT INTO `sys_log` VALUES (85, '2023-05-31 09:56:50', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 369, '-');
INSERT INTO `sys_log` VALUES (86, '2023-05-31 10:05:28', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 261, '-');
INSERT INTO `sys_log` VALUES (87, '2023-05-31 10:12:14', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 271, '-');
INSERT INTO `sys_log` VALUES (88, '2023-05-31 10:34:24', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 177, '-');
INSERT INTO `sys_log` VALUES (89, '2023-05-31 10:34:47', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (90, '2023-05-31 10:35:08', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 136, '-');
INSERT INTO `sys_log` VALUES (91, '2023-05-31 14:30:07', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 421, '-');
INSERT INTO `sys_log` VALUES (92, '2023-05-31 14:34:16', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 419, '-');
INSERT INTO `sys_log` VALUES (93, '2023-05-31 15:41:26', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 658, '-');
INSERT INTO `sys_log` VALUES (94, '2023-05-31 22:13:51', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 1093, '-');
INSERT INTO `sys_log` VALUES (95, '2023-06-01 08:04:35', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 129, '-');
INSERT INTO `sys_log` VALUES (96, '2023-06-01 09:05:10', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 217, '-');
INSERT INTO `sys_log` VALUES (97, '2023-06-01 09:30:22', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 390, '-');
INSERT INTO `sys_log` VALUES (98, '2023-06-01 09:32:51', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 132, '-');
INSERT INTO `sys_log` VALUES (99, '2023-06-01 09:55:40', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 162, '-');
INSERT INTO `sys_log` VALUES (100, '2023-06-01 14:06:36', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 154, '-');
INSERT INTO `sys_log` VALUES (101, '2023-06-01 14:09:42', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 118, '-');
INSERT INTO `sys_log` VALUES (102, '2023-06-01 14:13:29', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 149, '-');
INSERT INTO `sys_log` VALUES (103, '2023-06-01 14:14:41', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (104, '2023-06-01 14:14:50', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 153, '-');
INSERT INTO `sys_log` VALUES (105, '2023-06-01 14:15:42', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 141, '-');
INSERT INTO `sys_log` VALUES (106, '2023-06-01 16:17:46', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 162, '-');
INSERT INTO `sys_log` VALUES (107, '2023-06-01 16:18:34', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 290, '-');
INSERT INTO `sys_log` VALUES (108, '2023-06-02 08:42:13', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 293, '-');
INSERT INTO `sys_log` VALUES (109, '2023-06-02 13:49:23', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 148, '-');
INSERT INTO `sys_log` VALUES (110, '2023-06-02 14:40:34', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 321, '-');
INSERT INTO `sys_log` VALUES (111, '2023-06-02 14:40:57', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 112, '-');
INSERT INTO `sys_log` VALUES (112, '2023-06-02 14:43:40', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 129, '-');
INSERT INTO `sys_log` VALUES (113, '2023-06-02 14:43:49', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 118, '-');
INSERT INTO `sys_log` VALUES (114, '2023-06-02 14:46:43', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 117, '-');
INSERT INTO `sys_log` VALUES (115, '2023-06-02 14:47:05', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 139, '-');
INSERT INTO `sys_log` VALUES (116, '2023-06-02 14:47:28', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 111, '-');
INSERT INTO `sys_log` VALUES (117, '2023-06-02 14:47:39', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 131, '-');
INSERT INTO `sys_log` VALUES (118, '2023-06-02 14:50:00', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 127, '-');
INSERT INTO `sys_log` VALUES (119, '2023-06-02 14:50:10', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 130, '-');
INSERT INTO `sys_log` VALUES (120, '2023-06-02 15:10:41', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 269, '-');
INSERT INTO `sys_log` VALUES (121, '2023-06-02 15:10:52', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (122, '2023-06-02 15:11:06', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 148, '-');
INSERT INTO `sys_log` VALUES (123, '2023-06-02 15:11:19', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 111, '-');
INSERT INTO `sys_log` VALUES (124, '2023-06-02 15:11:38', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 106, '-');
INSERT INTO `sys_log` VALUES (125, '2023-06-02 15:11:49', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 131, '-');
INSERT INTO `sys_log` VALUES (126, '2023-06-02 16:16:07', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 236, '-');
INSERT INTO `sys_log` VALUES (127, '2023-06-02 16:16:24', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 211, '-');
INSERT INTO `sys_log` VALUES (128, '2023-06-02 16:20:25', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 171, '-');
INSERT INTO `sys_log` VALUES (129, '2023-06-02 16:20:35', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 186, '-');
INSERT INTO `sys_log` VALUES (130, '2023-06-02 16:20:54', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 156, '-');
INSERT INTO `sys_log` VALUES (131, '2023-06-02 16:21:12', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 259, '-');
INSERT INTO `sys_log` VALUES (132, '2023-06-02 16:21:34', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 247, '-');
INSERT INTO `sys_log` VALUES (133, '2023-06-02 16:21:49', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 150, '-');
INSERT INTO `sys_log` VALUES (134, '2023-06-02 16:22:08', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 203, '-');
INSERT INTO `sys_log` VALUES (135, '2023-06-02 16:22:19', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 139, '-');
INSERT INTO `sys_log` VALUES (136, '2023-06-02 16:22:39', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 139, '-');
INSERT INTO `sys_log` VALUES (137, '2023-06-02 16:22:55', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 177, '-');
INSERT INTO `sys_log` VALUES (138, '2023-06-02 16:23:04', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 166, '-');
INSERT INTO `sys_log` VALUES (139, '2023-06-02 16:23:33', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 242, '-');
INSERT INTO `sys_log` VALUES (140, '2023-06-02 16:24:34', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 572, '-');
INSERT INTO `sys_log` VALUES (141, '2023-06-02 16:31:46', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 158, '-');
INSERT INTO `sys_log` VALUES (142, '2023-06-02 16:32:29', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 251, '-');
INSERT INTO `sys_log` VALUES (143, '2023-06-02 16:33:53', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 262, '-');
INSERT INTO `sys_log` VALUES (144, '2023-06-02 16:34:15', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 291, '-');
INSERT INTO `sys_log` VALUES (145, '2023-06-02 16:34:46', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 187, '-');
INSERT INTO `sys_log` VALUES (146, '2023-06-02 16:36:35', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 174, '-');
INSERT INTO `sys_log` VALUES (147, '2023-06-02 16:37:26', NULL, 'test1', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 312, '-');
INSERT INTO `sys_log` VALUES (148, '2023-06-02 16:37:49', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 164, '-');
INSERT INTO `sys_log` VALUES (149, '2023-06-02 16:38:27', NULL, 'test1', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 209, '-');
INSERT INTO `sys_log` VALUES (150, '2023-06-02 16:38:45', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 209, '-');
INSERT INTO `sys_log` VALUES (151, '2023-06-02 16:39:02', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 201, '-');
INSERT INTO `sys_log` VALUES (152, '2023-06-02 16:39:26', NULL, 'test1', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 159, '-');
INSERT INTO `sys_log` VALUES (153, '2023-06-02 16:39:50', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 315, '-');
INSERT INTO `sys_log` VALUES (154, '2023-06-02 16:40:02', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 154, '-');
INSERT INTO `sys_log` VALUES (155, '2023-06-02 16:40:16', NULL, 'test1', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 163, '-');
INSERT INTO `sys_log` VALUES (156, '2023-06-02 16:40:37', NULL, 'test1', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 228, '-');
INSERT INTO `sys_log` VALUES (157, '2023-06-02 16:40:51', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 270, '-');
INSERT INTO `sys_log` VALUES (158, '2023-06-02 16:41:26', NULL, 'test1', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 254, '-');
INSERT INTO `sys_log` VALUES (159, '2023-06-02 16:41:39', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 185, '-');
INSERT INTO `sys_log` VALUES (160, '2023-06-02 16:43:30', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '964367', NULL, '/login', 'POST', '-', 178, '-');
INSERT INTO `sys_log` VALUES (161, '2023-06-02 16:44:31', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 160, '-');
INSERT INTO `sys_log` VALUES (162, '2023-06-02 16:44:48', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '964367', NULL, '/login', 'POST', '-', 159, '-');
INSERT INTO `sys_log` VALUES (163, '2023-06-02 16:46:20', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '964367', NULL, '/login', 'POST', '-', 333, '-');
INSERT INTO `sys_log` VALUES (164, '2023-06-02 16:46:31', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 225, '-');
INSERT INTO `sys_log` VALUES (165, '2023-06-02 16:47:05', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '964367', NULL, '/login', 'POST', '-', 249, '-');
INSERT INTO `sys_log` VALUES (166, '2023-06-02 16:47:23', NULL, 'test1', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 196, '-');
INSERT INTO `sys_log` VALUES (167, '2023-06-02 16:47:38', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '964367', NULL, '/login', 'POST', '-', 175, '-');
INSERT INTO `sys_log` VALUES (168, '2023-06-02 16:48:03', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 147, '-');
INSERT INTO `sys_log` VALUES (169, '2023-06-02 16:48:43', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 160, '-');
INSERT INTO `sys_log` VALUES (170, '2023-06-02 16:49:04', NULL, 'test1', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 156, '-');
INSERT INTO `sys_log` VALUES (171, '2023-06-02 16:49:17', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 161, '-');
INSERT INTO `sys_log` VALUES (172, '2023-06-02 21:38:56', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 142, '-');
INSERT INTO `sys_log` VALUES (173, '2023-06-03 08:35:17', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 153, '-');
INSERT INTO `sys_log` VALUES (174, '2023-06-03 09:44:27', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '250531', NULL, '/login', 'POST', '-', 304, '-');
INSERT INTO `sys_log` VALUES (175, '2023-06-03 09:44:48', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 115, '-');
INSERT INTO `sys_log` VALUES (176, '2023-06-03 09:49:11', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 151, '-');
INSERT INTO `sys_log` VALUES (177, '2023-06-03 09:50:23', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 119, '-');
INSERT INTO `sys_log` VALUES (178, '2023-06-03 10:18:07', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 129, '-');
INSERT INTO `sys_log` VALUES (179, '2023-06-03 10:18:32', NULL, 'lw', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 122, '-');
INSERT INTO `sys_log` VALUES (180, '2023-06-03 10:46:04', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '619889', NULL, '/login', 'POST', '-', 303, '-');
INSERT INTO `sys_log` VALUES (181, '2023-06-03 11:31:11', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 299, '-');
INSERT INTO `sys_log` VALUES (182, '2023-06-03 11:39:06', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 182, '-');
INSERT INTO `sys_log` VALUES (183, '2023-06-03 18:37:09', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 405, '-');
INSERT INTO `sys_log` VALUES (184, '2023-06-03 19:39:59', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 315, '-');
INSERT INTO `sys_log` VALUES (185, '2023-06-03 19:40:08', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 117, '-');
INSERT INTO `sys_log` VALUES (186, '2023-06-03 19:40:21', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 127, '-');
INSERT INTO `sys_log` VALUES (187, '2023-06-03 19:41:01', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (188, '2023-06-03 19:41:13', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 206, '-');
INSERT INTO `sys_log` VALUES (189, '2023-06-03 19:41:39', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 125, '-');
INSERT INTO `sys_log` VALUES (190, '2023-06-03 19:41:54', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 122, '-');
INSERT INTO `sys_log` VALUES (191, '2023-06-03 20:12:19', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 316, '-');
INSERT INTO `sys_log` VALUES (192, '2023-06-03 20:12:32', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 126, '-');
INSERT INTO `sys_log` VALUES (193, '2023-06-03 20:27:06', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 335, '-');
INSERT INTO `sys_log` VALUES (194, '2023-06-03 20:44:26', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 284, '-');
INSERT INTO `sys_log` VALUES (195, '2023-06-03 20:44:39', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 146, '-');
INSERT INTO `sys_log` VALUES (196, '2023-06-03 20:45:20', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 123, '-');
INSERT INTO `sys_log` VALUES (197, '2023-06-03 20:45:35', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 122, '-');
INSERT INTO `sys_log` VALUES (198, '2023-06-03 20:46:22', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 124, '-');
INSERT INTO `sys_log` VALUES (199, '2023-06-03 20:46:35', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 119, '-');
INSERT INTO `sys_log` VALUES (200, '2023-06-03 20:46:57', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 122, '-');
INSERT INTO `sys_log` VALUES (201, '2023-06-03 20:47:20', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 120, '-');
INSERT INTO `sys_log` VALUES (202, '2023-06-03 20:47:33', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 115, '-');
INSERT INTO `sys_log` VALUES (203, '2023-06-03 20:48:32', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 128, '-');
INSERT INTO `sys_log` VALUES (204, '2023-06-03 20:48:52', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 129, '-');
INSERT INTO `sys_log` VALUES (205, '2023-06-03 20:49:07', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 119, '-');
INSERT INTO `sys_log` VALUES (206, '2023-06-03 20:49:36', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 118, '-');
INSERT INTO `sys_log` VALUES (207, '2023-06-03 20:51:18', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 114, '-');
INSERT INTO `sys_log` VALUES (208, '2023-06-03 20:51:50', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 121, '-');
INSERT INTO `sys_log` VALUES (209, '2023-06-03 20:52:16', NULL, 'test', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 123, '-');
INSERT INTO `sys_log` VALUES (210, '2023-06-03 20:52:37', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 112, '-');
INSERT INTO `sys_log` VALUES (211, '2023-06-03 20:53:07', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 125, '-');
INSERT INTO `sys_log` VALUES (212, '2023-06-03 20:54:02', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 140, '-');
INSERT INTO `sys_log` VALUES (213, '2023-06-03 21:03:49', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 129, '-');
INSERT INTO `sys_log` VALUES (214, '2023-06-03 21:05:40', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 117, '-');
INSERT INTO `sys_log` VALUES (215, '2023-06-03 21:29:38', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 140, '-');
INSERT INTO `sys_log` VALUES (216, '2023-06-03 22:08:45', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 149, '-');
INSERT INTO `sys_log` VALUES (217, '2023-06-03 22:10:44', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (218, '2023-06-03 22:11:13', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (219, '2023-06-03 22:11:29', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 142, '-');
INSERT INTO `sys_log` VALUES (220, '2023-06-03 22:12:16', NULL, 'wangwu', NULL, 1, '127.0.0.1', '用户登录', '854554', NULL, '/login', 'POST', '-', 110, '-');
INSERT INTO `sys_log` VALUES (221, '2023-06-03 22:13:18', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 133, '-');
INSERT INTO `sys_log` VALUES (222, '2023-06-03 23:10:47', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 146, '-');
INSERT INTO `sys_log` VALUES (223, '2023-06-03 23:44:31', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 376, '-');
INSERT INTO `sys_log` VALUES (224, '2023-06-04 08:03:15', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 243, '-');
INSERT INTO `sys_log` VALUES (225, '2023-06-04 09:55:21', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 117925, '-');
INSERT INTO `sys_log` VALUES (226, '2023-06-04 09:57:49', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 85325, '-');
INSERT INTO `sys_log` VALUES (227, '2023-06-04 10:03:26', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 14363, '-');
INSERT INTO `sys_log` VALUES (228, '2023-06-04 14:05:12', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 383, '-');
INSERT INTO `sys_log` VALUES (229, '2023-06-04 14:11:30', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 11564, '-');
INSERT INTO `sys_log` VALUES (230, '2023-06-04 14:11:42', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 151, '-');
INSERT INTO `sys_log` VALUES (231, '2023-06-04 14:26:08', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 350, '-');
INSERT INTO `sys_log` VALUES (232, '2023-06-04 14:50:39', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 164, '-');
INSERT INTO `sys_log` VALUES (233, '2023-06-04 14:51:21', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 169, '-');
INSERT INTO `sys_log` VALUES (234, '2023-06-04 21:40:44', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 203, '-');
INSERT INTO `sys_log` VALUES (235, '2023-06-05 08:05:59', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 178, '-');
INSERT INTO `sys_log` VALUES (236, '2023-06-05 09:18:00', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 143, '-');
INSERT INTO `sys_log` VALUES (237, '2023-06-05 14:44:28', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 263, '-');
INSERT INTO `sys_log` VALUES (238, '2023-06-05 16:03:10', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 260, '-');
INSERT INTO `sys_log` VALUES (239, '2023-06-06 08:11:12', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 192, '-');
INSERT INTO `sys_log` VALUES (240, '2023-06-06 15:22:45', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 560, '-');
INSERT INTO `sys_log` VALUES (241, '2023-06-06 16:10:02', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 277, '-');
INSERT INTO `sys_log` VALUES (242, '2023-06-06 16:25:38', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 196, '-');
INSERT INTO `sys_log` VALUES (243, '2023-06-06 16:50:24', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 322, '-');
INSERT INTO `sys_log` VALUES (244, '2023-06-06 17:17:48', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 147, '-');
INSERT INTO `sys_log` VALUES (245, '2023-06-06 17:23:43', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '059218', NULL, '/login', 'POST', '-', 132, '-');
INSERT INTO `sys_log` VALUES (246, '2023-06-06 17:26:48', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 135, '-');
INSERT INTO `sys_log` VALUES (247, '2023-06-06 17:28:56', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '059218', NULL, '/login', 'POST', '-', 168, '-');
INSERT INTO `sys_log` VALUES (248, '2023-06-06 17:29:14', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 155, '-');
INSERT INTO `sys_log` VALUES (249, '2023-06-06 17:35:11', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 175, '-');
INSERT INTO `sys_log` VALUES (250, '2023-06-06 17:49:38', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 152, '-');
INSERT INTO `sys_log` VALUES (251, '2023-06-06 17:49:46', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '059218', NULL, '/login', 'POST', '-', 143, '-');
INSERT INTO `sys_log` VALUES (252, '2023-06-06 17:50:25', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 130, '-');
INSERT INTO `sys_log` VALUES (253, '2023-06-06 17:50:43', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 160, '-');
INSERT INTO `sys_log` VALUES (254, '2023-06-06 17:50:55', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '059218', NULL, '/login', 'POST', '-', 170, '-');
INSERT INTO `sys_log` VALUES (255, '2023-06-06 17:53:25', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 133, '-');
INSERT INTO `sys_log` VALUES (256, '2023-06-06 17:56:45', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '059218', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (257, '2023-06-06 17:57:01', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 140, '-');
INSERT INTO `sys_log` VALUES (258, '2023-06-06 17:57:08', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 150, '-');
INSERT INTO `sys_log` VALUES (259, '2023-06-06 17:57:18', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '059218', NULL, '/login', 'POST', '-', 164, '-');
INSERT INTO `sys_log` VALUES (260, '2023-06-06 17:57:42', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 185, '-');
INSERT INTO `sys_log` VALUES (261, '2023-06-06 17:58:46', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '059218', NULL, '/login', 'POST', '-', 150, '-');
INSERT INTO `sys_log` VALUES (262, '2023-06-06 19:48:51', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 187, '-');
INSERT INTO `sys_log` VALUES (263, '2023-06-06 21:57:04', NULL, 'lw', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 335, '-');
INSERT INTO `sys_log` VALUES (264, '2023-06-06 21:58:10', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 144, '-');
INSERT INTO `sys_log` VALUES (265, '2023-06-06 21:58:54', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 150, '-');
INSERT INTO `sys_log` VALUES (266, '2023-06-06 21:59:21', NULL, 'aa', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 156, '-');
INSERT INTO `sys_log` VALUES (267, '2023-06-06 21:59:47', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 163, '-');
INSERT INTO `sys_log` VALUES (268, '2023-06-06 22:16:34', NULL, 'lw', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 237, '-');
INSERT INTO `sys_log` VALUES (269, '2023-06-06 22:18:36', NULL, 'aa', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 141, '-');
INSERT INTO `sys_log` VALUES (270, '2023-06-06 22:19:14', NULL, 'znpi', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 151, '-');
INSERT INTO `sys_log` VALUES (271, '2023-06-06 22:19:38', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 143, '-');
INSERT INTO `sys_log` VALUES (272, '2023-06-06 22:19:53', NULL, 'lw', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 156, '-');
INSERT INTO `sys_log` VALUES (273, '2023-06-06 22:20:09', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 141, '-');
INSERT INTO `sys_log` VALUES (274, '2023-06-06 22:20:39', NULL, 'lw', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 191, '-');
INSERT INTO `sys_log` VALUES (275, '2023-06-06 22:22:40', NULL, 'aa', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 134, '-');
INSERT INTO `sys_log` VALUES (276, '2023-06-06 22:23:12', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 148, '-');
INSERT INTO `sys_log` VALUES (277, '2023-06-06 22:23:26', NULL, 'lw', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 127, '-');
INSERT INTO `sys_log` VALUES (278, '2023-06-06 22:24:15', NULL, 'aa', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 130, '-');
INSERT INTO `sys_log` VALUES (279, '2023-06-06 22:24:51', NULL, 'lw', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 146, '-');
INSERT INTO `sys_log` VALUES (280, '2023-06-06 22:26:08', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 160, '-');
INSERT INTO `sys_log` VALUES (281, '2023-06-06 22:26:22', NULL, 'aa', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 151, '-');
INSERT INTO `sys_log` VALUES (282, '2023-06-06 22:26:47', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 188, '-');
INSERT INTO `sys_log` VALUES (283, '2023-06-06 22:27:13', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '059218', NULL, '/login', 'POST', '-', 126, '-');
INSERT INTO `sys_log` VALUES (284, '2023-06-06 22:27:34', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 132, '-');
INSERT INTO `sys_log` VALUES (285, '2023-06-07 08:23:41', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 186, '-');
INSERT INTO `sys_log` VALUES (286, '2023-06-07 10:43:16', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 175, '-');
INSERT INTO `sys_log` VALUES (287, '2023-06-07 11:03:33', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 383, '-');
INSERT INTO `sys_log` VALUES (288, '2023-06-07 11:03:58', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 141, '-');
INSERT INTO `sys_log` VALUES (289, '2023-06-07 11:04:18', NULL, '00001', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 157, '-');
INSERT INTO `sys_log` VALUES (290, '2023-06-07 11:04:52', NULL, 'admin', NULL, 1, '127.0.0.1', '用户登录', '000000', NULL, '/login', 'POST', '-', 134, '-');

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
INSERT INTO `sys_menu` VALUES (37, '2022-12-06 14:57:53', '2023-06-03 11:38:10', 'admin', 'admin', '菜单新增', NULL, NULL, NULL, 'sys_menu_add', NULL, 2, 1, 3, 0, 1, NULL, 5, 0, NULL);
INSERT INTO `sys_menu` VALUES (38, '2022-12-06 14:58:12', '2023-06-03 11:38:17', 'admin', 'admin', '菜单修改', NULL, NULL, NULL, 'sys_menu_edit', NULL, 3, 1, 3, 0, 1, NULL, 5, 0, NULL);
INSERT INTO `sys_menu` VALUES (39, '2022-12-06 14:58:39', '2023-06-03 11:38:17', 'admin', 'admin', '菜单删除', NULL, NULL, NULL, 'sys_menu_delete', NULL, 4, 1, 3, 0, 1, NULL, 5, 0, NULL);
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
INSERT INTO `sys_menu` VALUES (141, '2023-06-06 17:33:03', '2023-06-06 17:43:07', 'admin', 'admin', '更改状态', NULL, NULL, NULL, 'workflow_deployment_update', NULL, 3, 1, 3, 0, 1, NULL, 72, 0, NULL);
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
INSERT INTO `sys_package` VALUES (3, '2023-05-26 16:07:59', '2023-06-01 17:15:43', 'admin', 'admin', '套餐2', 1, NULL, '');
INSERT INTO `sys_package` VALUES (4, '2023-06-01 16:19:09', '2023-06-01 16:37:03', 'admin', 'admin', '套餐1', 1, NULL, NULL);
INSERT INTO `sys_package` VALUES (5, '2023-06-01 16:37:50', '2023-06-01 16:46:50', 'admin', 'admin', 'a', 1, NULL, NULL);
INSERT INTO `sys_package` VALUES (7, '2023-06-01 17:38:56', '2023-06-01 17:39:09', 'admin', 'admin', 'a', 1, NULL, NULL);
INSERT INTO `sys_package` VALUES (8, '2023-06-01 17:39:14', '2023-06-03 23:48:09', 'admin', 'admin', 'b', 1, NULL, NULL);

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
INSERT INTO `sys_package_menu` VALUES (36, 2, 33);
INSERT INTO `sys_package_menu` VALUES (37, 2, 16);
INSERT INTO `sys_package_menu` VALUES (38, 2, 3);
INSERT INTO `sys_package_menu` VALUES (39, 2, 35);
INSERT INTO `sys_package_menu` VALUES (40, 2, 34);
INSERT INTO `sys_package_menu` VALUES (41, 2, 15);
INSERT INTO `sys_package_menu` VALUES (42, 2, 14);
INSERT INTO `sys_package_menu` VALUES (53, 2, 40);
INSERT INTO `sys_package_menu` VALUES (55, 2, 36);
INSERT INTO `sys_package_menu` VALUES (58, 2, 32);
INSERT INTO `sys_package_menu` VALUES (59, 2, 29);
INSERT INTO `sys_package_menu` VALUES (60, 2, 31);
INSERT INTO `sys_package_menu` VALUES (61, 2, 30);
INSERT INTO `sys_package_menu` VALUES (63, 2, 24);
INSERT INTO `sys_package_menu` VALUES (64, 2, 5);
INSERT INTO `sys_package_menu` VALUES (66, 2, 4);
INSERT INTO `sys_package_menu` VALUES (67, 2, 1);
INSERT INTO `sys_package_menu` VALUES (68, 2, 2);
INSERT INTO `sys_package_menu` VALUES (69, 2, 73);
INSERT INTO `sys_package_menu` VALUES (70, 2, 21);
INSERT INTO `sys_package_menu` VALUES (72, 2, 63);
INSERT INTO `sys_package_menu` VALUES (73, 2, 62);
INSERT INTO `sys_package_menu` VALUES (168, 3, 14);
INSERT INTO `sys_package_menu` VALUES (169, 3, 16);
INSERT INTO `sys_package_menu` VALUES (170, 3, 15);
INSERT INTO `sys_package_menu` VALUES (171, 3, 2);
INSERT INTO `sys_package_menu` VALUES (172, 3, 34);
INSERT INTO `sys_package_menu` VALUES (173, 3, 1);
INSERT INTO `sys_package_menu` VALUES (174, 3, 33);
INSERT INTO `sys_package_menu` VALUES (175, 3, 3);
INSERT INTO `sys_package_menu` VALUES (189, 3, 35);
INSERT INTO `sys_package_menu` VALUES (191, 2, 66);
INSERT INTO `sys_package_menu` VALUES (195, 2, 69);
INSERT INTO `sys_package_menu` VALUES (196, 2, 68);
INSERT INTO `sys_package_menu` VALUES (197, 2, 71);
INSERT INTO `sys_package_menu` VALUES (198, 2, 70);
INSERT INTO `sys_package_menu` VALUES (199, 2, 80);
INSERT INTO `sys_package_menu` VALUES (201, 2, 76);
INSERT INTO `sys_package_menu` VALUES (202, 2, 78);
INSERT INTO `sys_package_menu` VALUES (209, 8, 1);
INSERT INTO `sys_package_menu` VALUES (211, 8, 3);
INSERT INTO `sys_package_menu` VALUES (212, 8, 2);
INSERT INTO `sys_package_menu` VALUES (214, 8, 5);
INSERT INTO `sys_package_menu` VALUES (216, 8, 15);
INSERT INTO `sys_package_menu` VALUES (217, 8, 14);
INSERT INTO `sys_package_menu` VALUES (218, 8, 16);
INSERT INTO `sys_package_menu` VALUES (223, 8, 33);
INSERT INTO `sys_package_menu` VALUES (230, 8, 35);
INSERT INTO `sys_package_menu` VALUES (231, 8, 34);
INSERT INTO `sys_package_menu` VALUES (233, 8, 36);
INSERT INTO `sys_package_menu` VALUES (253, 8, 66);
INSERT INTO `sys_package_menu` VALUES (254, 8, 73);
INSERT INTO `sys_package_menu` VALUES (255, 8, 24);
INSERT INTO `sys_package_menu` VALUES (256, 8, 21);
INSERT INTO `sys_package_menu` VALUES (257, 8, 31);
INSERT INTO `sys_package_menu` VALUES (258, 8, 63);
INSERT INTO `sys_package_menu` VALUES (259, 8, 30);
INSERT INTO `sys_package_menu` VALUES (260, 8, 62);
INSERT INTO `sys_package_menu` VALUES (261, 8, 32);
INSERT INTO `sys_package_menu` VALUES (262, 8, 29);
INSERT INTO `sys_package_menu` VALUES (263, 8, 55);
INSERT INTO `sys_package_menu` VALUES (264, 8, 54);
INSERT INTO `sys_package_menu` VALUES (265, 8, 53);
INSERT INTO `sys_package_menu` VALUES (266, 8, 52);
INSERT INTO `sys_package_menu` VALUES (269, 8, 41);
INSERT INTO `sys_package_menu` VALUES (271, 8, 40);
INSERT INTO `sys_package_menu` VALUES (274, 8, 4);
INSERT INTO `sys_package_menu` VALUES (282, 2, 41);
INSERT INTO `sys_package_menu` VALUES (283, 2, 53);
INSERT INTO `sys_package_menu` VALUES (284, 2, 52);
INSERT INTO `sys_package_menu` VALUES (285, 2, 55);
INSERT INTO `sys_package_menu` VALUES (286, 2, 54);
INSERT INTO `sys_package_menu` VALUES (290, 2, 129);
INSERT INTO `sys_package_menu` VALUES (291, 2, 128);
INSERT INTO `sys_package_menu` VALUES (292, 2, 131);
INSERT INTO `sys_package_menu` VALUES (293, 2, 67);
INSERT INTO `sys_package_menu` VALUES (294, 2, 130);
INSERT INTO `sys_package_menu` VALUES (295, 2, 125);
INSERT INTO `sys_package_menu` VALUES (296, 2, 127);
INSERT INTO `sys_package_menu` VALUES (297, 2, 126);
INSERT INTO `sys_package_menu` VALUES (298, 2, 137);
INSERT INTO `sys_package_menu` VALUES (299, 2, 136);
INSERT INTO `sys_package_menu` VALUES (300, 2, 72);
INSERT INTO `sys_package_menu` VALUES (301, 2, 75);
INSERT INTO `sys_package_menu` VALUES (302, 2, 138);
INSERT INTO `sys_package_menu` VALUES (303, 2, 74);
INSERT INTO `sys_package_menu` VALUES (304, 2, 133);
INSERT INTO `sys_package_menu` VALUES (305, 2, 132);
INSERT INTO `sys_package_menu` VALUES (306, 2, 135);
INSERT INTO `sys_package_menu` VALUES (307, 2, 134);
INSERT INTO `sys_package_menu` VALUES (308, 2, 77);
INSERT INTO `sys_package_menu` VALUES (309, 2, 139);
INSERT INTO `sys_package_menu` VALUES (310, 2, 140);
INSERT INTO `sys_package_menu` VALUES (311, 2, 142);
INSERT INTO `sys_package_menu` VALUES (312, 2, 144);
INSERT INTO `sys_package_menu` VALUES (313, 2, 143);

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
INSERT INTO `sys_role` VALUES (33, '2023-05-28 08:49:02', '2023-06-03 23:50:39', 'admin', NULL, '管理员', 'ADMIN', '250531', '租户管理员', 1, NULL);
INSERT INTO `sys_role` VALUES (34, '2023-05-30 23:11:25', '2023-06-03 23:50:39', 'admin', NULL, '普通用户', 'USER', '250531', NULL, 1, NULL);
INSERT INTO `sys_role` VALUES (35, '2023-06-01 14:08:27', '2023-06-03 23:44:59', 'admin', NULL, '管理员', 'ADMIN', '619889', '租户管理员', 1, NULL);
INSERT INTO `sys_role` VALUES (36, '2023-06-02 16:36:52', '2023-06-03 23:44:59', 'test', NULL, '普通用户', 'USER', '619889', NULL, 1, NULL);
INSERT INTO `sys_role` VALUES (37, '2023-06-02 16:43:11', '2023-06-03 23:44:19', 'admin', NULL, '管理员', 'ADMIN', '964367', '租户管理员', 1, NULL);
INSERT INTO `sys_role` VALUES (38, '2023-06-02 16:44:02', '2023-06-03 23:44:20', 'admin', NULL, '普通用户', 'USER', '964367', NULL, 1, NULL);
INSERT INTO `sys_role` VALUES (40, '2023-06-03 19:37:58', '2023-06-03 23:13:39', 'admin', NULL, '王五', 'ADMIN', '854554', '租户管理员', 1, NULL);
INSERT INTO `sys_role` VALUES (41, '2023-06-03 20:32:53', '2023-06-03 23:13:42', 'wangwu', NULL, '普通用户', 'USER', '854554', NULL, 1, NULL);
INSERT INTO `sys_role` VALUES (42, '2023-06-03 23:48:44', '2023-06-03 23:50:39', 'admin', NULL, '管理员', 'ADMIN', '473118', '租户管理员', 1, NULL);
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
INSERT INTO `sys_role_menu` VALUES (417, 33, 1);
INSERT INTO `sys_role_menu` VALUES (419, 33, 2);
INSERT INTO `sys_role_menu` VALUES (421, 33, 3);
INSERT INTO `sys_role_menu` VALUES (612, 33, 4);
INSERT INTO `sys_role_menu` VALUES (613, 33, 5);
INSERT INTO `sys_role_menu` VALUES (423, 33, 14);
INSERT INTO `sys_role_menu` VALUES (424, 33, 15);
INSERT INTO `sys_role_menu` VALUES (416, 33, 16);
INSERT INTO `sys_role_menu` VALUES (615, 33, 21);
INSERT INTO `sys_role_menu` VALUES (616, 33, 24);
INSERT INTO `sys_role_menu` VALUES (617, 33, 29);
INSERT INTO `sys_role_menu` VALUES (618, 33, 30);
INSERT INTO `sys_role_menu` VALUES (619, 33, 31);
INSERT INTO `sys_role_menu` VALUES (620, 33, 32);
INSERT INTO `sys_role_menu` VALUES (418, 33, 33);
INSERT INTO `sys_role_menu` VALUES (420, 33, 34);
INSERT INTO `sys_role_menu` VALUES (551, 33, 35);
INSERT INTO `sys_role_menu` VALUES (621, 33, 36);
INSERT INTO `sys_role_menu` VALUES (625, 33, 40);
INSERT INTO `sys_role_menu` VALUES (1008, 33, 41);
INSERT INTO `sys_role_menu` VALUES (1009, 33, 52);
INSERT INTO `sys_role_menu` VALUES (1010, 33, 53);
INSERT INTO `sys_role_menu` VALUES (1011, 33, 54);
INSERT INTO `sys_role_menu` VALUES (1012, 33, 55);
INSERT INTO `sys_role_menu` VALUES (631, 33, 62);
INSERT INTO `sys_role_menu` VALUES (632, 33, 63);
INSERT INTO `sys_role_menu` VALUES (663, 33, 66);
INSERT INTO `sys_role_menu` VALUES (1122, 33, 67);
INSERT INTO `sys_role_menu` VALUES (665, 33, 68);
INSERT INTO `sys_role_menu` VALUES (666, 33, 69);
INSERT INTO `sys_role_menu` VALUES (667, 33, 70);
INSERT INTO `sys_role_menu` VALUES (668, 33, 71);
INSERT INTO `sys_role_menu` VALUES (1123, 33, 72);
INSERT INTO `sys_role_menu` VALUES (614, 33, 73);
INSERT INTO `sys_role_menu` VALUES (1124, 33, 74);
INSERT INTO `sys_role_menu` VALUES (1125, 33, 75);
INSERT INTO `sys_role_menu` VALUES (672, 33, 76);
INSERT INTO `sys_role_menu` VALUES (1126, 33, 77);
INSERT INTO `sys_role_menu` VALUES (674, 33, 78);
INSERT INTO `sys_role_menu` VALUES (675, 33, 80);
INSERT INTO `sys_role_menu` VALUES (1127, 33, 125);
INSERT INTO `sys_role_menu` VALUES (1128, 33, 126);
INSERT INTO `sys_role_menu` VALUES (1129, 33, 127);
INSERT INTO `sys_role_menu` VALUES (1111, 33, 128);
INSERT INTO `sys_role_menu` VALUES (1112, 33, 129);
INSERT INTO `sys_role_menu` VALUES (1113, 33, 130);
INSERT INTO `sys_role_menu` VALUES (1114, 33, 131);
INSERT INTO `sys_role_menu` VALUES (1115, 33, 132);
INSERT INTO `sys_role_menu` VALUES (1116, 33, 133);
INSERT INTO `sys_role_menu` VALUES (1117, 33, 134);
INSERT INTO `sys_role_menu` VALUES (1118, 33, 135);
INSERT INTO `sys_role_menu` VALUES (1119, 33, 136);
INSERT INTO `sys_role_menu` VALUES (1120, 33, 137);
INSERT INTO `sys_role_menu` VALUES (1121, 33, 138);
INSERT INTO `sys_role_menu` VALUES (1172, 33, 139);
INSERT INTO `sys_role_menu` VALUES (1173, 33, 140);
INSERT INTO `sys_role_menu` VALUES (1174, 33, 142);
INSERT INTO `sys_role_menu` VALUES (1183, 33, 143);
INSERT INTO `sys_role_menu` VALUES (1184, 33, 144);
INSERT INTO `sys_role_menu` VALUES (514, 34, 1);
INSERT INTO `sys_role_menu` VALUES (516, 34, 2);
INSERT INTO `sys_role_menu` VALUES (515, 34, 3);
INSERT INTO `sys_role_menu` VALUES (525, 34, 14);
INSERT INTO `sys_role_menu` VALUES (524, 34, 15);
INSERT INTO `sys_role_menu` VALUES (523, 34, 16);
INSERT INTO `sys_role_menu` VALUES (528, 34, 33);
INSERT INTO `sys_role_menu` VALUES (531, 34, 34);
INSERT INTO `sys_role_menu` VALUES (601, 34, 35);
INSERT INTO `sys_role_menu` VALUES (749, 35, 1);
INSERT INTO `sys_role_menu` VALUES (750, 35, 2);
INSERT INTO `sys_role_menu` VALUES (751, 35, 3);
INSERT INTO `sys_role_menu` VALUES (885, 35, 4);
INSERT INTO `sys_role_menu` VALUES (753, 35, 5);
INSERT INTO `sys_role_menu` VALUES (754, 35, 14);
INSERT INTO `sys_role_menu` VALUES (755, 35, 15);
INSERT INTO `sys_role_menu` VALUES (756, 35, 16);
INSERT INTO `sys_role_menu` VALUES (868, 35, 21);
INSERT INTO `sys_role_menu` VALUES (869, 35, 24);
INSERT INTO `sys_role_menu` VALUES (870, 35, 29);
INSERT INTO `sys_role_menu` VALUES (871, 35, 30);
INSERT INTO `sys_role_menu` VALUES (873, 35, 31);
INSERT INTO `sys_role_menu` VALUES (866, 35, 32);
INSERT INTO `sys_role_menu` VALUES (762, 35, 33);
INSERT INTO `sys_role_menu` VALUES (763, 35, 34);
INSERT INTO `sys_role_menu` VALUES (764, 35, 35);
INSERT INTO `sys_role_menu` VALUES (765, 35, 36);
INSERT INTO `sys_role_menu` VALUES (897, 35, 40);
INSERT INTO `sys_role_menu` VALUES (898, 35, 41);
INSERT INTO `sys_role_menu` VALUES (899, 35, 52);
INSERT INTO `sys_role_menu` VALUES (900, 35, 53);
INSERT INTO `sys_role_menu` VALUES (901, 35, 54);
INSERT INTO `sys_role_menu` VALUES (902, 35, 55);
INSERT INTO `sys_role_menu` VALUES (872, 35, 62);
INSERT INTO `sys_role_menu` VALUES (874, 35, 63);
INSERT INTO `sys_role_menu` VALUES (820, 35, 66);
INSERT INTO `sys_role_menu` VALUES (867, 35, 73);
INSERT INTO `sys_role_menu` VALUES (800, 36, 1);
INSERT INTO `sys_role_menu` VALUES (795, 36, 2);
INSERT INTO `sys_role_menu` VALUES (794, 36, 3);
INSERT INTO `sys_role_menu` VALUES (796, 36, 5);
INSERT INTO `sys_role_menu` VALUES (803, 36, 14);
INSERT INTO `sys_role_menu` VALUES (802, 36, 15);
INSERT INTO `sys_role_menu` VALUES (804, 36, 16);
INSERT INTO `sys_role_menu` VALUES (811, 36, 33);
INSERT INTO `sys_role_menu` VALUES (808, 36, 34);
INSERT INTO `sys_role_menu` VALUES (807, 36, 35);
INSERT INTO `sys_role_menu` VALUES (810, 36, 36);
INSERT INTO `sys_role_menu` VALUES (821, 36, 66);
INSERT INTO `sys_role_menu` VALUES (822, 37, 1);
INSERT INTO `sys_role_menu` VALUES (824, 37, 2);
INSERT INTO `sys_role_menu` VALUES (827, 37, 3);
INSERT INTO `sys_role_menu` VALUES (904, 37, 4);
INSERT INTO `sys_role_menu` VALUES (831, 37, 5);
INSERT INTO `sys_role_menu` VALUES (837, 37, 14);
INSERT INTO `sys_role_menu` VALUES (838, 37, 15);
INSERT INTO `sys_role_menu` VALUES (839, 37, 16);
INSERT INTO `sys_role_menu` VALUES (877, 37, 21);
INSERT INTO `sys_role_menu` VALUES (878, 37, 24);
INSERT INTO `sys_role_menu` VALUES (879, 37, 29);
INSERT INTO `sys_role_menu` VALUES (880, 37, 30);
INSERT INTO `sys_role_menu` VALUES (882, 37, 31);
INSERT INTO `sys_role_menu` VALUES (875, 37, 32);
INSERT INTO `sys_role_menu` VALUES (823, 37, 33);
INSERT INTO `sys_role_menu` VALUES (825, 37, 34);
INSERT INTO `sys_role_menu` VALUES (828, 37, 35);
INSERT INTO `sys_role_menu` VALUES (829, 37, 36);
INSERT INTO `sys_role_menu` VALUES (916, 37, 40);
INSERT INTO `sys_role_menu` VALUES (917, 37, 41);
INSERT INTO `sys_role_menu` VALUES (918, 37, 52);
INSERT INTO `sys_role_menu` VALUES (919, 37, 53);
INSERT INTO `sys_role_menu` VALUES (920, 37, 54);
INSERT INTO `sys_role_menu` VALUES (921, 37, 55);
INSERT INTO `sys_role_menu` VALUES (881, 37, 62);
INSERT INTO `sys_role_menu` VALUES (883, 37, 63);
INSERT INTO `sys_role_menu` VALUES (826, 37, 66);
INSERT INTO `sys_role_menu` VALUES (876, 37, 73);
INSERT INTO `sys_role_menu` VALUES (859, 38, 1);
INSERT INTO `sys_role_menu` VALUES (863, 38, 2);
INSERT INTO `sys_role_menu` VALUES (861, 38, 3);
INSERT INTO `sys_role_menu` VALUES (853, 38, 5);
INSERT INTO `sys_role_menu` VALUES (845, 38, 14);
INSERT INTO `sys_role_menu` VALUES (844, 38, 15);
INSERT INTO `sys_role_menu` VALUES (852, 38, 16);
INSERT INTO `sys_role_menu` VALUES (860, 38, 33);
INSERT INTO `sys_role_menu` VALUES (864, 38, 34);
INSERT INTO `sys_role_menu` VALUES (862, 38, 35);
INSERT INTO `sys_role_menu` VALUES (855, 38, 36);
INSERT INTO `sys_role_menu` VALUES (922, 40, 1);
INSERT INTO `sys_role_menu` VALUES (923, 40, 2);
INSERT INTO `sys_role_menu` VALUES (925, 40, 3);
INSERT INTO `sys_role_menu` VALUES (927, 40, 4);
INSERT INTO `sys_role_menu` VALUES (929, 40, 5);
INSERT INTO `sys_role_menu` VALUES (939, 40, 14);
INSERT INTO `sys_role_menu` VALUES (941, 40, 15);
INSERT INTO `sys_role_menu` VALUES (942, 40, 16);
INSERT INTO `sys_role_menu` VALUES (944, 40, 21);
INSERT INTO `sys_role_menu` VALUES (945, 40, 24);
INSERT INTO `sys_role_menu` VALUES (946, 40, 29);
INSERT INTO `sys_role_menu` VALUES (947, 40, 30);
INSERT INTO `sys_role_menu` VALUES (948, 40, 31);
INSERT INTO `sys_role_menu` VALUES (949, 40, 32);
INSERT INTO `sys_role_menu` VALUES (950, 40, 33);
INSERT INTO `sys_role_menu` VALUES (951, 40, 34);
INSERT INTO `sys_role_menu` VALUES (952, 40, 35);
INSERT INTO `sys_role_menu` VALUES (953, 40, 36);
INSERT INTO `sys_role_menu` VALUES (957, 40, 40);
INSERT INTO `sys_role_menu` VALUES (1013, 40, 41);
INSERT INTO `sys_role_menu` VALUES (1014, 40, 52);
INSERT INTO `sys_role_menu` VALUES (1015, 40, 53);
INSERT INTO `sys_role_menu` VALUES (1016, 40, 54);
INSERT INTO `sys_role_menu` VALUES (1017, 40, 55);
INSERT INTO `sys_role_menu` VALUES (963, 40, 62);
INSERT INTO `sys_role_menu` VALUES (964, 40, 63);
INSERT INTO `sys_role_menu` VALUES (924, 40, 66);
INSERT INTO `sys_role_menu` VALUES (1141, 40, 67);
INSERT INTO `sys_role_menu` VALUES (1031, 40, 68);
INSERT INTO `sys_role_menu` VALUES (1032, 40, 69);
INSERT INTO `sys_role_menu` VALUES (1033, 40, 70);
INSERT INTO `sys_role_menu` VALUES (1034, 40, 71);
INSERT INTO `sys_role_menu` VALUES (1142, 40, 72);
INSERT INTO `sys_role_menu` VALUES (934, 40, 73);
INSERT INTO `sys_role_menu` VALUES (1143, 40, 74);
INSERT INTO `sys_role_menu` VALUES (1144, 40, 75);
INSERT INTO `sys_role_menu` VALUES (1038, 40, 76);
INSERT INTO `sys_role_menu` VALUES (1145, 40, 77);
INSERT INTO `sys_role_menu` VALUES (1040, 40, 78);
INSERT INTO `sys_role_menu` VALUES (1041, 40, 80);
INSERT INTO `sys_role_menu` VALUES (1146, 40, 125);
INSERT INTO `sys_role_menu` VALUES (1147, 40, 126);
INSERT INTO `sys_role_menu` VALUES (1148, 40, 127);
INSERT INTO `sys_role_menu` VALUES (1130, 40, 128);
INSERT INTO `sys_role_menu` VALUES (1131, 40, 129);
INSERT INTO `sys_role_menu` VALUES (1132, 40, 130);
INSERT INTO `sys_role_menu` VALUES (1133, 40, 131);
INSERT INTO `sys_role_menu` VALUES (1134, 40, 132);
INSERT INTO `sys_role_menu` VALUES (1135, 40, 133);
INSERT INTO `sys_role_menu` VALUES (1136, 40, 134);
INSERT INTO `sys_role_menu` VALUES (1137, 40, 135);
INSERT INTO `sys_role_menu` VALUES (1138, 40, 136);
INSERT INTO `sys_role_menu` VALUES (1139, 40, 137);
INSERT INTO `sys_role_menu` VALUES (1140, 40, 138);
INSERT INTO `sys_role_menu` VALUES (1175, 40, 139);
INSERT INTO `sys_role_menu` VALUES (1176, 40, 140);
INSERT INTO `sys_role_menu` VALUES (1177, 40, 142);
INSERT INTO `sys_role_menu` VALUES (1185, 40, 143);
INSERT INTO `sys_role_menu` VALUES (1186, 40, 144);
INSERT INTO `sys_role_menu` VALUES (994, 41, 1);
INSERT INTO `sys_role_menu` VALUES (992, 41, 2);
INSERT INTO `sys_role_menu` VALUES (986, 41, 3);
INSERT INTO `sys_role_menu` VALUES (984, 41, 4);
INSERT INTO `sys_role_menu` VALUES (989, 41, 5);
INSERT INTO `sys_role_menu` VALUES (997, 41, 14);
INSERT INTO `sys_role_menu` VALUES (1007, 41, 15);
INSERT INTO `sys_role_menu` VALUES (1005, 41, 16);
INSERT INTO `sys_role_menu` VALUES (1004, 41, 21);
INSERT INTO `sys_role_menu` VALUES (967, 41, 24);
INSERT INTO `sys_role_menu` VALUES (966, 41, 29);
INSERT INTO `sys_role_menu` VALUES (965, 41, 30);
INSERT INTO `sys_role_menu` VALUES (973, 41, 31);
INSERT INTO `sys_role_menu` VALUES (972, 41, 32);
INSERT INTO `sys_role_menu` VALUES (975, 41, 33);
INSERT INTO `sys_role_menu` VALUES (974, 41, 34);
INSERT INTO `sys_role_menu` VALUES (969, 41, 35);
INSERT INTO `sys_role_menu` VALUES (968, 41, 36);
INSERT INTO `sys_role_menu` VALUES (976, 41, 40);
INSERT INTO `sys_role_menu` VALUES (982, 41, 62);
INSERT INTO `sys_role_menu` VALUES (991, 41, 63);
INSERT INTO `sys_role_menu` VALUES (993, 41, 66);
INSERT INTO `sys_role_menu` VALUES (1003, 41, 73);
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
INSERT INTO `sys_tenant` VALUES (2, '2023-05-28 08:49:03', '2023-06-03 23:50:38', 'admin', 'admin', '250531', 6, '江西志浩电子科技有限公司', 49, '张三', 'admin', NULL, NULL, 2, NULL, 3, 1, NULL, NULL);
INSERT INTO `sys_tenant` VALUES (3, '2023-06-01 14:08:27', '2023-06-03 23:44:58', 'admin', 'admin', '619889', 780, 'a', 53, '张三', 'admin', NULL, NULL, 8, NULL, 3, 1, NULL, NULL);
INSERT INTO `sys_tenant` VALUES (4, '2023-06-02 16:43:11', '2023-06-03 23:31:21', 'admin', 'admin', '964367', 210, '东莞市安泰彩钢板有限公司', 56, '里斯', 'admin', NULL, NULL, 8, NULL, 2, 1, NULL, NULL);
INSERT INTO `sys_tenant` VALUES (5, '2023-06-03 19:37:58', '2023-06-03 23:10:56', 'admin', 'admin', '854554', 208, '东莞市川硕光电科技有限公司', 58, '王五', 'wangwu', '15019097492', '22@qq.com', 2, NULL, 2, 1, NULL, NULL);
INSERT INTO `sys_tenant` VALUES (6, '2023-06-03 23:48:44', '2023-06-03 23:50:38', 'admin', 'admin', '473118', 700, '深圳市大族超能激光科技有限公司', 60, 'te', 'admin', '15019729374', '223@qq.com', NULL, NULL, -1, 1, NULL, NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '2022-08-16 14:29:55', '2023-06-01 14:15:04', 'admin', 'admin', 'admin', '000000', '超级管理员', '{bcrypt}$2a$10$by4agdlzb5vCxVENLtmLuuhmReyAgKbql0b2l.W4/1mvo7fMxMwy6', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 2, '15019013139', NULL, '1960-12-29', 1, 1, 0);
INSERT INTO `sys_user` VALUES (42, '2023-03-25 22:55:59', '2023-05-26 14:39:02', 'admin', 'admin', 'znpi', '000000', 'ZnPi', '{bcrypt}$2a$10$ZNNyoHRYHhiHxNn35IlkuOItxwzIN.rM.8aPo70NM5B9rnK4X5STi', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '15015023432', NULL, '1996-02-15', 3, 1, 0);
INSERT INTO `sys_user` VALUES (43, '2023-04-21 14:03:53', '2023-06-07 11:04:11', 'admin', 'admin', '00001', '000000', '吸血鬼', '{bcrypt}$2a$10$3bATQy14M8Pt7Itxez7ybujGYq7lG0Ez0x3NkZf6BM1gTzAb.rEoe', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, NULL, 4, 1, 0);
INSERT INTO `sys_user` VALUES (44, '2023-04-25 16:59:16', '2023-06-06 21:59:06', 'admin', 'admin', 'aa', '000000', 'aa', '{bcrypt}$2a$10$ooLcYEYUEJ/9I4EgAimw6OAZaIA8uDuOmRBLcH52Wo.P6j0m32dt2', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '13444444444', NULL, '2023-04-17', 1, 1, 0);
INSERT INTO `sys_user` VALUES (45, '2023-04-27 09:12:21', '2023-05-26 14:39:05', 'admin', 'admin', 'lw', '000000', 'lw', '{bcrypt}$2a$10$lSw1Leq.Al3slWACemoqQe3KWgzdML/d8UV61yLDf8leSJ/i2UcX.', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '13511111111', NULL, '2023-03-28', 5, 1, 0);
INSERT INTO `sys_user` VALUES (49, '2023-05-28 08:49:03', '2023-06-03 23:50:39', 'admin', 'admin', 'admin', '250531', '管理员', '{bcrypt}$2a$10$qbi8MQSgesFqnsOKx/dl4.4ozn5MkzZMlEA9S70546fo8YwfAph4i', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, NULL, 44, 1, NULL);
INSERT INTO `sys_user` VALUES (50, '2023-05-30 17:32:18', '2023-06-03 23:50:39', 'admin', NULL, 'znpi', '250531', 'ZnPi', '{bcrypt}$2a$10$ZfrYIoNVnf8owGnlpPy6EOjWFmCyI0lx4nJJiOqfRe5JiR5bspLz2', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, '2023-05-21', 44, 1, NULL);
INSERT INTO `sys_user` VALUES (51, '2023-05-31 10:05:49', '2023-06-03 23:50:39', 'admin', NULL, 'test', '250531', 'test', '{bcrypt}$2a$10$aVmBEdmcNLRv46UDaXwl0OS9eiqrrNbBNtvAuCuZEWEyIBI/o2aoO', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO `sys_user` VALUES (52, '2023-05-31 10:05:59', '2023-06-03 23:50:39', 'admin', NULL, 'test1', '250531', 'test', '{bcrypt}$2a$10$ul0E5Toy/sSV3fqHlOuBXO.fVJeVed0zj82plQSQoRLYsH542eDfq', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, NULL, 44, 1, NULL);
INSERT INTO `sys_user` VALUES (53, '2023-06-01 14:08:27', '2023-06-03 23:44:59', 'admin', NULL, 'admin', '619889', '张三', '{bcrypt}$2a$10$vcz2ThHyu7Sm8FToz7uKkO5UttgtyENkZjriL4BLbsoTnf3oAyOH.', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '', NULL, NULL, 45, 1, NULL);
INSERT INTO `sys_user` VALUES (54, '2023-06-02 16:24:18', '2023-06-03 23:44:59', 'admin', NULL, 'test', '619889', 'test', '{bcrypt}$2a$10$R.mYvcU4d6GShULOi8sTqeoIRnSVLO5YjSawIzvKbdg/BYE01RiP.', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, NULL, 45, 1, NULL);
INSERT INTO `sys_user` VALUES (55, '2023-06-02 16:37:10', '2023-06-03 23:44:59', 'test', NULL, 'test1', '619889', 'test1', '{bcrypt}$2a$10$Gvy4owP4xgOzd8AaAEonIuj/aDTcLgybcIF2aXeKFMCM9vNBNw0pi', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, NULL, 45, 1, NULL);
INSERT INTO `sys_user` VALUES (56, '2023-06-02 16:43:11', '2023-06-03 23:44:14', 'admin', NULL, 'admin', '964367', '里斯', '{bcrypt}$2a$10$WlgkjNx.OYffhn5Ko0Ureu1o.7qVsQ1TbccwWujsmlGfqyjh5NggK', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '111', '111', NULL, 46, 1, NULL);
INSERT INTO `sys_user` VALUES (57, '2023-06-02 16:45:52', '2023-06-03 23:44:16', 'admin', NULL, 'test', '964367', 'test', '{bcrypt}$2a$10$.q7176QTPx5kUuTmRU1Ig.h.7.i8yF570xawV73b6Z8/P3oERPSSu', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO `sys_user` VALUES (58, '2023-06-03 19:37:58', '2023-06-03 23:13:51', 'admin', NULL, 'wangwu', '854554', '王五', '{bcrypt}$2a$10$M6dDP/BjW6AZ9s7yDUUljeqWt8/U24v.6amoz1Dt.13eoCOJ7B77G', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '15029093490', '748275821@qq.com', NULL, 48, 1, NULL);
INSERT INTO `sys_user` VALUES (59, '2023-06-03 20:44:07', '2023-06-03 23:13:53', 'wangwu', NULL, 'test', '854554', 'test', '{bcrypt}$2a$10$cQDvtX3SOkM0qxhQ7h35uebUOcwEhPpnFCbcR/f39jqyc4za6UGVi', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, NULL, NULL, NULL, 48, 1, NULL);
INSERT INTO `sys_user` VALUES (60, '2023-06-03 23:48:44', '2023-06-03 23:50:39', 'admin', NULL, 'admin', '473118', 'te', '{bcrypt}$2a$10$SbZjrv9YhlE1HL8ZqbzmTOkq9H0nspZkJaEcvOAfWZpsEv9b2eFqW', 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg', 1, '15019729374', '223@qq.com', NULL, 49, 1, NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (40, 1, 1);
INSERT INTO `sys_user_role` VALUES (42, 42, 2);
INSERT INTO `sys_user_role` VALUES (61, 43, 2);
INSERT INTO `sys_user_role` VALUES (60, 44, 1);
INSERT INTO `sys_user_role` VALUES (41, 45, 1);
INSERT INTO `sys_user_role` VALUES (46, 49, 33);
INSERT INTO `sys_user_role` VALUES (48, 50, 34);
INSERT INTO `sys_user_role` VALUES (49, 51, 34);
INSERT INTO `sys_user_role` VALUES (50, 52, 34);
INSERT INTO `sys_user_role` VALUES (51, 53, 35);
INSERT INTO `sys_user_role` VALUES (52, 54, 35);
INSERT INTO `sys_user_role` VALUES (53, 55, 36);
INSERT INTO `sys_user_role` VALUES (54, 56, 37);
INSERT INTO `sys_user_role` VALUES (55, 57, 38);
INSERT INTO `sys_user_role` VALUES (56, 58, 40);
INSERT INTO `sys_user_role` VALUES (57, 59, 41);
INSERT INTO `sys_user_role` VALUES (58, 60, 42);
INSERT INTO `sys_user_role` VALUES (59, 61, 43);

SET FOREIGN_KEY_CHECKS = 1;
