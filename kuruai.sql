-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for kurulai
CREATE DATABASE IF NOT EXISTS `kurulai` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `kurulai`;

-- Dumping structure for table kurulai.activity_log
CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL COMMENT 'NULL = aksi sistem',
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` text COLLATE utf8mb4_unicode_ci,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IPv4 atau IPv6',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_action` (`action`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Log aktivitas dan audit trail';


-- Dumping structure for table kurulai.changelogs
CREATE TABLE IF NOT EXISTS `changelogs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Contoh: 4.1.0',
  `series` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Contoh: Sakura Series',
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Judul singkat update',
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Keterangan detail (bullet point, newline OK)',
  `release_date` date NOT NULL COMMENT 'Tanggal pembaruan',
  `author` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Atas nama (opsional)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_release_date` (`release_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Dumping structure for table kurulai.chat_messages
CREATE TABLE IF NOT EXISTS `chat_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'user | assistant | system',
  `content` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_image` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = pesan mengandung gambar',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_messages_session` FOREIGN KEY (`session_id`) REFERENCES `chat_sessions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Isi pesan tiap sesi chat';


-- Dumping structure for table kurulai.chat_sessions
CREATE TABLE IF NOT EXISTS `chat_sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Chat Baru',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_updated_at` (`updated_at`),
  CONSTRAINT `fk_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Sesi percakapan chat';


-- Dumping structure for table kurulai.generated_images
CREATE TABLE IF NOT EXISTS `generated_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `prompt` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Prompt yang dipakai',
  `url` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'URL gambar dari Pollinations',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_images_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Riwayat gambar AI yang digenerate';


-- Dumping structure for table kurulai.inbox_messages
CREATE TABLE IF NOT EXISTS `inbox_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'Penerima pesan',
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pesan dari Admin',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `sent_by` int DEFAULT NULL COMMENT 'ID admin pengirim',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_is_read` (`is_read`),
  CONSTRAINT `fk_inbox_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Kotak masuk pesan admin ke user';


-- Dumping structure for table kurulai.shop_config
CREATE TABLE IF NOT EXISTS `shop_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `banner_url` text COLLATE utf8mb4_unicode_ci COMMENT 'URL banner toko (rasio 5:4)',
  `shop_url` text COLLATE utf8mb4_unicode_ci COMMENT 'URL toko lynk.id atau eksternal',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Konfigurasi halaman toko digital';


-- Dumping structure for table kurulai.subscription_tracker
CREATE TABLE IF NOT EXISTS `subscription_tracker` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `amount_paid` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'Total akumulasi pembayaran (Rp)',
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Catatan transaksi admin',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_id` (`user_id`),
  CONSTRAINT `fk_tracker_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tracker pembayaran langganan manual admin';


-- Dumping structure for table kurulai.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Auto-generated dari display_name',
  `display_name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Nama tampilan bebas (contoh: Riel Akuonza)',
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `whatsapp` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'No WhatsApp opsional',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user' COMMENT 'user | admin',
  `is_banned` tinyint(1) NOT NULL DEFAULT '0',
  `ban_reason` text COLLATE utf8mb4_unicode_ci,
  `subscription` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'free' COMMENT 'free | premium | vip',
  `avatar_color` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#7C3AED' COMMENT 'Warna avatar fallback',
  `avatar_url` text COLLATE utf8mb4_unicode_ci COMMENT 'URL foto profil custom',
  `bio` text COLLATE utf8mb4_unicode_ci,
  `otp_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Kode OTP sementara',
  `otp_expires` datetime DEFAULT NULL COMMENT 'Kadaluarsa OTP',
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_active` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_username` (`username`),
  UNIQUE KEY `uq_email` (`email`),
  KEY `idx_subscription` (`subscription`),
  KEY `idx_role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Data pengguna KuruAi';


-- Dumping structure for table kurulai.user_nicknames
CREATE TABLE IF NOT EXISTS `user_nicknames` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nickname` varchar(60) NOT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_id` (`user_id`),
  CONSTRAINT `fk_nick_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Dumping structure for view kurulai.v_today_usage
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_today_usage` (
	`user_id` INT(10) NOT NULL,
	`subscription` VARCHAR(20) NOT NULL COMMENT 'free | premium | vip' COLLATE 'utf8mb4_unicode_ci',
	`chat_today` BIGINT(19) NOT NULL,
	`img_today` BIGINT(19) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view kurulai.v_user_stats
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_user_stats` (
	`id` INT(10) NOT NULL,
	`username` VARCHAR(30) NOT NULL COMMENT 'Auto-generated dari display_name' COLLATE 'utf8mb4_unicode_ci',
	`display_name` VARCHAR(60) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`email` VARCHAR(191) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`whatsapp` VARCHAR(30) NULL COMMENT 'No WhatsApp opsional' COLLATE 'utf8mb4_unicode_ci',
	`subscription` VARCHAR(20) NOT NULL COMMENT 'free | premium | vip' COLLATE 'utf8mb4_unicode_ci',
	`is_banned` TINYINT(1) NOT NULL,
	`email_verified` TINYINT(1) NOT NULL,
	`created_at` DATETIME NOT NULL,
	`last_active` DATETIME NOT NULL,
	`total_sessions` BIGINT(19) NOT NULL,
	`total_messages` BIGINT(19) NOT NULL,
	`total_images` BIGINT(19) NOT NULL,
	`total_paid` DECIMAL(12,2) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view kurulai.v_today_usage
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_today_usage`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_today_usage` AS select `u`.`id` AS `user_id`,`u`.`subscription` AS `subscription`,count(distinct (case when ((`cm`.`role` = 'user') and (cast(`cm`.`created_at` as date) = curdate())) then `cm`.`id` end)) AS `chat_today`,count(distinct (case when (cast(`gi`.`created_at` as date) = curdate()) then `gi`.`id` end)) AS `img_today` from (((`users` `u` left join `chat_sessions` `cs` on((`cs`.`user_id` = `u`.`id`))) left join `chat_messages` `cm` on((`cm`.`session_id` = `cs`.`id`))) left join `generated_images` `gi` on((`gi`.`user_id` = `u`.`id`))) group by `u`.`id`;

-- Dumping structure for view kurulai.v_user_stats
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_user_stats`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_user_stats` AS select `u`.`id` AS `id`,`u`.`username` AS `username`,coalesce(`u`.`display_name`,`u`.`username`) AS `display_name`,`u`.`email` AS `email`,`u`.`whatsapp` AS `whatsapp`,`u`.`subscription` AS `subscription`,`u`.`is_banned` AS `is_banned`,`u`.`email_verified` AS `email_verified`,`u`.`created_at` AS `created_at`,`u`.`last_active` AS `last_active`,count(distinct `cs`.`id`) AS `total_sessions`,count(distinct `cm`.`id`) AS `total_messages`,count(distinct `gi`.`id`) AS `total_images`,coalesce(`st`.`amount_paid`,0) AS `total_paid` from ((((`users` `u` left join `chat_sessions` `cs` on((`cs`.`user_id` = `u`.`id`))) left join `chat_messages` `cm` on(((`cm`.`session_id` = `cs`.`id`) and (`cm`.`role` = 'user')))) left join `generated_images` `gi` on((`gi`.`user_id` = `u`.`id`))) left join `subscription_tracker` `st` on((`st`.`user_id` = `u`.`id`))) where (`u`.`role` <> 'admin') group by `u`.`id`;


/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
