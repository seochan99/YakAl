CREATE DATABASE IF NOT EXISTS yakal default CHARACTER SET UTF8;

USE yakal;

CREATE TABLE `users` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `birthday` date DEFAULT NULL,
    `breakfast_time` time(6) DEFAULT NULL,
    `created_date` date NOT NULL,
    `device_token` varchar(255) DEFAULT NULL,
    `dinner_time` time(6) DEFAULT NULL,
    `is_detail` tinyint NOT NULL,
    `is_ios` tinyint DEFAULT NULL,
    `is_login` tinyint NOT NULL,
    `login_provider` enum('APPLE','GOOGLE','KAKAO') NOT NULL,
    `lunch_time` time(6) DEFAULT NULL,
    `name` char(20) DEFAULT NULL,
    `noti_is_allowed` tinyint NOT NULL,
    `refresh_token` varchar(255) DEFAULT NULL,
    `role` enum('ROLE_MOBILE','ROLE_WEB') NOT NULL,
    `sex` enum('FEMALE','MALE') DEFAULT NULL,
    `social_id` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `risks` (
    `id` char(7) NOT NULL,
    `score` tinyint NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `prescriptions` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `created_date` date NOT NULL,
    `pharmacy_name` varchar(255) NOT NULL,
    `prescribed_date` date NOT NULL,
    `user_id` bigint NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `notifications` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `content` varchar(255) NOT NULL,
    `create_date` datetime(6) NOT NULL,
    `is_read` tinyint NOT NULL,
    `status` tinyint DEFAULT NULL,
    `title` varchar(255) NOT NULL,
    `user_id` bigint NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `medicals` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `medical_introduction` varchar(255) DEFAULT NULL,
    `medical_location` varchar(255) DEFAULT NULL,
    `medical_name` varchar(255) DEFAULT NULL,
    `medical_point` varbinary(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `images` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `path` varchar(255) NOT NULL,
    `type` varchar(255) NOT NULL,
    `uuid_name` char(41) NOT NULL,
    `use_medical` bigint DEFAULT NULL,
    `use_user` bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`use_user`) REFERENCES `users` (`id`),
    FOREIGN KEY (`use_medical`) REFERENCES `medicals` (`id`),
    CONSTRAINT `uc_use_user` UNIQUE (`use_user`),
    CONSTRAINT `uc_use_medical` UNIQUE (`use_medical`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `doses` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `kd_code` varchar(255) NOT NULL,
    `created_at` datetime(6) NOT NULL,
    `date` date NOT NULL,
    `deleted_at` datetime(6) DEFAULT NULL,
    `is_deleted` tinyint NOT NULL,
    `is_half` tinyint NOT NULL,
    `is_taken` tinyint NOT NULL,
    `pill_cnt` bigint NOT NULL,
    `time` enum('AFTERNOON','DEFAULT','EVENING','MORNING') NOT NULL,
    `risks_id` char(7) DEFAULT NULL,
    `prescription_id` bigint NOT NULL,
    `user_id` bigint NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`id`),
    FOREIGN KEY (`risks_id`) REFERENCES `risks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;