/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/12/19 21:10:06                          */
/*==============================================================*/


drop table if exists sys_dict;

drop table if exists sys_dict_type;

drop table if exists sys_office;

drop table if exists sys_resource;

drop table if exists sys_role;

drop table if exists sys_role_resource;

drop table if exists sys_user;

drop table if exists sys_user_resource;

drop table if exists sys_user_role;

drop table if exists t_activity;

drop table if exists t_contract_drawing;

drop table if exists t_customer_info;

drop table if exists t_design_sketch;

drop table if exists t_engineering_budget;

drop table if exists t_engineering_cost;

drop table if exists t_payment;

drop table if exists t_project;

drop table if exists t_receivables;

/*==============================================================*/
/* Table: sys_dict                                              */
/*==============================================================*/
create table sys_dict
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   dict_type_id         bigint(20) comment 'sys_dict_type表的id',
   code                 char(6) comment '字典值编码（唯一）',
   name                 varchar(200) comment '字典值中文名字',
   primary key (id)
)
charset = UTF8;

alter table sys_dict comment '数据字典表';

/*==============================================================*/
/* Table: sys_dict_type                                         */
/*==============================================================*/
create table sys_dict_type
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   code                 char(6) comment '字典类型编码（唯一）',
   name                 varchar(200) comment '字典类型中文名称',
   primary key (id)
)
charset = UTF8;

alter table sys_dict_type comment '数据字典类型表';

/*==============================================================*/
/* Table: sys_office                                            */
/*==============================================================*/
create table sys_office
(
   id                   bigint(11) unsigned not null auto_increment comment '主键',
   parent_id            bigint(11) comment '父id（根节点的parentId为0）',
   name                 varchar(20) comment '部门名字',
   primary key (id)
)
charset = UTF8;

alter table sys_office comment '公司机构表';

/*==============================================================*/
/* Table: sys_resource                                          */
/*==============================================================*/
create table sys_resource
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   url                  varchar(200) comment 'url',
   permission_identity  varchar(100) comment '权限标识',
   primary key (id)
);

alter table sys_resource comment '系统资源表';

/*==============================================================*/
/* Table: sys_role                                              */
/*==============================================================*/
create table sys_role
(
   id                   bigint(11) unsigned not null auto_increment comment '主键',
   name                 varchar(50) comment '角色名称',
   english_name         varchar(50) comment '英文名称',
   primary key (id)
);

alter table sys_role comment '系统角色表';

/*==============================================================*/
/* Table: sys_role_resource                                     */
/*==============================================================*/
create table sys_role_resource
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   role_id              bigint(20) comment '角色id',
   resource_id          bigint(20) comment '资源id',
   primary key (id)
);

alter table sys_role_resource comment '系统角色资源表';

/*==============================================================*/
/* Table: sys_user                                              */
/*==============================================================*/
create table sys_user
(
   id                   bigint(20) not null auto_increment comment '主键',
   staff_no             varchar(20) not null comment '员工工号',
   office_id            bigint(20) not null comment '部门id',
   name                 varchar(20) comment '员工名字',
   username             varchar(20) comment '员工登录系统名',
   password             char(32) comment '员工登录系统密码',
   primary key (id)
)
charset = UTF8;

alter table sys_user comment '公司员工表';

/*==============================================================*/
/* Table: sys_user_resource                                     */
/*==============================================================*/
create table sys_user_resource
(
   user_id              bigint(20) not null comment '员工id',
   resource_id          bigint(20) not null comment '资源id',
   primary key (user_id, resource_id)
);

alter table sys_user_resource comment '系统用户资源表';

/*==============================================================*/
/* Table: sys_user_role                                         */
/*==============================================================*/
create table sys_user_role
(
   user_id              bigint(20) not null comment '员工id',
   role_id              bigint(20) not null comment '角色主键',
   primary key (user_id, role_id)
);

alter table sys_user_role comment '系统用户角色表';

/*==============================================================*/
/* Table: t_activity                                            */
/*==============================================================*/
create table t_activity
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   details              varchar(200) comment '活动内容',
   primary key (id)
)
charset = UTF8;

alter table t_activity comment '活动表';

/*==============================================================*/
/* Table: t_contract_drawing                                    */
/*==============================================================*/
create table t_contract_drawing
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   project_cost_id      bigint(20) comment '工程费用id',
   real_hair            decimal(12,2) comment '实发施工图费用',
   primary key (id)
);

alter table t_contract_drawing comment '施工图';

