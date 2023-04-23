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
CREATE DATABASE /*!32312 IF NOT EXISTS*/`examdb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `examdb`;

/*Table structure for table `tbl_cand` */

DROP TABLE IF EXISTS `tbl_cand`;

CREATE TABLE `tbl_cand` (
  `cand_id` int NOT NULL AUTO_INCREMENT COMMENT '考生ID',
  `tenant_id` int NOT NULL COMMENT '租户ID',
  `exam_id` int NOT NULL COMMENT '考试ID',
  `paper_id` int NOT NULL COMMENT '试卷ID',
  `cand_name` varchar(50) NOT NULL DEFAULT '' COMMENT '考生姓名',
  `cand_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '考生编号',
  `cand_idcard` varchar(50) NOT NULL DEFAULT '' COMMENT '考生身份证',
  `cand_mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '考生手机',
  `cand_email` varchar(100) NOT NULL DEFAULT '' COMMENT '考生邮箱',
  `cand_dept` varchar(50) NOT NULL DEFAULT '' COMMENT '考生单位',
  `cand_photo` varchar(200) NOT NULL DEFAULT '' COMMENT '考生照片',
  `cand_memo` varchar(500) NOT NULL DEFAULT '' COMMENT '考生备注',
  `test_code` char(6) NOT NULL DEFAULT '' COMMENT '考试密码',
  `account_from` varchar(50) NOT NULL DEFAULT '' COMMENT '第三方来源',
  `account_id` varchar(50) NOT NULL DEFAULT '' COMMENT '第三方ID',
  `cand_status` varchar(10) NOT NULL DEFAULT '' COMMENT '考生状态：init 创建，login 登录，photo 拍照，compare 比对，finish 交卷',
  `cand_login_time` varchar(20) NOT NULL DEFAULT '' COMMENT '考生登录时间',
  `cand_finish_time` varchar(20) NOT NULL DEFAULT '' COMMENT '考生交卷时间',
  `cand_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '考生IP',
  `cand_env` varchar(200) NOT NULL DEFAULT '' COMMENT '考生客户端环境',
  `cand_score` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '考生试卷得分',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0  COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`cand_id`),
  KEY `idx_paper_id` (`paper_id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_login_1` (`cand_id`,`test_code`),
  KEY `idx_login_2` (`cand_idcard`,`exam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10001001 DEFAULT CHARSET=utf8mb3 COMMENT='考生表';

/*Table structure for table `tbl_cand_answer` */

DROP TABLE IF EXISTS `tbl_cand_answer`;

CREATE TABLE `tbl_cand_answer` (
  `cand_id` int NOT NULL COMMENT '考生ID',
  `question_id` int NOT NULL COMMENT '试题ID',
  `fact_answer` varchar(200) NOT NULL DEFAULT '' COMMENT '考生答案',
  `fact_score` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '考生得分',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`cand_id`,`question_id`),
  KEY `idx_answer` (`cand_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='考生作答试题';

/*Table structure for table `tbl_cand_log` */

DROP TABLE IF EXISTS `tbl_cand_log`;

CREATE TABLE `tbl_cand_log` (
  `log_id` int NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `tenant_id` int NOT NULL COMMENT '租户ID',
  `log_type` varchar(50) NOT NULL DEFAULT '' COMMENT '日志类型',
  `log_time` varchar(20) NOT NULL DEFAULT '' COMMENT '日志时间',
  `log_operator` int NOT NULL DEFAULT '0' COMMENT '日志操作者ID',
  `log_object` int NOT NULL DEFAULT '0' COMMENT '日志操作对象ID',
  `log_desc` varchar(100) NOT NULL DEFAULT '' COMMENT '日志描述',
  `log_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '日志IP',
  `log_env` varchar(200) NOT NULL DEFAULT '' COMMENT '日志客户端环境',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`log_id`),
  KEY `idx_cand` (`log_operator`)
) ENGINE=InnoDB AUTO_INCREMENT=1000010001 DEFAULT CHARSET=utf8mb3 COMMENT='考生作答日志';

/*Table structure for table `tbl_cand_section` */

DROP TABLE IF EXISTS `tbl_cand_section`;

CREATE TABLE `tbl_cand_section` (
  `cand_id` int NOT NULL COMMENT '考生ID',
  `section_id` int NOT NULL COMMENT '单元ID',
  `section_score` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '考生单元得分',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`cand_id`,`section_id`),
  KEY `idx_cand` (`cand_id`,`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='考生作答单元';

/*Table structure for table `tbl_category` */

DROP TABLE IF EXISTS `tbl_category`;

CREATE TABLE `tbl_category` (
  `category_id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parent_id` int NOT NULL COMMENT '分类父ID',
  `tenant_id` int NOT NULL COMMENT '租户ID',
  `category_name` varchar(100) NOT NULL DEFAULT '' COMMENT '分类名称',
  `category_order` int NOT NULL DEFAULT '0' COMMENT '分类排序号',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`category_id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb3 COMMENT='分类表';

/*Table structure for table `tbl_exam` */

DROP TABLE IF EXISTS `tbl_exam`;

CREATE TABLE `tbl_exam` (
  `exam_id` int NOT NULL AUTO_INCREMENT COMMENT '考试ID',
  `tenant_id` int NOT NULL COMMENT '租户ID',
  `exam_name` varchar(200) NOT NULL DEFAULT '' COMMENT '考试名称',
  `exam_start_time` timestamp NOT NULL COMMENT '考试开始时间',
  `exam_end_time` timestamp NOT NULL COMMENT '考试结束时间',
  `exam_notice` text NOT NULL COMMENT '考试须知',
  `exam_set_device` json NOT NULL COMMENT '设置-作答设备',
  `exam_set_login` json NOT NULL COMMENT '设置-登录方式',
  `exam_set_mode` json NOT NULL COMMENT '设置-开考模式',
  `exam_set_time` json NOT NULL COMMENT '设置-时间限定',
  `exam_set_security` json NOT NULL COMMENT '设置-安全要求',
  `exam_set_custom` json NOT NULL COMMENT '设置-界面定制',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0  COMMENT '删除状态：0 否；1 是；',  
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`exam_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb3 COMMENT='考试表';

/*Table structure for table `tbl_exam_paper` */

DROP TABLE IF EXISTS `tbl_exam_paper`;

CREATE TABLE `tbl_exam_paper` (
  `exam_id` int NOT NULL COMMENT '考试ID',
  `paper_id` int NOT NULL COMMENT '试卷ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`exam_id`,`paper_id`),
  KEY `idx_main` (`exam_id`,`paper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='考试试卷关联表';

/*Table structure for table `tbl_log` */

DROP TABLE IF EXISTS `tbl_log`;

CREATE TABLE `tbl_log` (
  `log_id` int NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `tenant_id` int NOT NULL COMMENT '租户ID',
  `log_type` varchar(50) NOT NULL DEFAULT '' COMMENT '日志类型',
  `log_time` varchar(20) NOT NULL DEFAULT '' COMMENT '日志时间',
  `log_operator` int NOT NULL DEFAULT '0' COMMENT '日志操作者ID',
  `log_object` int NOT NULL DEFAULT '0' COMMENT '日志操作对象ID',
  `log_desc` varchar(100) NOT NULL DEFAULT '' COMMENT '日志描述',
  `log_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '日志IP',
  `log_env` varchar(200) NOT NULL DEFAULT '' COMMENT '日志客户端环境',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`log_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000010001 DEFAULT CHARSET=utf8mb3 COMMENT='日志表';

/*Table structure for table `tbl_paper` */

DROP TABLE IF EXISTS `tbl_paper`;

CREATE TABLE `tbl_paper` (
  `paper_id` int NOT NULL AUTO_INCREMENT COMMENT '试卷ID',
  `tenant_id` int NOT NULL COMMENT '租户ID',
  `paper_name` varchar(200) NOT NULL DEFAULT '' COMMENT '试卷名称',
  `paper_duration` int NOT NULL DEFAULT '0' COMMENT '试卷时长（分钟）',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0  COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`paper_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb3 COMMENT='试卷表';

/*Table structure for table `tbl_question` */

DROP TABLE IF EXISTS `tbl_question`;

CREATE TABLE `tbl_question` (
  `question_id` int NOT NULL AUTO_INCREMENT COMMENT '试题ID',
  `tenant_id` int NOT NULL COMMENT '租户ID',
  `category_id` int NOT NULL COMMENT '分类ID',
  `question_type` char(1) NOT NULL DEFAULT 'S' COMMENT '类型',
  `question_body` text NOT NULL COMMENT '题干',
  `question_choice_a` varchar(500) NOT NULL DEFAULT '' COMMENT '选项A',
  `question_choice_b` varchar(500) NOT NULL DEFAULT '' COMMENT '选项B',
  `question_choice_c` varchar(500) NOT NULL DEFAULT '' COMMENT '选项C',
  `question_choice_d` varchar(500) NOT NULL DEFAULT '' COMMENT '选项D',
  `question_choice_e` varchar(500) NOT NULL DEFAULT '' COMMENT '选项E',
  `question_choice_f` varchar(500) NOT NULL DEFAULT '' COMMENT '选项F',
  `question_choice_g` varchar(500) NOT NULL DEFAULT '' COMMENT '选项G',
  `question_choice_h` varchar(500) NOT NULL DEFAULT '' COMMENT '选项H',
  `question_choice_i` varchar(500) NOT NULL DEFAULT '' COMMENT '选项I',
  `question_answer` varchar(500) NOT NULL DEFAULT '' COMMENT '答案',
  `question_analysis` varchar(500) NOT NULL DEFAULT '' COMMENT '答案解析',
  `question_score` decimal(5,2) NOT NULL DEFAULT '1.00' COMMENT '分值',
  `question_memo` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0  COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`question_id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000001 DEFAULT CHARSET=utf8mb3 COMMENT='试题表';

/*Table structure for table `tbl_section` */

DROP TABLE IF EXISTS `tbl_section`;

CREATE TABLE `tbl_section` (
  `section_id` int NOT NULL AUTO_INCREMENT COMMENT '单元ID',
  `tenant_id` int NOT NULL COMMENT '租户ID',
  `paper_id` int NOT NULL COMMENT '试卷ID',
  `section_name` varchar(100) NOT NULL DEFAULT '' COMMENT '单元名称',
  `section_order` int NOT NULL DEFAULT '0' COMMENT '单元排序',
  `section_random` int NOT NULL DEFAULT '0' COMMENT '单元乱序',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0  COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`section_id`),
  KEY `idx_paper_id` (`paper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb3 COMMENT='单元表';

/*Table structure for table `tbl_section_question` */

DROP TABLE IF EXISTS `tbl_section_question`;

CREATE TABLE `tbl_section_question` (
  `section_id` int NOT NULL COMMENT '单元ID',
  `question_id` int NOT NULL COMMENT '试题ID',
  `question_score` decimal(5,2) NOT NULL DEFAULT '1.00' COMMENT '试题分值',
  `question_order` int NOT NULL DEFAULT '0' COMMENT '试题排序号',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`section_id`,`question_id`),
  KEY `idx_main` (`section_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='单元试题关联表';

/*Table structure for table `tbl_tenant` */

DROP TABLE IF EXISTS `tbl_tenant`;

CREATE TABLE `tbl_tenant` (
  `tenant_id` int NOT NULL AUTO_INCREMENT COMMENT '租户ID',
  `tenant_name` varchar(100) NOT NULL DEFAULT '' COMMENT '租户名称',
  `tenant_mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户手机',
  `tenant_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '租户邮箱',
  `login_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录帐号',
  `login_password` varchar(100) NOT NULL DEFAULT '' COMMENT '登录密码',
  `login_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最近登录时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0  COMMENT '删除状态：0 否；1 是；',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb3 COMMENT='租户表';

CREATE TABLE `tbl_rysnc_task` (
  `rysnc_task_id` int NOT NULL AUTO_INCREMENT COMMENT '同步ID',
  `exam_id` int NOT NULL COMMENT '考试ID',
  `remote_exam_id` int NOT NULL COMMENT '远程考试ID',
  `rysnc_status` varchar(10) NOT NULL DEFAULT '' COMMENT '同步状态：init 创建；exam 考试完成；paper 试卷完成；section 单元完成；question 试题完成；cand 考生完成；finish 完成；',
  `rysnc_secret` varchar(100) NOT NULL DEFAULT '' COMMENT '推送密钥',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`rysnc_task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb3 COMMENT='同步任务表';





/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
