/*
Navicat MySQL Data Transfer

Source Server         : localVMwareCentOS
Source Server Version : 50716
Source Host           : 192.168.238.188:3306
Source Database       : zzq_web

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-08-16 18:49:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dict_type_id` bigint(20) DEFAULT NULL COMMENT 'sys_dict_type表的id',
  `code` char(6) DEFAULT NULL COMMENT '字典值编码（唯一）',
  `name` varchar(200) DEFAULT NULL COMMENT '字典值中文名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` char(6) DEFAULT NULL COMMENT '字典类型编码（唯一）',
  `name` varchar(200) DEFAULT NULL COMMENT '字典类型中文名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------

-- ----------------------------
-- Table structure for sys_office
-- ----------------------------
DROP TABLE IF EXISTS `sys_office`;
CREATE TABLE `sys_office` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` bigint(11) DEFAULT NULL COMMENT '父id（根节点的parentId为0）',
  `name` varchar(20) DEFAULT NULL COMMENT '部门名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司机构表';

-- ----------------------------
-- Records of sys_office
-- ----------------------------

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `url` varchar(200) DEFAULT NULL COMMENT 'url',
  `permission_identity` varchar(100) DEFAULT NULL COMMENT '权限标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统资源表';

-- ----------------------------
-- Records of sys_resource
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `english_name` varchar(50) DEFAULT NULL COMMENT '英文名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色资源表';

-- ----------------------------
-- Records of sys_role_resource
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `staff_no` varchar(20) NOT NULL COMMENT '员工工号',
  `office_id` bigint(20) NOT NULL COMMENT '部门id',
  `name` varchar(20) DEFAULT NULL COMMENT '员工名字',
  `username` varchar(20) DEFAULT NULL COMMENT '员工登录系统名',
  `password` char(32) DEFAULT NULL COMMENT '员工登录系统密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='公司员工表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '1', '1', '10', 'zengxiaohui', '123456');
INSERT INTO `sys_user` VALUES ('4', '848', '848', '848', '848', '848');

-- ----------------------------
-- Table structure for sys_user_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_resource`;
CREATE TABLE `sys_user_resource` (
  `user_id` bigint(20) NOT NULL COMMENT '员工id',
  `resource_id` bigint(20) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`user_id`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户资源表';

-- ----------------------------
-- Records of sys_user_resource
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '员工id',
  `role_id` bigint(20) NOT NULL COMMENT '角色主键',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for t_activity
-- ----------------------------
DROP TABLE IF EXISTS `t_activity`;
CREATE TABLE `t_activity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `details` varchar(200) DEFAULT NULL COMMENT '活动内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动表';

-- ----------------------------
-- Records of t_activity
-- ----------------------------

-- ----------------------------
-- Table structure for t_contract_drawing
-- ----------------------------
DROP TABLE IF EXISTS `t_contract_drawing`;
CREATE TABLE `t_contract_drawing` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_cost_id` bigint(20) DEFAULT NULL COMMENT '工程费用id',
  `real_hair` decimal(12,2) DEFAULT NULL COMMENT '实发施工图费用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='施工图';

-- ----------------------------
-- Records of t_contract_drawing
-- ----------------------------

-- ----------------------------
-- Table structure for t_customer_info
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_info`;
CREATE TABLE `t_customer_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '客户名字',
  `sex` bit(1) DEFAULT NULL COMMENT '客户性别（0：男，1：女）',
  `mobile` char(11) DEFAULT NULL COMMENT '客户手机号码',
  `detail_address` varchar(100) DEFAULT NULL COMMENT '客户详细地址',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户信息表';

-- ----------------------------
-- Records of t_customer_info
-- ----------------------------

-- ----------------------------
-- Table structure for t_design_sketch
-- ----------------------------
DROP TABLE IF EXISTS `t_design_sketch`;
CREATE TABLE `t_design_sketch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_cost_id` bigint(20) DEFAULT NULL COMMENT '工程费用id',
  `offer` decimal(12,2) DEFAULT NULL COMMENT '效果图报价',
  `make` decimal(12,2) DEFAULT NULL COMMENT '效果图制作费用',
  `print` decimal(12,2) DEFAULT NULL COMMENT '效果图打印费用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='效果图';

-- ----------------------------
-- Records of t_design_sketch
-- ----------------------------

-- ----------------------------
-- Table structure for t_engineering_budget
-- ----------------------------
DROP TABLE IF EXISTS `t_engineering_budget`;
CREATE TABLE `t_engineering_budget` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_contract_code` char(12) NOT NULL COMMENT '合同编号',
  `budget_contract_price` decimal(12,2) DEFAULT NULL COMMENT '预算合同价',
  `new_budget_item` decimal(12,2) DEFAULT NULL COMMENT '预算新增项目',
  `new_reduction_projectt` decimal(12,2) DEFAULT NULL COMMENT '预算新减项目',
  `total_budget` decimal(12,2) DEFAULT NULL COMMENT '预算总价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工程费用预算表';

-- ----------------------------
-- Records of t_engineering_budget
-- ----------------------------

-- ----------------------------
-- Table structure for t_engineering_cost
-- ----------------------------
DROP TABLE IF EXISTS `t_engineering_cost`;
CREATE TABLE `t_engineering_cost` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_contract_code` char(12) NOT NULL COMMENT '合同编号',
  `design_sketch_id` bigint(20) DEFAULT NULL COMMENT '效果图费用id',
  `contract_drawing_id` bigint(20) DEFAULT NULL COMMENT '施工图费用id',
  `company_remind` varchar(20) DEFAULT NULL COMMENT '公司提点',
  `manager_into` decimal(12,2) DEFAULT NULL COMMENT '项目经理分成',
  `project_manager_residual` decimal(12,2) DEFAULT NULL COMMENT '项目经理剩余分成',
  `manager_cost` decimal(12,2) DEFAULT NULL COMMENT '管理费',
  `total_cost` decimal(12,2) DEFAULT NULL COMMENT '成本总计',
  `contract_price` decimal(12,2) DEFAULT NULL COMMENT '合同价',
  `new_item` decimal(12,2) DEFAULT NULL COMMENT '新增项目',
  `reduce_item` decimal(12,2) DEFAULT NULL COMMENT '新减项目',
  `total` decimal(12,2) DEFAULT NULL COMMENT '总价',
  `settlement_price` decimal(12,2) DEFAULT NULL COMMENT '结算价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工程费用表';

-- ----------------------------
-- Records of t_engineering_cost
-- ----------------------------

-- ----------------------------
-- Table structure for t_payment
-- ----------------------------
DROP TABLE IF EXISTS `t_payment`;
CREATE TABLE `t_payment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `payment_dict_code` char(6) DEFAULT NULL COMMENT '付款',
  `project_contract_code` char(12) NOT NULL COMMENT '合同编号',
  `payment_date` date DEFAULT NULL COMMENT '付款日期',
  `details` varchar(1000) DEFAULT NULL COMMENT '付款描述',
  `payment_amounts` decimal(12,2) DEFAULT NULL COMMENT '付款金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司付款表';

-- ----------------------------
-- Records of t_payment
-- ----------------------------

-- ----------------------------
-- Table structure for t_project
-- ----------------------------
DROP TABLE IF EXISTS `t_project`;
CREATE TABLE `t_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '工程主键',
  `customer_info_id` bigint(20) DEFAULT NULL COMMENT 't_customer_info表id',
  `contract_code` char(12) NOT NULL COMMENT '合同编号',
  `name` varchar(100) NOT NULL COMMENT '工程名字(现在用的是客户的地址作为工程名字)',
  `contract_time` datetime DEFAULT NULL COMMENT '签合同日期',
  `info_sources` varchar(20) DEFAULT NULL COMMENT '信息来源',
  `period` smallint(4) DEFAULT NULL COMMENT '工期单位(天)',
  `start_time` datetime DEFAULT NULL COMMENT '开工日期',
  `end_time` datetime DEFAULT NULL COMMENT '完工日期',
  `project_supervision` varchar(20) DEFAULT NULL COMMENT '工程监理',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `salesman_id` bigint(20) DEFAULT NULL COMMENT '业务员id',
  `designer_id` bigint(20) DEFAULT NULL COMMENT '设计师id',
  `project_manager_id` bigint(20) DEFAULT NULL COMMENT '项目经理id',
  `activity_ids` varchar(100) DEFAULT NULL COMMENT '所有活动id，'''',''''分隔',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工程信息表';

-- ----------------------------
-- Records of t_project
-- ----------------------------

-- ----------------------------
-- Table structure for t_receivables
-- ----------------------------
DROP TABLE IF EXISTS `t_receivables`;
CREATE TABLE `t_receivables` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_contract_code` char(12) NOT NULL COMMENT '合同编号',
  `periods` varchar(20) DEFAULT NULL COMMENT '期数',
  `receivable_date` date DEFAULT NULL COMMENT '收款日期',
  `receivable_amounts` decimal(12,2) DEFAULT NULL COMMENT '收款金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司收款表';

-- ----------------------------
-- Records of t_receivables
-- ----------------------------
