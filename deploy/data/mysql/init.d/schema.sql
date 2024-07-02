-- MySQL dump 10.13  Distrib 8.0.33, for Linux (aarch64)
--
-- Host: localhost    Database: chatgpt_plus
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chatgpt_admin_users`
--

DROP TABLE IF EXISTS `chatgpt_admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_admin_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `salt` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码盐',
  `status` tinyint(1) NOT NULL COMMENT '当前状态',
  `last_login_at` int NOT NULL COMMENT '最后登录时间',
  `last_login_ip` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '最后登录 IP',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='系统用户';
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `chatgpt_admin_users` (`id`, `username`, `password`, `salt`, `status`, `last_login_at`, `last_login_ip`, `created_at`, `updated_at`) VALUES
                                                                                                                                                     (1, 'admin', '6d17e80c87d209efb84ca4b2e0824f549d09fac8b2e1cc698de5bb5e1d75dfd0', 'mmrql75o', 1, 1712456145, '::1', '2024-03-11 16:30:20', '2024-04-07 10:15:45');

--
-- Table structure for table `chatgpt_api_keys`
--

DROP TABLE IF EXISTS `chatgpt_api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_api_keys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `platform` char(20) DEFAULT NULL COMMENT '平台',
  `name` varchar(30) DEFAULT NULL COMMENT '名称',
  `value` varchar(100) NOT NULL COMMENT 'API KEY value',
  `type` varchar(10) NOT NULL DEFAULT 'chat' COMMENT '用途（chat=>聊天，img=>图片）',
  `last_used_at` int NOT NULL COMMENT '最后使用时间',
  `api_url` varchar(255) DEFAULT NULL COMMENT 'API 地址',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用',
  `proxy_url` varchar(100) DEFAULT NULL COMMENT '代理地址',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='OpenAI API ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_chat_history`
--

