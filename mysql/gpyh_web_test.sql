/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50715
Source Host           : 127.0.0.1:3306
Source Database       : gpyh_web_test

Target Server Type    : MYSQL
Target Server Version : 50715
File Encoding         : 65001

Date: 2017-04-24 11:23:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_api_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_api_data`;
CREATE TABLE `sys_api_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `api_id` bigint(20) DEFAULT NULL COMMENT 'api表对应id',
  `type` int(11) DEFAULT NULL COMMENT '类型（1：发送，2：接收，3：处理的结果）',
  `data` mediumtext COMMENT 'json串',
  PRIMARY KEY (`id`),
  KEY `idx_api_id` (`api_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=862878 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_api_receive
-- ----------------------------
DROP TABLE IF EXISTS `sys_api_receive`;
CREATE TABLE `sys_api_receive` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `task_number` varchar(50) DEFAULT NULL COMMENT '任务号',
  `task_type` varchar(20) DEFAULT NULL COMMENT '类型（详见接口定义文档）',
  `business_code` varchar(50) DEFAULT NULL,
  `ip` varchar(50) NOT NULL COMMENT '请求方ip',
  `url` varchar(200) NOT NULL COMMENT '对方请求url',
  `param` varchar(200) NOT NULL COMMENT '对方请求接口参数（不包括json）',
  `receive_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '接收时间',
  `response_code` varchar(30) DEFAULT NULL COMMENT '返回结果代码（详见接口定义文档）',
  `response_message` varchar(200) DEFAULT NULL COMMENT '返回结果消息',
  `deal_time` datetime DEFAULT NULL COMMENT '处理结束时间',
  `deal_code` varchar(30) DEFAULT NULL COMMENT '处理结果代码（详见接口定义文档）',
  `deal_message` varchar(200) DEFAULT NULL COMMENT '处理结果消息',
  `need_result` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_businesscode` (`business_code`) USING BTREE,
  KEY `idx_type,time` (`task_type`,`receive_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=614825 DEFAULT CHARSET=utf8 COMMENT='接收接口数据表';

-- ----------------------------
-- Table structure for sys_api_send
-- ----------------------------
DROP TABLE IF EXISTS `sys_api_send`;
CREATE TABLE `sys_api_send` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `task_number` varchar(40) DEFAULT NULL COMMENT '任务号',
  `task_type` varchar(20) NOT NULL COMMENT '类型（详见接口定义文档）',
  `business_code` varchar(30) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL COMMENT '我方调用接口url',
  `param` varchar(200) DEFAULT NULL COMMENT '我方调用接口参数（不包括json）',
  `send_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `network_status` varchar(200) DEFAULT NULL COMMENT '发送网络状态（http状态码或网络异常信息）',
  `response_time` datetime DEFAULT NULL COMMENT '服务器回复时间',
  `response_code` varchar(30) DEFAULT NULL COMMENT '服务器回复代码（详见接口定义文档）',
  `response_message` varchar(1000) DEFAULT NULL COMMENT '服务器回复消息',
  `local_ip` varchar(200) DEFAULT NULL,
  `web_ip` varchar(20) DEFAULT NULL,
  `fail_id` bigint(20) DEFAULT NULL COMMENT '失败任务id',
  PRIMARY KEY (`id`),
  KEY `idx_businesscode` (`business_code`) USING BTREE,
  KEY `idx_type,time` (`task_type`,`send_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=768305 DEFAULT CHARSET=utf8 COMMENT='发送接口数据表';

-- ----------------------------
-- Table structure for sys_cron_lock
-- ----------------------------
DROP TABLE IF EXISTS `sys_cron_lock`;
CREATE TABLE `sys_cron_lock` (
  `id` bigint(20) NOT NULL COMMENT '自增id',
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `remark` varchar(20) DEFAULT NULL COMMENT '说明',
  `rev` int(11) DEFAULT NULL COMMENT '锁',
  `lock_time` datetime DEFAULT NULL COMMENT '最后一次锁时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dict_type_id` bigint(20) NOT NULL COMMENT 'sys_dict_type表的id',
  `code` char(6) NOT NULL COMMENT '字典值编码（唯一）',
  `name` varchar(50) NOT NULL COMMENT '字典值中文名字',
  `status` int(11) NOT NULL COMMENT '状态（0：失效，1：生效）',
  `sort` int(11) NOT NULL COMMENT '排序(倒序)',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_code` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8 COMMENT='数据字典表';

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` char(3) NOT NULL COMMENT '字典类型编码（唯一）',
  `name` varchar(50) NOT NULL COMMENT '字典类型中文名称',
  `status` int(11) NOT NULL COMMENT '状态（0：失效，1：生效）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_code` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='数据字典类型表';

-- ----------------------------
-- Table structure for sys_office
-- ----------------------------
DROP TABLE IF EXISTS `sys_office`;
CREATE TABLE `sys_office` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` bigint(20) NOT NULL COMMENT '父id（根节点的parentId为0）',
  `parent_ids` varchar(200) NOT NULL COMMENT '所有父id，'',''分隔',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序（倒序）',
  `head_name` varchar(20) DEFAULT NULL COMMENT '负责人姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮件',
  `is_deleted` bit(1) NOT NULL COMMENT '是否删除（0：否，1：是）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='机构表';

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` bigint(20) NOT NULL COMMENT '父节点id',
  `parent_ids` varchar(200) NOT NULL COMMENT '父节点列表',
  `name` varchar(100) NOT NULL COMMENT '资源名',
  `type_dict_code` char(6) DEFAULT NULL COMMENT '资源类型（菜单、按钮）',
  `url` varchar(200) DEFAULT NULL COMMENT 'url',
  `permission_identity` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT NULL COMMENT '小图标',
  `level` int(11) NOT NULL COMMENT '菜单等级（0：根节点，1：一级菜单，2：二级菜单）',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `is_enabled` bit(1) NOT NULL COMMENT '是否启用（0：否，1：是）',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否已删除（0：否，1：是）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=510 DEFAULT CHARSET=utf8 COMMENT='系统资源表';

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `english_name` varchar(50) DEFAULT NULL COMMENT '英文名称',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除（0：否，1：是）',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='系统角色表';

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `resource_id` bigint(20) NOT NULL COMMENT '资源id',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93839 DEFAULT CHARSET=utf8 COMMENT='系统角色资源表';

-- ----------------------------
-- Table structure for sys_salesman_goal
-- ----------------------------
DROP TABLE IF EXISTS `sys_salesman_goal`;
CREATE TABLE `sys_salesman_goal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sys_user_id` bigint(20) NOT NULL COMMENT '业务员id',
  `goal_account` decimal(12,3) DEFAULT NULL COMMENT '目标金额',
  `effective_customer_count` decimal(12,3) DEFAULT NULL COMMENT '目标有效客户数',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='业务员目标表';

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `office_id` bigint(20) DEFAULT NULL COMMENT '部门id',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `staff_no` varchar(20) NOT NULL COMMENT '员工工号',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `qq` varchar(20) DEFAULT NULL COMMENT 'QQ号',
  `email` varchar(50) DEFAULT NULL COMMENT 'email',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `mobile` char(11) DEFAULT NULL COMMENT '手机号',
  `salt` char(50) DEFAULT NULL COMMENT 'salt',
  `app_id` varchar(45) DEFAULT NULL,
  `app_seed` varchar(45) DEFAULT NULL,
  `position_dict_code` char(6) NOT NULL COMMENT '职务',
  `is_super_admin` bit(1) NOT NULL COMMENT '是否超级管理员（0：否，1：是）',
  `parent_id` bigint(20) NOT NULL COMMENT '上级领导，0是没有上级领导',
  `parent_ids` varchar(200) NOT NULL COMMENT '上级领导列表","分割',
  `is_enabled` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否启用（0：未启用，1：启用）',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除（0：否，1：是）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_username` (`username`) USING BTREE,
  UNIQUE KEY `uni_staff_no` (`staff_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- ----------------------------
-- Table structure for sys_user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_login_log`;
CREATE TABLE `sys_user_login_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT 'sys_user表主键',
  `remote_ip` varchar(50) DEFAULT NULL COMMENT '客户端ip',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '客户端信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33737 DEFAULT CHARSET=utf8 COMMENT='后台用户登录日志';

-- ----------------------------
-- Table structure for sys_user_opt_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_opt_log`;
CREATE TABLE `sys_user_opt_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT 'sys_user表主键',
  `title` varchar(100) DEFAULT NULL COMMENT '日志标题',
  `request_uri` varchar(200) DEFAULT NULL COMMENT 'uri',
  `method` varchar(10) DEFAULT NULL COMMENT '方法类型',
  `remote_ip` varchar(50) DEFAULT NULL COMMENT '客户端ip',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '客户端信息',
  `params` varchar(1000) DEFAULT NULL COMMENT '参数',
  `exception` varchar(1000) DEFAULT NULL COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=3951322 DEFAULT CHARSET=utf8 COMMENT='后台用户操作日志';

-- ----------------------------
-- Table structure for sys_user_opt_log_history
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_opt_log_history`;
CREATE TABLE `sys_user_opt_log_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT 'sys_user表主键',
  `title` varchar(100) DEFAULT NULL COMMENT '日志标题',
  `request_uri` varchar(200) DEFAULT NULL COMMENT 'uri',
  `method` varchar(10) DEFAULT NULL COMMENT '方法类型',
  `remote_ip` varchar(50) DEFAULT NULL COMMENT '客户端ip',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '客户端信息',
  `params` varchar(1000) DEFAULT NULL COMMENT '参数',
  `exception` varchar(1000) DEFAULT NULL COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户操作日志(历史记录)';

-- ----------------------------
-- Table structure for sys_user_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_resource`;
CREATE TABLE `sys_user_resource` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `resource_id` bigint(20) NOT NULL COMMENT '资源id',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_active` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否启用（0、未启用   1、启用）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4717 DEFAULT CHARSET=utf8 COMMENT='系统用户资源表';

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT 'sys_user表的id',
  `role_id` bigint(20) NOT NULL COMMENT 'sys_role表的id',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户角色表';

-- ----------------------------
-- Table structure for temp_standard_attr_name
-- ----------------------------
DROP TABLE IF EXISTS `temp_standard_attr_name`;
CREATE TABLE `temp_standard_attr_name` (
  `id` bigint(20) NOT NULL,
  `goods_name` varchar(100) DEFAULT NULL COMMENT '品名',
  `description` varchar(200) DEFAULT NULL COMMENT '中文描述',
  `attr_name` varchar(100) DEFAULT NULL COMMENT '属性',
  `is_check` varchar(100) DEFAULT NULL COMMENT '是否检验',
  `is_print` varchar(100) DEFAULT NULL COMMENT '是否打印',
  `print_sort` varchar(100) DEFAULT NULL COMMENT '打印顺序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='品名属性临时表';

-- ----------------------------
-- Table structure for t_aboutus_data
-- ----------------------------
DROP TABLE IF EXISTS `t_aboutus_data`;
CREATE TABLE `t_aboutus_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type_id` bigint(20) NOT NULL COMMENT '分类id（关联t_aboutus_type）',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '新闻公告内容',
  `sort` int(11) DEFAULT NULL COMMENT '排序（升序）',
  `del_flag` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除(0未删除1已删除)',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='《关于我们》详细内容表';

-- ----------------------------
-- Table structure for t_aboutus_type
-- ----------------------------
DROP TABLE IF EXISTS `t_aboutus_type`;
CREATE TABLE `t_aboutus_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `parent_id` bigint(20) NOT NULL COMMENT '上一级分类id（没有上级则为0）',
  `parent_ids` varchar(50) NOT NULL COMMENT '所有父类分类id（从上往下，依次以逗号间隔）',
  `parent_names` varchar(500) NOT NULL COMMENT '所有父类分类名称（从上往下，依次以逗号间隔）',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，0：失效，1：生效）',
  `is_leaf` bit(1) NOT NULL COMMENT '是否叶子节点（0：否，1：是）',
  `grade` int(11) DEFAULT NULL COMMENT '树结构等级，从1开始',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='《关于我们》分类信息表';

-- ----------------------------
-- Table structure for t_amount_flow
-- ----------------------------
DROP TABLE IF EXISTS `t_amount_flow`;
CREATE TABLE `t_amount_flow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `merchant_id` bigint(20) NOT NULL COMMENT '商家id',
  `useage` varchar(500) DEFAULT NULL COMMENT '用途',
  `income` decimal(11,2) DEFAULT NULL COMMENT '收入',
  `expense` decimal(11,2) DEFAULT NULL COMMENT '支出',
  `balance` decimal(11,2) DEFAULT NULL COMMENT '余额',
  `use_time` datetime DEFAULT NULL COMMENT '使用日期',
  `use_name` varchar(11) DEFAULT NULL COMMENT '使用人',
  `is_accour_repour` bit(1) NOT NULL COMMENT '是否报销',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `crerate_name` varchar(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '类型（1：收入，2 ：支出）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金流动表';

-- ----------------------------
-- Table structure for t_area_freepost_config
-- ----------------------------
DROP TABLE IF EXISTS `t_area_freepost_config`;
CREATE TABLE `t_area_freepost_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `level` int(11) DEFAULT NULL COMMENT '地区级别：(1、全国  2、省  3、市）',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市',
  `status` int(11) DEFAULT NULL COMMENT '状态（-1：删除,0：禁用，1：启用）',
  `post_free_num` int(10) DEFAULT '0' COMMENT '一天内免邮次数',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `delivery_type_dict_code` char(6) DEFAULT NULL COMMENT '配送类型(sys_dict的code)',
  PRIMARY KEY (`id`),
  KEY `idx_province_id` (`province_id`,`city_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='区域免邮配置表';

-- ----------------------------
-- Table structure for t_area_price
-- ----------------------------
DROP TABLE IF EXISTS `t_area_price`;
CREATE TABLE `t_area_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) NOT NULL COMMENT '商品主键',
  `level` int(11) NOT NULL COMMENT '区域等级（1：全国，2：省，3：市，4：区县）',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区、县',
  `discount` decimal(12,2) NOT NULL COMMENT '折扣',
  `status` int(11) NOT NULL COMMENT '状态（10：生效，-1：删除）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_name` varchar(12) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(12) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='地区价格表';

-- ----------------------------
-- Table structure for t_area_price_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_area_price_rule`;
CREATE TABLE `t_area_price_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '规则名称',
  `status` int(12) NOT NULL COMMENT '状态（10：生效，1：失效，-1：删除）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_name` varchar(12) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(12) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='地区价格规则表';

-- ----------------------------
-- Table structure for t_area_price_rule_item
-- ----------------------------
DROP TABLE IF EXISTS `t_area_price_rule_item`;
CREATE TABLE `t_area_price_rule_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `area_price_rule_id` bigint(20) NOT NULL COMMENT '地区价格规则id',
  `discount` decimal(12,3) NOT NULL COMMENT '折扣',
  `level` int(12) NOT NULL COMMENT '级别（1：全国，2：省，3：市，4：区、县）',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区、县',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8 COMMENT='地区价格规则字表';

-- ----------------------------
-- Table structure for t_area_sell_config
-- ----------------------------
DROP TABLE IF EXISTS `t_area_sell_config`;
CREATE TABLE `t_area_sell_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `config_type` int(10) DEFAULT NULL COMMENT '商家类型：1、自营  2、第三方',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商id',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `level` int(11) DEFAULT NULL COMMENT '地区级别：1、全国  2、省  3、市）',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市',
  `status` int(11) DEFAULT NULL COMMENT '状态：0、禁用  1、启用）',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_province_id` (`province_id`,`city_id`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`,`supplier_id`,`status`,`level`,`province_id`,`city_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1184 DEFAULT CHARSET=utf8 COMMENT='区域销售配置表';

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_dict_code` char(6) NOT NULL COMMENT '公告类型（sys_dict表的code）',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `imageUrl` varchar(200) DEFAULT NULL COMMENT '标题图标',
  `keywords` varchar(200) DEFAULT NULL COMMENT '关键字',
  `description` varchar(200) DEFAULT NULL COMMENT '描述,摘要',
  `sort` int(11) DEFAULT NULL COMMENT '排序（升序）',
  `hits` int(11) NOT NULL DEFAULT '0' COMMENT '点击数',
  `audit_status` int(11) NOT NULL DEFAULT '0' COMMENT '审核状态(-1失效 0发布 1审核中 9审核通过)',
  `del_flag` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否删除(0未删除1已删除)',
  `is_top` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否置顶',
  `author` varchar(50) DEFAULT NULL COMMENT '作者',
  `copyfrom` varchar(200) DEFAULT NULL COMMENT '新闻公告来源',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `browse_num` int(11) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=utf8 COMMENT='新闻公告';

-- ----------------------------
-- Table structure for t_article_data
-- ----------------------------
DROP TABLE IF EXISTS `t_article_data`;
CREATE TABLE `t_article_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `article_id` bigint(20) NOT NULL COMMENT '新闻公告id（关联t_article）',
  `content` text COMMENT '新闻公告内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=utf8 COMMENT='新闻公告详情表';

-- ----------------------------
-- Table structure for t_ask_price
-- ----------------------------
DROP TABLE IF EXISTS `t_ask_price`;
CREATE TABLE `t_ask_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `material_name` varchar(50) DEFAULT NULL COMMENT '材质',
  `name` varchar(50) DEFAULT NULL COMMENT '品名',
  `specification` varchar(50) DEFAULT NULL COMMENT '规格',
  `number` decimal(12,3) DEFAULT NULL COMMENT '数量',
  `demand` varchar(50) DEFAULT NULL COMMENT '特殊要求',
  `price` decimal(12,2) DEFAULT NULL COMMENT '价格',
  `delivery_time` int(11) DEFAULT NULL COMMENT '交期',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `status` int(11) DEFAULT NULL COMMENT '状态（1未报价、2已报价、3未成交、4已成交）',
  `reason` varchar(200) DEFAULT NULL COMMENT '原因说明（是否成交原因）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `answer_sys_user` bigint(20) DEFAULT NULL COMMENT '回答人id',
  `answer_name` varchar(20) DEFAULT NULL COMMENT '回答人名称',
  `answer_time` datetime DEFAULT NULL COMMENT '回答时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `standard_name` varchar(50) DEFAULT NULL COMMENT '标准名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=293 DEFAULT CHARSET=utf8 COMMENT='询价表';

-- ----------------------------
-- Table structure for t_ask_price_img
-- ----------------------------
DROP TABLE IF EXISTS `t_ask_price_img`;
CREATE TABLE `t_ask_price_img` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ask_price_id` bigint(20) DEFAULT NULL COMMENT '询价表id',
  `img_url` varchar(200) DEFAULT NULL COMMENT '图片url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='询价图片';

-- ----------------------------
-- Table structure for t_attr_name
-- ----------------------------
DROP TABLE IF EXISTS `t_attr_name`;
CREATE TABLE `t_attr_name` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint(20) NOT NULL COMMENT '类目id',
  `category_name` varchar(50) NOT NULL COMMENT '类目名称',
  `name` varchar(50) NOT NULL COMMENT '属性名',
  `attr_group_id` char(6) NOT NULL COMMENT '属性分组id（0：属于无分组）',
  `attr_group_name` varchar(50) NOT NULL,
  `is_filter` bit(1) NOT NULL COMMENT '是否过滤属性（0：否，1：是）',
  `is_must` bit(1) NOT NULL COMMENT '是否必须（0：否，1：是）',
  `is_check` bit(1) DEFAULT NULL COMMENT '是否检验',
  `is_draw` bit(1) DEFAULT NULL COMMENT '是否图纸',
  `is_default` bit(1) NOT NULL COMMENT '是否默认属性（0：否，1：是）',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `status` int(11) NOT NULL COMMENT '状态（0：失效，1：生效）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1193 DEFAULT CHARSET=utf8 COMMENT='属性名表';

-- ----------------------------
-- Table structure for t_brand
-- ----------------------------
DROP TABLE IF EXISTS `t_brand`;
CREATE TABLE `t_brand` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `english_name` varchar(50) DEFAULT NULL COMMENT '英文名称',
  `logo_url` varchar(200) DEFAULT NULL COMMENT '品牌logo',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `official_url` varchar(200) DEFAULT NULL COMMENT '官网',
  `signet_url` varchar(200) DEFAULT NULL COMMENT '印记url',
  `status` int(11) NOT NULL COMMENT '状态（0：失效，1：生效）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_campaign_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_campaign_customer`;
CREATE TABLE `t_campaign_customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `campaign_num_one` int(10) DEFAULT '0' COMMENT '活动抽奖次数（6月1号）',
  `used_num_one` int(10) DEFAULT '0' COMMENT '已经抽奖次数（6月1号）',
  `campaign_num_two` int(10) DEFAULT '0' COMMENT '活动抽奖次数（6月2号）',
  `used_num_two` int(10) DEFAULT '0' COMMENT '已经抽奖次数（6月2号）',
  `campaign_num_three` int(10) DEFAULT '0' COMMENT '活动抽奖次数（6月3号）',
  `used_num_three` int(10) DEFAULT '0' COMMENT '已经抽奖次数（6月3号）',
  `campaign_num_four` int(10) DEFAULT '0' COMMENT '活动抽奖次数（6月4号）',
  `used_num_four` int(10) DEFAULT '0' COMMENT '已经抽奖次数（6月4号）',
  `status` int(10) DEFAULT '1' COMMENT '状态：0、无效  1、有效',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_customer_info_id` (`customer_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4110 DEFAULT CHARSET=utf8 COMMENT='客户抽奖活动表';

-- ----------------------------
-- Table structure for t_campaign_customer_record
-- ----------------------------
DROP TABLE IF EXISTS `t_campaign_customer_record`;
CREATE TABLE `t_campaign_customer_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `get_num` int(10) DEFAULT '0' COMMENT '获取抽奖次数',
  `create_time` datetime DEFAULT NULL COMMENT '获取时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_customer_info_id` (`customer_info_id`,`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=627 DEFAULT CHARSET=utf8 COMMENT='客户获得抽奖资格记录表';

-- ----------------------------
-- Table structure for t_campaign_prize
-- ----------------------------
DROP TABLE IF EXISTS `t_campaign_prize`;
CREATE TABLE `t_campaign_prize` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) DEFAULT NULL COMMENT '奖品名称',
  `description` varchar(100) DEFAULT NULL COMMENT '奖品图片展示',
  `amount` int(20) DEFAULT NULL COMMENT '奖品数量',
  `freeze_num` int(20) DEFAULT NULL COMMENT '奖品占用',
  `red_package_value` decimal(10,2) DEFAULT NULL COMMENT '红包面额',
  `prize_order` varchar(100) DEFAULT NULL COMMENT '中奖次序',
  `weight` bigint(10) DEFAULT NULL COMMENT '概率权重',
  `need_weight` bit(1) DEFAULT NULL COMMENT '奖品是否需要权重',
  `angle` int(10) DEFAULT NULL COMMENT '转盘转动角度',
  `status` int(10) DEFAULT '1' COMMENT '状态：0、无效  1、有效',
  `date_time` datetime DEFAULT NULL COMMENT '奖品抽取日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='活动奖品表';

-- ----------------------------
-- Table structure for t_campaign_prize_record
-- ----------------------------
DROP TABLE IF EXISTS `t_campaign_prize_record`;
CREATE TABLE `t_campaign_prize_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `campaign_prize_id` bigint(20) NOT NULL COMMENT '活动奖品id',
  `create_time` datetime NOT NULL COMMENT '中奖时间',
  `time_type` varchar(20) NOT NULL COMMENT '中奖时间标识',
  `thing_type` int(10) DEFAULT NULL COMMENT '实物奖品标识',
  `phone_type` int(10) DEFAULT NULL COMMENT '手机奖品标识',
  `prize_type` int(10) NOT NULL COMMENT '中奖类型：1：实物  2：微信红包',
  `exchange_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '红包兑换码',
  `is_take` bit(1) DEFAULT NULL COMMENT '是否领取：0：未领取 1：已领取',
  `open_id` varchar(50) DEFAULT NULL COMMENT '红包领取人',
  `end_time` datetime DEFAULT NULL COMMENT '红包有效期',
  `take_time` datetime DEFAULT NULL COMMENT '领取时间',
  `contact_name` varchar(20) DEFAULT NULL COMMENT '联系人',
  `contact_mobile` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份id',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城市id',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区县id',
  `detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `postcode` char(6) DEFAULT NULL COMMENT '邮政编码',
  `mch_billno` varchar(50) DEFAULT NULL COMMENT '微信红包发送时获取的商户订单号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_customer_info_id` (`customer_info_id`,`time_type`,`thing_type`) USING BTREE,
  UNIQUE KEY `uni_customer_phone` (`customer_info_id`,`phone_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2114 DEFAULT CHARSET=utf8 COMMENT='活动中奖记录表';

-- ----------------------------
-- Table structure for t_campaign_record
-- ----------------------------
DROP TABLE IF EXISTS `t_campaign_record`;
CREATE TABLE `t_campaign_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `create_time` datetime DEFAULT NULL COMMENT '抽奖时间',
  `campaign_order` bigint(20) NOT NULL COMMENT '抽奖次序',
  `record_lock` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2359 DEFAULT CHARSET=utf8 COMMENT='活动抽奖记录表';

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '类目名',
  `parent_id` bigint(20) NOT NULL COMMENT '父类目id（没有上级则为0）',
  `parent_ids` varchar(50) NOT NULL COMMENT '所有父类目id（从上往下，依次以逗号间隔）',
  `parent_names` varchar(500) NOT NULL COMMENT '所有父类目名称（从上往下，依次以逗号间隔）',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，0：失效，1：生效）',
  `is_leaf` bit(1) NOT NULL COMMENT '是否叶子节点（0：否，1：是）',
  `grade` int(11) DEFAULT NULL COMMENT '树结构等级，从1开始',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `description` varchar(50) DEFAULT NULL COMMENT '商品分类描述',
  PRIMARY KEY (`id`),
  KEY `idx_sort` (`sort`,`parent_ids`) USING BTREE,
  KEY `idx_parent_ids` (`parent_ids`,`sort`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2327 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_category_picture
-- ----------------------------
DROP TABLE IF EXISTS `t_category_picture`;
CREATE TABLE `t_category_picture` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint(20) DEFAULT NULL COMMENT '分类id(t_category表的id)',
  `url` varchar(200) NOT NULL COMMENT '图片url',
  `type_dict_code` char(6) NOT NULL COMMENT '图片类型',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_category_id` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2089 DEFAULT CHARSET=utf8 COMMENT='分类图片表';

-- ----------------------------
-- Table structure for t_check
-- ----------------------------
DROP TABLE IF EXISTS `t_check`;
CREATE TABLE `t_check` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `check_code` varchar(20) DEFAULT NULL COMMENT '检验单号',
  `status` int(11) DEFAULT NULL COMMENT '检验单状态（1、保存，2、审核）',
  `check_status` int(11) DEFAULT NULL COMMENT '检验单综合判定（1、不良，2、特采，3、合格）',
  `warranty_status` int(11) DEFAULT NULL COMMENT '质保书综合判定（1、不良，2、特采，3、合格）',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `bar_code` varchar(10) DEFAULT NULL COMMENT '商品编码',
  `oven_number` varchar(50) DEFAULT NULL COMMENT '炉号',
  `batch_qty` decimal(12,3) DEFAULT NULL COMMENT '批数量',
  `sample_qty` decimal(12,3) DEFAULT NULL COMMENT '抽样数量',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `check_name` varchar(20) DEFAULT NULL COMMENT '检验人名称',
  `check_date` datetime DEFAULT NULL COMMENT '检验日期',
  `check_update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称（j检验单）',
  `check_update_time` datetime DEFAULT NULL COMMENT '更新时间（检验单）',
  `audit_name` varchar(20) DEFAULT NULL COMMENT '审核人名称（生成质保数据人名称）',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间（生成质保数据时间）',
  `warranty_name` varchar(20) DEFAULT NULL COMMENT '更新人名称（质保数据）',
  `warranty_update_time` datetime DEFAULT NULL COMMENT '更新时间（质保数据）',
  `bill_type` varchar(10) DEFAULT NULL COMMENT '单据类型（仓库用）',
  `bill_code` varchar(20) DEFAULT NULL COMMENT '单据号（仓库用）',
  PRIMARY KEY (`id`),
  KEY `idx_goods_id` (`goods_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7376 DEFAULT CHARSET=utf8 COMMENT='检验主表';

-- ----------------------------
-- Table structure for t_check_balance
-- ----------------------------
DROP TABLE IF EXISTS `t_check_balance`;
CREATE TABLE `t_check_balance` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `check_balance_code` varchar(20) NOT NULL COMMENT '勾兑单号',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `customer_name` varchar(100) DEFAULT NULL COMMENT '客户名称',
  `check_balance_date` date DEFAULT NULL COMMENT '勾兑日期',
  `check_balance_amounts` decimal(18,2) DEFAULT NULL COMMENT '勾兑总金额',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人名称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `AK_Key_check_balance_code` (`check_balance_code`) USING BTREE,
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20711 DEFAULT CHARSET=utf8 COMMENT='客户勾兑表';

-- ----------------------------
-- Table structure for t_check_item
-- ----------------------------
DROP TABLE IF EXISTS `t_check_item`;
CREATE TABLE `t_check_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `check_id` bigint(20) DEFAULT NULL COMMENT '检验单id',
  `check_type` char(1) DEFAULT NULL COMMENT '检验类型（A、化学成分，B、机械性能，C、尺寸检验）',
  `check_project` varchar(50) DEFAULT NULL COMMENT '检验项目名称',
  `standard_value` varchar(50) DEFAULT NULL COMMENT '标准值',
  `check_value_1` varchar(50) DEFAULT NULL COMMENT '实测值1',
  `check_value_2` varchar(50) DEFAULT NULL COMMENT '实测值2',
  `check_value_3` varchar(50) DEFAULT NULL COMMENT '实测值3',
  `check_value_4` varchar(50) DEFAULT NULL COMMENT '实测值4',
  `check_value_5` varchar(50) DEFAULT NULL COMMENT '实测值5',
  `check_value_6` varchar(50) DEFAULT NULL COMMENT '实测值6',
  `check_value_7` varchar(50) DEFAULT NULL COMMENT '实测值7',
  `check_value_8` varchar(50) DEFAULT NULL COMMENT '实测值8',
  `check_value_9` varchar(50) DEFAULT NULL COMMENT '实测值9',
  `check_value_10` varchar(50) DEFAULT NULL COMMENT '实测值10',
  `check_status` int(11) DEFAULT NULL COMMENT 'j检验单项判定（1、不良，2、特采，3、合格）',
  `warranty_value` varchar(50) DEFAULT NULL COMMENT '质保数据检验值',
  `warranty_status` int(11) DEFAULT NULL COMMENT '质保书单项判定（1、不良，2、特采，3、合格）',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123685 DEFAULT CHARSET=utf8 COMMENT='检验子表';

-- ----------------------------
-- Table structure for t_collection
-- ----------------------------
DROP TABLE IF EXISTS `t_collection`;
CREATE TABLE `t_collection` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '收藏表id',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户信息id',
  `type` int(10) NOT NULL DEFAULT '1' COMMENT '类型：1我的收藏，2我的非标',
  `user_defined_name` varchar(50) DEFAULT NULL COMMENT '用户定义品名',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_customer_goods_id` (`customer_info_id`,`goods_id`,`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34335 DEFAULT CHARSET=utf8 COMMENT='顾客收藏表';

-- ----------------------------
-- Table structure for t_coupon
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon`;
CREATE TABLE `t_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(45) DEFAULT NULL COMMENT '名称',
  `type` int(11) DEFAULT NULL COMMENT '类型（1：满减券，2：代金券）',
  `status` int(11) DEFAULT NULL COMMENT '状态（9：失效，10：生效）',
  `purchase_amount` decimal(12,2) DEFAULT NULL COMMENT '满减起始额度（满多少）',
  `coupon_amount` decimal(12,2) DEFAULT NULL COMMENT '折扣额度（减多少）',
  `effect_days` int(11) DEFAULT NULL COMMENT '有效天数',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(45) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(45) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='优惠券表';

-- ----------------------------
-- Table structure for t_coupon_use
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon_use`;
CREATE TABLE `t_coupon_use` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `customer_info_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '优惠券id',
  `coupon_code` varchar(20) DEFAULT NULL COMMENT '优惠券编号',
  `status` int(11) NOT NULL COMMENT '状态（7：未生效，8，已使用，9：已失效，10：可使用，11：已删除）',
  `coupon_amount` decimal(12,2) DEFAULT NULL COMMENT '优惠金额',
  `effect_time` datetime DEFAULT NULL COMMENT '生效日期',
  `expire_time` datetime DEFAULT NULL COMMENT '失效日期',
  `used_amount` decimal(12,2) DEFAULT NULL COMMENT '实际抵消金额',
  `used_time` datetime DEFAULT NULL COMMENT '使用日期',
  `use_order_id` bigint(20) DEFAULT NULL COMMENT '使用订单id',
  `source` int(11) DEFAULT NULL COMMENT '来源（1：新用户赠送，2：订单购买，3：后台，4：天天抽奖）',
  `source_order_id` bigint(20) DEFAULT NULL COMMENT '来源订单id',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建用户id',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新用户id',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_coupon_code` (`coupon_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=134168 DEFAULT CHARSET=utf8 COMMENT='优惠券使用表';

-- ----------------------------
-- Table structure for t_customer_account
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_account`;
CREATE TABLE `t_customer_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT 't_customer_info表id',
  `login_name` varchar(20) NOT NULL COMMENT '账号',
  `real_name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `mobile` varchar(30) DEFAULT NULL COMMENT '手机号',
  `qq` varchar(20) DEFAULT NULL COMMENT 'QQ',
  `email` varchar(50) DEFAULT NULL COMMENT 'email',
  `password_salt` char(10) DEFAULT NULL COMMENT '盐',
  `pwd_error_count` int(11) DEFAULT '0' COMMENT '密码错误次数',
  `pwd_error_time` datetime DEFAULT NULL COMMENT '密码错误时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后一次登录时间',
  `last_login_ip` varchar(39) DEFAULT NULL COMMENT '最后一次登录IP',
  `status` int(11) NOT NULL COMMENT '状态（1：生效，2：未生效，-1：作废）',
  `open_id` varchar(50) DEFAULT NULL COMMENT '微信端标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_login_name` (`login_name`) USING BTREE,
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28466 DEFAULT CHARSET=utf8 COMMENT='客户账号表';

-- ----------------------------
-- Table structure for t_customer_address
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_address`;
CREATE TABLE `t_customer_address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户信息表id',
  `consignee` varchar(20) NOT NULL COMMENT '姓名',
  `mobile` varchar(30) DEFAULT NULL COMMENT '手机',
  `phone` varchar(30) DEFAULT NULL COMMENT '固定电话',
  `email` varchar(50) DEFAULT NULL COMMENT 'email',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份id（t_region表的id）',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城市id（t_region表的id）',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区县id（t_region表的id）',
  `detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `postcode` char(6) DEFAULT NULL COMMENT '邮编',
  `is_customer_direct` bit(1) NOT NULL COMMENT '是否客户直发（0：否，1：是）',
  `is_default` bit(1) NOT NULL COMMENT '是否默认（0：否，1：是）',
  `is_put_bill` bit(1) DEFAULT NULL COMMENT '是否放单',
  `is_show_price` bit(1) DEFAULT NULL COMMENT '是否显示价格',
  `status` int(11) NOT NULL DEFAULT '10' COMMENT '状态（10：生效，-1：已删除）',
  `address_short_name` varchar(50) DEFAULT NULL COMMENT '地址简称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21890 DEFAULT CHARSET=utf8 COMMENT='客户地址表';

-- ----------------------------
-- Table structure for t_customer_contract
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_contract`;
CREATE TABLE `t_customer_contract` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `contract_code` varchar(50) NOT NULL COMMENT '合同编号',
  `sigin_time` datetime NOT NULL COMMENT '签订日期',
  `credit_limit` decimal(11,2) NOT NULL COMMENT '授信额度',
  `contract_url` varchar(200) DEFAULT NULL COMMENT '电子合同保存地址',
  `owner` varchar(20) NOT NULL COMMENT '甲方经办人',
  `second` varchar(20) NOT NULL COMMENT '乙方经办人',
  `status` int(11) NOT NULL COMMENT '状态（-1：删除，0：作废，10：使用）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='月结客户合同等级表';

-- ----------------------------
-- Table structure for t_customer_extend
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_extend`;
CREATE TABLE `t_customer_extend` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT 't_customer_info表id',
  `customer_msg_click` int(11) DEFAULT '0' COMMENT '信息点击次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY ` uni_customer_info_id` (`customer_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20378 DEFAULT CHARSET=utf8 COMMENT='客户扩展表';

-- ----------------------------
-- Table structure for t_customer_growth_log
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_growth_log`;
CREATE TABLE `t_customer_growth_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户主键',
  `change_growth_value` int(11) NOT NULL COMMENT '成长值',
  `source` int(11) NOT NULL COMMENT '来源(1:下单，2: 系统)',
  `current_level` int(11) NOT NULL COMMENT '当前等级',
  `current_growth_value` int(11) NOT NULL COMMENT '当前总成长值',
  `remark` varchar(100) DEFAULT NULL COMMENT '说明',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62521 DEFAULT CHARSET=utf8 COMMENT='客户成长值记录表';

-- ----------------------------
-- Table structure for t_customer_info
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_info`;
CREATE TABLE `t_customer_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_seq` varchar(20) DEFAULT NULL COMMENT '客户编号（暂时不用）',
  `customer_code` varchar(20) DEFAULT NULL COMMENT '客户代号',
  `full_name` varchar(50) DEFAULT NULL COMMENT '全称',
  `short_name` varchar(20) DEFAULT NULL COMMENT '简称',
  `short_spell` varchar(20) DEFAULT NULL COMMENT '简拼',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份id',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城市id',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区县id',
  `detail_address` varchar(100) DEFAULT NULL COMMENT '详细地址',
  `found_date` date DEFAULT NULL COMMENT '成立日期',
  `legal_person` varchar(20) DEFAULT NULL COMMENT '法人',
  `business_license_no` varchar(50) DEFAULT NULL COMMENT '营业执照号',
  `corporation_tax_no` varchar(50) DEFAULT NULL COMMENT '税号',
  `official_url` varchar(200) DEFAULT NULL COMMENT '公司网址',
  `type_dict_code` char(6) DEFAULT NULL COMMENT '公司类别',
  `level_self_motion` int(11) NOT NULL DEFAULT '1' COMMENT '等级是否自动（1：自动升降（默认），2：自动升不自动降，3：自动降不升，4：不自动）',
  `level` int(11) NOT NULL COMMENT '会员等级（1：钻石会员，2：白金会员，3：金牌会员，4：银牌会员，5：铜牌会员）',
  `credit_limit` decimal(12,2) NOT NULL COMMENT '信用额度（信用额度申请表）',
  `settlement_dict_code` char(6) NOT NULL COMMENT '结算方式',
  `source` int(11) NOT NULL COMMENT '来源（1：网站，2：微信，3：后台）',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `phone` varchar(30) DEFAULT NULL COMMENT '电话',
  `salesman_id` bigint(20) DEFAULT NULL COMMENT '业务员id（sys_user的id）',
  `salesman_name` varchar(20) DEFAULT NULL COMMENT '业务员姓名',
  `customer_service_id` bigint(20) DEFAULT NULL COMMENT '客服id（sys_user的id）',
  `customer_service_name` varchar(20) DEFAULT NULL COMMENT '客服姓名',
  `is_take_invoice` bit(1) NOT NULL COMMENT '是否开票（0：不开票，1：开票）',
  `score` bigint(20) DEFAULT NULL COMMENT '积分',
  `growth_value` bigint(20) NOT NULL DEFAULT '0' COMMENT '成长值',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `rev` int(11) DEFAULT NULL COMMENT '用来锁定行',
  `get_way_code` char(6) DEFAULT NULL COMMENT '获取渠道',
  `is_udesk_customer` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否已经是Udesk系统中的客户',
  `price_type_id` bigint(20) NOT NULL DEFAULT '1' COMMENT '客户所属价格分类id',
  PRIMARY KEY (`id`),
  KEY `idx_type_dict_code` (`type_dict_code`) USING BTREE,
  KEY `idx_settlement_dict_code` (`settlement_dict_code`) USING BTREE,
  KEY `idx_province_id` (`province_id`) USING BTREE,
  KEY `idx_city_id` (`city_id`) USING BTREE,
  KEY `idx_county_id` (`county_id`) USING BTREE,
  KEY `idx_take_invoice` (`is_take_invoice`) USING BTREE,
  KEY `idx_short_name` (`short_name`) USING BTREE,
  KEY `idx_customer_code` (`customer_code`) USING BTREE,
  KEY `idx_price_type_id` (`price_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28815 DEFAULT CHARSET=utf8 COMMENT='客户信息表';

-- ----------------------------
-- Table structure for t_customer_invoice
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_invoice`;
CREATE TABLE `t_customer_invoice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) unsigned NOT NULL COMMENT '客户信息表id',
  `invoice_type` int(11) NOT NULL COMMENT '发票类型（1：普通发票，2：增值税发票）',
  `title` varchar(100) NOT NULL COMMENT '发票抬头（单位名称）',
  `tax_code` varchar(50) DEFAULT NULL COMMENT '纳税人识别码',
  `register_address` varchar(100) DEFAULT NULL COMMENT '注册地址',
  `register_phone` varchar(20) DEFAULT NULL COMMENT '注册电话',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '开户银行',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '银行账号',
  `tax_reg_url` varchar(200) DEFAULT NULL COMMENT '税务登记证图片地址',
  `taxpayer_url` varchar(200) DEFAULT NULL COMMENT '一般纳税人证书图片地址',
  `consignee` varchar(20) DEFAULT NULL COMMENT '收票人姓名',
  `mobile` varchar(50) DEFAULT NULL COMMENT '收票人手机',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份（t_region表的id）',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城市（t_region表的id）',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区县（t_region表的id）',
  `detail_address` varchar(100) DEFAULT NULL COMMENT '详细地址',
  `is_default` bit(1) NOT NULL COMMENT '是否默认',
  `status` int(11) NOT NULL COMMENT '状态（0：未审核，1：审核未通过，2：审核通过）',
  `audit_sys_user` bigint(20) DEFAULT NULL COMMENT '审核人id',
  `audit_name` varchar(20) DEFAULT NULL COMMENT '审核人姓名',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `back_remark` varchar(200) DEFAULT NULL COMMENT '后台备注（只在后台显示）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_customer_info_id` (`customer_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5519 DEFAULT CHARSET=utf8 COMMENT='客户财务信息表';

-- ----------------------------
-- Table structure for t_customer_log
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_log`;
CREATE TABLE `t_customer_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `table_name` varchar(45) DEFAULT NULL COMMENT '表名',
  `customer_info_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `type` varchar(50) DEFAULT NULL COMMENT '类型',
  `message` varchar(500) DEFAULT NULL COMMENT '消息记录',
  `json` text COMMENT '数据json',
  `create_sys_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(45) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62465 DEFAULT CHARSET=utf8 COMMENT='客户修改日志';

-- ----------------------------
-- Table structure for t_customer_login_log
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_login_log`;
CREATE TABLE `t_customer_login_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT 't_customer_info表主键',
  `remote_ip` varchar(50) DEFAULT NULL COMMENT '客户端ip',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '客户端信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=428281 DEFAULT CHARSET=utf8 COMMENT='网站用户登录日志';

-- ----------------------------
-- Table structure for t_customer_message
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_message`;
CREATE TABLE `t_customer_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `send_id` bigint(20) NOT NULL COMMENT '发信人id',
  `receiver_id` bigint(20) NOT NULL COMMENT '收信人id',
  `customer_message_text_id` bigint(20) NOT NULL COMMENT '消息内容',
  `read_time` datetime DEFAULT NULL COMMENT '读取时间',
  `status` int(11) NOT NULL COMMENT '状态（-1：删除，0：未读，1：已读）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136843 DEFAULT CHARSET=utf8 COMMENT='客户消息';

-- ----------------------------
-- Table structure for t_customer_message_text
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_message_text`;
CREATE TABLE `t_customer_message_text` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `receiver_criteria` varchar(300) DEFAULT NULL COMMENT '接受此消息的客户条件（空为全部）',
  `type` char(6) NOT NULL COMMENT '消息类型（数据字典）',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `text` text NOT NULL COMMENT '内容',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4542 DEFAULT CHARSET=utf8 COMMENT='客户站内信内容';

-- ----------------------------
-- Table structure for t_customer_overdue
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_overdue`;
CREATE TABLE `t_customer_overdue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `receivable_id` bigint(20) NOT NULL COMMENT '立账单id',
  `overdue_time` datetime NOT NULL COMMENT '逾期日期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_receivable_id` (`receivable_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=973 DEFAULT CHARSET=utf8 COMMENT='客户逾期表';

-- ----------------------------
-- Table structure for t_customer_overdue_amount
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_overdue_amount`;
CREATE TABLE `t_customer_overdue_amount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `amount` decimal(13,2) NOT NULL COMMENT '逾期金额',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25975 DEFAULT CHARSET=utf8 COMMENT='客户逾期金额表';

-- ----------------------------
-- Table structure for t_customer_overdue_copy
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_overdue_copy`;
CREATE TABLE `t_customer_overdue_copy` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `amount` decimal(12,2) NOT NULL COMMENT '逾期金额',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户逾期表';

-- ----------------------------
-- Table structure for t_customer_service_area
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_service_area`;
CREATE TABLE `t_customer_service_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_person_id` bigint(20) NOT NULL COMMENT '服务人员id',
  `region_level` int(10) NOT NULL COMMENT '地区级别',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省id',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市id',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区、县',
  `type` varchar(11) DEFAULT NULL,
  `status` int(10) NOT NULL COMMENT '状态(-1:删除，10：生效，9：失效)',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 COMMENT='客服服务区域表';

-- ----------------------------
-- Table structure for t_delivery
-- ----------------------------
DROP TABLE IF EXISTS `t_delivery`;
CREATE TABLE `t_delivery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `delivery_code` char(12) NOT NULL COMMENT '出货通知单号',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户信息id',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `delivery_goods_number` int(11) DEFAULT NULL COMMENT '商品件数',
  `status` int(11) NOT NULL COMMENT '状态(-1:作废,1:申请,2:取货完毕,3:送货单4.退货单)',
  `delivery_mode` varchar(20) DEFAULT NULL COMMENT '货运方式名称',
  `delivery_compary` varchar(50) DEFAULT NULL COMMENT '货运公司名称',
  `customer_address_id` bigint(20) DEFAULT NULL COMMENT '收货地址id',
  `consignee` varchar(50) DEFAULT NULL COMMENT '收货人',
  `consignee_phone` varchar(50) DEFAULT NULL COMMENT '收货人电话',
  `consignee_mobile` varchar(50) DEFAULT NULL,
  `consignee_province` varchar(20) DEFAULT NULL COMMENT '收货地址省',
  `consignee_city` varchar(20) DEFAULT NULL COMMENT '收货地址市',
  `consignee_county` varchar(20) DEFAULT NULL COMMENT '收货地址区县',
  `detail_address` varchar(100) DEFAULT NULL COMMENT '收货地址',
  `send_date` date DEFAULT NULL COMMENT '送货日期',
  `waybill_no` varchar(200) DEFAULT NULL COMMENT '运单号',
  `type` int(11) NOT NULL COMMENT '0:表示订单通知单;1:退单通知单',
  `is_urgent` bit(1) DEFAULT NULL COMMENT '是否加急',
  `is_put_bill` bit(1) DEFAULT NULL COMMENT '是否放单',
  `is_show_price` bit(1) DEFAULT NULL COMMENT '是否显示单价',
  `is_supplier_send` bit(1) DEFAULT NULL COMMENT '供应商直发',
  `supplier_code` varchar(20) DEFAULT NULL COMMENT '供应商编码',
  `take_man` varchar(20) DEFAULT NULL COMMENT '取货人',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `is_auto_created` bit(1) DEFAULT NULL,
  `total_price` decimal(12,2) DEFAULT NULL COMMENT '总金额',
  `total_weight` decimal(12,3) DEFAULT NULL COMMENT '总重量',
  `is_delivery_print` bit(1) DEFAULT NULL COMMENT '是否已打印送货单',
  `is_waybill_print` bit(1) DEFAULT NULL COMMENT '是否已打印快递单',
  `goods_box_number` varchar(30) DEFAULT NULL COMMENT '取货件数盒',
  `sms_send_name` varchar(20) DEFAULT NULL COMMENT '短信发送人姓名',
  `sms_send_time` datetime DEFAULT NULL COMMENT '短信发送时间',
  `print_delivery_name` varchar(20) DEFAULT NULL COMMENT '打印送货单人姓名',
  `print_delivery_time` datetime DEFAULT NULL COMMENT '打印送货单时间',
  `print_waybill_name` varchar(20) DEFAULT NULL COMMENT '打印快递单人姓名',
  `print_waybill_time` datetime DEFAULT NULL COMMENT '打印快递单时间',
  `waybill_name` varchar(20) DEFAULT NULL COMMENT '快递单填写人姓名',
  `waybill_time` datetime DEFAULT NULL COMMENT '快递单填写时间',
  `warehouse_remark` varchar(200) DEFAULT NULL COMMENT '仓库备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `sync_status` int(11) DEFAULT NULL COMMENT '同步状态（wms）',
  `sync_time` datetime DEFAULT NULL COMMENT '同步时间（wms）',
  `local_sync_time` datetime DEFAULT NULL COMMENT '本地同步时间，同步写入时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_delivery_code` (`delivery_code`) USING BTREE,
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_send_date` (`send_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=246866 DEFAULT CHARSET=utf8 COMMENT='出货通知单主表';

-- ----------------------------
-- Table structure for t_deliveryorder
-- ----------------------------
DROP TABLE IF EXISTS `t_deliveryorder`;
CREATE TABLE `t_deliveryorder` (
  `sID` varchar(50) DEFAULT NULL,
  `sDRID` varchar(50) DEFAULT NULL,
  `sClientName` varchar(50) DEFAULT NULL,
  `sCreateDate` timestamp NULL DEFAULT NULL,
  `sSendDate` timestamp NULL DEFAULT NULL,
  `sSendModel` varchar(50) DEFAULT NULL,
  `sSendMan` varchar(50) DEFAULT NULL,
  `sTelephone` varchar(50) DEFAULT NULL,
  `sPhone` varchar(50) DEFAULT NULL,
  `sSendAddress` varchar(255) DEFAULT NULL,
  `sNum` double DEFAULT NULL,
  `sOrderPerson` varchar(50) DEFAULT NULL,
  `sBCreaterPerson` varchar(50) DEFAULT NULL,
  `sBCreateTime` timestamp NULL DEFAULT NULL,
  `sTakePerson` varchar(50) DEFAULT NULL,
  `sSendMessagePerson` varchar(50) DEFAULT NULL,
  `sSendMessageTime` varchar(50) DEFAULT NULL,
  `sBoxNum` varchar(50) DEFAULT NULL,
  `sWInputPerson` varchar(50) DEFAULT NULL,
  `sWInputTime` timestamp NULL DEFAULT NULL,
  `sExperssNo` varchar(50) DEFAULT NULL,
  `sSendCompany` varchar(50) DEFAULT NULL,
  `sPayMentType` varchar(50) DEFAULT NULL,
  `sWeight` double DEFAULT NULL,
  `sTotialAmount` double DEFAULT NULL,
  `sISsPrint` tinyint(4) DEFAULT NULL,
  `sPrintPerson` varchar(50) DEFAULT NULL,
  `sPrintTime` timestamp NULL DEFAULT NULL,
  `IsTakeInvoice` tinyint(4) DEFAULT NULL,
  `Remark` varchar(200) DEFAULT NULL,
  `IsExPrint` tinyint(4) DEFAULT NULL,
  `sClientID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_delivery_area
-- ----------------------------
DROP TABLE IF EXISTS `t_delivery_area`;
CREATE TABLE `t_delivery_area` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` bigint(20) NOT NULL COMMENT '商家id',
  `delivery_company_id` bigint(20) NOT NULL COMMENT '物流公司id',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份id',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城市id',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区县id',
  `level` int(11) DEFAULT NULL COMMENT '行政区域级别（1全国2省3市4区县）',
  `is_cod` bit(1) DEFAULT NULL COMMENT '支持货到付款（0：不支持，1：支持）',
  `delivery_fee` decimal(12,2) DEFAULT NULL COMMENT '最低运费（起步价）',
  `base_delivery_fee` decimal(12,2) DEFAULT NULL COMMENT '首重价',
  `freight_kg` decimal(12,2) DEFAULT NULL COMMENT '每公斤运费',
  `delivery_for_free_amount` decimal(12,2) DEFAULT NULL COMMENT '包邮金额',
  `sort` int(11) DEFAULT NULL COMMENT '排序（倒序）',
  `message` varchar(200) DEFAULT NULL COMMENT '提示信息',
  `is_free_frist` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否首单包邮',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，9：失效，10：生效）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delivery_point_address` varchar(200) DEFAULT NULL COMMENT '提货点地址',
  `delivery_point_phone` varchar(30) DEFAULT NULL COMMENT '提货点电话',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3660 DEFAULT CHARSET=utf8 COMMENT='物流配送表';

-- ----------------------------
-- Table structure for t_delivery_company
-- ----------------------------
DROP TABLE IF EXISTS `t_delivery_company`;
CREATE TABLE `t_delivery_company` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(50) NOT NULL COMMENT '公司代码',
  `name` varchar(50) NOT NULL COMMENT '公司名称',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `delivery_type_dict_code` char(6) NOT NULL COMMENT '配送类型(sys_dict的code)',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，9：失效，10：生效）',
  `sort` int(11) NOT NULL COMMENT '排序（倒序）',
  `is_fc` bit(1) NOT NULL COMMENT '运费到付（0：否，1：是）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=619 DEFAULT CHARSET=utf8 COMMENT='配送公司表';

-- ----------------------------
-- Table structure for t_delivery_item
-- ----------------------------
DROP TABLE IF EXISTS `t_delivery_item`;
CREATE TABLE `t_delivery_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `delivery_id` bigint(20) NOT NULL COMMENT '出货通知单主表id',
  `delivery_code` char(12) NOT NULL COMMENT '出货通知单号',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `order_item_id` bigint(20) NOT NULL COMMENT '订单子表id',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `bar_code` varchar(20) DEFAULT NULL COMMENT '条码',
  `apply_num` decimal(12,3) DEFAULT NULL COMMENT '申请数量',
  `take_num` decimal(12,3) DEFAULT NULL COMMENT '取货数量',
  `delivery_num` decimal(12,3) DEFAULT NULL COMMENT '实际发货数量',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `is_balance_account` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否对账',
  `p_is_statement` bit(1) DEFAULT NULL COMMENT '供应商是否对账',
  `origin_apply_num` decimal(12,3) DEFAULT NULL COMMENT '原始申请量，只记录',
  `origin_take_num` decimal(12,3) DEFAULT NULL COMMENT '原始取货量，只记录',
  `sync_time` datetime DEFAULT NULL COMMENT '同步时间，由客户端提供',
  `local_sync_time` datetime DEFAULT NULL COMMENT '本地同步时间，同步写入时间',
  PRIMARY KEY (`id`),
  KEY `idx_delivery_id` (`delivery_id`) USING BTREE,
  KEY `idx_order_item_id` (`order_item_id`) USING BTREE,
  KEY `idx_goods_id` (`goods_id`) USING BTREE,
  KEY `idx_is_balance_account` (`is_balance_account`) USING BTREE,
  KEY `idx_p_is_staterment` (`p_is_statement`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=682215 DEFAULT CHARSET=utf8 COMMENT='出货通知单子表';

-- ----------------------------
-- Table structure for t_dzp_collect
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_collect`;
CREATE TABLE `t_dzp_collect` (
  `c_innerId` varchar(50) NOT NULL COMMENT '收藏表主键',
  `c_loginInnerId` varchar(50) DEFAULT NULL COMMENT '登陆人id',
  `c_custInnerId` varchar(50) DEFAULT NULL COMMENT '登陆人所属公司',
  `c_productId` varchar(50) DEFAULT NULL COMMENT '产品id',
  `c_createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `c_createPerson` varchar(50) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`c_innerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏表';

-- ----------------------------
-- Table structure for t_dzp_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_notice`;
CREATE TABLE `t_dzp_notice` (
  `n_innerid` varchar(50) NOT NULL COMMENT 'innerid主键',
  `n_title` varchar(50) DEFAULT NULL COMMENT '消息标题',
  `n_content` varchar(200) DEFAULT NULL COMMENT '消息内容',
  `n_loginInnerId` varchar(50) DEFAULT NULL COMMENT '消息客户Id',
  `n_type` int(11) DEFAULT NULL COMMENT '消息类型 1公共消息 2呆滞品消息',
  `n_publishTime` datetime DEFAULT NULL COMMENT '发布时间',
  `n_remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `n_isRead` bit(1) DEFAULT NULL COMMENT '是否已读 0未读1已读',
  `n_readTime` datetime DEFAULT NULL COMMENT '阅读时间',
  `n_createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`n_innerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='呆滞品通知表';

-- ----------------------------
-- Table structure for t_dzp_order
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_order`;
CREATE TABLE `t_dzp_order` (
  `o_orderId` varchar(50) NOT NULL COMMENT '订单号',
  `o_productId` varchar(50) DEFAULT NULL COMMENT '商品表主键',
  `o_quantity` decimal(18,3) DEFAULT NULL COMMENT '商品数量',
  `o_price` decimal(18,2) DEFAULT NULL COMMENT '商品单价',
  `o_amounts` decimal(18,2) DEFAULT NULL COMMENT '商品金额',
  `o_statusCode` int(11) NOT NULL COMMENT '订单状态：0提交 1审核通过 -1审核不通过 6已发货 7已收货 8已退款 9完成',
  `o_statusName` varchar(50) DEFAULT NULL COMMENT '订单状态名称',
  `o_address` varchar(200) DEFAULT NULL COMMENT '收货地址',
  `o_consignee` varchar(50) DEFAULT NULL COMMENT '收货人',
  `o_conPhone` varchar(50) DEFAULT NULL COMMENT '收货人联系电话',
  `o_logisticsCompany` varchar(50) DEFAULT NULL COMMENT '物流公司',
  `o_logisticsNum` varchar(50) DEFAULT NULL COMMENT '物流单号',
  `o_customer` varchar(50) NOT NULL COMMENT '下单客户',
  `o_custLogin` varchar(50) NOT NULL COMMENT '下单账号',
  `o_createDate` datetime DEFAULT NULL COMMENT '下单时间',
  `o_orderType` int(11) NOT NULL COMMENT '订单类型：0或空正常订单 1样品单',
  `o_payStatus` int(11) NOT NULL COMMENT '支付状态：0未支付 1已支付',
  `o_paymentType` varchar(50) DEFAULT NULL COMMENT '支付方式',
  `o_paymentSeq` varchar(100) DEFAULT NULL COMMENT '支付流水号',
  `o_paymentTime` datetime DEFAULT NULL COMMENT '支付时间',
  `o_remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `o_supplierInnerid` varchar(50) NOT NULL COMMENT '供应商innerid（客户表innerid）',
  `o_payAmounts` decimal(18,2) DEFAULT NULL COMMENT '付款金额',
  `o_supplierLoginer` varchar(50) DEFAULT NULL COMMENT '商品发布人',
  `o_postage` decimal(18,2) DEFAULT NULL COMMENT '运费',
  `o_p_isSettle` bit(1) DEFAULT b'0' COMMENT '是否对账',
  `o_p_statementCode` varchar(20) DEFAULT NULL COMMENT '对账单号',
  `invoice_code` varchar(45) DEFAULT NULL COMMENT '发票号',
  `invoice_date` datetime DEFAULT NULL COMMENT '开票日期',
  `invoice_amount` decimal(12,2) DEFAULT NULL COMMENT '开票金额',
  `is_settle` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否客户对账',
  `statement_id` bigint(20) DEFAULT NULL COMMENT '客户对账单id',
  PRIMARY KEY (`o_orderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='呆滞品订单主表';

-- ----------------------------
-- Table structure for t_dzp_order_invoice
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_order_invoice`;
CREATE TABLE `t_dzp_order_invoice` (
  `a_orderId` varchar(50) NOT NULL COMMENT '订单号',
  `a_invoiceInnerid` varchar(50) DEFAULT NULL COMMENT '发票信息主键',
  `a_invoiceType` varchar(50) DEFAULT NULL COMMENT '开票类型：普通发票 增税发票',
  `a_invoiceTitle` varchar(100) DEFAULT NULL COMMENT '发票抬头',
  `a_receiveAddress` varchar(100) DEFAULT NULL COMMENT '收票地址',
  `a_receivePerson` varchar(50) DEFAULT NULL COMMENT '收票联系人',
  `a_receivePhone` varchar(50) DEFAULT NULL COMMENT '收票联系人电话',
  `a_company` varchar(100) DEFAULT NULL COMMENT '单位名称',
  `a_bank` varchar(100) DEFAULT NULL COMMENT '开户行',
  `a_account` varchar(50) DEFAULT NULL COMMENT '账号',
  `a_taxNum` varchar(100) DEFAULT NULL COMMENT '税号',
  `a_inAddress` varchar(100) DEFAULT NULL COMMENT '开票地址',
  `a_remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`a_orderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_dzp_order_log
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_order_log`;
CREATE TABLE `t_dzp_order_log` (
  `l_innerid` varchar(50) NOT NULL COMMENT 'innerid主键',
  `l_orderid` varchar(50) DEFAULT NULL COMMENT '订单号',
  `l_approvePerson` varchar(50) DEFAULT NULL COMMENT '处理人',
  `l_approveDate` datetime DEFAULT NULL COMMENT '处理时间',
  `l_approveThings` varchar(500) DEFAULT NULL COMMENT '处理事件',
  `l_DeliveryQty` decimal(18,3) DEFAULT NULL COMMENT '发货数量',
  `l_receiveQty` decimal(18,3) DEFAULT NULL COMMENT '收货数量',
  `l_typeCode` int(11) DEFAULT NULL COMMENT '处理类型 0提交 1审核通过 -1审核不通过 6已发货 7已收货 9完成',
  `l_typeName` varchar(50) DEFAULT NULL,
  `l_remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`l_innerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_dzp_payment
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_payment`;
CREATE TABLE `t_dzp_payment` (
  `inner_id` varchar(50) NOT NULL COMMENT '主键',
  `pay_code` varchar(50) DEFAULT NULL COMMENT '编号',
  `customer_info_id` varchar(50) DEFAULT NULL COMMENT '付款客户',
  `method` varchar(50) DEFAULT NULL COMMENT '付款类型',
  `pay_money` decimal(18,2) DEFAULT NULL COMMENT '金额',
  `voucher_code` varchar(50) DEFAULT NULL COMMENT '凭证号',
  `pay_date` varchar(50) DEFAULT NULL COMMENT '付款日期',
  `order_id` varchar(200) DEFAULT NULL COMMENT '订单号',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `remark2` varchar(200) DEFAULT NULL COMMENT '备注2',
  `oper_man` varchar(50) DEFAULT NULL COMMENT '操作人',
  `oper_time` varchar(50) DEFAULT NULL COMMENT '操作时间',
  `check_balance_code` varchar(50) DEFAULT NULL COMMENT '勾兑单号',
  `is_settle` bit(1) DEFAULT b'0' COMMENT '是否结清',
  PRIMARY KEY (`inner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_dzp_product
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_product`;
CREATE TABLE `t_dzp_product` (
  `p_productId` varchar(50) NOT NULL COMMENT '商品编号',
  `p_bigClass` varchar(50) DEFAULT NULL COMMENT '大类',
  `p_material` varchar(50) DEFAULT NULL COMMENT '材质',
  `p_name` varchar(50) DEFAULT NULL COMMENT '品名',
  `p_spec` varchar(50) DEFAULT NULL COMMENT '规格',
  `p_description` varchar(200) DEFAULT NULL COMMENT '中文描述',
  `p_availableStock` decimal(18,3) DEFAULT NULL COMMENT '可用库存',
  `p_totalStock` decimal(18,3) DEFAULT NULL COMMENT '总发布库存量',
  `p_DeliveryStock` decimal(18,3) DEFAULT NULL COMMENT '发货量',
  `p_lockStock` decimal(18,3) DEFAULT NULL COMMENT '占用量',
  `p_price` decimal(18,2) DEFAULT NULL COMMENT '单价',
  `p_MOQ` decimal(18,3) DEFAULT NULL COMMENT '起订量',
  `p_packingUnit` varchar(50) DEFAULT NULL COMMENT '包装单位',
  `p_packingQty` decimal(18,3) DEFAULT NULL COMMENT '包装数量',
  `p_province` varchar(50) DEFAULT NULL COMMENT '省',
  `p_city` varchar(50) DEFAULT NULL COMMENT '市',
  `p_special_note` text COMMENT '特别说明',
  `p_brand` varchar(50) DEFAULT NULL COMMENT '品牌',
  `p_SupplierInnerid` varchar(50) DEFAULT NULL COMMENT '供应商innerid（客户表innerid）',
  `p_createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `p_createPerson` varchar(50) DEFAULT NULL COMMENT '创建人（登录人innerid）',
  `p_updateDate` datetime DEFAULT NULL COMMENT '修改时间',
  `p_updatePerson` varchar(50) DEFAULT NULL COMMENT '修改人',
  `p_statusCode` int(11) DEFAULT NULL COMMENT '状态：-1作废 0未审核/下架 1待审核 3未通过  9上架',
  `p_statusName` varchar(50) DEFAULT NULL,
  `p_provideSamples` bit(1) DEFAULT NULL COMMENT '是否提供样品',
  `p_samplesQty` decimal(18,3) DEFAULT NULL COMMENT '提供样品数量',
  `p_productImg` varchar(200) DEFAULT NULL COMMENT '图片路径',
  `p_contactPerson` varchar(50) DEFAULT NULL COMMENT '产品联系人',
  `p_contactPhone` varchar(50) DEFAULT NULL COMMENT '产品联系人手机',
  `p_sortField` int(11) DEFAULT NULL COMMENT '排序字段',
  `p_approvePerson` varchar(50) DEFAULT NULL COMMENT '审核人',
  `p_approveDate` datetime DEFAULT NULL COMMENT '审核时间',
  `p_promiseDeliveryTime` varchar(50) DEFAULT NULL COMMENT '承诺发货时间：24小时、48小时、协商',
  `p_remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `p_ShowDay` int(11) DEFAULT NULL COMMENT '展示周期 单位：天',
  `p_searchKey` varchar(500) DEFAULT NULL COMMENT '搜索关键字',
  `p_setTop` bit(1) DEFAULT NULL COMMENT '置顶',
  `p_specPic1` varchar(200) DEFAULT NULL COMMENT '产品规格图1',
  `p_specPic2` varchar(200) DEFAULT NULL COMMENT '产品规格图2',
  `p_specPic3` varchar(200) DEFAULT NULL COMMENT '产品规格图3',
  PRIMARY KEY (`p_productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_dzp_provider
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_provider`;
CREATE TABLE `t_dzp_provider` (
  `c_custInnerid` varchar(50) NOT NULL COMMENT '客户innerid 主键',
  `c_companyName` varchar(300) DEFAULT NULL COMMENT '公司全称',
  `c_companySimple` varchar(200) DEFAULT NULL COMMENT '公司简称',
  `c_companySX` varchar(100) DEFAULT NULL COMMENT '拼音缩写',
  `c_legalPerson` varchar(50) DEFAULT NULL COMMENT '法人姓名',
  `c_regProvince` varchar(50) DEFAULT NULL COMMENT '营业执照所在地省份',
  `c_regCity` varchar(50) DEFAULT NULL COMMENT '营业执照所在地市',
  `c_licenseCode` varchar(100) DEFAULT NULL COMMENT '营业执照代码',
  `c_licenseImg` varchar(200) DEFAULT NULL COMMENT '营业执照路径',
  `c_taxnum` varchar(100) DEFAULT NULL COMMENT '税务登记号',
  `c_taxnumImg` varchar(200) DEFAULT NULL COMMENT '税务登记证路径',
  `c_organizationCode` varchar(100) DEFAULT NULL COMMENT '组织机构代码',
  `c_organizationImg` varchar(200) DEFAULT NULL COMMENT '组织机构代码路径',
  `c_taxpayer` varchar(100) DEFAULT NULL COMMENT '是否一般纳税人 --是/否\r\n',
  `c_type` varchar(50) DEFAULT NULL COMMENT '类别 经销商 工厂 零售商 其他',
  `c_StatusCode` int(11) DEFAULT NULL COMMENT '状态代码：-1作废 0非供应商 1申请 3审核未通过 9供应商',
  `c_StatusName` varchar(50) DEFAULT NULL COMMENT '状态代码：-1作废 0非供应商 1申请 3审核未通过 9供应商',
  `c_createPerson` varchar(50) DEFAULT NULL COMMENT '创建人',
  `c_createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `c_examinePerson` varchar(50) DEFAULT NULL COMMENT '审核人',
  `c_examineDate` datetime DEFAULT NULL COMMENT '审核时间',
  `c_updatePerson` varchar(50) DEFAULT NULL COMMENT '修改人',
  `c_updateDate` datetime DEFAULT NULL COMMENT '修改时间',
  `c_contactPhone` varchar(50) DEFAULT NULL COMMENT '紧急联系电话',
  `c_contactPerson` varchar(50) DEFAULT NULL COMMENT '紧急联系人',
  `c_contactAddress` varchar(200) DEFAULT NULL COMMENT '联系地址',
  `c_remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `c_payee` varchar(50) DEFAULT NULL,
  `c_deposit_bank` varchar(200) DEFAULT NULL,
  `c_deposit_no` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`c_custInnerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_dzp_p_check
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_p_check`;
CREATE TABLE `t_dzp_p_check` (
  `check_code` varchar(20) NOT NULL COMMENT '勾对单号',
  `status` int(10) DEFAULT NULL COMMENT '状态0-作废1-生效',
  `provider_id` bigint(20) DEFAULT NULL COMMENT '供应商id',
  `check_date` datetime DEFAULT NULL COMMENT '勾对日期',
  `check_amount` decimal(18,2) DEFAULT NULL COMMENT '勾对总金额',
  `oper_person` varchar(20) DEFAULT NULL COMMENT '操作人名称',
  `oper_time` datetime DEFAULT NULL COMMENT '操作日期',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`check_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='呆滞品供应商勾兑';

-- ----------------------------
-- Table structure for t_dzp_p_payment
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_p_payment`;
CREATE TABLE `t_dzp_p_payment` (
  `pay_code` varchar(20) NOT NULL COMMENT '付款单号',
  `provider_id` varchar(20) DEFAULT NULL COMMENT '供应商id',
  `status` int(11) DEFAULT NULL COMMENT '状态0-作废1-生效',
  `method` varchar(20) DEFAULT NULL COMMENT '付款方式',
  `pay_amount` decimal(18,2) DEFAULT NULL COMMENT '付款金额',
  `voucher_code` varchar(50) DEFAULT NULL COMMENT '付款凭证号',
  `pay_time` datetime DEFAULT NULL COMMENT '付款时间',
  `oper_person` varchar(20) DEFAULT NULL COMMENT '操作人',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `is_settle` bit(1) DEFAULT NULL COMMENT '是否结清',
  `check_code` varchar(20) DEFAULT NULL COMMENT '勾对单号',
  PRIMARY KEY (`pay_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='呆滞品供应商付款表';

-- ----------------------------
-- Table structure for t_dzp_p_statement
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_p_statement`;
CREATE TABLE `t_dzp_p_statement` (
  `statement_code` varchar(20) NOT NULL COMMENT '对账单号',
  `provider_id` varchar(50) DEFAULT NULL COMMENT '供应商id',
  `status` int(11) DEFAULT NULL COMMENT '状态(1生成对账单2已立账3已勾对)',
  `statement_amount` decimal(18,2) DEFAULT NULL COMMENT '对账总金额',
  `statement_time` datetime DEFAULT NULL COMMENT '对账日期',
  `statement_person` varchar(50) DEFAULT NULL COMMENT '对账人名称',
  `receivable_amount` decimal(18,2) DEFAULT NULL COMMENT '立账金额',
  `receivable_time` datetime DEFAULT NULL COMMENT '立账时间',
  `receivable_person` varchar(50) DEFAULT NULL COMMENT '立账人名称',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `is_settle` bit(1) DEFAULT b'0' COMMENT '是否勾对',
  `check_code` varchar(20) DEFAULT NULL COMMENT '勾兑单号',
  `invoice_code` varchar(20) DEFAULT NULL COMMENT '发票号码',
  `invoice_amount` decimal(18,2) DEFAULT NULL COMMENT '发票金额',
  `invoice_time` datetime DEFAULT NULL COMMENT '开票时间',
  PRIMARY KEY (`statement_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='呆滞品供应商对账';

-- ----------------------------
-- Table structure for t_dzp_settle
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_settle`;
CREATE TABLE `t_dzp_settle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `settle_code` varchar(20) DEFAULT NULL COMMENT '勾兑单号',
  `customer_info_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `settle_time` datetime DEFAULT NULL COMMENT '勾兑时间',
  `settle_amount` decimal(12,2) DEFAULT NULL COMMENT '勾兑金额',
  `settle_user_id` bigint(20) DEFAULT NULL COMMENT '勾兑人id',
  `settle_user_name` varchar(20) DEFAULT NULL COMMENT '勾兑人名称',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='呆滞品勾兑单';

-- ----------------------------
-- Table structure for t_dzp_statement
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_statement`;
CREATE TABLE `t_dzp_statement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `statement_code` varchar(20) DEFAULT NULL COMMENT '对账单号',
  `customer_info_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `status` int(11) DEFAULT NULL COMMENT '状态（1、申请，2、请立账，3、已立账，4、已开票）',
  `statement_time` datetime DEFAULT NULL COMMENT '对账时间',
  `statement_amount` decimal(12,2) DEFAULT NULL COMMENT '对账金额',
  `statement_user_id` bigint(20) DEFAULT NULL COMMENT '对账人id',
  `statement_user_name` varchar(20) DEFAULT NULL COMMENT '对账人名称',
  `receivable_time` datetime DEFAULT NULL COMMENT '立账时间',
  `receivable_amount` decimal(12,2) DEFAULT NULL COMMENT '立账金额',
  `receivable_user_id` bigint(20) DEFAULT NULL COMMENT '立账人id',
  `receivable_user_name` varchar(20) DEFAULT NULL COMMENT '立账人名称',
  `invoice_code` varchar(50) DEFAULT NULL COMMENT '发票号',
  `invoice_date` date DEFAULT NULL COMMENT '开票日期',
  `invoice_amount` decimal(12,2) DEFAULT NULL COMMENT '开票金额',
  `express_company` varchar(20) DEFAULT NULL COMMENT '快递公司',
  `express_number` varchar(20) DEFAULT NULL COMMENT '快递单号',
  `is_settle` bit(1) DEFAULT b'0' COMMENT '是否结清（1、已结清，0、未结清）',
  `settle_id` bigint(20) DEFAULT NULL COMMENT '呆滞品勾兑单id',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='呆滞品客户对账表';

-- ----------------------------
-- Table structure for t_dzp_statement_item
-- ----------------------------
DROP TABLE IF EXISTS `t_dzp_statement_item`;
CREATE TABLE `t_dzp_statement_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `statement_id` bigint(20) DEFAULT NULL COMMENT '对账单号id',
  `order_code` varchar(20) DEFAULT NULL COMMENT '呆滞品订单编号',
  `goods_code` varchar(20) DEFAULT NULL COMMENT '呆滞品商品编号',
  `num` decimal(12,3) DEFAULT NULL COMMENT '商品数量',
  `price` decimal(12,2) DEFAULT NULL COMMENT '商品单价',
  `total_amount` decimal(12,2) DEFAULT NULL COMMENT '小计金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='呆滞品客户对账子表';

-- ----------------------------
-- Table structure for t_floor
-- ----------------------------
DROP TABLE IF EXISTS `t_floor`;
CREATE TABLE `t_floor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `title` varchar(30) NOT NULL COMMENT '标题',
  `title_url` varchar(500) DEFAULT NULL COMMENT '标题跳转链接',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，10：生效）',
  `sort` int(11) NOT NULL COMMENT '排序',
  `type` int(11) NOT NULL COMMENT '类型（1：正常楼层，2：每日推荐，3：品牌，4：微信楼层，5：微信每日推存）',
  `description` varchar(50) DEFAULT NULL COMMENT '描述',
  `is_contain_ad` bit(1) DEFAULT NULL COMMENT '是否显示广告条',
  `ad_image_url` varchar(500) DEFAULT NULL COMMENT '广告图片url',
  `ad_click_url` varchar(500) DEFAULT NULL COMMENT '广告链接url',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='主页楼层主表';

-- ----------------------------
-- Table structure for t_floor_item
-- ----------------------------
DROP TABLE IF EXISTS `t_floor_item`;
CREATE TABLE `t_floor_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `floor_tab_id` bigint(20) NOT NULL COMMENT '楼层id',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，10：生效）',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `type` int(11) NOT NULL COMMENT '类型（1：纯文字，2：图片）',
  `text_content` varchar(50) DEFAULT NULL COMMENT '文字内容',
  `image_url` varchar(500) DEFAULT NULL COMMENT '图片url',
  `image_title` varchar(50) DEFAULT NULL COMMENT '图片黑色大标题',
  `image_description` varchar(50) DEFAULT NULL COMMENT '图片红色小标题',
  `show_tip` bit(1) DEFAULT NULL COMMENT '是否在图片上显示文字',
  `section_type` int(11) DEFAULT NULL COMMENT '图片类型（1：主图，2：次级主图，3：小图）',
  `click_url` varchar(500) DEFAULT NULL COMMENT '链接url',
  `roll_page` int(11) DEFAULT NULL COMMENT '所在滚动页',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8 COMMENT='主页楼层内容子表';

-- ----------------------------
-- Table structure for t_floor_section
-- ----------------------------
DROP TABLE IF EXISTS `t_floor_section`;
CREATE TABLE `t_floor_section` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `floor_template_id` bigint(11) NOT NULL COMMENT '楼层模板id',
  `type` int(11) DEFAULT NULL COMMENT '分区类型（1：左，2：中，3：右）',
  `picture_count` int(11) DEFAULT NULL COMMENT '图片数量',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，10：生效）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='楼层模板分区定义表';

-- ----------------------------
-- Table structure for t_floor_tab
-- ----------------------------
DROP TABLE IF EXISTS `t_floor_tab`;
CREATE TABLE `t_floor_tab` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `floor_id` bigint(11) NOT NULL COMMENT '楼层id',
  `floor_template_id` bigint(11) NOT NULL,
  `title` varchar(20) DEFAULT NULL COMMENT 'tab页标题',
  `title_url` varchar(500) DEFAULT NULL COMMENT 'tab页标题跳转链接',
  `roll_count` int(11) DEFAULT NULL COMMENT '滚动页数',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，10：生效）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='楼层tab页表（预留）';

-- ----------------------------
-- Table structure for t_floor_template
-- ----------------------------
DROP TABLE IF EXISTS `t_floor_template`;
CREATE TABLE `t_floor_template` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(30) NOT NULL COMMENT '模板名称',
  `floor_type` int(11) NOT NULL COMMENT '类型（1：网站楼层，2：网站推荐，3：品牌（未使用），4：微信楼层，5：微信推荐）',
  `layout_type` int(11) NOT NULL COMMENT '布局类型（0：无分区，1：左右布局，2：左中右布局）',
  `is_roll` bit(1) DEFAULT NULL COMMENT '是否可以滚动',
  `roll_type` int(11) DEFAULT NULL COMMENT '滚动类型（0：全部，1：仅左，2：仅中，3：仅右，4：左中，5：中右）',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，10：生效）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='楼层模板表';

-- ----------------------------
-- Table structure for t_freight_report
-- ----------------------------
DROP TABLE IF EXISTS `t_freight_report`;
CREATE TABLE `t_freight_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` bigint(20) NOT NULL COMMENT '商家id',
  `freight_time` date NOT NULL COMMENT '费用发生时间',
  `vectura_cost` decimal(12,2) DEFAULT NULL COMMENT '货运费用',
  `express_cost` decimal(12,2) DEFAULT NULL COMMENT '快递费用',
  `other_cost` decimal(12,2) DEFAULT NULL COMMENT '其他物流费用',
  `piece_num` decimal(12,0) NOT NULL COMMENT '总件数',
  `weight` decimal(12,3) NOT NULL COMMENT '重量',
  `status` int(11) NOT NULL COMMENT '状态（10：生效，-1：删除）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_merchantId` (`merchant_id`) USING BTREE,
  KEY `idx_freightTime` (`freight_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8 COMMENT='运费统计表';

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint(20) DEFAULT NULL COMMENT '类目id',
  `brand_id` bigint(20) NOT NULL COMMENT '品牌id',
  `bar_code` varchar(20) NOT NULL COMMENT '条码（唯一）',
  `scan_barcode` varchar(20) DEFAULT NULL COMMENT '仓库扫描码',
  `goods_standard_id` bigint(20) NOT NULL COMMENT '分类品名id(t_goods_standard表的id字段)',
  `supplier_id` bigint(20) NOT NULL COMMENT '供应商id',
  `merchant_id` bigint(20) NOT NULL COMMENT '商家id',
  `name` varchar(50) DEFAULT NULL COMMENT '品名',
  `material_dict_code` char(6) DEFAULT NULL COMMENT '材质',
  `specification` varchar(50) DEFAULT NULL COMMENT '规格',
  `description` varchar(100) DEFAULT NULL COMMENT '中文描述',
  `buying_initial_price` decimal(12,2) NOT NULL COMMENT '进价牌价',
  `buying_discount` decimal(12,4) DEFAULT NULL COMMENT '进价折扣',
  `process_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '进价加工价',
  `buying_price` decimal(12,2) NOT NULL COMMENT '进价',
  `market_price` decimal(12,2) NOT NULL COMMENT '市场价',
  `member_discount_1` decimal(12,4) DEFAULT NULL COMMENT '1级会员价折扣',
  `member_discount_2` decimal(12,4) DEFAULT NULL COMMENT '2级会员价折扣',
  `member_discount_3` decimal(12,4) DEFAULT NULL COMMENT '3级会员价折扣',
  `member_discount_4` decimal(12,4) DEFAULT NULL COMMENT '4级会员价折扣',
  `member_discount_5` decimal(12,4) DEFAULT NULL COMMENT '5级会员价折扣',
  `member_price_1` decimal(12,2) NOT NULL COMMENT '一级会员价',
  `member_price_2` decimal(12,2) NOT NULL COMMENT '二级会员价',
  `member_price_3` decimal(12,2) NOT NULL COMMENT '三级会员价',
  `member_price_4` decimal(12,2) NOT NULL COMMENT '四级会员价',
  `member_price_5` decimal(12,2) NOT NULL COMMENT '五级会员价',
  `promotion_type_dict_code` char(6) NOT NULL COMMENT '促销类型（无，新品特价，震撼特价，促销特价）',
  `promotion_price_1` decimal(12,2) DEFAULT NULL COMMENT '一级会员促销价',
  `promotion_price_2` decimal(12,2) DEFAULT NULL COMMENT '二级会员促销价',
  `promotion_price_3` decimal(12,2) DEFAULT NULL COMMENT '三级会员促销价',
  `promotion_price_4` decimal(12,2) DEFAULT NULL COMMENT '四级会员促销价',
  `promotion_price_5` decimal(12,2) DEFAULT NULL COMMENT '五级会员促销价',
  `sample_num_upper` decimal(12,3) DEFAULT NULL COMMENT '样品数量上限',
  `unit_dict_code` char(6) NOT NULL COMMENT '数量单位',
  `weight` decimal(12,3) DEFAULT NULL COMMENT '重量（kg）',
  `min_pack_unit_id` bigint(20) DEFAULT NULL COMMENT '最小包装单位ID',
  `status` int(11) NOT NULL COMMENT '状态（0：下架，1：上架）',
  `diameter` varchar(20) DEFAULT NULL COMMENT '直径',
  `length` varchar(20) DEFAULT NULL COMMENT '长度',
  `metric_diameter` decimal(12,2) DEFAULT NULL COMMENT '公制直径(mm)',
  `metric_length` decimal(12,2) DEFAULT NULL COMMENT '公制长度(mm)',
  `pack_desc` varchar(200) DEFAULT NULL COMMENT '包装描述',
  `is_first` bit(1) NOT NULL COMMENT '是否尝鲜价',
  `area_price_rule_id` bigint(20) DEFAULT NULL COMMENT '商品折扣',
  `is_discount` bit(1) NOT NULL COMMENT '是否折上折',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `vulgo` varchar(200) DEFAULT NULL COMMENT '俗称',
  `search_key` varchar(500) DEFAULT NULL COMMENT '搜索字段',
  `is_public` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否公开（公开只可以搜索）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_bar_code` (`bar_code`) USING BTREE,
  UNIQUE KEY `uni_scanbarcode_merchant` (`scan_barcode`,`merchant_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_material_dict_code` (`material_dict_code`,`name`,`metric_diameter`,`metric_length`,`brand_id`) USING BTREE,
  KEY `idx_goods_standard_id` (`goods_standard_id`,`category_id`,`status`) USING BTREE,
  KEY `idx_merchant_brand` (`merchant_id`,`brand_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109452 DEFAULT CHARSET=utf8 COMMENT='商品表';

-- ----------------------------
-- Table structure for t_goods_attr
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_attr`;
CREATE TABLE `t_goods_attr` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `attr_name_id` bigint(20) NOT NULL COMMENT '属性名id',
  `attr_name` varchar(50) NOT NULL COMMENT '属性名',
  `attr_value` varchar(50) NOT NULL COMMENT '属性值',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_goods_id` (`goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2746159 DEFAULT CHARSET=utf8 COMMENT='商品属性表';

-- ----------------------------
-- Table structure for t_goods_discount
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_discount`;
CREATE TABLE `t_goods_discount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `goods_id` bigint(20) NOT NULL COMMENT '商品主键',
  `goods_qty` decimal(12,3) NOT NULL COMMENT '商品数量',
  `discount` decimal(4,2) NOT NULL COMMENT '折扣',
  PRIMARY KEY (`id`),
  KEY `idx_goods_id` (`goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=93989 DEFAULT CHARSET=utf8 COMMENT='商品折扣表';

-- ----------------------------
-- Table structure for t_goods_log
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_log`;
CREATE TABLE `t_goods_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品表id',
  `bar_code` varchar(20) DEFAULT NULL COMMENT '条码',
  `action_code` varchar(30) NOT NULL COMMENT '操作代号',
  `action_name` varchar(50) NOT NULL COMMENT '操作名称',
  `detail_msg` varchar(500) DEFAULT NULL COMMENT '详细描述',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index2` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='商品日志';

-- ----------------------------
-- Table structure for t_goods_log_extend
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_log_extend`;
CREATE TABLE `t_goods_log_extend` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_log_id` bigint(20) NOT NULL,
  `json` mediumtext COMMENT 'JSON对象',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='商品日志扩展表';

-- ----------------------------
-- Table structure for t_goods_name_picture
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_name_picture`;
CREATE TABLE `t_goods_name_picture` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_standard_id` bigint(20) NOT NULL COMMENT 't_goods_standard表的id',
  `type_dict_code` char(6) NOT NULL COMMENT '图片类型数据字典，主图、图纸、表格',
  `url` varchar(200) DEFAULT NULL COMMENT '图片访问地址url',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_gsid_type` (`goods_standard_id`,`type_dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12750 DEFAULT CHARSET=utf8 COMMENT='商品品名图片';

-- ----------------------------
-- Table structure for t_goods_pack
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_pack`;
CREATE TABLE `t_goods_pack` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) NOT NULL COMMENT 't_goods表的id',
  `pack_unit_id` bigint(20) NOT NULL COMMENT '包装单位ID',
  `pack_unit_name` varchar(10) NOT NULL COMMENT '包装单位',
  `pack_num` decimal(12,3) NOT NULL COMMENT '包装数量',
  `pack_level` int(3) DEFAULT NULL COMMENT '包装级别',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_goods_pack` (`goods_id`,`pack_unit_id`) USING BTREE,
  KEY `uni_goods_level` (`goods_id`,`pack_level`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=290871 DEFAULT CHARSET=utf8 COMMENT='商品包装表';

-- ----------------------------
-- Table structure for t_goods_picture
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_picture`;
CREATE TABLE `t_goods_picture` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `url` varchar(200) NOT NULL COMMENT '图片url',
  `type_dict_code` char(6) NOT NULL COMMENT '图片类型',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_goods_id` (`goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=427973 DEFAULT CHARSET=utf8 COMMENT='商品图片表';

-- ----------------------------
-- Table structure for t_goods_price_log
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_price_log`;
CREATE TABLE `t_goods_price_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `buying_initial_price` decimal(12,2) NOT NULL COMMENT '进价牌价',
  `buying_discount` decimal(12,4) DEFAULT NULL COMMENT '进价折扣',
  `process_price` decimal(12,2) DEFAULT '0.00' COMMENT '进价加工价',
  `buying_price` decimal(12,2) NOT NULL COMMENT '进价',
  `market_price` decimal(12,2) NOT NULL COMMENT '市场价',
  `member_price_1` decimal(12,2) NOT NULL COMMENT '一级会员价',
  `member_price_2` decimal(12,2) NOT NULL COMMENT '二级会员价',
  `member_price_3` decimal(12,2) NOT NULL COMMENT '三级会员价',
  `member_price_4` decimal(12,2) NOT NULL COMMENT '四级会员价',
  `member_price_5` decimal(12,2) NOT NULL COMMENT '五级会员价',
  `promotion_type_dict_code` char(6) NOT NULL COMMENT '促销类型（无，新品特价，震撼特价，促销特价）',
  `promotion_price_1` decimal(12,2) DEFAULT NULL COMMENT '一级会员促销价',
  `promotion_price_2` decimal(12,2) DEFAULT NULL COMMENT '二级会员促销价',
  `promotion_price_3` decimal(12,2) DEFAULT NULL COMMENT '三级会员促销价',
  `promotion_price_4` decimal(12,2) DEFAULT NULL COMMENT '四级会员促销价',
  `promotion_price_5` decimal(12,2) DEFAULT NULL COMMENT '五级会员促销价',
  `is_discount` bit(1) NOT NULL COMMENT '是否折上折',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_goods_id` (`goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=983094 DEFAULT CHARSET=utf8 COMMENT='商品价格日志';

-- ----------------------------
-- Table structure for t_goods_selling
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_selling`;
CREATE TABLE `t_goods_selling` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `gs_id` bigint(20) NOT NULL COMMENT '分类品名标准表id',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_goods_standard
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_standard`;
CREATE TABLE `t_goods_standard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编码',
  `goods_name` varchar(50) DEFAULT NULL COMMENT '品名',
  `category_id` bigint(20) DEFAULT NULL COMMENT '分类id（对应末级分类Id）',
  `standard_id` bigint(20) DEFAULT NULL COMMENT '标准id',
  `description` varchar(50) NOT NULL COMMENT '中文描述',
  `sort` int(11) DEFAULT NULL COMMENT '排序（升序）',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态，-1：已删除，0：失效，1：生效',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `big_pic_word` varchar(30) DEFAULT NULL COMMENT '品名文字描述内容',
  `is_print_online` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否支持在线打印质保书',
  PRIMARY KEY (`id`),
  KEY `idx_standard_id` (`standard_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4949 DEFAULT CHARSET=utf8 COMMENT='分类品名标准表';

-- ----------------------------
-- Table structure for t_goods_standard_attr
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_standard_attr`;
CREATE TABLE `t_goods_standard_attr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_standard_id` bigint(20) NOT NULL COMMENT '商品名称id',
  `attr_name_id` bigint(20) NOT NULL COMMENT '属性名称id',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_name` varchar(12) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `is_check` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否检验',
  `is_print` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否打印',
  `print_sort` int(11) NOT NULL DEFAULT '0' COMMENT '打印顺序（倒序）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_2` (`goods_standard_id`,`attr_name_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=156351 DEFAULT CHARSET=utf8 COMMENT='品名属性表（只存检验打印的商品属性）';

-- ----------------------------
-- Table structure for t_goods_stockout
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_stockout`;
CREATE TABLE `t_goods_stockout` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `warehouse_stock_id` bigint(20) NOT NULL COMMENT '库存id',
  `status` bit(1) NOT NULL COMMENT '1: 缺货，0：不缺货',
  `stockout_time` datetime DEFAULT NULL COMMENT '缺货日期（null为货已补上）',
  PRIMARY KEY (`id`),
  KEY `idx_goods_id` (`goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=94481 DEFAULT CHARSET=utf8 COMMENT='商品缺货统计表';

-- ----------------------------
-- Table structure for t_goods_stockout_item
-- ----------------------------
DROP TABLE IF EXISTS `t_goods_stockout_item`;
CREATE TABLE `t_goods_stockout_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `good_stockout_id` bigint(20) NOT NULL COMMENT '商品缺货统计主表id',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `change_num` decimal(11,3) NOT NULL COMMENT '数量变化值',
  `type` varchar(20) NOT NULL COMMENT '类型',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=149278 DEFAULT CHARSET=utf8 COMMENT='商品缺货统计子表';

-- ----------------------------
-- Table structure for t_index_category
-- ----------------------------
DROP TABLE IF EXISTS `t_index_category`;
CREATE TABLE `t_index_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `category_ids` varchar(30) NOT NULL COMMENT '分类id',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，10：生效）',
  `sort` int(11) NOT NULL COMMENT '排序',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='主页分类设置表';

-- ----------------------------
-- Table structure for t_links
-- ----------------------------
DROP TABLE IF EXISTS `t_links`;
CREATE TABLE `t_links` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(50) NOT NULL COMMENT '链接显示名称',
  `url` varchar(200) NOT NULL COMMENT '链接地址',
  `link_type_code` varchar(20) DEFAULT NULL COMMENT '网站链接类型',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `audit_status` int(11) NOT NULL DEFAULT '0' COMMENT '审核状态(-1失效 0发布 1审核中 9审核通过)',
  `del_flag` bit(1) DEFAULT NULL COMMENT '是否删除(0未删除1已删除)',
  `sort` int(11) DEFAULT NULL COMMENT '排序（升序）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_nofollow` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否无需追踪',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='网站链接';

-- ----------------------------
-- Table structure for t_material_component
-- ----------------------------
DROP TABLE IF EXISTS `t_material_component`;
CREATE TABLE `t_material_component` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `material_code` char(6) DEFAULT NULL COMMENT '材质代码',
  `component` varchar(50) DEFAULT NULL COMMENT '成分',
  `standardValue` varchar(30) DEFAULT NULL COMMENT '标准值',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_sys_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COMMENT='材质成分表';

-- ----------------------------
-- Table structure for t_mechanical_property
-- ----------------------------
DROP TABLE IF EXISTS `t_mechanical_property`;
CREATE TABLE `t_mechanical_property` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `category_id` bigint(20) DEFAULT NULL COMMENT '分类id',
  `mechanical_propertycol` varchar(6) DEFAULT NULL COMMENT '机械性能code',
  `is_have` bit(1) DEFAULT NULL COMMENT '是否存在',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(45) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_category_mp` (`category_id`,`mechanical_propertycol`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COMMENT='分类机械性能';

-- ----------------------------
-- Table structure for t_merchant
-- ----------------------------
DROP TABLE IF EXISTS `t_merchant`;
CREATE TABLE `t_merchant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(50) NOT NULL COMMENT '商家名称',
  `show_name` varchar(20) DEFAULT NULL COMMENT '页面显示名称',
  `type` int(11) NOT NULL COMMENT '类型（1：自营，2：第三方）',
  `username` varchar(50) DEFAULT NULL,
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `salt` char(50) DEFAULT NULL COMMENT 'salt',
  `company_name` varchar(50) DEFAULT NULL COMMENT '公司名称',
  `legal_person` varchar(20) DEFAULT NULL COMMENT '法人',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份id',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城市id',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区县id',
  `detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `license_code` varchar(50) DEFAULT NULL COMMENT '营业执照代码',
  `license_img_addr` varchar(200) DEFAULT NULL COMMENT '营业执照图片路径',
  `tax_num` varchar(50) DEFAULT NULL COMMENT '税务登记号',
  `tax_img_addr` varchar(200) DEFAULT NULL COMMENT '税务登记图片路径',
  `organization_code` varchar(50) DEFAULT NULL COMMENT '组织机构代码',
  `organization_img_addr` varchar(200) DEFAULT NULL COMMENT '组织机构图片路径',
  `sale_type` varchar(20) DEFAULT NULL COMMENT '主营业务',
  `contacts` varchar(20) DEFAULT NULL COMMENT '联系人',
  `contacts_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `contact_mobile` char(11) DEFAULT NULL COMMENT '联系手机',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `audit_sys_user` bigint(20) DEFAULT NULL COMMENT '审核人id',
  `audit_name` varchar(20) DEFAULT NULL COMMENT '审核人姓名',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `notice` varchar(200) DEFAULT NULL COMMENT '商家公告',
  `self_pick_address` varchar(200) DEFAULT NULL COMMENT '自提地址',
  `returned_address` varchar(200) DEFAULT NULL COMMENT '退货地址',
  `app_key` varchar(45) DEFAULT NULL,
  `app_uuid` varchar(45) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `status` int(11) NOT NULL COMMENT '状态（-1：已删除，0：申请，1：审核未通过，9：失效，10：生效）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deduct_stock` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='商家';

-- ----------------------------
-- Table structure for t_merchant_contact
-- ----------------------------
DROP TABLE IF EXISTS `t_merchant_contact`;
CREATE TABLE `t_merchant_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` bigint(20) NOT NULL COMMENT '商家id',
  `consignee` varchar(20) NOT NULL COMMENT '联系人',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省id',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区县',
  `detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `contact_type_code` varchar(11) DEFAULT NULL COMMENT '联系人类型',
  `status` int(11) NOT NULL COMMENT '状态',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(11) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商家联系人表';

-- ----------------------------
-- Table structure for t_merchant_login_log
-- ----------------------------
DROP TABLE IF EXISTS `t_merchant_login_log`;
CREATE TABLE `t_merchant_login_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_id` bigint(20) NOT NULL COMMENT 't_merchant表主键',
  `remote_ip` varchar(50) DEFAULT NULL COMMENT '客户端ip',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `user_agent` varchar(200) DEFAULT NULL COMMENT '客户端信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7178 DEFAULT CHARSET=utf8 COMMENT='商家用户登录日志';

-- ----------------------------
-- Table structure for t_merchant_sell_area
-- ----------------------------
DROP TABLE IF EXISTS `t_merchant_sell_area`;
CREATE TABLE `t_merchant_sell_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `level` int(11) DEFAULT NULL COMMENT '地区级别（1全国，2省，3市）',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市',
  `status` int(11) DEFAULT NULL COMMENT '状态（0禁用，1启用）',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE,
  KEY `idx_province_id` (`province_id`) USING BTREE,
  KEY `idx_city_id` (`city_id`) USING BTREE,
  KEY `idx_level` (`level`,`province_id`,`city_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COMMENT='商家售卖地区表';

-- ----------------------------
-- Table structure for t_m_payment
-- ----------------------------
DROP TABLE IF EXISTS `t_m_payment`;
CREATE TABLE `t_m_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id主键自增',
  `payment_code` varchar(20) DEFAULT NULL COMMENT '付款单号',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `status` int(11) DEFAULT NULL COMMENT '状态(0-作废,1-生效)',
  `method` char(6) DEFAULT NULL COMMENT '付款方式',
  `pay_amount` decimal(12,2) DEFAULT NULL COMMENT '付款金额',
  `voucher_code` varchar(30) DEFAULT NULL COMMENT '付款凭证号',
  `pay_time` datetime DEFAULT NULL COMMENT '付款时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_settle` bit(1) DEFAULT NULL COMMENT '是否结清',
  `settle_id` varchar(20) DEFAULT NULL COMMENT '勾兑单号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_code` (`payment_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COMMENT='第三方商家付款表';

-- ----------------------------
-- Table structure for t_m_settle
-- ----------------------------
DROP TABLE IF EXISTS `t_m_settle`;
CREATE TABLE `t_m_settle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id主键自增',
  `settle_code` varchar(20) DEFAULT NULL COMMENT '勾兑单号',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `settle_date` datetime DEFAULT NULL COMMENT '勾兑日期',
  `settle_amount` decimal(12,2) DEFAULT NULL COMMENT '勾兑总金额',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `settle_code` (`settle_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='商家勾兑';

-- ----------------------------
-- Table structure for t_m_statement
-- ----------------------------
DROP TABLE IF EXISTS `t_m_statement`;
CREATE TABLE `t_m_statement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id主键自增',
  `statement_code` varchar(20) DEFAULT NULL COMMENT '对账单号',
  `status` int(11) DEFAULT NULL COMMENT '对账单状态0撤销1生成对账单2请立账3已立账',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `statement_amount` decimal(12,2) DEFAULT NULL COMMENT '对账总金额',
  `statement_sys_user` bigint(20) DEFAULT NULL COMMENT '对账人id',
  `statement_name` varchar(20) DEFAULT NULL COMMENT '对账人名称',
  `statement_time` datetime DEFAULT NULL COMMENT '对账时间',
  `receivable_amount` decimal(12,2) DEFAULT NULL COMMENT '立账总金额',
  `receivable_sys_user` bigint(20) DEFAULT NULL COMMENT '立账人id',
  `receivable_name` varchar(20) DEFAULT NULL COMMENT '立账人名称',
  `receivable_time` datetime DEFAULT NULL COMMENT '立账时间',
  `invoice_code` varchar(50) DEFAULT NULL COMMENT '发票号码',
  `invoice_date` date DEFAULT NULL COMMENT '发票日期',
  `invoice_amounts` decimal(12,2) DEFAULT NULL COMMENT '发票金额',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `is_settle` bit(1) DEFAULT NULL COMMENT '是否结清',
  `settle_id` varchar(20) DEFAULT NULL COMMENT '勾兑单号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `statement_code` (`statement_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8 COMMENT='商家对账单';

-- ----------------------------
-- Table structure for t_m_statement_item
-- ----------------------------
DROP TABLE IF EXISTS `t_m_statement_item`;
CREATE TABLE `t_m_statement_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id主键自增',
  `statement_id` bigint(20) unsigned DEFAULT NULL COMMENT '对账单id',
  `delivery_item_id` bigint(20) DEFAULT NULL COMMENT '出货单子表id',
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `type` int(11) DEFAULT NULL COMMENT '类型：0-送货单，1-退货单',
  `num` decimal(18,3) DEFAULT NULL COMMENT '商品数量',
  `price` decimal(18,2) DEFAULT NULL COMMENT '商品进价',
  `total_amount` decimal(18,2) DEFAULT NULL COMMENT '小计金额',
  `red_flag` int(11) DEFAULT NULL COMMENT '红冲标记（0或空：未红冲，1：红冲，2：被红冲）',
  `red_id` bigint(20) DEFAULT NULL COMMENT '被红冲对账单子表id',
  PRIMARY KEY (`id`),
  KEY `idx_delivery_item_id` (`delivery_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18934 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_code` char(12) NOT NULL COMMENT '订单编号',
  `order_type` int(11) NOT NULL COMMENT '订单类型（1：普通订单，2：样品单，3：众筹订单, 4:秒杀订单）',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户信息id',
  `customer_address_id` bigint(20) DEFAULT NULL COMMENT '收货人地址id',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户姓名',
  `merchant_id` bigint(20) NOT NULL COMMENT '商家id',
  `order_amount` decimal(12,2) NOT NULL COMMENT '订单金额',
  `paid_amount` decimal(12,2) DEFAULT NULL COMMENT '已付金额',
  `paid_time` datetime DEFAULT NULL COMMENT '付款时间',
  `pay_type` int(11) DEFAULT NULL COMMENT '支付类型(1在线支付，2线下支付，3月结)',
  `pay_status` int(11) NOT NULL COMMENT '支付状态（0：未支付，1：预付款，2：已支付，3：已退款）',
  `status` int(11) NOT NULL COMMENT '订单状态（0：未审核，1：审核未通过，2：审核通过，3：已发货，4：已退货',
  `is_agree_audit` int(11) NOT NULL DEFAULT '0' COMMENT '同意审核（0：正常，1：同意逾期，2：同意额度）',
  `is_show` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否显示',
  `warehouse_id` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `delivery_date` date DEFAULT NULL COMMENT '指定发货日期',
  `delivery_type_dict_code` char(6) NOT NULL COMMENT '配送类型',
  `delivery_company_id` bigint(20) DEFAULT NULL COMMENT '配送公司id',
  `contacts` varchar(20) DEFAULT NULL COMMENT '联系人',
  `contacts_mobile` varchar(30) DEFAULT NULL COMMENT '联系人手机',
  `contacts_phone` varchar(30) DEFAULT NULL COMMENT '联系人电话号码',
  `consignee` varchar(20) DEFAULT NULL COMMENT '收货人',
  `consignee_mobile` varchar(30) DEFAULT NULL COMMENT '收货人手机',
  `consignee_phone` varchar(30) DEFAULT NULL COMMENT '收货人电话',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省份id',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城市id',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区县id',
  `detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `postcode` char(6) DEFAULT NULL COMMENT '邮编',
  `is_take_invoice` bit(1) NOT NULL COMMENT '是否开票（0：不开票，1：开票）',
  `is_direct_customer` bit(1) NOT NULL COMMENT '是否直发客户（0：否，1：是）',
  `salesman_id` bigint(20) DEFAULT NULL COMMENT '业务员id（sys_user的id）',
  `salesman_name` varchar(20) DEFAULT NULL COMMENT '业务员姓名',
  `customer_service_id` bigint(20) DEFAULT NULL COMMENT '客服id（sys_user的id）',
  `customer_service_name` varchar(20) DEFAULT NULL COMMENT '客服姓名',
  `coupon_amount` decimal(12,2) DEFAULT NULL COMMENT '优惠金额',
  `finish_amount` decimal(12,2) DEFAULT NULL COMMENT '结案金额',
  `free_freight_type` int(11) DEFAULT NULL COMMENT '免邮类型（1：客户免邮机会，2：首单包邮）',
  `total_weight` decimal(12,6) DEFAULT NULL COMMENT '订单总重量',
  `source` int(11) DEFAULT NULL COMMENT '来源（1：网站，2：微信，3：后台）',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `customer_remark` varchar(200) DEFAULT NULL COMMENT '客户备注',
  `audit_sys_user` bigint(20) DEFAULT NULL COMMENT '审核人id',
  `audit_name` varchar(20) DEFAULT NULL COMMENT '审核人姓名',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `finish_sys_user` bigint(20) DEFAULT NULL COMMENT '结案人',
  `finish_name` varchar(45) DEFAULT NULL COMMENT '结案人',
  `finish_time` datetime DEFAULT NULL COMMENT '结案时间',
  `is_put_bill` bit(1) DEFAULT NULL COMMENT '是否放单',
  `is_show_price` bit(1) DEFAULT NULL COMMENT '是否显示价格',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(50) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_order_code` (`order_code`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE,
  KEY `idx_order_type` (`order_type`) USING BTREE,
  KEY `idx_consignee` (`delivery_type_dict_code`,`delivery_company_id`,`province_id`,`city_id`,`county_id`,`detail_address`,`consignee`,`consignee_mobile`,`consignee_phone`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=229026 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Table structure for t_order_invoice
-- ----------------------------
DROP TABLE IF EXISTS `t_order_invoice`;
CREATE TABLE `t_order_invoice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户信息表id',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `invoice_type` int(11) NOT NULL COMMENT '发票类型（1：普通发票，2：增值税发票）',
  `title` varchar(50) NOT NULL COMMENT '发票抬头（单位名称）',
  `tax_code` varchar(20) DEFAULT NULL COMMENT '纳税人识别码',
  `register_address` varchar(100) DEFAULT NULL COMMENT '注册地址',
  `register_phone` varchar(20) DEFAULT NULL COMMENT '注册电话',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '开户银行',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '银行账号',
  `consignee` varchar(20) NOT NULL COMMENT '收票人姓名',
  `mobile` char(11) NOT NULL COMMENT '收票人手机',
  `province_id` bigint(20) NOT NULL COMMENT '省份（t_region表的id）',
  `city_id` bigint(20) NOT NULL COMMENT '城市（t_region表的id）',
  `county_id` bigint(20) NOT NULL COMMENT '区县（t_region表的id）',
  `detail_address` varchar(100) NOT NULL COMMENT '详细地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单发票信息（废弃-20160411）';

-- ----------------------------
-- Table structure for t_order_item
-- ----------------------------
DROP TABLE IF EXISTS `t_order_item`;
CREATE TABLE `t_order_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `order_code` char(12) NOT NULL COMMENT '订单编号',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `bar_code` varchar(50) DEFAULT NULL COMMENT '条码',
  `goods_name` varchar(50) DEFAULT NULL COMMENT '品名',
  `goods_material` varchar(50) DEFAULT NULL COMMENT '材质',
  `goods_specification` varchar(50) DEFAULT NULL COMMENT '规格',
  `goods_description` varchar(100) DEFAULT NULL COMMENT '描述',
  `brand_name` varchar(50) DEFAULT NULL COMMENT '品牌名称',
  `buying_price` decimal(12,2) DEFAULT NULL COMMENT '进价',
  `market_price` decimal(12,2) NOT NULL COMMENT '市场价',
  `price` decimal(12,2) NOT NULL COMMENT '单价',
  `num` decimal(12,3) NOT NULL DEFAULT '0.000' COMMENT '购买数量',
  `apply_num` decimal(12,3) DEFAULT '0.000' COMMENT '申请数量',
  `take_num` decimal(12,3) DEFAULT '0.000' COMMENT '取货数量',
  `delivery_num` decimal(12,3) NOT NULL DEFAULT '0.000' COMMENT '发货数量',
  `delivery_status` int(11) NOT NULL COMMENT '发货状态（0：未发货，1：发货中，2：已发货）',
  `returned_num` decimal(12,3) DEFAULT NULL COMMENT '申请退货数量',
  `returned_status` int(11) DEFAULT NULL COMMENT '退货状态',
  `finish_amount` decimal(12,2) DEFAULT NULL COMMENT '结案金额',
  `finish_time` datetime DEFAULT NULL COMMENT '结案时间',
  `is_supplier_send` bit(1) DEFAULT b'0' COMMENT '供应商直发（0：否，1：是）',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `customer_remark` varchar(200) DEFAULT NULL COMMENT '客户备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_delivery_status` (`delivery_status`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE,
  KEY `idx_goods_id` (`goods_id`) USING BTREE,
  KEY `idx_num` (`num`,`apply_num`,`take_num`,`delivery_num`) USING BTREE,
  KEY `idx_is_supplier_send` (`is_supplier_send`) USING BTREE,
  KEY `idx_bar_code` (`bar_code`) USING BTREE,
  KEY `idx_order_code` (`order_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=707205 DEFAULT CHARSET=utf8 COMMENT='订单明细表';

-- ----------------------------
-- Table structure for t_order_log
-- ----------------------------
DROP TABLE IF EXISTS `t_order_log`;
CREATE TABLE `t_order_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `order_code` char(12) DEFAULT NULL COMMENT '订单编号',
  `action_code` varchar(30) DEFAULT NULL COMMENT '操作代号',
  `action_name` varchar(50) DEFAULT NULL COMMENT '操作名称',
  `detail_msg` text COMMENT '详细描述',
  `json` mediumtext COMMENT 'JSON对象',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_code_name` (`order_code`,`action_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2851 DEFAULT CHARSET=utf8 COMMENT='订单日志表';

-- ----------------------------
-- Table structure for t_order_system_remark
-- ----------------------------
DROP TABLE IF EXISTS `t_order_system_remark`;
CREATE TABLE `t_order_system_remark` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `order_item_id` bigint(20) DEFAULT NULL COMMENT '订单子项id',
  `remark_type` int(11) NOT NULL COMMENT '系统备注类型（1：每周特价，2：促销特价，3：满减，4：用券，5：现付优惠，6：修改价格，7：交期，8：首单包邮，9：每日免邮）',
  `short_code` varchar(2) DEFAULT NULL COMMENT '系统备注缩写',
  `show_remark` varchar(20) DEFAULT NULL COMMENT '显示备注',
  `status` int(11) DEFAULT NULL COMMENT '状态（9：不启用，10：启用）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建用户id',
  `create_name` varchar(45) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新用户id',
  `update_name` varchar(45) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_order_item_id` (`order_item_id`) USING BTREE,
  KEY `idx_order_id` (`order_id`,`remark_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28701 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_pack_unit
-- ----------------------------
DROP TABLE IF EXISTS `t_pack_unit`;
CREATE TABLE `t_pack_unit` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(10) DEFAULT NULL COMMENT '包装单位编码',
  `name` varchar(10) NOT NULL COMMENT '包装名称',
  `sort` int(11) NOT NULL COMMENT '顺序',
  `status` int(11) NOT NULL COMMENT '状态，0：失效，1：生效',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_name` (`name`) USING BTREE,
  UNIQUE KEY `uni_code` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='包装单位表';

-- ----------------------------
-- Table structure for t_page_picture
-- ----------------------------
DROP TABLE IF EXISTS `t_page_picture`;
CREATE TABLE `t_page_picture` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int(4) NOT NULL COMMENT '图片类型',
  `picture_url` varchar(200) NOT NULL COMMENT '图片所在地址',
  `link_Url` varchar(200) NOT NULL COMMENT '超链接地址',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `sort` int(11) DEFAULT NULL COMMENT '排序（升序）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_payment_info
-- ----------------------------
DROP TABLE IF EXISTS `t_payment_info`;
CREATE TABLE `t_payment_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pay_code` char(12) DEFAULT NULL COMMENT '流水哈',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户信息id',
  `customer_name` varchar(50) DEFAULT NULL COMMENT '客户姓名',
  `pay_type` int(11) NOT NULL COMMENT '支付方式，1：支付宝，2：银联支付，3：银联B2B，4：现金，5：银行，6：费用，7：承兑汇票，8：承兑贴息，9：其他，10：微信支付',
  `pay_amount` decimal(12,2) NOT NULL COMMENT '支付金额',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `certification_no` varchar(50) DEFAULT NULL COMMENT '凭证号',
  `is_take_invoice` bit(1) DEFAULT NULL COMMENT '是否开票（0：不开票，1：开票）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `check_balance_id` bigint(20) DEFAULT NULL COMMENT '勾兑单id',
  `is_settle` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否结清',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pay_code_UNIQUE` (`pay_code`) USING BTREE,
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=55847 DEFAULT CHARSET=utf8 COMMENT='付款信息表';

-- ----------------------------
-- Table structure for t_phone_visit_config
-- ----------------------------
DROP TABLE IF EXISTS `t_phone_visit_config`;
CREATE TABLE `t_phone_visit_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `visit_type` char(6) NOT NULL COMMENT '电话回访类型',
  `user_id` bigint(20) NOT NULL COMMENT '需要发送站内信用户id',
  `status` int(10) DEFAULT '1' COMMENT '状态：0、无效  1、有效',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='电话回访记录发送站内信配置表';

-- ----------------------------
-- Table structure for t_phone_visit_record
-- ----------------------------
DROP TABLE IF EXISTS `t_phone_visit_record`;
CREATE TABLE `t_phone_visit_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户信息id',
  `visit_type` char(6) NOT NULL COMMENT '电话回访记录类型',
  `visit_content` varchar(500) DEFAULT NULL COMMENT '回访内容',
  `status` int(11) DEFAULT NULL COMMENT '记录状态（1、有效）',
  `create_sys_user` bigint(20) NOT NULL COMMENT '创建者id',
  `create_name` varchar(20) NOT NULL COMMENT '创建者姓名',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3478 DEFAULT CHARSET=utf8 COMMENT='电话回访记录表';

-- ----------------------------
-- Table structure for t_price_ratio
-- ----------------------------
DROP TABLE IF EXISTS `t_price_ratio`;
CREATE TABLE `t_price_ratio` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `brand_name` varchar(50) DEFAULT NULL COMMENT '品牌',
  `material_name` varchar(50) DEFAULT NULL COMMENT '材质',
  `name` varchar(50) DEFAULT NULL COMMENT '品名改为标准',
  `specification` varchar(50) DEFAULT NULL COMMENT '规格',
  `price` decimal(12,5) DEFAULT NULL COMMENT '千支价',
  `stock` decimal(12,3) DEFAULT NULL COMMENT '库存数量',
  `warehouse_name` varchar(20) DEFAULT NULL COMMENT '仓库名称',
  `company_name` varchar(50) DEFAULT NULL COMMENT '公司识别码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `batch_date` datetime NOT NULL COMMENT '批次日期',
  `third_name` varchar(50) DEFAULT NULL COMMENT '第三方品名',
  PRIMARY KEY (`id`),
  KEY `idx_materialName_name_specification` (`material_name`,`name`,`specification`) USING BTREE,
  KEY `idx_batch_date` (`batch_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=297730 DEFAULT CHARSET=utf8 COMMENT='商品价格比对表';

-- ----------------------------
-- Table structure for t_price_ratio_mapper
-- ----------------------------
DROP TABLE IF EXISTS `t_price_ratio_mapper`;
CREATE TABLE `t_price_ratio_mapper` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `material_name` varchar(50) DEFAULT NULL COMMENT '材质',
  `name` varchar(50) DEFAULT NULL COMMENT '品名',
  `specification` varchar(50) DEFAULT NULL COMMENT '规格',
  PRIMARY KEY (`id`),
  KEY `idx_goods_id` (`goods_id`) USING BTREE,
  KEY `idx_materialName_name_specification` (`material_name`,`name`,`specification`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101902 DEFAULT CHARSET=utf8 COMMENT='商品价格比对映射表';

-- ----------------------------
-- Table structure for t_price_type
-- ----------------------------
DROP TABLE IF EXISTS `t_price_type`;
CREATE TABLE `t_price_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id主键自增',
  `type_name` varchar(10) NOT NULL COMMENT '价格系数分类',
  `price_coeff` decimal(12,2) NOT NULL COMMENT '价格系数',
  `is_default` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否默认',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人名称',
  `creae_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人名称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_name_UNIQUE` (`type_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='价格类别表';

-- ----------------------------
-- Table structure for t_print_tags_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_print_tags_goods`;
CREATE TABLE `t_print_tags_goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bar_code` varchar(20) NOT NULL COMMENT '条码（唯一）',
  `defined_name` varchar(50) DEFAULT NULL COMMENT '自定义标签名',
  `material` varchar(50) DEFAULT NULL COMMENT '材质',
  `name` varchar(50) DEFAULT NULL COMMENT '品名',
  `specification` varchar(50) DEFAULT NULL COMMENT '规格',
  `description` varchar(100) DEFAULT NULL COMMENT '中文描述',
  `weight` decimal(12,4) DEFAULT NULL COMMENT '单重（kg/K）',
  `pack_quality` decimal(12,3) DEFAULT NULL COMMENT '包装数量',
  `pack_unit_id` bigint(20) DEFAULT NULL COMMENT '包装单位id（t_pack_unit）',
  `batch` varchar(50) DEFAULT NULL COMMENT '批次',
  `status` int(11) DEFAULT NULL COMMENT '状态（-1、删除   0、失效   1、生效）',
  `is_qualified` bit(1) DEFAULT NULL COMMENT '是否合格',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_customer_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_customer_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='标签打印商品表';

-- ----------------------------
-- Table structure for t_print_tags_model
-- ----------------------------
DROP TABLE IF EXISTS `t_print_tags_model`;
CREATE TABLE `t_print_tags_model` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `width` int(11) DEFAULT NULL COMMENT '标签纸长度（mm）',
  `height` int(11) DEFAULT NULL COMMENT '标签纸宽度（mm）',
  `print_width` int(11) DEFAULT NULL COMMENT '打印内容长度（mm）',
  `print_height` int(11) DEFAULT NULL COMMENT '打印内容宽度（mm）',
  `templet_flag` varchar(10) DEFAULT NULL COMMENT '模板标识',
  `status` bit(1) DEFAULT NULL COMMENT '状态（0、无效  1、有效）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='标签打印尺寸配置表';

-- ----------------------------
-- Table structure for t_prizedraw_chance_config
-- ----------------------------
DROP TABLE IF EXISTS `t_prizedraw_chance_config`;
CREATE TABLE `t_prizedraw_chance_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `config_prize_id` bigint(20) NOT NULL COMMENT '奖品配置id',
  `chance_type` int(10) NOT NULL COMMENT '抽奖机会类型：1、签到获取  2、下单获取',
  `order_amount_bottom` decimal(10,2) DEFAULT NULL COMMENT '订单金额下限',
  `order_amount_top` decimal(10,2) DEFAULT NULL COMMENT '订单金额上限',
  `weight` bigint(10) NOT NULL COMMENT '概率权重',
  `status` int(10) DEFAULT '1' COMMENT '状态：0、无效  1、有效',
  `create_sys_user` bigint(20) NOT NULL COMMENT '创建者id',
  `create_name` varchar(20) NOT NULL COMMENT '创建者姓名',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='奖品概率配置表';

-- ----------------------------
-- Table structure for t_prizedraw_pool
-- ----------------------------
DROP TABLE IF EXISTS `t_prizedraw_pool`;
CREATE TABLE `t_prizedraw_pool` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `date_flag` varchar(20) NOT NULL COMMENT '日期标识',
  `pool_value` decimal(10,2) NOT NULL COMMENT '奖池金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `rev` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_date_flag` (`date_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COMMENT='每日奖池表';

-- ----------------------------
-- Table structure for t_prizedraw_pool_config
-- ----------------------------
DROP TABLE IF EXISTS `t_prizedraw_pool_config`;
CREATE TABLE `t_prizedraw_pool_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `base_value` decimal(10,2) NOT NULL COMMENT '奖池基础值',
  `compare_value` decimal(10,2) NOT NULL COMMENT '奖池值浮动参考额',
  `compare_value_cent` decimal(10,2) NOT NULL COMMENT '奖池值浮动参考额比例',
  `create_sys_user` bigint(20) NOT NULL COMMENT '创建者id',
  `create_name` varchar(20) NOT NULL COMMENT '创建者姓名',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='奖池配置表';

-- ----------------------------
-- Table structure for t_prizedraw_prize
-- ----------------------------
DROP TABLE IF EXISTS `t_prizedraw_prize`;
CREATE TABLE `t_prizedraw_prize` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `date_flag` varchar(20) NOT NULL COMMENT '日期标识',
  `config_prize_id` bigint(20) NOT NULL COMMENT '奖品配置id',
  `amount` int(20) NOT NULL COMMENT '奖品数量',
  `freeze_num` int(20) DEFAULT NULL COMMENT '奖品占用',
  `random_total_money` decimal(12,2) DEFAULT '0.00' COMMENT '随机红包总金额',
  `random_money_freeze` decimal(12,2) DEFAULT '0.00' COMMENT '随机红包总金额占用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `freeze_time` datetime DEFAULT NULL COMMENT '冻结时间',
  `rev` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_date_flag` (`date_flag`,`config_prize_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1512 DEFAULT CHARSET=utf8 COMMENT='每日奖品表';

-- ----------------------------
-- Table structure for t_prizedraw_prize_config
-- ----------------------------
DROP TABLE IF EXISTS `t_prizedraw_prize_config`;
CREATE TABLE `t_prizedraw_prize_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `prize_level_code` varchar(20) NOT NULL COMMENT '奖品等级编码',
  `prize_photo_url` varchar(100) DEFAULT NULL COMMENT '奖品图片',
  `prize_type_code` varchar(20) NOT NULL COMMENT '奖品类型：1、微信红包  2、代金券  3、优惠券   4、谢谢惠顾',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '优惠券id',
  `is_random` bit(1) NOT NULL COMMENT '是否为随机红包',
  `red_package_value` decimal(10,2) NOT NULL COMMENT '红包面额（随机红包红包面额上限）',
  `red_package_cent` decimal(10,2) NOT NULL COMMENT '红包数量占比',
  `angle` int(10) NOT NULL COMMENT '转动角度',
  `freeze_second` bigint(20) DEFAULT '0' COMMENT '冻结时长（秒）',
  `status` int(10) DEFAULT '1' COMMENT '状态：0、无效  1、有效',
  `create_sys_user` bigint(20) NOT NULL COMMENT '创建者id',
  `create_name` varchar(20) NOT NULL COMMENT '创建者姓名',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='奖品配置表';

-- ----------------------------
-- Table structure for t_prizedraw_record
-- ----------------------------
DROP TABLE IF EXISTS `t_prizedraw_record`;
CREATE TABLE `t_prizedraw_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `chance_type` int(10) NOT NULL COMMENT '抽奖机会类型：1、签到获取  2、下单获取',
  `is_sign_get` int(10) DEFAULT NULL COMMENT '签到获取标识',
  `date_flag` varchar(20) NOT NULL COMMENT '日期标识',
  `get_time` datetime NOT NULL COMMENT '获取时间',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `order_amount` decimal(12,2) DEFAULT NULL COMMENT '订单金额',
  `prize_type_code` varchar(20) DEFAULT NULL COMMENT '奖品类型：1、微信红包  2、代金券  3、优惠券  4、谢谢惠顾',
  `red_package_value` decimal(12,2) DEFAULT NULL COMMENT '红包金额',
  `coupon_value` decimal(12,2) DEFAULT NULL COMMENT '优惠券金额',
  `is_use` bit(1) DEFAULT b'0' COMMENT '是否使用：0：未使用 1：已使用',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  `is_win` bit(1) DEFAULT b'0' COMMENT '是否中微信红包奖：0：未中奖 1：已中奖',
  `prize_id` bigint(20) DEFAULT NULL COMMENT '奖品id',
  `is_take` bit(1) DEFAULT b'0' COMMENT '是否领取：0：未领取 1：已领取',
  `open_id` varchar(50) DEFAULT NULL COMMENT '红包领取人',
  `take_time` datetime DEFAULT NULL COMMENT '领取时间',
  `end_time` datetime DEFAULT NULL COMMENT '红包有效期',
  `mch_billno` varchar(50) DEFAULT NULL COMMENT '微信红包发送时获取的商户订单号',
  `rev` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_order_id` (`order_id`) USING BTREE,
  UNIQUE KEY `uni_day_sign` (`customer_info_id`,`is_sign_get`,`date_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=145077 DEFAULT CHARSET=utf8 COMMENT='客户抽奖记录表';

-- ----------------------------
-- Table structure for t_promotion_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_promotion_goods`;
CREATE TABLE `t_promotion_goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `promotion_price_1` decimal(12,2) NOT NULL COMMENT '一级特价活动价格',
  `promotion_price_2` decimal(12,2) NOT NULL COMMENT '二级特价活动价格',
  `promotion_price_3` decimal(12,2) NOT NULL COMMENT '三级特价活动价格',
  `promotion_price_4` decimal(12,2) NOT NULL COMMENT '四级特价活动价格',
  `promotion_price_5` decimal(12,2) NOT NULL COMMENT '五级特价活动价格',
  `is_negative_stock_his` bit(1) DEFAULT NULL COMMENT '是否支持负库存购买（用于记录原商品属性）',
  `is_negative_stock` bit(1) DEFAULT NULL COMMENT '是否支持负库存购买',
  `click_num` int(11) DEFAULT '0' COMMENT '点击次数',
  `begin_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '是否生效（0：未生效，1：已生效）',
  `sort_by` int(11) NOT NULL COMMENT '排序',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `delete_flag` int(11) DEFAULT '0' COMMENT '删除标识',
  `is_discount_his` bit(1) DEFAULT NULL COMMENT '是否折上折（用于记录原商品属性）',
  `is_discount` bit(1) DEFAULT NULL COMMENT '是否折上折',
  `promotion_buying_price` decimal(12,2) DEFAULT NULL COMMENT '商品进价',
  `goods_status_his` int(11) DEFAULT NULL COMMENT '商品状态历史（用于记录原商品属性）',
  `goods_limit_num` decimal(12,3) DEFAULT NULL COMMENT '商品限购数量',
  `promotion_num` decimal(12,3) DEFAULT NULL COMMENT '参与特价库存量',
  `need_freeze_num` decimal(12,3) DEFAULT NULL COMMENT '需要冻结的库存量',
  `buying_price_his` decimal(12,2) DEFAULT NULL COMMENT '商品进价历史（用于记录原商品属性）',
  `seckill_time` datetime DEFAULT NULL COMMENT '抢购开始时间',
  PRIMARY KEY (`id`),
  KEY `idx_goods_id` (`goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1884 DEFAULT CHARSET=utf8 COMMENT='特价商品活动表';

-- ----------------------------
-- Table structure for t_provider_apply
-- ----------------------------
DROP TABLE IF EXISTS `t_provider_apply`;
CREATE TABLE `t_provider_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) DEFAULT NULL COMMENT '客户信息id',
  `company_name` varchar(20) DEFAULT NULL COMMENT '公司名称',
  `legal_person` varchar(20) DEFAULT NULL COMMENT '公司法人',
  `registered_capital` decimal(12,2) DEFAULT NULL COMMENT '注册资金',
  `main_products` varchar(200) DEFAULT NULL COMMENT '主营产品',
  `output_quantity` decimal(12,3) DEFAULT NULL COMMENT '年产量',
  `supply_production` varchar(20) DEFAULT NULL COMMENT '供应产品',
  `contacts` varchar(20) DEFAULT NULL COMMENT '联系人',
  `contacts_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `contacts_fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省id',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市id',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区、县id',
  `detail_address` varchar(50) DEFAULT NULL COMMENT '详细地址',
  `quality_guarantee` varchar(200) DEFAULT NULL COMMENT '质量保证',
  `quality_guarantee_url` varchar(300) DEFAULT NULL COMMENT '质量保证书图片地址',
  `suggest` varchar(200) DEFAULT NULL COMMENT '建议',
  `status` int(10) DEFAULT NULL COMMENT '状态（-1：已删除，10：已处理，9：申请中）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `company_type` varchar(45) DEFAULT NULL COMMENT '企业性质',
  `main_material` varchar(200) DEFAULT NULL COMMENT '主营材质',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='成为供应商表';

-- ----------------------------
-- Table structure for t_receivable
-- ----------------------------
DROP TABLE IF EXISTS `t_receivable`;
CREATE TABLE `t_receivable` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `receivable_code` varchar(20) DEFAULT NULL COMMENT '立账编号',
  `customer_info_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `statement_amounts` decimal(18,2) DEFAULT NULL COMMENT '对账总额',
  `receivable_amounts` decimal(18,2) DEFAULT NULL COMMENT '立账总额',
  `receivable_date` date DEFAULT NULL COMMENT '应收日期',
  `is_invoice` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否开票1,开票 0,不开票',
  `invoice_date` datetime DEFAULT NULL COMMENT '开票时间',
  `invoice_code` varchar(50) DEFAULT NULL COMMENT '发票号码',
  `invoice_amounts` decimal(18,2) DEFAULT NULL COMMENT '开票金额',
  `invoice_remark` varchar(200) DEFAULT NULL COMMENT '开票备注',
  `check_balance_id` bigint(20) DEFAULT NULL COMMENT '勾对单号id',
  `is_settle` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否结清',
  `delivery_compary` varchar(50) DEFAULT NULL COMMENT '快递公司',
  `waybill_no` varchar(50) DEFAULT NULL COMMENT '快递单号',
  `express_time` datetime DEFAULT NULL COMMENT '快递时间',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人名称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '立账备注',
  `local_sync_time` datetime DEFAULT NULL COMMENT '本地同步时间',
  `sync_time` datetime DEFAULT NULL COMMENT '同步时间',
  `sys_update_receivable_date` bigint(20) DEFAULT NULL COMMENT '逾期日期更新人',
  `invoice_title` varchar(100) DEFAULT NULL COMMENT '买方名称（发票导入回写发票抬头）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `AK_Key_receivable_code` (`receivable_code`) USING BTREE,
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE,
  KEY `idx_check_balance_id` (`check_balance_id`) USING BTREE,
  KEY `idx_is_settle` (`is_settle`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36481 DEFAULT CHARSET=utf8 COMMENT='客户立账表';

-- ----------------------------
-- Table structure for t_region
-- ----------------------------
DROP TABLE IF EXISTS `t_region`;
CREATE TABLE `t_region` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` char(6) NOT NULL COMMENT '行政区域编码',
  `name` varchar(50) NOT NULL COMMENT '行政区域名称',
  `level` int(11) NOT NULL COMMENT '行政区域级别（1：省，2：市，3：区县）',
  `parent_id` bigint(20) NOT NULL COMMENT '上级行政区域id，省的上级为0',
  `parent_ids` varchar(100) NOT NULL COMMENT '所有上级行政区域id，'',''分隔',
  `status` int(11) NOT NULL COMMENT '状态（0：失效，1：生效）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_code` (`code`) USING BTREE,
  KEY `idx_level_status` (`level`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3594 DEFAULT CHARSET=utf8 COMMENT='地区表';

-- ----------------------------
-- Table structure for t_returned
-- ----------------------------
DROP TABLE IF EXISTS `t_returned`;
CREATE TABLE `t_returned` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `returned_code` varchar(20) NOT NULL COMMENT '退货单流水号',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户信息id',
  `merchant_id` bigint(20) NOT NULL COMMENT '商家id',
  `status` int(11) NOT NULL COMMENT '退货单状态：（0：未审核，1：审核通过，2：审核不通过，3：部分收货，4：收货完成，5：已收讫）',
  `delivery_company_name` varchar(20) DEFAULT NULL COMMENT '货运公司',
  `delivery_no` varchar(30) DEFAULT NULL COMMENT '货运单号',
  `delivery_type_dict_code` char(6) DEFAULT NULL COMMENT '物流类型',
  `delivery_info_time` datetime DEFAULT NULL COMMENT '物流填写时间',
  `apply_total_price` decimal(12,2) DEFAULT NULL COMMENT '应退总额',
  `actual_total_price` decimal(12,2) DEFAULT NULL COMMENT '实退总额',
  `apply_remark` varchar(200) DEFAULT NULL COMMENT '申请备注',
  `customer_remark` varchar(200) DEFAULT NULL COMMENT '仓库备注',
  `audit_sys_user` bigint(20) DEFAULT NULL COMMENT '审核人id',
  `audit_name` varchar(20) DEFAULT NULL COMMENT '审核人姓名',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `finish_sys_user` bigint(20) DEFAULT NULL COMMENT '收讫人id',
  `finish_name` varchar(20) DEFAULT NULL COMMENT '收讫人姓名',
  `finish_time` datetime DEFAULT NULL COMMENT '收讫时间',
  `customer_service_id` bigint(20) DEFAULT NULL COMMENT '客服id',
  `customer_service_name` varchar(20) DEFAULT NULL COMMENT '客服姓名',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `sync_time` datetime DEFAULT NULL COMMENT '同步时间，由客户端提供',
  `local_sync_time` datetime DEFAULT NULL COMMENT '本地同步时间，同步写入时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_returned_code` (`returned_code`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_update_time` (`update_time`) USING BTREE,
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6351 DEFAULT CHARSET=utf8 COMMENT='退货单主表';

-- ----------------------------
-- Table structure for t_returned_item
-- ----------------------------
DROP TABLE IF EXISTS `t_returned_item`;
CREATE TABLE `t_returned_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `returned_id` bigint(20) NOT NULL COMMENT '退货单号id',
  `returned_code` varchar(20) DEFAULT NULL COMMENT '退货单号',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `returned_type` int(11) DEFAULT NULL COMMENT '退货类型（0：商品单价，1：其他）',
  `price` decimal(12,2) NOT NULL COMMENT '退货单价',
  `buying_price` decimal(12,2) DEFAULT NULL COMMENT '进价',
  `apply_num` decimal(12,3) NOT NULL COMMENT '申请数量',
  `returned_num` decimal(12,3) DEFAULT NULL COMMENT '仓库收货数量',
  `reconciliation_num` decimal(12,3) DEFAULT NULL COMMENT '对账数量',
  `apply_remark` varchar(200) DEFAULT NULL COMMENT '申请备注',
  `customer_remark` varchar(200) DEFAULT NULL COMMENT '客户备注',
  `warehouse_remark` varchar(600) DEFAULT NULL COMMENT '仓库备注',
  `returned_reason_dict_code` char(6) DEFAULT NULL,
  `item_status` int(11) DEFAULT NULL COMMENT '收货状态（0：未收货，1：已收货）',
  `apply_price` decimal(12,2) DEFAULT NULL COMMENT '应退总额',
  `actual_price` decimal(12,2) DEFAULT NULL COMMENT '实退总额',
  `order_code` varchar(20) DEFAULT NULL COMMENT '订单号码',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `order_item_id` bigint(20) DEFAULT NULL COMMENT '订单子项id',
  `img_url1` varchar(300) DEFAULT NULL COMMENT '退货图片1',
  `img_url2` varchar(300) DEFAULT NULL COMMENT '退货图片2',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_balance_account` bit(1) NOT NULL COMMENT '是否对账(0未对账,1已对账)',
  `p_is_statement` bit(1) DEFAULT NULL COMMENT '供应商是否对账',
  `sync_time` datetime DEFAULT NULL COMMENT '同步时间，由客户端提供',
  `local_sync_time` datetime DEFAULT NULL COMMENT '本地同步时间，同步写入时间',
  PRIMARY KEY (`id`),
  KEY `idx_returned_id` (`returned_id`) USING BTREE,
  KEY `idx_is_balance_account` (`is_balance_account`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7523 DEFAULT CHARSET=utf8 COMMENT='退货单子表';

-- ----------------------------
-- Table structure for t_search_record
-- ----------------------------
DROP TABLE IF EXISTS `t_search_record`;
CREATE TABLE `t_search_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `search_key` varchar(200) DEFAULT NULL COMMENT '搜索关键字',
  `search_time` datetime DEFAULT NULL COMMENT '搜索时间',
  `customer_info_id` bigint(20) DEFAULT NULL COMMENT '搜索客户id',
  PRIMARY KEY (`id`),
  KEY `idx_search_time` (`search_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1196956 DEFAULT CHARSET=utf8 COMMENT='搜索记录表';

-- ----------------------------
-- Table structure for t_seckill_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_seckill_customer`;
CREATE TABLE `t_seckill_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id自增主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `seckill_goods_id` bigint(20) NOT NULL COMMENT '秒杀商品表id',
  `seckill_num` decimal(12,3) NOT NULL COMMENT '秒杀数量',
  `create_time` datetime NOT NULL COMMENT '秒杀时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_info_id` (`customer_info_id`,`seckill_goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2982 DEFAULT CHARSET=utf8 COMMENT='客户秒杀商品表';

-- ----------------------------
-- Table structure for t_seckill_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_seckill_goods`;
CREATE TABLE `t_seckill_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `goods_id` bigint(20) NOT NULL COMMENT '商品主键',
  `status` int(11) NOT NULL COMMENT '状态（1-即将开始，2-抢购中，3-已结束）',
  `img_src` varchar(200) DEFAULT NULL COMMENT '图片',
  `seckill_time` datetime NOT NULL COMMENT '秒杀开始时间',
  `discount` decimal(12,2) DEFAULT NULL COMMENT '折扣',
  `total_num` decimal(12,3) NOT NULL DEFAULT '0.000' COMMENT '总量',
  `seckill_num` decimal(12,3) NOT NULL DEFAULT '0.000' COMMENT '被秒量',
  `limit_num` decimal(12,3) NOT NULL COMMENT '客户限购量',
  `buying_price` decimal(12,2) DEFAULT NULL COMMENT '进价',
  `sort` int(11) NOT NULL COMMENT '排序（由小到大）',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_sys_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_sys_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `material_name` varchar(50) DEFAULT NULL COMMENT '材质',
  `name` varchar(50) DEFAULT NULL COMMENT '品名',
  `specification` varchar(50) DEFAULT NULL COMMENT '规格',
  `description` varchar(50) DEFAULT NULL COMMENT '中文描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='秒杀抢购商品表';

-- ----------------------------
-- Table structure for t_send_message
-- ----------------------------
DROP TABLE IF EXISTS `t_send_message`;
CREATE TABLE `t_send_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `msg_text` varchar(200) DEFAULT NULL COMMENT '信息内容',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `status` bit(1) DEFAULT b'0' COMMENT '状态（0待发送，1已发送）',
  `create_sys_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6613 DEFAULT CHARSET=utf8 COMMENT='短信发送表';

-- ----------------------------
-- Table structure for t_seq
-- ----------------------------
DROP TABLE IF EXISTS `t_seq`;
CREATE TABLE `t_seq` (
  `name` varchar(20) NOT NULL COMMENT '主键，序号标识',
  `prefix_code` varchar(10) NOT NULL COMMENT '序号前缀',
  `middle_date` varchar(10) NOT NULL COMMENT '序号日期段',
  `suffix_num` int(10) NOT NULL COMMENT '序号后缀数字段',
  `suffix_length` int(11) NOT NULL COMMENT '序号后缀位数',
  `remark` varchar(100) DEFAULT NULL COMMENT '序号描述',
  `rev` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `t_shopping_cart`;
CREATE TABLE `t_shopping_cart` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `customer_info_id` bigint(20) NOT NULL COMMENT '用户信息id',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `num` decimal(12,3) NOT NULL COMMENT '数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_customer_goods_id` (`customer_info_id`,`goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=293578 DEFAULT CHARSET=utf8 COMMENT='购物车表';

-- ----------------------------
-- Table structure for t_sign_record
-- ----------------------------
DROP TABLE IF EXISTS `t_sign_record`;
CREATE TABLE `t_sign_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `date_flag` varchar(20) NOT NULL COMMENT '日期标识',
  `customer_info_id` bigint(20) NOT NULL COMMENT 't_customer_info表id',
  `sign_date` datetime NOT NULL COMMENT '签到时间',
  `continue_sign_days` int(10) NOT NULL DEFAULT '0' COMMENT '连续签到天数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_customer_date` (`date_flag`,`customer_info_id`) USING BTREE,
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37000 DEFAULT CHARSET=utf8 COMMENT='签到记录表';

-- ----------------------------
-- Table structure for t_standard
-- ----------------------------
DROP TABLE IF EXISTS `t_standard`;
CREATE TABLE `t_standard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编码',
  `name` varchar(50) DEFAULT NULL COMMENT '标准名称',
  `category_id` bigint(20) DEFAULT NULL COMMENT '分类id（对应二级分类Id，一级为紧固件）',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态，-1：已删除，0：失效，1：生效',
  `customized` int(11) DEFAULT NULL COMMENT '定制类型（1：标准品，2：常规定制品，3：标准定制品，4：专属定制品，5：非标）',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_customized` (`customized`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8 COMMENT='商品标准表';

-- ----------------------------
-- Table structure for t_statement
-- ----------------------------
DROP TABLE IF EXISTS `t_statement`;
CREATE TABLE `t_statement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `statement_code` varchar(20) NOT NULL COMMENT '对账单号',
  `status` int(11) NOT NULL COMMENT '对账单状态0撤销1生成对账单2请立账3已立账',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户id',
  `statement_date` date NOT NULL COMMENT '对账日期',
  `statement_amount` decimal(18,2) NOT NULL COMMENT '对账总金额',
  `receivable_code` varchar(20) DEFAULT NULL COMMENT '立账单号',
  `receivable_amount` decimal(18,2) DEFAULT NULL COMMENT '立账金额',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `print_count` int(11) DEFAULT '0' COMMENT '打印次数',
  `export_count` int(11) DEFAULT '0' COMMENT '导出次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `AK_Key_statement_code` (`statement_code`) USING BTREE,
  KEY `idx_customer_info_id` (`customer_info_id`) USING BTREE,
  KEY `idx_receivable_code` (`receivable_code`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35231 DEFAULT CHARSET=utf8 COMMENT='客户对账单主表';

-- ----------------------------
-- Table structure for t_statement_item
-- ----------------------------
DROP TABLE IF EXISTS `t_statement_item`;
CREATE TABLE `t_statement_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `statement_id` bigint(20) NOT NULL COMMENT '对账单主表id',
  `delivery_item_id` bigint(20) NOT NULL COMMENT '送货单子表id',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '类型：0送货单1退货单',
  `num` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT '商品数量',
  `price` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '商品单价',
  `total_amounts` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '小计金额',
  `red_flag` int(11) DEFAULT '0' COMMENT '红冲标记:0未红冲,1红冲,2被红冲',
  `red_id` bigint(20) DEFAULT NULL COMMENT '被红冲对账单子表id',
  PRIMARY KEY (`id`),
  KEY `idx_statement_id` (`statement_id`) USING BTREE,
  KEY `idx_goods_id` (`goods_id`) USING BTREE,
  KEY `idx_delivery_item_id` (`delivery_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=663894 DEFAULT CHARSET=utf8 COMMENT='客户对账单字表';

-- ----------------------------
-- Table structure for t_suggest
-- ----------------------------
DROP TABLE IF EXISTS `t_suggest`;
CREATE TABLE `t_suggest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `details` varchar(1000) NOT NULL COMMENT '问题内容',
  `customer_info_id` bigint(20) NOT NULL COMMENT '客户信息id',
  `submit_time` datetime NOT NULL COMMENT '提交时间',
  `statut` int(11) NOT NULL COMMENT '状态：（0：未处理 ，1：处理中 ，2：已处理）',
  `deal_result` varchar(1000) DEFAULT NULL COMMENT '处理结果',
  `deal_sys_user` bigint(20) DEFAULT NULL COMMENT '问题处理人id',
  `deal_name` varchar(10) DEFAULT NULL COMMENT '问题处理人',
  `deal_time` datetime DEFAULT NULL COMMENT '问题处理时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='建议与意见';

-- ----------------------------
-- Table structure for t_supplier
-- ----------------------------
DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE `t_supplier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `supplier_seq` varchar(50) DEFAULT NULL COMMENT '供应商编号',
  `supplier_code` varchar(50) DEFAULT NULL COMMENT '供应商简码',
  `short_name` varchar(50) DEFAULT NULL COMMENT '供应商简称',
  `name` varchar(50) DEFAULT NULL COMMENT '供应商名称',
  `supplier_type` int(11) DEFAULT NULL COMMENT '供应商类型（0：其他，1：供应商，2：寄售商，3：第三方，4：物流商',
  `brand_id` bigint(20) DEFAULT NULL COMMENT '品牌id',
  `username` varchar(30) DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `contact` varchar(20) DEFAULT NULL COMMENT '联系人',
  `level` int(11) DEFAULT NULL COMMENT '等级',
  `tel` varchar(20) DEFAULT NULL COMMENT '电话',
  `mobile` char(11) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `zip_code` varchar(20) DEFAULT NULL COMMENT '邮编',
  `province_id` bigint(11) DEFAULT NULL,
  `city_id` bigint(11) DEFAULT NULL,
  `county_id` bigint(11) DEFAULT NULL,
  `detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `payment_type` int(11) DEFAULT NULL COMMENT '结算方式（1：月结60天，2：月结30天，3：月结现金，4：出货前结算）',
  `status` int(11) DEFAULT NULL COMMENT '状态（-1：作废，9：失效（不能登录），10：生效（可以登录））',
  `is_tax` bit(1) DEFAULT NULL COMMENT '是否含税',
  `supplier_uuid` varchar(50) DEFAULT NULL COMMENT '供应商UUID，对应仓库系统中的innerid，给第三方接口解密使用',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_sys_user` bigint(20) DEFAULT NULL,
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL,
  `update_name` varchar(20) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_supplier_code` (`supplier_seq`) USING BTREE,
  UNIQUE KEY `supplier_uuid_UNIQUE` (`supplier_uuid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=364 DEFAULT CHARSET=utf8 COMMENT='供应商表';

-- ----------------------------
-- Table structure for t_supplier_contact
-- ----------------------------
DROP TABLE IF EXISTS `t_supplier_contact`;
CREATE TABLE `t_supplier_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `supplier_id` bigint(20) NOT NULL COMMENT '供应商id',
  `consignee` varchar(20) DEFAULT NULL COMMENT '联系人',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别',
  `mobile` char(11) DEFAULT NULL COMMENT '手机',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省id',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市id',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区县id',
  `detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `is_main` bit(1) DEFAULT NULL COMMENT '是否主联系人',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `contact_type_code` varchar(11) DEFAULT NULL COMMENT '联系人类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_tables_logs
-- ----------------------------
DROP TABLE IF EXISTS `t_tables_logs`;
CREATE TABLE `t_tables_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id主键自增',
  `table_name` varchar(45) DEFAULT NULL COMMENT '表名',
  `type` varchar(45) DEFAULT NULL COMMENT '操作类型',
  `business_id` bigint(20) DEFAULT NULL COMMENT '单据id',
  `business_code` varchar(45) DEFAULT NULL COMMENT '单据编号',
  `message` varchar(500) DEFAULT NULL COMMENT '操作内容',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `json` text COMMENT '数据json',
  `batch_code` varchar(45) DEFAULT NULL COMMENT '批次号',
  `create_sys_id` bigint(20) DEFAULT NULL COMMENT '操作人id',
  `create_name` varchar(45) DEFAULT NULL COMMENT '操作人名称',
  `create_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `idx_table_name` (`table_name`) USING BTREE,
  KEY `idx_type` (`type`) USING BTREE,
  KEY `idx_business_id` (`business_id`) USING BTREE,
  KEY `idx_business_code` (`business_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25868 DEFAULT CHARSET=utf8 COMMENT='表记录修改日志';

-- ----------------------------
-- Table structure for t_timed_task
-- ----------------------------
DROP TABLE IF EXISTS `t_timed_task`;
CREATE TABLE `t_timed_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_customer_id` varchar(50) NOT NULL COMMENT '客户id分组',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_customer_id` (`group_customer_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24059 DEFAULT CHARSET=utf8 COMMENT='定时任务表';

-- ----------------------------
-- Table structure for t_tmp_dates
-- ----------------------------
DROP TABLE IF EXISTS `t_tmp_dates`;
CREATE TABLE `t_tmp_dates` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `moth` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_udesk_area_config
-- ----------------------------
DROP TABLE IF EXISTS `t_udesk_area_config`;
CREATE TABLE `t_udesk_area_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `level` int(11) DEFAULT NULL COMMENT '地区级别：1、全国  2、省  3、市  ',
  `province_id` bigint(20) DEFAULT NULL COMMENT '省',
  `city_id` bigint(20) DEFAULT NULL COMMENT '市',
  `county_id` bigint(20) DEFAULT NULL COMMENT '区、县',
  `charge_group` varchar(20) NOT NULL COMMENT '电话客服负责组',
  `charge_person` varchar(20) NOT NULL COMMENT '电话客服负责人',
  `status` int(11) DEFAULT NULL COMMENT '状态：0、禁用  1、启用',
  `create_sys_user` bigint(20) NOT NULL COMMENT '创建者id',
  `create_name` varchar(20) NOT NULL COMMENT '创建者姓名',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='udesk同步客户区域归属客服配置表';

-- ----------------------------
-- Table structure for t_user_message
-- ----------------------------
DROP TABLE IF EXISTS `t_user_message`;
CREATE TABLE `t_user_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `send_id` bigint(20) NOT NULL COMMENT '发信人id',
  `receiver_id` bigint(20) NOT NULL COMMENT '收信人id',
  `user_message_text_id` bigint(20) NOT NULL COMMENT '消息内容',
  `read_time` datetime DEFAULT NULL COMMENT '读取时间',
  `status` int(11) NOT NULL COMMENT '状态（-1：删除，0：未读，1：已读，2：已处理）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_receiver_id` (`receiver_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=476870 DEFAULT CHARSET=utf8 COMMENT='用户消息（客户、后台）';

-- ----------------------------
-- Table structure for t_user_message_text
-- ----------------------------
DROP TABLE IF EXISTS `t_user_message_text`;
CREATE TABLE `t_user_message_text` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` char(6) NOT NULL COMMENT '消息类型（数据字典）',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `text` varchar(2000) NOT NULL COMMENT '内容',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29419 DEFAULT CHARSET=utf8 COMMENT='站内信内容';

-- ----------------------------
-- Table structure for t_valiation_code
-- ----------------------------
DROP TABLE IF EXISTS `t_valiation_code`;
CREATE TABLE `t_valiation_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(20) NOT NULL COMMENT '类型(手机，邮箱)',
  `code` varchar(10) NOT NULL COMMENT '验证码',
  `receiver` varchar(20) NOT NULL COMMENT '验证码接受者（手机，邮箱）',
  `ip` varchar(50) NOT NULL COMMENT '请求验证码的 ip',
  `status` bit(1) NOT NULL COMMENT '状态(0 : 未验证，1：已验证)',
  `create_time` datetime NOT NULL COMMENT '生成时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11667 DEFAULT CHARSET=utf8 COMMENT='短信验证码记录表';

-- ----------------------------
-- Table structure for t_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse`;
CREATE TABLE `t_warehouse` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '仓库名称',
  `is_enabled` bit(1) NOT NULL COMMENT '是否启用（0：否，1：是）',
  `area` varchar(20) NOT NULL COMMENT '区域',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_sys_user` bigint(20) DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(20) DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_sys_user` bigint(20) DEFAULT NULL COMMENT '更新者id',
  `update_name` varchar(20) DEFAULT NULL COMMENT '更新者姓名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='仓库表(已废弃)';

-- ----------------------------
-- Table structure for t_warehouse_everyday_info
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_everyday_info`;
CREATE TABLE `t_warehouse_everyday_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `brand_id` bigint(20) NOT NULL COMMENT '品牌主键',
  `merchant_id` bigint(20) NOT NULL COMMENT '仓库id',
  `total_amount` decimal(12,2) NOT NULL COMMENT '库存总金额',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4790 DEFAULT CHARSET=utf8 COMMENT='每日库存信息表';

-- ----------------------------
-- Table structure for t_warehouse_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_stock`;
CREATE TABLE `t_warehouse_stock` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `merchant_id` bigint(20) NOT NULL COMMENT '商家id',
  `warehouse_id` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `stock` decimal(12,3) NOT NULL COMMENT '库存数量',
  `order_freeze_stock` decimal(12,3) NOT NULL COMMENT '订单冻结数量',
  `delivery_freeze_stock` decimal(12,3) NOT NULL COMMENT '发货通知单冻结数量',
  `order_num_lower` decimal(12,3) DEFAULT NULL COMMENT '起订量',
  `show_num_upper` decimal(12,3) NOT NULL DEFAULT '10000.000' COMMENT '商城最高显示数量',
  `prepare_max_num` decimal(12,3) DEFAULT NULL COMMENT '备货上限',
  `prepare_min_num` decimal(12,3) DEFAULT NULL COMMENT '备货下限',
  `primeval_prepare_max_num` decimal(12,3) DEFAULT '0.000' COMMENT '原始备货上限',
  `primeval_prepare_min_num` decimal(12,3) DEFAULT '0.000' COMMENT '原始备货下限',
  `stockout_delivery_days` int(11) DEFAULT NULL COMMENT '无货交期天数',
  `stockout_num_upper` decimal(12,3) DEFAULT NULL COMMENT '缺货数量上限',
  `is_standing` bit(1) DEFAULT NULL COMMENT '是否常备（0：否，1：是）',
  `is_negative_stock` bit(1) DEFAULT NULL COMMENT '是否支持负库存购买',
  `sync_time` datetime DEFAULT NULL COMMENT '同步时间，由客户端提供',
  `local_sync_time` datetime DEFAULT NULL COMMENT '本地同步时间，同步写入时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `goods_id_UNIQUE` (`goods_id`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109429 DEFAULT CHARSET=utf8 COMMENT='库存表';

-- ----------------------------
-- Table structure for t_warehouse_stock_log
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_stock_log`;
CREATE TABLE `t_warehouse_stock_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `goods_id` bigint(20) NOT NULL COMMENT '商品id',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商家id',
  `warehouse_stock_id` bigint(20) DEFAULT NULL,
  `bar_code` varchar(20) DEFAULT NULL COMMENT '条码',
  `action_code` varchar(30) DEFAULT NULL COMMENT '操作类型',
  `before_amount` decimal(12,3) DEFAULT NULL COMMENT '变化前数量',
  `after_amount` decimal(12,3) DEFAULT NULL COMMENT '变化后数量',
  `increasement` decimal(12,3) DEFAULT NULL COMMENT '增量',
  `available_before_status` int(11) DEFAULT NULL COMMENT '下单可用库存变化前状态（0：数量0，-1：负值，1：正值）',
  `available_after_status` int(11) DEFAULT NULL COMMENT '下单可用库存变化后状态（0：数量0，-1：负值，1：正值）',
  `before_status` int(11) DEFAULT NULL COMMENT '变化前状态（0：数量0，-1：负值，1：正值）',
  `after_status` int(11) DEFAULT NULL COMMENT '变化后状态（0：数量0，-1：负值，1：正值）',
  `business_code` varchar(20) DEFAULT NULL,
  `business_action` varchar(30) DEFAULT NULL,
  `json` text,
  `create_sys_user` bigint(20) DEFAULT NULL,
  `create_name` varchar(30) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_goods` (`id`,`goods_id`,`business_code`) USING BTREE,
  KEY `idx_goods_id` (`goods_id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_available_befor-available_after` (`available_before_status`,`available_after_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=930202 DEFAULT CHARSET=utf8;
SET FOREIGN_KEY_CHECKS=1;
