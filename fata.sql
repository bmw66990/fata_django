/*
 Navicat MySQL Data Transfer

 Source Server         : leakage
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : 39.98.231.163:3306
 Source Schema         : leakage

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 15/10/2020 17:52:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts_consumer
-- ----------------------------
DROP TABLE IF EXISTS `accounts_consumer`;
CREATE TABLE `accounts_consumer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `open_code` varchar(128) NOT NULL,
  `category` varchar(32) NOT NULL,
  `name` varchar(128) NOT NULL,
  `mobile` varchar(128) DEFAULT NULL,
  `sex` varchar(32) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `avator` varchar(128) DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `read_fault` longtext,
  `dept_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `open_code` (`open_code`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE,
  KEY `accounts_consumer_dept_id_508b86c3_fk_accounts_deportment_id` (`dept_id`) USING BTREE,
  CONSTRAINT `accounts_consumer_dept_id_508b86c3_fk_accounts_deportment_id` FOREIGN KEY (`dept_id`) REFERENCES `accounts_deportment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of accounts_consumer
-- ----------------------------
BEGIN;
INSERT INTO `accounts_consumer` VALUES (1, 'pbkdf2_sha256$180000$BA70AkogDNft$OgD7TaNUgWdb6SWpKI1e/eD3DdRWaEMlUOF9+sGXRV0=', '2020-09-29 10:22:50.124979', 1, 'admin', 'maintain', '', '', 'other', NULL, NULL, 0, 1, 1, 1, 1, '2020-09-24 07:57:22.850947', '[]', NULL);
INSERT INTO `accounts_consumer` VALUES (3, 'pbkdf2_sha256$180000$1fH7mmy3k5UP$7IIYeOf9rKTkPk2NbH4qIAAz8a6YKvaBxWZdmSrRXhc=', NULL, 0, 'harden', 'mangage', '科技公司', '13209382094', 'male', 'admin@roota.cn', NULL, 0, 1, 1, 0, 0, '2020-09-25 08:53:50.611009', '[]', NULL);
COMMIT;

-- ----------------------------
-- Table structure for accounts_consumer_groups
-- ----------------------------
DROP TABLE IF EXISTS `accounts_consumer_groups`;
CREATE TABLE `accounts_consumer_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `accounts_consumer_groups_consumer_id_group_id_ce1a7b0d_uniq` (`consumer_id`,`group_id`) USING BTREE,
  KEY `accounts_consumer_groups_group_id_22e61cfd_fk_auth_group_id` (`group_id`) USING BTREE,
  CONSTRAINT `accounts_consumer_gr_consumer_id_d4cca56a_fk_accounts_` FOREIGN KEY (`consumer_id`) REFERENCES `accounts_consumer` (`id`),
  CONSTRAINT `accounts_consumer_groups_group_id_22e61cfd_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for accounts_consumer_role
-- ----------------------------
DROP TABLE IF EXISTS `accounts_consumer_role`;
CREATE TABLE `accounts_consumer_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `accounts_consumer_role_consumer_id_role_id_1001fcc9_uniq` (`consumer_id`,`role_id`) USING BTREE,
  KEY `accounts_consumer_role_role_id_6ccd89ef_fk_accounts_role_id` (`role_id`) USING BTREE,
  CONSTRAINT `accounts_consumer_ro_consumer_id_ddd409b2_fk_accounts_` FOREIGN KEY (`consumer_id`) REFERENCES `accounts_consumer` (`id`),
  CONSTRAINT `accounts_consumer_role_role_id_6ccd89ef_fk_accounts_role_id` FOREIGN KEY (`role_id`) REFERENCES `accounts_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for accounts_consumer_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `accounts_consumer_user_permissions`;
CREATE TABLE `accounts_consumer_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `accounts_consumer_user_p_consumer_id_permission_i_1a70c777_uniq` (`consumer_id`,`permission_id`) USING BTREE,
  KEY `accounts_consumer_us_permission_id_5be7ad3c_fk_auth_perm` (`permission_id`) USING BTREE,
  CONSTRAINT `accounts_consumer_us_consumer_id_059cae62_fk_accounts_` FOREIGN KEY (`consumer_id`) REFERENCES `accounts_consumer` (`id`),
  CONSTRAINT `accounts_consumer_us_permission_id_5be7ad3c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for accounts_deportment
-- ----------------------------
DROP TABLE IF EXISTS `accounts_deportment`;
CREATE TABLE `accounts_deportment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `organization_type` varchar(18) DEFAULT NULL,
  `belong_dept_id` int(11) DEFAULT NULL,
  `create_by_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `update_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `accounts_deportment_belong_dept_id_1ced3673_fk_accounts_` (`belong_dept_id`) USING BTREE,
  KEY `accounts_deportment_create_by_id_31acd391_fk_accounts_` (`create_by_id`) USING BTREE,
  KEY `accounts_deportment_parent_id_10a77896_fk_accounts_deportment_id` (`parent_id`) USING BTREE,
  KEY `accounts_deportment_update_by_id_3808973a_fk_accounts_` (`update_by_id`) USING BTREE,
  CONSTRAINT `accounts_deportment_belong_dept_id_1ced3673_fk_accounts_` FOREIGN KEY (`belong_dept_id`) REFERENCES `accounts_deportment` (`id`),
  CONSTRAINT `accounts_deportment_create_by_id_31acd391_fk_accounts_` FOREIGN KEY (`create_by_id`) REFERENCES `accounts_consumer` (`id`),
  CONSTRAINT `accounts_deportment_parent_id_10a77896_fk_accounts_deportment_id` FOREIGN KEY (`parent_id`) REFERENCES `accounts_deportment` (`id`),
  CONSTRAINT `accounts_deportment_update_by_id_3808973a_fk_accounts_` FOREIGN KEY (`update_by_id`) REFERENCES `accounts_consumer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for accounts_role
-- ----------------------------
DROP TABLE IF EXISTS `accounts_role`;
CREATE TABLE `accounts_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `intro` varchar(255) DEFAULT NULL,
  `datas` varchar(50) NOT NULL,
  `role_permission_list` varchar(1024) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `depts_id` int(11) DEFAULT NULL,
  `modifier_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `code` (`code`) USING BTREE,
  KEY `accounts_role_creator_id_ed77f2e0_fk_accounts_consumer_id` (`creator_id`) USING BTREE,
  KEY `accounts_role_depts_id_44731d2f_fk_accounts_deportment_id` (`depts_id`) USING BTREE,
  KEY `accounts_role_modifier_id_c809e55c_fk_accounts_consumer_id` (`modifier_id`) USING BTREE,
  KEY `accounts_role_parent_id_526243b4_fk_accounts_role_id` (`parent_id`) USING BTREE,
  CONSTRAINT `accounts_role_creator_id_ed77f2e0_fk_accounts_consumer_id` FOREIGN KEY (`creator_id`) REFERENCES `accounts_consumer` (`id`),
  CONSTRAINT `accounts_role_depts_id_44731d2f_fk_accounts_deportment_id` FOREIGN KEY (`depts_id`) REFERENCES `accounts_deportment` (`id`),
  CONSTRAINT `accounts_role_modifier_id_c809e55c_fk_accounts_consumer_id` FOREIGN KEY (`modifier_id`) REFERENCES `accounts_consumer` (`id`),
  CONSTRAINT `accounts_role_parent_id_526243b4_fk_accounts_role_id` FOREIGN KEY (`parent_id`) REFERENCES `accounts_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for accounts_rolebutton
-- ----------------------------
DROP TABLE IF EXISTS `accounts_rolebutton`;
CREATE TABLE `accounts_rolebutton` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `code` varchar(32) DEFAULT NULL,
  `describe` varchar(256) DEFAULT NULL,
  `belong_menu` varchar(18) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for accounts_rolebutton_role
-- ----------------------------
DROP TABLE IF EXISTS `accounts_rolebutton_role`;
CREATE TABLE `accounts_rolebutton_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolebutton_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `accounts_rolebutton_role_rolebutton_id_role_id_89f706da_uniq` (`rolebutton_id`,`role_id`) USING BTREE,
  KEY `accounts_rolebutton_role_role_id_6a4c5176_fk_accounts_role_id` (`role_id`) USING BTREE,
  CONSTRAINT `accounts_rolebutton__rolebutton_id_f82633e5_fk_accounts_` FOREIGN KEY (`rolebutton_id`) REFERENCES `accounts_rolebutton` (`id`),
  CONSTRAINT `accounts_rolebutton_role_role_id_6a4c5176_fk_accounts_role_id` FOREIGN KEY (`role_id`) REFERENCES `accounts_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for accounts_rolemenu
-- ----------------------------
DROP TABLE IF EXISTS `accounts_rolemenu`;
CREATE TABLE `accounts_rolemenu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`) USING BTREE,
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add Token', 6, 'add_token');
INSERT INTO `auth_permission` VALUES (22, 'Can change Token', 6, 'change_token');
INSERT INTO `auth_permission` VALUES (23, 'Can delete Token', 6, 'delete_token');
INSERT INTO `auth_permission` VALUES (24, 'Can view Token', 6, 'view_token');
INSERT INTO `auth_permission` VALUES (25, 'Can add consumer', 7, 'add_consumer');
INSERT INTO `auth_permission` VALUES (26, 'Can change consumer', 7, 'change_consumer');
INSERT INTO `auth_permission` VALUES (27, 'Can delete consumer', 7, 'delete_consumer');
INSERT INTO `auth_permission` VALUES (28, 'Can view consumer', 7, 'view_consumer');
INSERT INTO `auth_permission` VALUES (29, 'Can add 用户组织表', 8, 'add_deportment');
INSERT INTO `auth_permission` VALUES (30, 'Can change 用户组织表', 8, 'change_deportment');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 用户组织表', 8, 'delete_deportment');
INSERT INTO `auth_permission` VALUES (32, 'Can view 用户组织表', 8, 'view_deportment');
INSERT INTO `auth_permission` VALUES (33, 'Can add role', 9, 'add_role');
INSERT INTO `auth_permission` VALUES (34, 'Can change role', 9, 'change_role');
INSERT INTO `auth_permission` VALUES (35, 'Can delete role', 9, 'delete_role');
INSERT INTO `auth_permission` VALUES (36, 'Can view role', 9, 'view_role');
INSERT INTO `auth_permission` VALUES (37, 'Can add 角色菜单表', 10, 'add_rolemenu');
INSERT INTO `auth_permission` VALUES (38, 'Can change 角色菜单表', 10, 'change_rolemenu');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 角色菜单表', 10, 'delete_rolemenu');
INSERT INTO `auth_permission` VALUES (40, 'Can view 角色菜单表', 10, 'view_rolemenu');
INSERT INTO `auth_permission` VALUES (41, 'Can add wechat user', 11, 'add_wechatuser');
INSERT INTO `auth_permission` VALUES (42, 'Can change wechat user', 11, 'change_wechatuser');
INSERT INTO `auth_permission` VALUES (43, 'Can delete wechat user', 11, 'delete_wechatuser');
INSERT INTO `auth_permission` VALUES (44, 'Can view wechat user', 11, 'view_wechatuser');
INSERT INTO `auth_permission` VALUES (45, 'Can add 角色按钮表', 12, 'add_rolebutton');
INSERT INTO `auth_permission` VALUES (46, 'Can change 角色按钮表', 12, 'change_rolebutton');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 角色按钮表', 12, 'delete_rolebutton');
INSERT INTO `auth_permission` VALUES (48, 'Can view 角色按钮表', 12, 'view_rolebutton');
INSERT INTO `auth_permission` VALUES (49, 'Can add 工单管理', 13, 'add_operational');
INSERT INTO `auth_permission` VALUES (50, 'Can change 工单管理', 13, 'change_operational');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 工单管理', 13, 'delete_operational');
INSERT INTO `auth_permission` VALUES (52, 'Can view 工单管理', 13, 'view_operational');
INSERT INTO `auth_permission` VALUES (53, 'Can add 新闻', 14, 'add_news');
INSERT INTO `auth_permission` VALUES (54, 'Can change 新闻', 14, 'change_news');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 新闻', 14, 'delete_news');
INSERT INTO `auth_permission` VALUES (56, 'Can view 新闻', 14, 'view_news');
INSERT INTO `auth_permission` VALUES (57, 'Can add 电压测量记录', 15, 'add_voltage');
INSERT INTO `auth_permission` VALUES (58, 'Can change 电压测量记录', 15, 'change_voltage');
INSERT INTO `auth_permission` VALUES (59, 'Can delete 电压测量记录', 15, 'delete_voltage');
INSERT INTO `auth_permission` VALUES (60, 'Can view 电压测量记录', 15, 'view_voltage');
INSERT INTO `auth_permission` VALUES (61, 'Can add 传感器设备', 16, 'add_sensor');
INSERT INTO `auth_permission` VALUES (62, 'Can change 传感器设备', 16, 'change_sensor');
INSERT INTO `auth_permission` VALUES (63, 'Can delete 传感器设备', 16, 'delete_sensor');
INSERT INTO `auth_permission` VALUES (64, 'Can view 传感器设备', 16, 'view_sensor');
INSERT INTO `auth_permission` VALUES (65, 'Can add 告警信息记录', 17, 'add_warninfo');
INSERT INTO `auth_permission` VALUES (66, 'Can change 告警信息记录', 17, 'change_warninfo');
INSERT INTO `auth_permission` VALUES (67, 'Can delete 告警信息记录', 17, 'delete_warninfo');
INSERT INTO `auth_permission` VALUES (68, 'Can view 告警信息记录', 17, 'view_warninfo');
INSERT INTO `auth_permission` VALUES (69, 'Can add 生产厂家基本信息', 18, 'add_manufactor');
INSERT INTO `auth_permission` VALUES (70, 'Can change 生产厂家基本信息', 18, 'change_manufactor');
INSERT INTO `auth_permission` VALUES (71, 'Can delete 生产厂家基本信息', 18, 'delete_manufactor');
INSERT INTO `auth_permission` VALUES (72, 'Can view 生产厂家基本信息', 18, 'view_manufactor');
INSERT INTO `auth_permission` VALUES (73, 'Can add application', 19, 'add_application');
INSERT INTO `auth_permission` VALUES (74, 'Can change application', 19, 'change_application');
INSERT INTO `auth_permission` VALUES (75, 'Can delete application', 19, 'delete_application');
INSERT INTO `auth_permission` VALUES (76, 'Can view application', 19, 'view_application');
INSERT INTO `auth_permission` VALUES (77, 'Can add access token', 20, 'add_accesstoken');
INSERT INTO `auth_permission` VALUES (78, 'Can change access token', 20, 'change_accesstoken');
INSERT INTO `auth_permission` VALUES (79, 'Can delete access token', 20, 'delete_accesstoken');
INSERT INTO `auth_permission` VALUES (80, 'Can view access token', 20, 'view_accesstoken');
INSERT INTO `auth_permission` VALUES (81, 'Can add grant', 21, 'add_grant');
INSERT INTO `auth_permission` VALUES (82, 'Can change grant', 21, 'change_grant');
INSERT INTO `auth_permission` VALUES (83, 'Can delete grant', 21, 'delete_grant');
INSERT INTO `auth_permission` VALUES (84, 'Can view grant', 21, 'view_grant');
INSERT INTO `auth_permission` VALUES (85, 'Can add refresh token', 22, 'add_refreshtoken');
INSERT INTO `auth_permission` VALUES (86, 'Can change refresh token', 22, 'change_refreshtoken');
INSERT INTO `auth_permission` VALUES (87, 'Can delete refresh token', 22, 'delete_refreshtoken');
INSERT INTO `auth_permission` VALUES (88, 'Can view refresh token', 22, 'view_refreshtoken');
INSERT INTO `auth_permission` VALUES (89, 'Can add cors model', 23, 'add_corsmodel');
INSERT INTO `auth_permission` VALUES (90, 'Can change cors model', 23, 'change_corsmodel');
INSERT INTO `auth_permission` VALUES (91, 'Can delete cors model', 23, 'delete_corsmodel');
INSERT INTO `auth_permission` VALUES (92, 'Can view cors model', 23, 'view_corsmodel');
COMMIT;

-- ----------------------------
-- Table structure for authtoken_token
-- ----------------------------
DROP TABLE IF EXISTS `authtoken_token`;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  UNIQUE KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_accounts_consumer_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_consumer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for corsheaders_corsmodel
-- ----------------------------
DROP TABLE IF EXISTS `corsheaders_corsmodel`;
CREATE TABLE `corsheaders_corsmodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cors` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`) USING BTREE,
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_consumer_id` (`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_consumer_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_consumer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `django_admin_log` VALUES (1, '2020-09-25 08:52:34.853869', '2', ' ', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (2, '2020-09-25 08:53:40.621807', '2', ' ', 3, '', 7, 1);
INSERT INTO `django_admin_log` VALUES (3, '2020-09-25 08:53:50.718504', '3', ' ', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (4, '2020-09-25 08:54:28.550516', '3', '科技公司 13209382094', 2, '[{\"changed\": {\"fields\": [\"\\u8d26\\u53f7\\u7c7b\\u522b\", \"\\u7528\\u6237\\u59d3\\u540d\", \"\\u8054\\u7cfb\\u7535\\u8bdd\", \"\\u6027\\u522b\", \"\\u90ae\\u7bb1\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (5, '2020-09-27 02:06:52.607300', '1', '中兴祥林', 1, '[{\"added\": {}}]', 18, 1);
INSERT INTO `django_admin_log` VALUES (6, '2020-09-27 02:06:57.804696', '1', '漏水监测托盘', 1, '[{\"added\": {}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (7, '2020-09-27 02:07:53.991226', '2', '漏水监测托盘002', 1, '[{\"added\": {}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (8, '2020-09-27 02:08:09.561731', '1', '漏水监测托盘', 2, '[{\"changed\": {\"fields\": [\"\\u4f20\\u611f\\u5668\\u578b\\u53f7\", \"\\u4f20\\u611f\\u5668\\u552f\\u4e00\\u7f16\\u53f7\"]}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (9, '2020-09-27 02:08:45.760821', '3', '漏水监测托盘003', 1, '[{\"added\": {}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (10, '2020-09-27 02:09:25.719078', '2', '天询华启', 1, '[{\"added\": {}}]', 18, 1);
INSERT INTO `django_admin_log` VALUES (11, '2020-09-27 02:09:29.861650', '4', '天询1号漏水监测', 1, '[{\"added\": {}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (12, '2020-09-27 02:09:37.142321', '1', '漏水监测托盘001', 2, '[{\"changed\": {\"fields\": [\"\\u4f20\\u611f\\u5668\\u540d\\u79f0\"]}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (13, '2020-09-27 02:19:46.247179', '3', '发生漏水事件', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (14, '2020-09-27 02:19:58.141155', '4', '发生漏水事件', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (15, '2020-09-27 02:20:06.305569', '5', '发生漏水事件', 1, '[{\"added\": {}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (16, '2020-09-27 02:21:44.477344', '1', '23.6', 1, '[{\"added\": {}}]', 15, 1);
INSERT INTO `django_admin_log` VALUES (17, '2020-09-27 02:21:53.233655', '2', '35.2', 1, '[{\"added\": {}}]', 15, 1);
INSERT INTO `django_admin_log` VALUES (18, '2020-09-27 02:22:03.227335', '3', '39.1', 1, '[{\"added\": {}}]', 15, 1);
INSERT INTO `django_admin_log` VALUES (19, '2020-09-27 02:22:26.611732', '4', '28.5', 1, '[{\"added\": {}}]', 15, 1);
INSERT INTO `django_admin_log` VALUES (20, '2020-09-27 21:16:36.885911', '5', '发生漏水事件5', 2, '[{\"changed\": {\"fields\": [\"\\u544a\\u8b66\\u4fe1\\u606f\"]}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (21, '2020-09-27 21:16:41.852994', '4', '发生漏水事件4', 2, '[{\"changed\": {\"fields\": [\"\\u544a\\u8b66\\u4fe1\\u606f\"]}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (22, '2020-09-27 21:16:46.140009', '3', '发生漏水事件3', 2, '[{\"changed\": {\"fields\": [\"\\u544a\\u8b66\\u4fe1\\u606f\"]}}]', 17, 1);
INSERT INTO `django_admin_log` VALUES (23, '2020-09-29 10:24:13.054770', '1', '23.6-29', 2, '[{\"changed\": {\"fields\": [\"\\u7535\\u538b\\u6d4b\\u91cf\\u91cf\"]}}]', 15, 1);
INSERT INTO `django_admin_log` VALUES (24, '2020-09-29 10:24:54.048144', '2', '35.2-36', 2, '[{\"changed\": {\"fields\": [\"\\u7535\\u538b\\u6d4b\\u91cf\\u91cf\"]}}]', 15, 1);
INSERT INTO `django_admin_log` VALUES (25, '2020-09-29 10:25:19.401591', '3', '39.1-41', 2, '[{\"changed\": {\"fields\": [\"\\u7535\\u538b\\u6d4b\\u91cf\\u91cf\"]}}]', 15, 1);
INSERT INTO `django_admin_log` VALUES (26, '2020-09-29 10:25:41.551354', '4', '28.5-30', 2, '[{\"changed\": {\"fields\": [\"\\u7535\\u538b\\u6d4b\\u91cf\\u91cf\"]}}]', 15, 1);
INSERT INTO `django_admin_log` VALUES (27, '2020-09-29 17:05:48.567563', '5', '天询2号漏水监测', 1, '[{\"added\": {}}]', 16, 1);
COMMIT;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` VALUES (7, 'accounts', 'consumer');
INSERT INTO `django_content_type` VALUES (8, 'accounts', 'deportment');
INSERT INTO `django_content_type` VALUES (13, 'accounts', 'operational');
INSERT INTO `django_content_type` VALUES (9, 'accounts', 'role');
INSERT INTO `django_content_type` VALUES (12, 'accounts', 'rolebutton');
INSERT INTO `django_content_type` VALUES (10, 'accounts', 'rolemenu');
INSERT INTO `django_content_type` VALUES (11, 'accounts', 'wechatuser');
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (6, 'authtoken', 'token');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (23, 'corsheaders', 'corsmodel');
INSERT INTO `django_content_type` VALUES (20, 'oauth2_provider', 'accesstoken');
INSERT INTO `django_content_type` VALUES (19, 'oauth2_provider', 'application');
INSERT INTO `django_content_type` VALUES (21, 'oauth2_provider', 'grant');
INSERT INTO `django_content_type` VALUES (22, 'oauth2_provider', 'refreshtoken');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (18, 'valve', 'manufactor');
INSERT INTO `django_content_type` VALUES (14, 'valve', 'news');
INSERT INTO `django_content_type` VALUES (16, 'valve', 'sensor');
INSERT INTO `django_content_type` VALUES (15, 'valve', 'voltage');
INSERT INTO `django_content_type` VALUES (17, 'valve', 'warninfo');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2020-09-24 07:57:02.905613');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2020-09-24 07:57:02.990443');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2020-09-24 07:57:03.107140');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2020-09-24 07:57:03.298652');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2020-09-24 07:57:03.304551');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2020-09-24 07:57:03.310167');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2020-09-24 07:57:03.315845');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2020-09-24 07:57:03.317666');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2020-09-24 07:57:03.324531');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2020-09-24 07:57:03.331326');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2020-09-24 07:57:03.337002');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2020-09-24 07:57:03.374758');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2020-09-24 07:57:03.382385');
INSERT INTO `django_migrations` VALUES (14, 'accounts', '0001_initial', '2020-09-24 07:57:03.994681');
INSERT INTO `django_migrations` VALUES (15, 'admin', '0001_initial', '2020-09-24 07:57:04.726707');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0002_logentry_remove_auto_add', '2020-09-24 07:57:04.800711');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0003_logentry_add_action_flag_choices', '2020-09-24 07:57:04.814835');
INSERT INTO `django_migrations` VALUES (18, 'authtoken', '0001_initial', '2020-09-24 07:57:04.866784');
INSERT INTO `django_migrations` VALUES (19, 'authtoken', '0002_auto_20160226_1747', '2020-09-24 07:57:05.001523');
INSERT INTO `django_migrations` VALUES (20, 'sessions', '0001_initial', '2020-09-24 07:57:05.038899');
INSERT INTO `django_migrations` VALUES (21, 'accounts', '0002_auto_20200924_1605', '2020-09-24 08:06:00.875771');
INSERT INTO `django_migrations` VALUES (22, 'valve', '0001_initial', '2020-09-24 09:49:08.940669');
INSERT INTO `django_migrations` VALUES (23, 'valve', '0002_auto_20200925_1634', '2020-09-25 08:34:12.221177');
INSERT INTO `django_migrations` VALUES (24, 'valve', '0003_auto_20200925_1639', '2020-09-25 08:39:25.361628');
INSERT INTO `django_migrations` VALUES (25, 'corsheaders', '0001_initial', '2020-10-09 17:01:30.615900');
INSERT INTO `django_migrations` VALUES (26, 'oauth2_provider', '0001_initial', '2020-10-09 17:01:31.245339');
INSERT INTO `django_migrations` VALUES (27, 'oauth2_provider', '0002_auto_20190406_1805', '2020-10-09 17:01:31.626259');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  KEY `django_session_expire_date_a5c62663` (`expire_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` VALUES ('6eyyx0h7gcfoklkjaffhkhrnx5seslr1', 'MGIxYmM4MTYzZGYyMDM4ODQzOTBmYmY3YzVmMzI2ZDZmNDUxNjNlODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5YzUwZTczMjg2MjUxOGE5YzRhODZiYTAwMDk2ODhhMGM1ZTMzNmE1In0=', '2020-10-11 02:05:51.679181');
INSERT INTO `django_session` VALUES ('fwsakkxtwup3w1ydsthur98h0d6yfnu2', 'MGIxYmM4MTYzZGYyMDM4ODQzOTBmYmY3YzVmMzI2ZDZmNDUxNjNlODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5YzUwZTczMjg2MjUxOGE5YzRhODZiYTAwMDk2ODhhMGM1ZTMzNmE1In0=', '2020-10-08 07:57:45.055726');
INSERT INTO `django_session` VALUES ('n6rv9ap1is4zha38o2ry30ciekoz97rz', 'MGIxYmM4MTYzZGYyMDM4ODQzOTBmYmY3YzVmMzI2ZDZmNDUxNjNlODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5YzUwZTczMjg2MjUxOGE5YzRhODZiYTAwMDk2ODhhMGM1ZTMzNmE1In0=', '2020-10-13 10:22:50.130043');
COMMIT;

-- ----------------------------
-- Table structure for oauth2_provider_accesstoken
-- ----------------------------
DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_acce_user_id_6e4c9a65_fk_accounts_` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_user_id_6e4c9a65_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_consumer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for oauth2_provider_application
-- ----------------------------
DROP TABLE IF EXISTS `oauth2_provider_application`;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) NOT NULL,
  `redirect_uris` longtext NOT NULL,
  `client_type` varchar(32) NOT NULL,
  `authorization_grant_type` varchar(32) NOT NULL,
  `client_secret` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_appl_user_id_79829054_fk_accounts_` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_appl_user_id_79829054_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_consumer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth2_provider_application
-- ----------------------------
BEGIN;
INSERT INTO `oauth2_provider_application` VALUES (1, 'y08eZqDL9fFvIzuMfD43zVNzyyE0ig7QFoQIVcDi', 'http://api.fata.xatxhq.cn', 'confidential', 'authorization-code', 'Gv5g7yzqhjIbvBUa84rMrqYBqFc4VcjV2cxEPmH1YAaT20ZwROmIHJ1Isahj1fpvCfByLDUDQISNNGBDYSeU2pDBbMvaZpUufcPTpKrH35HhEOiGOD0T1thCVm30lrEm', 'fata', 1, 0, '2020-10-09 17:02:47.904433', '2020-10-09 17:02:47.904470');
COMMIT;

-- ----------------------------
-- Table structure for oauth2_provider_grant
-- ----------------------------
DROP TABLE IF EXISTS `oauth2_provider_grant`;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` varchar(255) NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) NOT NULL,
  `code_challenge_method` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_accounts_consumer_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_accounts_consumer_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_consumer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth2_provider_grant
-- ----------------------------
BEGIN;
INSERT INTO `oauth2_provider_grant` VALUES (1, 'hJ20wGjLS4smELeElQjjqBZLCEffyq', '2020-10-09 17:04:36.104438', 'http://api.fata.xatxhq.cn', 'read write', 1, 1, '2020-10-09 17:03:36.105090', '2020-10-09 17:03:36.105101', '', '');
COMMIT;

-- ----------------------------
-- Table structure for oauth2_provider_refreshtoken
-- ----------------------------
DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `access_token_id` bigint(20) DEFAULT NULL,
  `application_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refr_user_id_da837fce_fk_accounts_` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refr_user_id_da837fce_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_consumer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for valve_manufactor
-- ----------------------------
DROP TABLE IF EXISTS `valve_manufactor`;
CREATE TABLE `valve_manufactor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `modifier_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `valve_manufactor_creator_id_d927ebaa_fk_accounts_consumer_id` (`creator_id`) USING BTREE,
  KEY `valve_manufactor_modifier_id_992ba06e_fk_accounts_consumer_id` (`modifier_id`) USING BTREE,
  CONSTRAINT `valve_manufactor_creator_id_d927ebaa_fk_accounts_consumer_id` FOREIGN KEY (`creator_id`) REFERENCES `accounts_consumer` (`id`),
  CONSTRAINT `valve_manufactor_modifier_id_992ba06e_fk_accounts_consumer_id` FOREIGN KEY (`modifier_id`) REFERENCES `accounts_consumer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of valve_manufactor
-- ----------------------------
BEGIN;
INSERT INTO `valve_manufactor` VALUES (1, '2020-09-27 02:06:52.606076', '2020-09-27 02:06:52.606111', '中兴祥林', '西安市长安区花园村', 1, 3, 3);
INSERT INTO `valve_manufactor` VALUES (2, '2020-09-27 02:09:25.718375', '2020-09-27 02:09:25.718410', '天询华启', '吉元大街北段路东（原恒源电磁厂址）', 1, 3, 3);
COMMIT;

-- ----------------------------
-- Table structure for valve_sensor
-- ----------------------------
DROP TABLE IF EXISTS `valve_sensor`;
CREATE TABLE `valve_sensor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `manufactor_id` int(11) DEFAULT NULL,
  `modifier_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `serial_number` (`serial_number`) USING BTREE,
  KEY `valve_sensor_creator_id_a2b8be9c_fk_accounts_consumer_id` (`creator_id`) USING BTREE,
  KEY `valve_sensor_manufactor_id_e00fe79b_fk_valve_manufactor_id` (`manufactor_id`) USING BTREE,
  KEY `valve_sensor_modifier_id_90b3ce03_fk_accounts_consumer_id` (`modifier_id`) USING BTREE,
  CONSTRAINT `valve_sensor_creator_id_a2b8be9c_fk_accounts_consumer_id` FOREIGN KEY (`creator_id`) REFERENCES `accounts_consumer` (`id`),
  CONSTRAINT `valve_sensor_manufactor_id_e00fe79b_fk_valve_manufactor_id` FOREIGN KEY (`manufactor_id`) REFERENCES `valve_manufactor` (`id`),
  CONSTRAINT `valve_sensor_modifier_id_90b3ce03_fk_accounts_consumer_id` FOREIGN KEY (`modifier_id`) REFERENCES `accounts_consumer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of valve_sensor
-- ----------------------------
BEGIN;
INSERT INTO `valve_sensor` VALUES (1, '2020-09-27 02:06:57.803193', '2020-09-27 02:09:37.141326', '漏水监测托盘001', 'ZTE-001', 'ZTE-0001', 1, 3, 1, 3);
INSERT INTO `valve_sensor` VALUES (2, '2020-09-27 02:07:53.990445', '2020-09-27 02:07:53.990481', '漏水监测托盘002', 'ZTE-002', 'ZTE-00000002', 1, 3, 1, 3);
INSERT INTO `valve_sensor` VALUES (3, '2020-09-27 02:08:45.760024', '2020-09-27 02:08:45.760061', '漏水监测托盘003', 'ZTE-003', 'ZTE-00000003', 1, 3, 1, 3);
INSERT INTO `valve_sensor` VALUES (4, '2020-09-27 02:09:29.860919', '2020-09-27 02:09:29.860957', '天询1号漏水监测', 'TX-001', 'TX-00000001', 1, 3, 2, 3);
INSERT INTO `valve_sensor` VALUES (5, '2020-09-29 17:05:48.566353', '2020-09-29 17:05:48.566386', '天询2号漏水监测', 'TX-002', 'TX-0000002', 1, 3, 2, 3);
COMMIT;

-- ----------------------------
-- Table structure for valve_voltage
-- ----------------------------
DROP TABLE IF EXISTS `valve_voltage`;
CREATE TABLE `valve_voltage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  `voltage` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `sensor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `valve_voltage_sensor_id_47ef3398_fk_valve_sensor_id` (`sensor_id`) USING BTREE,
  CONSTRAINT `valve_voltage_sensor_id_47ef3398_fk_valve_sensor_id` FOREIGN KEY (`sensor_id`) REFERENCES `valve_sensor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of valve_voltage
-- ----------------------------
BEGIN;
INSERT INTO `valve_voltage` VALUES (1, '2020-09-26 02:21:44.476380', '2020-09-29 10:24:13.053241', '23.6-29', 1, 1);
INSERT INTO `valve_voltage` VALUES (2, '2020-09-28 02:21:53.232623', '2020-09-29 10:24:54.046607', '35.2-36', 1, 2);
INSERT INTO `valve_voltage` VALUES (3, '2020-09-27 02:22:03.226388', '2020-09-29 10:25:19.400435', '39.1-41', 1, 3);
INSERT INTO `valve_voltage` VALUES (4, '2020-09-27 02:22:26.610565', '2020-09-29 10:25:41.550202', '28.5-30', 1, 4);
COMMIT;

-- ----------------------------
-- Table structure for valve_warninfo
-- ----------------------------
DROP TABLE IF EXISTS `valve_warninfo`;
CREATE TABLE `valve_warninfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_at` datetime(6) NOT NULL,
  `modified_at` datetime(6) NOT NULL,
  `warn_info` varchar(255) DEFAULT NULL,
  `sensor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `valve_warninfo_sensor_id_0673a8fb_fk_valve_sensor_id` (`sensor_id`) USING BTREE,
  CONSTRAINT `valve_warninfo_sensor_id_0673a8fb_fk_valve_sensor_id` FOREIGN KEY (`sensor_id`) REFERENCES `valve_sensor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of valve_warninfo
-- ----------------------------
BEGIN;
INSERT INTO `valve_warninfo` VALUES (3, '2020-09-23 02:19:46.245094', '2020-09-28 21:16:46.139056', '发生漏水事件3', 1);
INSERT INTO `valve_warninfo` VALUES (4, '2020-09-24 02:19:58.140309', '2020-09-27 21:16:41.852007', '发生漏水事件4', 2);
INSERT INTO `valve_warninfo` VALUES (5, '2020-09-25 02:20:06.304611', '2020-09-27 21:16:36.884847', '发生漏水事件5', 3);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
