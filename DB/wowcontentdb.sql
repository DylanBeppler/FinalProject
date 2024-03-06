-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema wowcontentdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `wowcontentdb` ;

-- -----------------------------------------------------
-- Schema wowcontentdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wowcontentdb` DEFAULT CHARACTER SET utf8 ;
USE `wowcontentdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `join_date` DATETIME NULL,
  `email` VARCHAR(150) NULL,
  `role` VARCHAR(45) NULL DEFAULT 'standard',
  `about_me` TEXT NULL,
  `avatar_url` VARCHAR(2000) NULL,
  `last_updated` DATETIME NULL,
  `battletag` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_category` ;

CREATE TABLE IF NOT EXISTS `content_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content` ;

CREATE TABLE IF NOT EXISTS `content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  `created_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  `last_update` DATETIME NULL,
  `content_category_id` INT NOT NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `int_UNIQUE` (`id` ASC),
  INDEX `fk_mount_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_content_content_category1_idx` (`content_category_id` ASC),
  CONSTRAINT `fk_mount_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_content_category1`
    FOREIGN KEY (`content_category_id`)
    REFERENCES `content_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_has_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_has_content` ;

CREATE TABLE IF NOT EXISTS `content_has_content` (
  `content_id` INT NOT NULL,
  `content_id1` INT NOT NULL,
  PRIMARY KEY (`content_id`, `content_id1`),
  INDEX `fk_content_has_content_content2_idx` (`content_id1` ASC),
  INDEX `fk_content_has_content_content1_idx` (`content_id` ASC),
  CONSTRAINT `fk_content_has_content_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_has_content_content2`
    FOREIGN KEY (`content_id1`)
    REFERENCES `content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `image_url`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image_url` ;

CREATE TABLE IF NOT EXISTS `image_url` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(2000) NULL,
  `caption` VARCHAR(45) NULL,
  `created_date` DATETIME NULL,
  `update_date` DATETIME NULL,
  `content_id` INT NOT NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_image_url_content1_idx` (`content_id` ASC),
  CONSTRAINT `fk_image_url_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_comment` ;

CREATE TABLE IF NOT EXISTS `content_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment_date` DATETIME NULL,
  `message` TEXT NULL,
  `user_id` INT NOT NULL,
  `content_id` INT NOT NULL,
  `reply_to_id` INT NULL,
  `enabled` TINYINT NULL,
  `image_url` VARCHAR(2000) NULL,
  `updated_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_comment_content1_idx` (`content_id` ASC),
  INDEX `fk_comment_comment1_idx` (`reply_to_id` ASC),
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_comment1`
    FOREIGN KEY (`reply_to_id`)
    REFERENCES `content_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_vote` ;

CREATE TABLE IF NOT EXISTS `content_vote` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `content_id` INT NOT NULL,
  `upvoted` TINYINT NULL,
  `vote_date` DATETIME NULL,
  PRIMARY KEY (`id`, `user_id`, `content_id`),
  INDEX `fk_user_has_content_content1_idx` (`content_id` ASC),
  INDEX `fk_user_has_content_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `user_id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_user_has_content_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_content_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS user@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'user'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `join_date`, `email`, `role`, `about_me`, `avatar_url`, `last_updated`, `battletag`) VALUES (1, 'blake', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, '2024/03/04', 'blake', 'test', 'test', 'test', '2024/03/23', 'test');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `join_date`, `email`, `role`, `about_me`, `avatar_url`, `last_updated`, `battletag`) VALUES (2, 'zach', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, '2024/03/04', 'zach', 'test', 'test', 'test', '2024/03/23', 'test');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `join_date`, `email`, `role`, `about_me`, `avatar_url`, `last_updated`, `battletag`) VALUES (3, 'dylan', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, '2024/03/04', 'dylan', 'test', 'test', 'test', '2024/03/23', 'test');

COMMIT;


-- -----------------------------------------------------
-- Data for table `content_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (1, 'Quest', 'test', 'test');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (2, 'Mount', 'test', 'test');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (3, 'Boss', 'test', 'test');

COMMIT;


-- -----------------------------------------------------
-- Data for table `content`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (1, 'mount', 'mount description', 'how to obtain mount', '2024-03-04', 1, '2024-03-04', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `content_has_content`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `content_has_content` (`content_id`, `content_id1`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `image_url`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `image_url` (`id`, `url`, `caption`, `created_date`, `update_date`, `content_id`, `enabled`) VALUES (1, 'test', 'test', '2024/03/24', '2024/03/24', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `content_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (1, '2024/03/04', 'test', 1, 1, 1, 1, 'test', '2024/03/24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `content_vote`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (1, 1, 1, false, '2024/03/05');

COMMIT;