/*==============================================================*/
/* Table: t_customer_info                                       */
/*==============================================================*/
create table t_customer_info
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   name                 varchar(20) not null comment '客户名字',
   sex                  bit(1) comment '客户性别（0：男，1：女）',
   mobile               char(11) comment '客户手机号码',
   detail_address       varchar(100) comment '客户详细地址',
   remark               varchar(200) comment '备注',
   primary key (id)
)
charset = UTF8;

alter table t_customer_info comment '客户信息表';

/*==============================================================*/
/* Table: t_design_sketch                                       */
/*==============================================================*/
create table t_design_sketch
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   project_cost_id      bigint(20) comment '工程费用id',
   offer                decimal(12,2) comment '效果图报价',
   make                 decimal(12,2) comment '效果图制作费用',
   print                decimal(12,2) comment '效果图打印费用',
   primary key (id)
);

alter table t_design_sketch comment '效果图';

/*==============================================================*/
/* Table: t_engineering_budget                                  */
/*==============================================================*/
create table t_engineering_budget
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   project_contract_code char(12) not null comment '合同编号',
   budget_contract_price decimal(12,2) comment '预算合同价',
   new_budget_item      decimal(12,2) comment '预算新增项目',
   new_reduction_projectt decimal(12,2) comment '预算新减项目',
   total_budget         decimal(12,2) comment '预算总价',
   primary key (id)
)
charset = UTF8;

alter table t_engineering_budget comment '工程费用预算表';

/*==============================================================*/
/* Table: t_engineering_cost                                    */
/*==============================================================*/
create table t_engineering_cost
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   project_contract_code char(12) not null comment '合同编号',
   design_sketch_id     bigint(20) comment '效果图费用id',
   contract_drawing_id  bigint(20) comment '施工图费用id',
   company_remind       varchar(20) comment '公司提点',
   manager_into         decimal(12,2) comment '项目经理分成',
   project_manager_residual decimal(12,2) comment '项目经理剩余分成',
   manager_cost         decimal(12,2) comment '管理费',
   total_cost           decimal(12,2) comment '成本总计',
   contract_price       decimal(12,2) comment '合同价',
   new_item             decimal(12,2) comment '新增项目',
   reduce_item          decimal(12,2) comment '新减项目',
   total                decimal(12,2) comment '总价',
   settlement_price     decimal(12,2) comment '结算价',
   primary key (id)
)
charset = UTF8;

alter table t_engineering_cost comment '工程费用表';

/*==============================================================*/
/* Table: t_payment                                             */
/*==============================================================*/
create table t_payment
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   payment_dict_code    char(6) comment '付款',
   project_contract_code char(12) not null comment '合同编号',
   payment_date         date comment '付款日期',
   details              varchar(1000) comment '付款描述',
   payment_amounts      decimal(12,2) comment '付款金额',
   primary key (id)
)
charset = UTF8;

alter table t_payment comment '公司付款表';

/*==============================================================*/
/* Table: t_project                                             */
/*==============================================================*/
create table t_project
(
   id                   bigint(20) unsigned not null auto_increment comment '工程主键',
   customer_info_id     bigint(20) comment 't_customer_info表id',
   contract_code        char(12) not null comment '合同编号',
   name                 varchar(100) not null comment '工程名字(现在用的是客户的地址作为工程名字)',
   contract_time        datetime comment '签合同日期',
   info_sources         varchar(20) comment '信息来源',
   period               smallint(4) comment '工期单位(天)',
   start_time           datetime comment '开工日期',
   end_time             datetime comment '完工日期',
   project_supervision  varchar(20) comment '工程监理',
   remark               varchar(200) comment '备注',
   salesman_id          bigint(20) comment '业务员id',
   designer_id          bigint(20) comment '设计师id',
   project_manager_id   bigint(20) comment '项目经理id',
   activity_ids         varchar(100) comment '所有活动id，'''',''''分隔',
   primary key (id)
)
charset = UTF8;

alter table t_project comment '工程信息表';

/*==============================================================*/
/* Table: t_receivables                                         */
/*==============================================================*/
create table t_receivables
(
   id                   bigint(20) unsigned not null auto_increment comment '主键',
   project_contract_code char(12) not null comment '合同编号',
   periods              varchar(20) comment '期数',
   receivable_date      date comment '收款日期',
   receivable_amounts   decimal(12,2) comment '收款金额',
   primary key (id)
)
charset = UTF8;

alter table t_receivables comment '公司收款表';