DROP TABLE IF EXISTS `chatgpt_chat_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_chat_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `chat_id` char(40) NOT NULL COMMENT '会话 ID',
  `type` varchar(10) NOT NULL COMMENT '类型：prompt|reply',
  `icon` varchar(100) NOT NULL COMMENT '角色图标',
  `role_id` int NOT NULL COMMENT '角色 ID',
  `model` varchar(30) DEFAULT NULL COMMENT '模型名称',
  `content` text NOT NULL COMMENT '聊天内容',
  `tokens` smallint NOT NULL COMMENT '耗费 token 数量',
  `use_context` tinyint(1) NOT NULL COMMENT '是否允许作为上下文语料',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_id` (`chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='聊天历史记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_chat_items`
--

DROP TABLE IF EXISTS `chatgpt_chat_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_chat_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chat_id` char(40) NOT NULL COMMENT '会话 ID',
  `user_id` int NOT NULL COMMENT '用户 ID',
  `role_id` int NOT NULL COMMENT '角色 ID',
  `title` varchar(100) NOT NULL COMMENT '会话标题',
  `model_id` int NOT NULL DEFAULT '0' COMMENT '模型 ID',
  `model` varchar(30) DEFAULT NULL COMMENT '模型名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chat_id` (`chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户会话列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_chat_models`
--

DROP TABLE IF EXISTS `chatgpt_chat_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_chat_models` (
  `id` int NOT NULL AUTO_INCREMENT,
  `platform` varchar(20) DEFAULT NULL COMMENT '模型平台',
  `name` varchar(50) NOT NULL COMMENT '模型名称',
  `value` varchar(50) NOT NULL COMMENT '模型值',
  `sort_num` tinyint(1) NOT NULL COMMENT '排序数字',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用模型',
  `power` tinyint NOT NULL COMMENT '消耗算力点数',
  `temperature` float(3,1) NOT NULL DEFAULT '1.0' COMMENT '模型创意度',
  `max_tokens` int NOT NULL DEFAULT '1024' COMMENT '最大响应长度',
  `max_context` int NOT NULL DEFAULT '4096' COMMENT '最大上下文长度',
  `open` tinyint(1) NOT NULL COMMENT '是否开放模型',
  `key_id` int NOT NULL COMMENT 'API KEY ID',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='AI 模型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_chat_roles`
--

DROP TABLE IF EXISTS `chatgpt_chat_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_chat_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '角色名称',
  `marker` varchar(30) NOT NULL COMMENT '角色标识',
  `context_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色语料 json',
  `hello_msg` varchar(255) NOT NULL COMMENT '打招呼信息',
  `icon` varchar(255) NOT NULL COMMENT '角色图标',
  `enable` tinyint(1) NOT NULL COMMENT '是否被启用',
  `sort_num` smallint NOT NULL DEFAULT '0' COMMENT '角色排序',
  `model_id` int NOT NULL DEFAULT '0' COMMENT 'ID',
  `description` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `marker` (`marker`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='聊天角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_configs`
--

DROP TABLE IF EXISTS `chatgpt_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_configs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marker` varchar(20) NOT NULL COMMENT '标识',
  `config_json` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `marker` (`marker`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_dall_jobs`
--

DROP TABLE IF EXISTS `chatgpt_dall_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_dall_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'ID',
  `prompt` varchar(2000) NOT NULL,
  `img_url` varchar(255) NOT NULL,
  `org_url` varchar(400) DEFAULT NULL,
  `publish` tinyint(1) NOT NULL,
  `power` smallint NOT NULL,
  `progress` smallint NOT NULL,
  `err_msg` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DALLE ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_files`
--

DROP TABLE IF EXISTS `chatgpt_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `name` varchar(100) NOT NULL COMMENT '文件名',
  `obj_key` varchar(100) DEFAULT NULL COMMENT '文件标识',
  `url` varchar(255) NOT NULL COMMENT '文件地址',
  `ext` varchar(10) NOT NULL COMMENT '文件后缀',
  `size` bigint NOT NULL DEFAULT '0' COMMENT '文件大小',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_functions`
--

DROP TABLE IF EXISTS `chatgpt_functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_functions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '函数名称',
  `label` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '函数标签',
  `description` varchar(255) DEFAULT NULL COMMENT '函数描述',
  `parameters` text COMMENT '函数参数（JSON）',
  `token` varchar(255) DEFAULT NULL COMMENT 'API授权token',
  `action` varchar(255) DEFAULT NULL COMMENT '函数处理 API',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='函数插件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_invite_codes`
--

DROP TABLE IF EXISTS `chatgpt_invite_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_invite_codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `code` char(8) NOT NULL COMMENT '邀请码',
  `hits` int NOT NULL COMMENT '点击次数',
  `reg_num` smallint NOT NULL COMMENT '注册数量',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户邀请码';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_invite_logs`
--

DROP TABLE IF EXISTS `chatgpt_invite_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_invite_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inviter_id` int NOT NULL COMMENT '邀请人ID',
  `user_id` int NOT NULL COMMENT '注册用户ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `invite_code` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邀请码',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='邀请注册日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_menus`
--

DROP TABLE IF EXISTS `chatgpt_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '菜单名称',
  `icon` varchar(150) NOT NULL COMMENT '菜单图标',
  `url` varchar(100) NOT NULL COMMENT '地址',
  `sort_num` smallint NOT NULL COMMENT '排序',
  `enabled` tinyint(1) NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='前端菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_mj_jobs`
--

DROP TABLE IF EXISTS `chatgpt_mj_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_mj_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `task_id` varchar(20) DEFAULT NULL COMMENT '任务 ID',
  `type` varchar(20) DEFAULT 'image' COMMENT '任务类别',
  `message_id` char(40) NOT NULL COMMENT '消息 ID',
  `channel_id` char(40) DEFAULT NULL COMMENT '频道ID',
  `reference_id` char(40) DEFAULT NULL COMMENT '引用消息 ID',
  `prompt` varchar(2000) NOT NULL COMMENT '会话提示词',
  `img_url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片URL',
  `org_url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '原始图片地址',
  `hash` varchar(100) DEFAULT NULL COMMENT 'message hash',
  `progress` smallint DEFAULT '0' COMMENT '任务进度',
  `use_proxy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用反代',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `err_msg` varchar(255) DEFAULT NULL COMMENT '错误信息',
  `power` smallint NOT NULL DEFAULT '0' COMMENT '消耗算力',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `message_id` (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MidJourney 任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_orders`
--

DROP TABLE IF EXISTS `chatgpt_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `product_id` int NOT NULL COMMENT '产品ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户明',
  `order_no` varchar(30) NOT NULL COMMENT '订单ID',
  `trade_no` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '支付平台交易流水号',
  `subject` varchar(100) NOT NULL COMMENT '订单产品',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态（0：待支付，1：已扫码，2：支付失败）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `pay_time` int DEFAULT NULL COMMENT '支付时间',
  `pay_way` varchar(20) NOT NULL COMMENT '支付方式',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='充值订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_power_logs`
--

DROP TABLE IF EXISTS `chatgpt_power_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_power_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `type` tinyint(1) NOT NULL COMMENT '类型（1：充值，2：消费，3：退费）',
  `amount` smallint NOT NULL COMMENT '算力数值',
  `balance` int NOT NULL COMMENT '余额',
  `model` varchar(30) NOT NULL COMMENT '模型',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `mark` tinyint(1) NOT NULL COMMENT '资金类型（0：支出，1：收入）',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户算力消费日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_products`
--

DROP TABLE IF EXISTS `chatgpt_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '名称',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠金额',
  `days` smallint NOT NULL DEFAULT '0' COMMENT '延长天数',
  `power` int NOT NULL DEFAULT '0' COMMENT '增加算力值',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启动',
  `sales` int NOT NULL DEFAULT '0' COMMENT '销量',
  `sort_num` tinyint NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `app_url` varchar(255) DEFAULT NULL COMMENT 'App跳转地址',
  `url` varchar(255) DEFAULT NULL COMMENT '跳转地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='会员套餐表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_rewards`
--

DROP TABLE IF EXISTS `chatgpt_rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_rewards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `tx_id` char(36) NOT NULL COMMENT '交易 ID',
  `amount` decimal(10,2) NOT NULL COMMENT '打赏金额',
  `remark` varchar(80) NOT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL COMMENT '核销状态，0：未核销，1：已核销',
  `exchange` varchar(255) NOT NULL COMMENT '兑换详情（json）',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tx_id` (`tx_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户打赏';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_sd_jobs`
--

DROP TABLE IF EXISTS `chatgpt_sd_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_sd_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'txt2img' COMMENT '任务类别',
  `task_id` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务 ID',
  `prompt` varchar(2000) NOT NULL COMMENT '会话提示词',
  `img_url` varchar(255) DEFAULT NULL COMMENT '图片URL',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '绘画参数json',
  `progress` smallint DEFAULT '0' COMMENT '任务进度',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `err_msg` varchar(255) DEFAULT NULL COMMENT '错误信息',
  `power` smallint NOT NULL DEFAULT '0' COMMENT '消耗算力',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Stable Diffusion 任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_user_login_logs`
--

DROP TABLE IF EXISTS `chatgpt_user_login_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_user_login_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `login_ip` char(16) NOT NULL COMMENT '登录IP',
  `login_address` varchar(30) NOT NULL COMMENT '登录地址',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户登录日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatgpt_users`
--

DROP TABLE IF EXISTS `chatgpt_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatgpt_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `nickname` varchar(30) NOT NULL COMMENT '昵称',
  `password` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `avatar` varchar(100) NOT NULL COMMENT '头像',
  `salt` char(12) NOT NULL COMMENT '密码盐',
  `power` int NOT NULL DEFAULT '0' COMMENT '剩余算力',
  `expired_time` int NOT NULL COMMENT '用户过期时间',
  `status` tinyint(1) NOT NULL COMMENT '当前状态',
  `chat_config_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '聊天配置json',
  `chat_roles_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '聊天角色 json',
  `chat_models_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'AI模型 json',
  `last_login_at` int NOT NULL COMMENT '最后登录时间',
  `vip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否会员',
  `last_login_ip` char(16) NOT NULL COMMENT '最后登录 IP',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `username_2` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-02  0:57:39
