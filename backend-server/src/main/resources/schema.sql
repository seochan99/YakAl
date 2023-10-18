CREATE TABLE `users`
(
    `id`              bigint       NOT NULL AUTO_INCREMENT,
    `birthday`        date         DEFAULT NULL,
    `breakfast_time`  time(6)      DEFAULT NULL,
    `created_date`    date         NOT NULL,
    `department`      varchar(255) DEFAULT NULL,
    `device_token`    varchar(255) DEFAULT NULL,
    `dinner_time`     time(6)      DEFAULT NULL,
    `is_certified`    bit(1)       DEFAULT NULL,
    `is_detail`       tinyint(1) NOT NULL,
    `is_identified`   tinyint(1) DEFAULT NULL,
    `is_ios`          tinyint(1) DEFAULT NULL,
    `is_login`        tinyint(1) NOT NULL,
    `job`             enum('DOCTOR','PATIENT','PHARMACIST') DEFAULT NULL,
    `login_provider`  enum('APPLE','GOOGLE','KAKAO') NOT NULL,
    `lunch_time`      time(6)      DEFAULT NULL,
    `name`            char(20)     DEFAULT NULL,
    `noti_is_allowed` tinyint(1) NOT NULL,
    `refresh_token`   varchar(255) DEFAULT NULL,
    `role`            enum('ROLE_MOBILE','ROLE_WEB') NOT NULL,
    `sex`             enum('FEMALE','MALE') DEFAULT NULL,
    `social_id`       varchar(255) NOT NULL,
    `tel`             varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `risks`
(
    `id`                char(7) NOT NULL,
    `properties`        enum('ANTICHOLINERGIC', 'BEERS_CRITERIA', 'BOTH') DEFAULT NULL,
    `score`             tinyint NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `dosenames`
(
    `id`        varchar(255) NOT NULL,
    `dose_name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `prescriptions`
(
    `id`              bigint       NOT NULL AUTO_INCREMENT,
    `created_date`    date         NOT NULL,
    `is_allow`        bit(1) DEFAULT NULL,
    `pharmacy_name`   varchar(255) NOT NULL,
    `prescribed_date` date         NOT NULL,
    `user_id`         bigint       NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `notifications`
(
    `id`          bigint       NOT NULL AUTO_INCREMENT,
    `content`     varchar(255) NOT NULL,
    `create_date` datetime(6) NOT NULL,
    `is_read`     tinyint      NOT NULL,
    `status`      tinyint DEFAULT NULL,
    `title`       varchar(255) NOT NULL,
    `user_id`     bigint       NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `medicals`
(
    `id`              bigint       NOT NULL AUTO_INCREMENT,
    `is_register`     bit(1)       DEFAULT NULL,
    `medical_address` varchar(255) DEFAULT NULL,
    `medical_name`    varchar(255) NOT NULL,
    `medical_point`   point        DEFAULT NULL,
    `medical_tel`     varchar(255) DEFAULT NULL,
    `type`            enum('HOSPITAL','PHARMACY') DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `registrations`
(
    `id`                           bigint       NOT NULL AUTO_INCREMENT,
    `business_registration_number` varchar(255) NOT NULL,
    `director_name`                varchar(255) NOT NULL,
    `director_tel`                 varchar(255) NOT NULL,
    `e_medical`                    enum('HOSPITAL','PHARMACY') NOT NULL,
    `e_recive`                     tinyint      NOT NULL,
    `is_precessed`                 bit(1)       DEFAULT NULL,
    `medical_address`              varchar(255) NOT NULL,
    `medical_characteristics`      varchar(255) DEFAULT NULL,
    `medical_detail_address`       varchar(255) NOT NULL,
    `medical_name`                 varchar(255) NOT NULL,
    `medical_runtime`              varchar(255) DEFAULT NULL,
    `medical_tel`                  varchar(255) NOT NULL,
    `zip_code`                     varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `experts`
(
    `id`                 bigint NOT NULL AUTO_INCREMENT,
    `create_date`        date   NOT NULL,
    `last_modified_date` date   DEFAULT NULL,
    `is_processed`       bit(1) DEFAULT NULL,
    `use_medical`        bigint DEFAULT NULL,
    `use_user`           bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`use_user`) REFERENCES `users` (`id`),
    FOREIGN KEY (`use_medical`) REFERENCES `medicals` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `images`
(
    `id`              bigint       NOT NULL AUTO_INCREMENT,
    `path`            varchar(255) NOT NULL,
    `type`            varchar(255) NOT NULL,
    `uuid_name`       char(41)     NOT NULL,
    `expert_id`       bigint DEFAULT NULL,
    `use_medical`     bigint DEFAULT NULL,
    `registration_id` bigint DEFAULT NULL,
    `use_user`        bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`registration_id`) REFERENCES `registrations` (`id`),
    FOREIGN KEY (`expert_id`) REFERENCES `experts` (`id`),
    FOREIGN KEY (`use_user`) REFERENCES `users` (`id`),
    FOREIGN KEY (`use_medical`) REFERENCES `medicals` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `doses`
(
    `id`              bigint NOT NULL AUTO_INCREMENT,
    `created_at`      datetime(6) NOT NULL,
    `date`            date   NOT NULL,
    `deleted_at`      datetime(6) DEFAULT NULL,
    `is_deleted`      tinyint(1) NOT NULL,
    `is_half`         tinyint(1) NOT NULL,
    `is_taken`        tinyint(1) NOT NULL,
    `pill_cnt`        bigint NOT NULL,
    `time`            enum('AFTERNOON','DEFAULT','EVENING','MORNING') NOT NULL,
    `risks_id`        char(7)      DEFAULT NULL,
    `dosename_id`     varchar(255) DEFAULT NULL,
    `prescription_id` bigint NOT NULL,
    `user_id`         bigint NOT NULL,
    PRIMARY KEY (`id`),
    KEY               `FKopvpsje1yswua17uie823eot8` (`risks_id`),
    KEY               `FK33nr5l4v5kcu28q0bi76qqu55` (`dosename_id`),
    KEY               `FKbombg2eew20wy2skjyko02kr3` (`prescription_id`),
    KEY               `FK31ck2prxo9c95rqumfmaiuoyu` (`user_id`),
    CONSTRAINT `FK31ck2prxo9c95rqumfmaiuoyu` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    CONSTRAINT `FK33nr5l4v5kcu28q0bi76qqu55` FOREIGN KEY (`dosename_id`) REFERENCES `dosenames` (`id`),
    CONSTRAINT `FKbombg2eew20wy2skjyko02kr3` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`id`),
    CONSTRAINT `FKopvpsje1yswua17uie823eot8` FOREIGN KEY (`risks_id`) REFERENCES `risks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `boards`
(
    `id`                 bigint       NOT NULL AUTO_INCREMENT,
    `create_date`        date         NOT NULL,
    `last_modified_date` date   DEFAULT NULL,
    `content`            varchar(255) NOT NULL,
    `disease`            enum('감기몸살','기타질환','남성질환','눈질환','만성질환','소아진료','소화기질환','암관련질환','여성질환','정신질환','치아','통증','피부질환') DEFAULT NULL,
    `is_deleted`         tinyint(1) NOT NULL,
    `is_edit`            tinyint(1) NOT NULL,
    `read_cnt`           bigint       NOT NULL,
    `region`             enum('강남구','강동구','강북구','강서구','관악구','광진구','구로구','금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구','서초구','성동구','성북구','송파구','양천구','영등포구','용산구','은평구','종로구','중구','중랑구') DEFAULT NULL,
    `title`              varchar(255) NOT NULL,
    `user_id`            bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `comments`
(
    `id`                 bigint       NOT NULL AUTO_INCREMENT,
    `create_date`        date         NOT NULL,
    `last_modified_date` date   DEFAULT NULL,
    `context`            varchar(255) NOT NULL,
    `is_deleted`         tinyint      NOT NULL,
    `is_edit`            tinyint      NOT NULL,
    `board_id`           bigint DEFAULT NULL,
    `parent_comment`     bigint DEFAULT NULL,
    `user_id`            bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`parent_comment`) REFERENCES `comments` (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    FOREIGN KEY (`board_id`) REFERENCES `boards` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `likes`
(
    `id`       bigint NOT NULL AUTO_INCREMENT,
    `board_id` bigint NOT NULL,
    `user_id`  bigint NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`board_id`) REFERENCES `boards` (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `surbeys`
(
    `id`           bigint       NOT NULL AUTO_INCREMENT,
    `introduction` varchar(255) NOT NULL,
    `title`        varchar(255) NOT NULL,
    `total_score`  varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `counsels`
(
    `id`                 bigint NOT NULL AUTO_INCREMENT,
    `create_date`        date   NOT NULL,
    `last_modified_date` date DEFAULT NULL,
    `is_deleted`         tinyint(1) NOT NULL,
    `expert_id`          bigint NOT NULL,
    `patient_id`         bigint NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`expert_id`) REFERENCES `users` (`id`),
    FOREIGN KEY (`patient_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- CREATE TABLE `diagnosis`
-- (
--     `id`      bigint       NOT NULL AUTO_INCREMENT,
--     `name`    varchar(255) NOT NULL,
--     `user_id` bigint       NOT NULL,
--     PRIMARY KEY (`id`),
--     FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- CREATE TABLE `healthfoods`
-- (
--     `id`      bigint       NOT NULL AUTO_INCREMENT,
--     `name`    varchar(255) NOT NULL,
--     `user_id` bigint       NOT NULL,
--     PRIMARY KEY (`id`),
--     FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `login_logs`
(
    `id`         bigint NOT NULL AUTO_INCREMENT,
    `login_time` date   NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- CREATE TABLE `notes`
-- (
--     `id`                 bigint NOT NULL AUTO_INCREMENT,
--     `create_date`        date   NOT NULL,
--     `last_modified_date` date         DEFAULT NULL,
--     `description`        varchar(255) DEFAULT NULL,
--     `is_deleted`         tinyint(1) NOT NULL,
--     `is_edit`            tinyint(1) NOT NULL,
--     `title`              varchar(255) DEFAULT NULL,
--     `counsel_id`         bigint NOT NULL,
--     PRIMARY KEY (`id`),
--     FOREIGN KEY (`counsel_id`) REFERENCES `counsels` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `answers`
(
    `id`          bigint       NOT NULL AUTO_INCREMENT,
    `content`     varchar(255) NOT NULL,
    `score`       int          NOT NULL,
    `surbey_id`   bigint DEFAULT NULL,
    `user_id`     bigint DEFAULT NULL,
    `create_date` date         NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
    FOREIGN KEY (`surbey_id`) REFERENCES `surbeys` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `guardians`
(
    `id`          bigint NOT NULL AUTO_INCREMENT,
    `created_at`  datetime(6) DEFAULT NULL,
    `guardian_id` bigint NOT NULL,
    `patient_id`  bigint NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`patient_id`) REFERENCES `users` (`id`),
    FOREIGN KEY (`guardian_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;