/*
 Navicat MySQL Data Transfer

 Source Server         : springboot
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : company_project

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 10/09/2021 19:18:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_content
-- ----------------------------
DROP TABLE IF EXISTS `sys_content`;
CREATE TABLE `sys_content`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '标题',
  `type` int(11) NULL DEFAULT NULL COMMENT '文章类型',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '文章管理' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_content
-- ----------------------------
INSERT INTO `sys_content` VALUES ('1434029689634070530', '测试', 0, '撒下', '2021-09-04 13:44:56', '1');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `dept_no` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门编号(规则：父级关系编码+自己的编码)',
  `name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `pid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父级id',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态(1:正常；0:弃用)',
  `relation_code` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '为了维护更深层级关系',
  `dept_manager_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门经理user_id',
  `manager_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门经理名称',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门经理联系电话',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint(4) NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统部门' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', 'D000001', '总公司', '0', 1, 'D000001', NULL, '小李', '13888888888', '2019-11-07 22:43:33', NULL, 1);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1434029202318860289', '邓文杰', '11', '2021-09-04 13:42:59');
INSERT INTO `sys_dict` VALUES ('1434029435652186114', '邓文杰2', '222', '2021-09-04 13:43:55');

-- ----------------------------
-- Table structure for sys_dict_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_detail`;
CREATE TABLE `sys_dict_detail`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典标签',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典值',
  `sort` smallint(6) NULL DEFAULT NULL COMMENT '排序',
  `dict_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典详情' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dict_detail
-- ----------------------------
INSERT INTO `sys_dict_detail` VALUES ('1255790073535885314', '男', '1', 1, '1255790029680242690', '2020-04-30 17:24:19');
INSERT INTO `sys_dict_detail` VALUES ('1255790100115189761', '女', '2', 2, '1255790029680242690', '2020-04-30 17:24:25');
INSERT INTO `sys_dict_detail` VALUES ('1282504475715350530', '诗词', '1', 1, '1282504369620430849', '2020-07-13 10:37:49');
INSERT INTO `sys_dict_detail` VALUES ('1282504651729317889', '散文', '2', 2, '1282504369620430849', '2020-07-13 10:38:31');
INSERT INTO `sys_dict_detail` VALUES ('1282846022950842369', '剧本', '3', 3, '1282504369620430849', '2020-07-14 09:15:01');

-- ----------------------------
-- Table structure for sys_files
-- ----------------------------
DROP TABLE IF EXISTS `sys_files`;
CREATE TABLE `sys_files`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件上传' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1252884495040782337', 'testTask', '1', '0 */1 * * * ?', 0, '1', '2020-04-22 16:58:35');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务日志id',
  `job_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `job_id`(`job_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
