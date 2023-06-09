/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.28 : Database - examdb
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET SESSION sql_mode='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

/*Table structure for table `tbl_cand` */

DROP TABLE IF EXISTS `tbl_cand`;

CREATE TABLE `tbl_cand` (
  `cand_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '考生ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `exam_id` int(11) NOT NULL COMMENT '考试ID',
  `paper_id` int(11) NOT NULL COMMENT '试卷ID',
  `cand_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生姓名',
  `cand_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生编号',
  `cand_idcard` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生身份证',
  `cand_mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生手机',
  `cand_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生邮箱',
  `cand_dept` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生单位',
  `cand_photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生照片',
  `cand_memo` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生备注',
  `test_code` char(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考试密码',
  `cand_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生状态：init 创建，login 登录，photo 拍照，compare 比对，finish 交卷',
  `cand_login_time` char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生登录时间',
  `cand_finish_time` char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生交卷时间',
  `cand_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生IP',
  `cand_province` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生登录IP所在省',
  `cand_city` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生登录IP所在市',
  `cand_env` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生客户端环境',
  `cand_score` decimal(5, 2) NOT NULL DEFAULT 0.00 COMMENT '考生试卷得分',
  `cand_delay` json NULL COMMENT '考生延时信息',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`cand_id`) USING BTREE,
  INDEX `idx_paper_id`(`exam_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `idx_login_1`(`cand_id`, `test_code`) USING BTREE,
  INDEX `idx_login_2`(`cand_idcard`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10001001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '考生表' ROW_FORMAT = Dynamic;

/*Table structure for table `tbl_cand_answer` */

DROP TABLE IF EXISTS `tbl_cand_answer`;

CREATE TABLE `tbl_cand_answer` (
  `cand_id` int(11) NOT NULL COMMENT '考生ID',
  `question_id` int(11) NOT NULL COMMENT '试题ID',
  `fact_answer` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生答案',
  `fact_score` decimal(5, 2) NOT NULL DEFAULT 0.00 COMMENT '考生得分',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`cand_id`, `question_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '考生作答试题' ROW_FORMAT = Dynamic;

/*Table structure for table `tbl_cand_log` */

DROP TABLE IF EXISTS `tbl_cand_log`;

CREATE TABLE `tbl_cand_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `exam_id` int(11) NOT NULL COMMENT '考试ID',
  `cand_id` int(11) NOT NULL COMMENT '考生ID',
  `log_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志类型',
  `log_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '日志时间',
  `log_operator` int(11) NOT NULL DEFAULT 0 COMMENT '日志操作者ID',
  `log_desc` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志描述',
  `log_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志IP',
  `log_env` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志客户端环境',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `idx_cand`(`log_operator`) USING BTREE,
  INDEX `idx_exam_cand`(`exam_id`,`cand_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000010001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '考生作答日志' ROW_FORMAT = Dynamic;

/*Table structure for table `tbl_cand_section` */

DROP TABLE IF EXISTS `tbl_cand_section`;

CREATE TABLE `tbl_cand_section` (
  `cand_id` int(11) NOT NULL COMMENT '考生ID',
  `section_id` int(11) NOT NULL COMMENT '单元ID',
  `section_score` decimal(5, 2) NOT NULL DEFAULT 0.00 COMMENT '考生单元得分',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`cand_id`, `section_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '考生作答单元' ROW_FORMAT = Dynamic;

/*Table structure for table `tbl_category` */

DROP TABLE IF EXISTS `tbl_category`;

CREATE TABLE `tbl_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '分类父ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `category_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类类型：question cand',
  `category_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `category_order` int(11) NOT NULL DEFAULT 0 COMMENT '分类排序号',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

/*Table structure for table `tbl_exam` */

DROP TABLE IF EXISTS `tbl_exam`;

CREATE TABLE `tbl_exam` (
  `exam_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '考试ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `exam_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考试名称',
  `exam_start_time` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '考试开始时间',
  `exam_end_time` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '考试结束时间',
  `exam_notice` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '考试须知',
  `exam_set_device` json NOT NULL COMMENT '设置-作答设备',
  `exam_set_login` json NOT NULL COMMENT '设置-登录方式',
  `exam_set_mode` json NOT NULL COMMENT '设置-开考模式',
  `exam_set_time` json NOT NULL COMMENT '设置-时间限定',
  `exam_set_security` json NOT NULL COMMENT '设置-安全要求',
  `exam_set_custom` json NOT NULL COMMENT '设置-界面定制',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`exam_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '考试表' ROW_FORMAT = Dynamic;

/*Table structure for table `tbl_exam_paper` */

DROP TABLE IF EXISTS `tbl_exam_paper`;

CREATE TABLE `tbl_exam_paper`  (
  `exam_id` int(11) NOT NULL COMMENT '考试ID',
  `paper_id` int(11) NOT NULL COMMENT '试卷ID',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`exam_id`, `paper_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '考试试卷关联表' ROW_FORMAT = Dynamic;

/*Table structure for table `tbl_log` */

DROP TABLE IF EXISTS `tbl_log`;

CREATE TABLE `tbl_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `log_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志类型',
  `log_operator` int(11) NOT NULL DEFAULT 0 COMMENT '日志操作者ID',
  `log_object` int(11) NOT NULL DEFAULT 0 COMMENT '日志操作对象ID',
  `log_desc` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志描述',
  `log_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志IP',
  `log_env` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志客户端环境',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000010001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志表' ROW_FORMAT = Dynamic;

/*Table structure for table `tbl_paper` */

DROP TABLE IF EXISTS `tbl_paper`;
CREATE TABLE `tbl_paper`  (
  `paper_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '试卷ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `paper_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '试卷名称',
  `paper_duration` int(11) NOT NULL DEFAULT 0 COMMENT '试卷时长（分钟）',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`paper_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '试卷表' ROW_FORMAT = Dynamic;

/*Table structure for table `tbl_question` */

-- ----------------------------
-- Table structure for tbl_question
-- ----------------------------
DROP TABLE IF EXISTS `tbl_question`;
CREATE TABLE `tbl_question`  (
  `question_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '试题ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `category_id` int(11) NOT NULL COMMENT '分类ID',
  `question_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'S' COMMENT '类型',
  `question_body` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '题干',
  `question_choice_a` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '选项A',
  `question_choice_b` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '选项B',
  `question_choice_c` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '选项C',
  `question_choice_d` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '选项D',
  `question_choice_e` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '选项E',
  `question_choice_f` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '选项F',
  `question_choice_g` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '选项G',
  `question_choice_h` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '选项H',
  `question_choice_i` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '选项I',
  `question_answer` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '答案',
  `question_analysis` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '答案解析',
  `question_score` decimal(5, 2) NOT NULL DEFAULT 1.00 COMMENT '分值',
  `question_memo` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`question_id`) USING BTREE,
  INDEX `idx_category_id`(`category_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '试题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_section
-- ----------------------------
DROP TABLE IF EXISTS `tbl_section`;
CREATE TABLE `tbl_section`  (
  `section_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '单元ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `paper_id` int(11) NOT NULL COMMENT '试卷ID',
  `section_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '单元名称',
  `section_order` int(11) NOT NULL DEFAULT 0 COMMENT '单元排序',
  `section_random` int(11) NOT NULL DEFAULT 0 COMMENT '单元乱序',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`section_id`) USING BTREE,
  INDEX `idx_paper_id`(`paper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单元表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_section_question
-- ----------------------------
DROP TABLE IF EXISTS `tbl_section_question`;
CREATE TABLE `tbl_section_question`  (
  `section_id` int(11) NOT NULL COMMENT '单元ID',
  `paper_id` int(11) NOT NULL COMMENT '试卷ID',
  `question_id` int(11) NOT NULL COMMENT '试题ID',
  `question_score` decimal(5, 2) NOT NULL DEFAULT 1.00 COMMENT '试题分值',
  `question_order` int(11) NOT NULL DEFAULT 0 COMMENT '试题排序号',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  INDEX `idx_paper`(`paper_id`) USING BTREE,
  UNIQUE INDEX `idx_section_question`(`section_id`, `question_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单元试题关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_task_rysnc
-- ----------------------------
DROP TABLE IF EXISTS `tbl_task_rysnc`;
CREATE TABLE `tbl_task_rysnc`  (
  `task_rysnc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '同步ID',
  `tenant_id` int(11) NOT NULL COMMENT '租户ID',
  `exam_id` int(11) NOT NULL COMMENT '考试ID',
  `remote_exam_id` int(11) NOT NULL COMMENT '远程考试ID',
  `rysnc_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '同步状态：init 创建；exam 考试完成；paper 试卷完成；section 单元完成；question 试题完成；cand 考生完成；finish 完成；',
  `rysnc_secret` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '推送密钥',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`task_rysnc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '同步任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_tenant
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tenant`;
CREATE TABLE `tbl_tenant`  (
  `tenant_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '租户ID',
  `tenant_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户名称',
  `tenant_mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户手机',
  `tenant_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户邮箱',
  `login_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录帐号',
  `login_password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `login_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最近登录时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`tenant_id`) USING BTREE,
  UNIQUE INDEX `login_name`(`login_name`) USING BTREE,
  UNIQUE INDEX `tenant_name`(`tenant_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '租户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_tenant
-- ----------------------------
INSERT INTO `tbl_tenant` VALUES (1, 'tanantname', '13811334455', '111@qq.com', 'username', '173e794615af94a9a747899a53e1e64b', '2023-05-10 14:34:28', 0, '2023-05-10 14:34:28', '2023-05-10 15:30:45');
INSERT INTO `tbl_tenant` VALUES (5, '企业1', '', '', 'admin1', 'admin123', '2023-05-15 13:19:59', 0, '2023-05-15 13:19:59', '2023-05-15 13:19:59');

SET FOREIGN_KEY_CHECKS = 1;