INSERT INTO `sys_job_log` VALUES ('1433054280662695937', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-01 21:09:00');
INSERT INTO `sys_job_log` VALUES ('1433054532249632769', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-01 21:10:00');
INSERT INTO `sys_job_log` VALUES ('1433056797215744002', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-01 21:19:00');
INSERT INTO `sys_job_log` VALUES ('1434027694726619138', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-04 13:37:00');
INSERT INTO `sys_job_log` VALUES ('1434027946309361665', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-04 13:38:00');
INSERT INTO `sys_job_log` VALUES ('1434028197963407362', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-04 13:39:00');
INSERT INTO `sys_job_log` VALUES ('1434028449625841665', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-04 13:40:00');
INSERT INTO `sys_job_log` VALUES ('1434028701271498754', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-04 13:41:00');
INSERT INTO `sys_job_log` VALUES ('1434028952954904578', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-04 13:42:00');
INSERT INTO `sys_job_log` VALUES ('1434029204583784449', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-04 13:43:00');
INSERT INTO `sys_job_log` VALUES ('1434029456279773186', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-04 13:44:00');
INSERT INTO `sys_job_log` VALUES ('1434029707887681538', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-04 13:45:00');
INSERT INTO `sys_job_log` VALUES ('1434029959554310146', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-04 13:46:00');
INSERT INTO `sys_job_log` VALUES ('1434030211216744450', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-04 13:47:00');
INSERT INTO `sys_job_log` VALUES ('1434030462862401538', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-04 13:48:00');
INSERT INTO `sys_job_log` VALUES ('1434030714558390274', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-04 13:49:00');
INSERT INTO `sys_job_log` VALUES ('1434410718614032386', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-05 14:59:00');
INSERT INTO `sys_job_log` VALUES ('1434413997616017410', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-05 15:12:02');
INSERT INTO `sys_job_log` VALUES ('1434414241686761473', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-05 15:13:00');
INSERT INTO `sys_job_log` VALUES ('1434440001692672001', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-05 16:55:22');
INSERT INTO `sys_job_log` VALUES ('1434440297261096961', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-05 16:56:32');
INSERT INTO `sys_job_log` VALUES ('1434441046049255425', '1252884495040782337', 'testTask', '1', 0, NULL, 4, '2021-09-05 16:59:31');
INSERT INTO `sys_job_log` VALUES ('1435193381469827074', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-07 18:49:01');
INSERT INTO `sys_job_log` VALUES ('1435193381469827075', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2021-09-07 18:49:01');
INSERT INTO `sys_job_log` VALUES ('1435193647925604353', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-07 18:50:05');
INSERT INTO `sys_job_log` VALUES ('1435193879207915521', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-07 18:51:00');
INSERT INTO `sys_job_log` VALUES ('1435197933321465858', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-07 19:07:07');
INSERT INTO `sys_job_log` VALUES ('1435981398174388225', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-09 23:00:19');
INSERT INTO `sys_job_log` VALUES ('1435981821060874241', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:02:00');
INSERT INTO `sys_job_log` VALUES ('1435982080617009153', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-09 23:03:02');
INSERT INTO `sys_job_log` VALUES ('1435982390777401346', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:04:16');
INSERT INTO `sys_job_log` VALUES ('1435982630205042689', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-09 23:05:13');
INSERT INTO `sys_job_log` VALUES ('1435982827727388674', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:06:00');
INSERT INTO `sys_job_log` VALUES ('1435983079238828033', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-09 23:07:00');
INSERT INTO `sys_job_log` VALUES ('1435983330846736385', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:08:00');
INSERT INTO `sys_job_log` VALUES ('1435983582504976386', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:09:00');
INSERT INTO `sys_job_log` VALUES ('1435983834142244865', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:10:00');
INSERT INTO `sys_job_log` VALUES ('1435985504213471234', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-09 23:16:42');
INSERT INTO `sys_job_log` VALUES ('1435985504213471235', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-09 23:16:42');
INSERT INTO `sys_job_log` VALUES ('1435985599105335297', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-09 23:17:01');
INSERT INTO `sys_job_log` VALUES ('1435985847408132097', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:18:00');
INSERT INTO `sys_job_log` VALUES ('1435986099108315138', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:19:00');
INSERT INTO `sys_job_log` VALUES ('1435987414148497410', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:24:14');
INSERT INTO `sys_job_log` VALUES ('1435987414148497411', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:24:14');
INSERT INTO `sys_job_log` VALUES ('1435988251126116353', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-09 23:27:33');
INSERT INTO `sys_job_log` VALUES ('1435988251126116354', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:27:33');
INSERT INTO `sys_job_log` VALUES ('1435988806850441217', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-09 23:29:46');
INSERT INTO `sys_job_log` VALUES ('1435989491973140481', '1252884495040782337', 'testTask', '1', 0, NULL, 8901, '2021-09-09 23:32:29');
INSERT INTO `sys_job_log` VALUES ('1435989491973140482', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:32:29');
INSERT INTO `sys_job_log` VALUES ('1435989796274089985', '1252884495040782337', 'testTask', '1', 0, NULL, 2, '2021-09-09 23:33:41');
INSERT INTO `sys_job_log` VALUES ('1435990125728268290', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:35:00');
INSERT INTO `sys_job_log` VALUES ('1435990377294233601', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-09 23:36:00');
INSERT INTO `sys_job_log` VALUES ('1436000192024301570', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-10 00:15:00');
INSERT INTO `sys_job_log` VALUES ('1436000443577683969', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 00:16:00');
INSERT INTO `sys_job_log` VALUES ('1436000696053821441', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-10 00:17:00');
INSERT INTO `sys_job_log` VALUES ('1436000946936115202', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 00:18:00');
INSERT INTO `sys_job_log` VALUES ('1436229203212128257', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 15:25:01');
INSERT INTO `sys_job_log` VALUES ('1436229704339206145', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 15:27:00');
INSERT INTO `sys_job_log` VALUES ('1436229955884199938', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-10 15:28:00');
INSERT INTO `sys_job_log` VALUES ('1436230207592771586', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 15:29:00');
INSERT INTO `sys_job_log` VALUES ('1436230459230040065', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 15:30:00');
INSERT INTO `sys_job_log` VALUES ('1436230710879891457', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 15:31:00');
INSERT INTO `sys_job_log` VALUES ('1436232724238041089', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 15:39:00');
INSERT INTO `sys_job_log` VALUES ('1436232975799812098', '1252884495040782337', 'testTask', '1', 0, NULL, 1, '2021-09-10 15:40:00');
INSERT INTO `sys_job_log` VALUES ('1436233227466440706', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 15:41:00');
INSERT INTO `sys_job_log` VALUES ('1436233479124680705', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 15:42:00');
INSERT INTO `sys_job_log` VALUES ('1436287585726091265', '1252884495040782337', 'testTask', '1', 0, NULL, 0, '2021-09-10 19:17:00');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户操作',
  `time` int(11) NULL DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1433054280352317441', '1', 'admin', '机构管理-树型组织列表', 20, 'com.company.project.controller.DeptController.getTree()', '[null]', '0:0:0:0:0:0:0:1', '2021-09-01 21:09:00');
INSERT INTO `sys_log` VALUES ('1433054280461369346', '1', 'admin', '用户管理-分页获取用户列表', 62, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '0:0:0:0:0:0:0:1', '2021-09-01 21:09:00');
INSERT INTO `sys_log` VALUES ('1433054283611291650', '1', 'admin', '角色管理-分页获取角色信息', 9, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '0:0:0:0:0:0:0:1', '2021-09-01 21:09:01');
INSERT INTO `sys_log` VALUES ('1433054287964979202', '1', 'admin', '机构管理-树型组织列表', 4, 'com.company.project.controller.DeptController.getTree()', '[null]', '0:0:0:0:0:0:0:1', '2021-09-01 21:09:02');
INSERT INTO `sys_log` VALUES ('1433054288032088066', '1', 'admin', '用户管理-分页获取用户列表', 11, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '0:0:0:0:0:0:0:1', '2021-09-01 21:09:02');
INSERT INTO `sys_log` VALUES ('1433054307611099137', '1', 'admin', '角色管理-分页获取角色信息', 7, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '0:0:0:0:0:0:0:1', '2021-09-01 21:09:06');
INSERT INTO `sys_log` VALUES ('1433054339911434241', '1', 'admin', '角色管理-查询角色详情', 144, 'com.company.project.controller.RoleController.detailInfo()', '[\"1\"]', '0:0:0:0:0:0:0:1', '2021-09-01 21:09:14');
INSERT INTO `sys_log` VALUES ('1433054359624663042', '1', 'admin', '角色管理-分页获取角色信息', 11, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '0:0:0:0:0:0:0:1', '2021-09-01 21:09:19');
INSERT INTO `sys_log` VALUES ('1433054366008393730', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 107, 'com.company.project.controller.PermissionController.getAllPermissionTree()', NULL, '0:0:0:0:0:0:0:1', '2021-09-01 21:09:20');
INSERT INTO `sys_log` VALUES ('1433056914136162305', '1', 'admin', '菜单权限管理-获取所有菜单权限', 149, 'com.company.project.controller.PermissionController.getAllMenusPermission()', NULL, '192.168.199.1', '2021-09-01 21:19:28');
INSERT INTO `sys_log` VALUES ('1433056918997360641', '1', 'admin', '角色管理-分页获取角色信息', 44, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-01 21:19:29');
INSERT INTO `sys_log` VALUES ('1433056923258773505', '1', 'admin', '机构管理-树型组织列表', 13, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-01 21:19:30');
INSERT INTO `sys_log` VALUES ('1433056923325882370', '1', 'admin', '用户管理-分页获取用户列表', 12, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-01 21:19:30');
INSERT INTO `sys_log` VALUES ('1433056927427911682', '1', 'admin', '机构管理-获取所有组织机构', 6, 'com.company.project.controller.DeptController.getDeptAll()', NULL, '192.168.199.1', '2021-09-01 21:19:31');
INSERT INTO `sys_log` VALUES ('1433056986517266434', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 13, 'com.company.project.controller.SysLogController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-01 21:19:45');
INSERT INTO `sys_log` VALUES ('1434027939686555650', '1', 'admin', '用户管理-查询用户详情', 8, 'com.company.project.controller.UserController.youSelfInfo()', NULL, '192.168.199.1', '2021-09-04 13:37:58');
INSERT INTO `sys_log` VALUES ('1434028000805953537', '1', 'admin', '用户管理-更新用户信息', 32, 'com.company.project.controller.UserController.updateUserInfoById()', '[{\"email\":\"xxxxxx@163.com\",\"id\":\"1\",\"phone\":\"13888888888\",\"realName\":\"yyds\",\"sex\":2,\"status\":1,\"updateId\":\"1\",\"updateTime\":1630733892983,\"username\":\"admin\"}]', '192.168.199.1', '2021-09-04 13:38:13');
INSERT INTO `sys_log` VALUES ('1434028052270063618', '1', 'admin', '菜单权限管理-获取所有菜单权限', 129, 'com.company.project.controller.PermissionController.getAllMenusPermission()', NULL, '192.168.199.1', '2021-09-04 13:38:25');
INSERT INTO `sys_log` VALUES ('1434028131739541506', '1', 'admin', '角色管理-分页获取角色信息', 44, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:38:44');
INSERT INTO `sys_log` VALUES ('1434028174366253058', '1', 'admin', '角色管理-查询角色详情', 128, 'com.company.project.controller.RoleController.detailInfo()', '[\"1\"]', '192.168.199.1', '2021-09-04 13:38:54');
INSERT INTO `sys_log` VALUES ('1434028202107379714', '1', 'admin', '机构管理-树型组织列表', 5, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-04 13:39:01');
INSERT INTO `sys_log` VALUES ('1434028202170294273', '1', 'admin', '用户管理-分页获取用户列表', 15, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:39:01');
INSERT INTO `sys_log` VALUES ('1434028245690392578', '1', 'admin', '机构管理-获取所有组织机构', 5, 'com.company.project.controller.DeptController.getDeptAll()', NULL, '192.168.199.1', '2021-09-04 13:39:11');
INSERT INTO `sys_log` VALUES ('1434028254838169602', '1', 'admin', '机构管理-树型组织列表', 1, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-04 13:39:14');
INSERT INTO `sys_log` VALUES ('1434028254901084162', '1', 'admin', '用户管理-分页获取用户列表', 12, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:39:14');
INSERT INTO `sys_log` VALUES ('1434028356331937794', '1', 'admin', '用户管理-新增用户', 16, 'com.company.project.controller.UserController.addUser()', '[{\"createId\":\"1\",\"createTime\":1630733977749,\"createWhere\":1,\"deleted\":1,\"deptId\":\"1\",\"deptName\":\"总公司\",\"id\":\"1434028356206108674\",\"password\":\"1e9a31023e5e263d24edd303256574db\",\"phone\":\"21321313\",\"salt\":\"f53650d9651a4402a349\",\"status\":1,\"updateId\":\"1\",\"updateTime\":1630733977749,\"username\":\"Test\"}]', '192.168.199.1', '2021-09-04 13:39:38');
INSERT INTO `sys_log` VALUES ('1434028356461961217', '1', 'admin', '用户管理-分页获取用户列表', 10, 'com.company.project.controller.UserController.pageInfo()', '[{\"nickName\":\"\",\"username\":\"\"}]', '192.168.199.1', '2021-09-04 13:39:38');
INSERT INTO `sys_log` VALUES ('1434028447486746626', '1', 'admin', '机构管理-树型组织列表', 2, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-04 13:40:00');
INSERT INTO `sys_log` VALUES ('1434028447566438401', '1', 'admin', '用户管理-分页获取用户列表', 10, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:40:00');
INSERT INTO `sys_log` VALUES ('1434028532199104513', '1', 'admin', '机构管理-获取所有组织机构', 4, 'com.company.project.controller.DeptController.getDeptAll()', NULL, '192.168.199.1', '2021-09-04 13:40:20');
INSERT INTO `sys_log` VALUES ('1434028548007436290', '1', 'admin', '机构管理-树型组织列表', 13, 'com.company.project.controller.DeptController.getTree()', '[\"1\"]', '192.168.199.1', '2021-09-04 13:40:23');
INSERT INTO `sys_log` VALUES ('1434028564797235201', '1', 'admin', '角色管理-分页获取角色信息', 5, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:40:27');
INSERT INTO `sys_log` VALUES ('1434028570660872194', '1', 'admin', '菜单权限管理-获取所有菜单权限', 92, 'com.company.project.controller.PermissionController.getAllMenusPermission()', NULL, '192.168.199.1', '2021-09-04 13:40:29');
INSERT INTO `sys_log` VALUES ('1434028583210229761', '1', 'admin', '角色管理-分页获取角色信息', 5, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:40:32');
INSERT INTO `sys_log` VALUES ('1434028606866104321', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 76, 'com.company.project.controller.PermissionController.getAllPermissionTree()', NULL, '192.168.199.1', '2021-09-04 13:40:37');
INSERT INTO `sys_log` VALUES ('1434028627904733186', '1', 'admin', '菜单权限管理-获取所有菜单权限', 81, 'com.company.project.controller.PermissionController.getAllMenusPermission()', NULL, '192.168.199.1', '2021-09-04 13:40:43');
INSERT INTO `sys_log` VALUES ('1434028638264664065', '1', 'admin', '菜单权限管理-获取所有菜单权限', 63, 'com.company.project.controller.PermissionController.getAllMenusPermission()', NULL, '192.168.199.1', '2021-09-04 13:40:45');
INSERT INTO `sys_log` VALUES ('1434029770051461121', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 14, 'com.company.project.controller.SysLogController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:45:15');
INSERT INTO `sys_log` VALUES ('1434030007654588418', '1', 'admin', '菜单权限管理-获取所有菜单权限', 83, 'com.company.project.controller.PermissionController.getAllMenusPermission()', NULL, '192.168.199.1', '2021-09-04 13:46:11');
INSERT INTO `sys_log` VALUES ('1434030024377278465', '1', 'admin', '角色管理-分页获取角色信息', 5, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:46:15');
INSERT INTO `sys_log` VALUES ('1434030052172931074', '1', 'admin', '菜单权限管理-获取所有目录菜单树', 67, 'com.company.project.controller.PermissionController.getAllPermissionTree()', NULL, '192.168.199.1', '2021-09-04 13:46:22');
INSERT INTO `sys_log` VALUES ('1434030125325787138', '1', 'admin', '角色管理-新增角色', 55, 'com.company.project.controller.RoleController.addRole()', '[{\"createTime\":1630734399489,\"deleted\":1,\"description\":\"test\",\"id\":\"1434030125132849153\",\"name\":\"邓文杰\",\"permissions\":[\"51\",\"11\",\"17\",\"26\",\"40\",\"43\",\"44\",\"53\",\"36\",\"3\",\"19\",\"1311115974068449281\",\"13\",\"39\",\"24\",\"10\",\"23\",\"52\",\"25\",\"56\",\"57\",\"42\",\"41\",\"12\",\"22\",\"5\",\"38\",\"9\",\"54\",\"15\",\"4\",\"1\",\"16\",\"20\",\"27\",\"29\",\"30\",\"28\",\"45\",\"49\",\"48\",\"47\",\"46\",\"59\",\"60\",\"61\",\"62\",\"63\",\"55\",\"18\",\"14\",\"31\",\"32\",\"33\",\"34\",\"35\",\"8\",\"58\",\"7\"],\"status\":1,\"updateTime\":1630734399489}]', '192.168.199.1', '2021-09-04 13:46:40');
INSERT INTO `sys_log` VALUES ('1434030125518725121', '1', 'admin', '角色管理-分页获取角色信息', 4, 'com.company.project.controller.RoleController.pageInfo()', '[{\"name\":\"\"}]', '192.168.199.1', '2021-09-04 13:46:40');
INSERT INTO `sys_log` VALUES ('1434030148377681921', '1', 'admin', '角色管理-查询角色详情', 78, 'com.company.project.controller.RoleController.detailInfo()', '[\"1434030125132849153\"]', '192.168.199.1', '2021-09-04 13:46:45');
INSERT INTO `sys_log` VALUES ('1434030213167095810', '1', 'admin', '机构管理-树型组织列表', 1, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-04 13:47:00');
INSERT INTO `sys_log` VALUES ('1434030213230010369', '1', 'admin', '用户管理-分页获取用户列表', 8, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:47:00');
INSERT INTO `sys_log` VALUES ('1434030258616573953', NULL, NULL, '用户管理-退出', 2, 'com.company.project.controller.UserController.logout()', NULL, '192.168.199.1', '2021-09-04 13:47:11');
INSERT INTO `sys_log` VALUES ('1434030382067523585', NULL, NULL, '用户管理-退出', 1, 'com.company.project.controller.UserController.logout()', NULL, '192.168.199.1', '2021-09-04 13:47:41');
INSERT INTO `sys_log` VALUES ('1434030450203992066', '1', 'admin', '角色管理-分页获取角色信息', 4, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:47:57');
INSERT INTO `sys_log` VALUES ('1434030460219990017', '1', 'admin', '机构管理-树型组织列表', 1, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-04 13:47:59');
INSERT INTO `sys_log` VALUES ('1434030460282904577', '1', 'admin', '用户管理-分页获取用户列表', 7, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:47:59');
INSERT INTO `sys_log` VALUES ('1434030495955460098', '1', 'admin', '用户管理-赋予角色-获取所有角色接口', 5, 'com.company.project.controller.UserController.getUserOwnRole()', '[\"1434028356206108674\"]', '192.168.199.1', '2021-09-04 13:48:08');
INSERT INTO `sys_log` VALUES ('1434030536606654466', '1', 'admin', '用户管理-赋予角色-用户赋予角色接口', 7, 'com.company.project.controller.UserController.setUserOwnRole()', '[\"1434028356206108674\",[]]', '192.168.199.1', '2021-09-04 13:48:18');
INSERT INTO `sys_log` VALUES ('1434030536736677890', '1', 'admin', '用户管理-分页获取用户列表', 10, 'com.company.project.controller.UserController.pageInfo()', '[{\"nickName\":\"\",\"username\":\"\"}]', '192.168.199.1', '2021-09-04 13:48:18');
INSERT INTO `sys_log` VALUES ('1434030561235607553', '1', 'admin', '用户管理-赋予角色-获取所有角色接口', 3, 'com.company.project.controller.UserController.getUserOwnRole()', '[\"1434028356206108674\"]', '192.168.199.1', '2021-09-04 13:48:23');
INSERT INTO `sys_log` VALUES ('1434030601052135427', '1', 'admin', '用户管理-赋予角色-用户赋予角色接口', 13, 'com.company.project.controller.UserController.setUserOwnRole()', '[\"1434028356206108674\",[\"1434030125132849153\"]]', '192.168.199.1', '2021-09-04 13:48:33');
INSERT INTO `sys_log` VALUES ('1434030601177964546', '1', 'admin', '用户管理-分页获取用户列表', 8, 'com.company.project.controller.UserController.pageInfo()', '[{\"nickName\":\"\",\"username\":\"\"}]', '192.168.199.1', '2021-09-04 13:48:33');
INSERT INTO `sys_log` VALUES ('1434030614629097474', '1', 'admin', '用户管理-赋予角色-获取所有角色接口', 4, 'com.company.project.controller.UserController.getUserOwnRole()', '[\"1434028356206108674\"]', '192.168.199.1', '2021-09-04 13:48:36');
INSERT INTO `sys_log` VALUES ('1434030637060235265', NULL, NULL, '用户管理-退出', 1, 'com.company.project.controller.UserController.logout()', NULL, '192.168.199.1', '2021-09-04 13:48:42');
INSERT INTO `sys_log` VALUES ('1434030682325164033', '1434028356206108674', 'Test', '机构管理-树型组织列表', 2, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-04 13:48:52');
INSERT INTO `sys_log` VALUES ('1434030682455187457', '1434028356206108674', 'Test', '用户管理-分页获取用户列表', 8, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:48:52');
INSERT INTO `sys_log` VALUES ('1434030684128714753', '1434028356206108674', 'Test', '机构管理-树型组织列表', 1, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-04 13:48:53');
INSERT INTO `sys_log` VALUES ('1434030684195823617', '1434028356206108674', 'Test', '用户管理-分页获取用户列表', 8, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:48:53');
INSERT INTO `sys_log` VALUES ('1434030685827407873', '1434028356206108674', 'Test', '角色管理-分页获取角色信息', 5, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:48:53');
INSERT INTO `sys_log` VALUES ('1434030688616620033', '1434028356206108674', 'Test', '机构管理-获取所有组织机构', 3, 'com.company.project.controller.DeptController.getDeptAll()', NULL, '192.168.199.1', '2021-09-04 13:48:54');
INSERT INTO `sys_log` VALUES ('1434030738835021825', '1434028356206108674', 'Test', '系统操作日志管理-分页查询系统操作日志', 5, 'com.company.project.controller.SysLogController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:49:06');
INSERT INTO `sys_log` VALUES ('1434030793637797889', '1434028356206108674', 'Test', '机构管理-树型组织列表', 2, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-04 13:49:19');
INSERT INTO `sys_log` VALUES ('1434030793700712449', '1434028356206108674', 'Test', '用户管理-分页获取用户列表', 7, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:49:19');
INSERT INTO `sys_log` VALUES ('1434030801523089410', '1434028356206108674', 'Test', '机构管理-获取所有组织机构', 3, 'com.company.project.controller.DeptController.getDeptAll()', NULL, '192.168.199.1', '2021-09-04 13:49:21');
INSERT INTO `sys_log` VALUES ('1434030805230854146', '1434028356206108674', 'Test', '机构管理-树型组织列表', 1, 'com.company.project.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-04 13:49:22');
INSERT INTO `sys_log` VALUES ('1434030805365071874', '1434028356206108674', 'Test', '用户管理-分页获取用户列表', 12, 'com.company.project.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:49:22');
INSERT INTO `sys_log` VALUES ('1434030816651943937', '1434028356206108674', 'Test', '角色管理-分页获取角色信息', 4, 'com.company.project.controller.RoleController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-04 13:49:24');
INSERT INTO `sys_log` VALUES ('1434030823220224002', '1434028356206108674', 'Test', '菜单权限管理-获取所有菜单权限', 59, 'com.company.project.controller.PermissionController.getAllMenusPermission()', NULL, '192.168.199.1', '2021-09-04 13:49:26');
INSERT INTO `sys_log` VALUES ('1436233088043581441', NULL, NULL, '用户管理-退出', 4, 'com.example.company.controller.UserController.logout()', NULL, '192.168.199.1', '2021-09-10 15:40:27');
INSERT INTO `sys_log` VALUES ('1436233170054807553', '1', 'admin', '用户管理-查询用户详情', 10, 'com.example.company.controller.UserController.youSelfInfo()', NULL, '192.168.199.1', '2021-09-10 15:40:46');
INSERT INTO `sys_log` VALUES ('1436233291521851394', NULL, NULL, '用户管理-退出', 3, 'com.example.company.controller.UserController.logout()', NULL, '192.168.199.1', '2021-09-10 15:41:15');
INSERT INTO `sys_log` VALUES ('1436287437746851841', '1', 'admin', '菜单权限管理-获取所有菜单权限', 145, 'com.example.company.controller.PermissionController.getAllMenusPermission()', NULL, '192.168.199.1', '2021-09-10 19:16:25');
INSERT INTO `sys_log` VALUES ('1436287442540941313', '1', 'admin', '角色管理-分页获取角色信息', 49, 'com.example.company.controller.RoleController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-10 19:16:26');
INSERT INTO `sys_log` VALUES ('1436287445657309185', '1', 'admin', '机构管理-树型组织列表', 15, 'com.example.company.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-10 19:16:27');
INSERT INTO `sys_log` VALUES ('1436287445720223745', '1', 'admin', '用户管理-分页获取用户列表', 15, 'com.example.company.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-10 19:16:27');
INSERT INTO `sys_log` VALUES ('1436287449516068865', '1', 'admin', '机构管理-树型组织列表', 2, 'com.example.company.controller.DeptController.getTree()', '[null]', '192.168.199.1', '2021-09-10 19:16:28');
INSERT INTO `sys_log` VALUES ('1436287449578983426', '1', 'admin', '用户管理-分页获取用户列表', 14, 'com.example.company.controller.UserController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-10 19:16:28');
INSERT INTO `sys_log` VALUES ('1436287451466420225', '1', 'admin', '机构管理-获取所有组织机构', 6, 'com.example.company.controller.DeptController.getDeptAll()', NULL, '192.168.199.1', '2021-09-10 19:16:28');
INSERT INTO `sys_log` VALUES ('1436287527672729601', '1', 'admin', '系统操作日志管理-分页查询系统操作日志', 17, 'com.example.company.controller.LogController.pageInfo()', '[{}]', '192.168.199.1', '2021-09-10 19:16:46');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限名称',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：sys:user:add,sys:user:edit)',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问地址URL',
  `target` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'a target属性:_self _blank',
  `pid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级菜单权限名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '菜单权限类型(1:目录;2:菜单;3:按钮)',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态1:正常 0：禁用',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint(4) NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统权限' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('1', '删除', 'sysGenerator:delete', NULL, 'sysGenerator/delete', NULL, '15', 1, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('10', '赋予角色', 'sys:user:role:update', NULL, '/sys/user/roles/*', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('11', '菜单权限管理', NULL, NULL, '/index/menus', '_self', '51', 98, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('12', '列表', 'sys:dept:list', NULL, '/sys/depts', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('13', '删除', 'sys:role:deleted', NULL, '/sys/role/*', NULL, '53', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('1311115974068449281', '数据权限', 'sys:role:bindDept', '', '/sys/role/bindDept', '_self', '53', 5, 3, 1, '2020-09-30 09:29:42', NULL, 1);
INSERT INTO `sys_permission` VALUES ('14', '定时任务立即执行', 'sysJob:run', NULL, '/sysJob/run', '_self', '59', 5, 3, 1, '2020-04-22 15:47:54', NULL, 1);
INSERT INTO `sys_permission` VALUES ('15', '代码生成', NULL, NULL, '/index/sysGenerator', '_self', '54', 1, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('16', '列表', 'sysGenerator:list', NULL, 'sysGenerator/listByPage', NULL, '15', 1, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('17', '详情', 'sys:permission:detail', NULL, '/sys/permission/*', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('18', '定时任务恢复', 'sysJob:resume', NULL, '/sysJob/resume', '_self', '59', 4, 3, 1, '2020-04-22 15:48:40', NULL, 1);
INSERT INTO `sys_permission` VALUES ('19', '列表', 'sys:role:list', NULL, '/sys/roles', NULL, '53', 0, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('2', 'SQL 监控', '', '', '/druid/sql.html', '_self', '21', 98, 2, 1, '2020-03-19 13:29:40', '2020-05-07 13:36:59', 1);
INSERT INTO `sys_permission` VALUES ('20', '修改', 'sysGenerator:update', NULL, 'sysGenerator/update', NULL, '15', 1, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('21', '其他', NULL, 'layui-icon-list', NULL, NULL, '0', 200, 1, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('22', '详情', 'sys:dept:detail', NULL, '/sys/dept/*', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('23', '列表', 'sys:user:list', NULL, '/sys/users', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('24', '用户管理', NULL, NULL, '/index/users', '_self', '51', 100, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('25', '详情', 'sys:user:detail', NULL, '/sys/user/*', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('26', '删除', 'sys:permission:deleted', NULL, '/sys/permission/*', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('27', '文件管理', '', '', '/index/sysFiles', '_self', '54', 10, 2, 1, NULL, '2020-06-15 16:00:29', 1);
INSERT INTO `sys_permission` VALUES ('28', '列表', 'sysFiles:list', NULL, 'sysFiles/listByPage', NULL, '27', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('29', '新增', 'sysFiles:add', NULL, 'sysFiles/add', NULL, '27', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('3', '新增', 'sys:role:add', NULL, '/sys/role', NULL, '53', 0, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('30', '删除', 'sysFiles:delete', NULL, 'sysFiles/delete', NULL, '27', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('31', '文章管理', NULL, NULL, '/index/sysContent', '_self', '54', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('32', '列表', 'sysContent:list', NULL, 'sysContent/listByPage', NULL, '31', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('33', '新增', 'sysContent:add', NULL, 'sysContent/add', NULL, '31', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('34', '修改', 'sysContent:update', NULL, 'sysContent/update', NULL, '31', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('35', '删除', 'sysContent:delete', NULL, 'sysContent/delete', NULL, '31', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('36', '更新', 'sys:role:update', NULL, '/sys/role', NULL, '53', 0, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('38', '更新', 'sys:dept:update', NULL, '/sys/dept', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('39', '详情', 'sys:role:detail', NULL, '/sys/role/*', NULL, '53', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('4', '添加', 'sysGenerator:add', NULL, 'sysGenerator/add', NULL, '15', 1, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('40', '编辑', 'sys:permission:update', NULL, '/sys/permission', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('41', '部门管理', NULL, NULL, '/index/depts', '_self', '51', 100, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('42', '新增', 'sys:user:add', NULL, '/sys/user', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('43', '列表', 'sys:permission:list', NULL, '/sys/permissions', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('44', '新增', 'sys:permission:add', NULL, '/sys/permission', NULL, '11', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('45', '字典管理', NULL, '', '/index/sysDict', NULL, '54', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('46', '列表', 'sysDict:list', NULL, 'sysDict/listByPage', NULL, '45', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('47', '新增', 'sysDict:add', NULL, 'sysDict/add', NULL, '45', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('48', '修改', 'sysDict:update', NULL, 'sysDict/update', NULL, '45', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('49', '删除', 'sysDict:delete', NULL, 'sysDict/delete', NULL, '45', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('5', '删除', 'sys:dept:deleted', NULL, '/sys/dept/*', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('50', '表单构建', '', '', '/index/build', '_self', '21', 1, 2, 1, '2020-04-22 13:09:41', '2020-05-07 13:36:47', 1);
INSERT INTO `sys_permission` VALUES ('51', '组织管理', NULL, 'layui-icon-user', NULL, NULL, '0', 1, 1, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('52', '拥有角色', 'sys:user:role:detail', NULL, '/sys/user/roles/*', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('53', '角色管理', NULL, NULL, '/index/roles', '_self', '51', 99, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('54', '系统管理', NULL, 'layui-icon-set-fill', NULL, NULL, '0', 98, 1, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('55', '定时任务暂停', 'sysJob:pause', NULL, '/sysJob/pause', '_self', '59', 1, 3, 1, '2020-04-22 15:48:18', NULL, 1);
INSERT INTO `sys_permission` VALUES ('56', '更新', 'sys:user:update', NULL, '/sys/user', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('57', '删除', 'sys:user:deleted', NULL, '/sys/user', NULL, '24', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('58', '删除', 'sys:log:deleted', NULL, '/sys/logs', NULL, '8', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('59', '定时任务', NULL, NULL, '/index/sysJob', '_self', '54', 10, 2, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('6', '接口管理', '', '', '/doc.html', '_blank', '21', 100, 2, 1, '2020-03-19 13:29:40', '2020-05-07 13:36:02', 1);
INSERT INTO `sys_permission` VALUES ('60', '列表', 'sysJob:list', NULL, 'sysJob/listByPage', NULL, '59', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('61', '新增', 'sysJob:add', NULL, 'sysJob/add', NULL, '59', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('62', '修改', 'sysJob:update', NULL, 'sysJob/update', NULL, '59', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('63', '删除', 'sysJob:delete', NULL, 'sysJob/delete', NULL, '59', 0, 3, 1, NULL, NULL, 1);
INSERT INTO `sys_permission` VALUES ('7', '列表', 'sys:log:list', NULL, '/sys/logs', NULL, '8', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('8', '日志管理', NULL, NULL, '/index/logs', '_self', '54', 97, 2, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);
INSERT INTO `sys_permission` VALUES ('9', '新增', 'sys:dept:add', NULL, '/sys/dept', NULL, '41', 100, 3, 1, '2020-03-19 13:29:40', '2020-03-19 13:29:40', 1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `description` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态(1:正常0:弃用)',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` tinyint(4) NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  `data_scope` int(11) NULL DEFAULT NULL COMMENT '数据范围（1：所有 2：自定义 3： 本部门及以下部门 4：仅本部门 5:自己）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', '拥有所有权限-不能删除', 1, '2019-11-01 19:26:29', '2020-03-19 13:29:51', 1, NULL);
INSERT INTO `sys_role` VALUES ('1434030125132849153', '邓文杰', 'test', 1, '2021-09-04 13:46:39', '2021-09-04 13:46:39', 1, NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `dept_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色部门' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `permission_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('1', '1', '1', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('10', '1', '10', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('11', '1', '11', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('12', '1', '12', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('13', '1', '13', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('1311116066716430339', '1', '1311115974068449281', '2020-09-30 09:30:04');
INSERT INTO `sys_role_permission` VALUES ('14', '1', '14', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763714', '1434030125132849153', '51', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763715', '1434030125132849153', '11', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763716', '1434030125132849153', '17', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763717', '1434030125132849153', '26', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763718', '1434030125132849153', '40', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763719', '1434030125132849153', '43', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763720', '1434030125132849153', '44', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763721', '1434030125132849153', '53', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763722', '1434030125132849153', '36', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763723', '1434030125132849153', '3', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763724', '1434030125132849153', '19', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763725', '1434030125132849153', '1311115974068449281', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763726', '1434030125132849153', '13', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763727', '1434030125132849153', '39', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763728', '1434030125132849153', '24', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763729', '1434030125132849153', '10', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763730', '1434030125132849153', '23', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763731', '1434030125132849153', '52', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763732', '1434030125132849153', '25', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763733', '1434030125132849153', '56', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763734', '1434030125132849153', '57', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763735', '1434030125132849153', '42', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763736', '1434030125132849153', '41', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125195763737', '1434030125132849153', '12', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872577', '1434030125132849153', '22', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872578', '1434030125132849153', '5', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872579', '1434030125132849153', '38', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872580', '1434030125132849153', '9', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872581', '1434030125132849153', '54', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872582', '1434030125132849153', '15', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872583', '1434030125132849153', '4', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872584', '1434030125132849153', '1', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872585', '1434030125132849153', '16', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872586', '1434030125132849153', '20', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872587', '1434030125132849153', '27', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872588', '1434030125132849153', '29', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872589', '1434030125132849153', '30', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872590', '1434030125132849153', '28', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872591', '1434030125132849153', '45', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872592', '1434030125132849153', '49', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872593', '1434030125132849153', '48', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872594', '1434030125132849153', '47', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872595', '1434030125132849153', '46', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872596', '1434030125132849153', '59', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872597', '1434030125132849153', '60', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872598', '1434030125132849153', '61', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872599', '1434030125132849153', '62', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872600', '1434030125132849153', '63', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872601', '1434030125132849153', '55', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872602', '1434030125132849153', '18', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872603', '1434030125132849153', '14', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872604', '1434030125132849153', '31', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872605', '1434030125132849153', '32', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872606', '1434030125132849153', '33', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872607', '1434030125132849153', '34', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872608', '1434030125132849153', '35', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872609', '1434030125132849153', '8', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872610', '1434030125132849153', '58', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('1434030125262872611', '1434030125132849153', '7', '2021-09-04 13:46:40');
INSERT INTO `sys_role_permission` VALUES ('15', '1', '15', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('16', '1', '16', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('17', '1', '17', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('18', '1', '18', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('19', '1', '19', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('2', '1', '2', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('20', '1', '20', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('21', '1', '21', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('22', '1', '22', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('23', '1', '23', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('24', '1', '24', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('25', '1', '25', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('26', '1', '26', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('27', '1', '27', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('28', '1', '28', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('29', '1', '29', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('3', '1', '3', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('30', '1', '30', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('31', '1', '31', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('32', '1', '32', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('33', '1', '33', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('34', '1', '34', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('35', '1', '35', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('36', '1', '36', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('38', '1', '38', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('39', '1', '39', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('4', '1', '4', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('40', '1', '40', '2020-06-15 15:21:17');
INSERT INTO `sys_role_permission` VALUES ('41', '1', '41', '2020-06-15 15:21:17');
INSERT INTO `sys_role_permission` VALUES ('42', '1', '42', '2020-06-15 15:21:17');
INSERT INTO `sys_role_permission` VALUES ('43', '1', '43', '2020-06-15 15:21:17');
INSERT INTO `sys_role_permission` VALUES ('44', '1', '44', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('45', '1', '45', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('46', '1', '46', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('47', '1', '47', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('48', '1', '48', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('49', '1', '49', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('5', '1', '5', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('50', '1', '50', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('51', '1', '51', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('52', '1', '52', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('53', '1', '53', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('54', '1', '54', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('55', '1', '55', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('56', '1', '56', '2020-05-26 17:04:21');
INSERT INTO `sys_role_permission` VALUES ('57', '1', '57', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('58', '1', '58', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('59', '1', '59', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('6', '1', '6', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('60', '1', '60', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('61', '1', '61', '2020-05-26 14:21:56');
INSERT INTO `sys_role_permission` VALUES ('62', '1', '62', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('63', '1', '63', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('7', '1', '7', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('8', '1', '8', '2020-04-22 15:48:47');
INSERT INTO `sys_role_permission` VALUES ('9', '1', '9', '2020-04-22 15:48:47');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账户名称',
  `salt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密盐值',
  `password` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码密文',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `dept_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `real_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实名称',
  `nick_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱(唯一)',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '账户状态(1.正常 2.锁定 )',
  `sex` tinyint(4) NULL DEFAULT NULL COMMENT '性别(1.男 2.女)',
  `deleted` tinyint(4) NULL DEFAULT NULL COMMENT '是否删除(1未删除；0已删除)',
  `create_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_where` tinyint(4) NULL DEFAULT NULL COMMENT '创建来源(1.web 2.android 3.ios )',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '324ce32d86224b00a02b', '2102b59a75ab87616b62d0b9432569d0', '13888888888', '1', 'yyds', '爱糖宝', 'xxxxxx@163.com', 1, 2, 1, '1', '1', 3, '2019-09-22 19:38:05', '2021-09-04 13:38:13');
INSERT INTO `sys_user` VALUES ('1434028356206108674', 'Test', 'f53650d9651a4402a349', '1e9a31023e5e263d24edd303256574db', '21321313', '1', NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, 1, '2021-09-04 13:39:38', '2021-09-04 13:39:38');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1', '1', '2020-03-19 02:23:13');
INSERT INTO `sys_user_role` VALUES ('1434030601052135426', '1434028356206108674', '1434030125132849153', '2021-09-04 13:48:33');

SET FOREIGN_KEY_CHECKS = 1;
