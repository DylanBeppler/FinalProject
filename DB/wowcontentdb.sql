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
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `quest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quest` ;

CREATE TABLE IF NOT EXISTS `quest` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `created_date` DATETIME NULL,
  `upvote` INT NULL,
  `downvote` INT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_quest_user_idx` (`user_id` ASC),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC),
  CONSTRAINT `fk_quest_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boss`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boss` ;

CREATE TABLE IF NOT EXISTS `boss` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `location` TEXT NULL,
  `created_date` DATETIME NULL,
  `upvote` INT NULL,
  `downvote` INT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_boss_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  CONSTRAINT `fk_boss_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mount` ;

CREATE TABLE IF NOT EXISTS `mount` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `how_obtained` TEXT NULL,
  `upvote` INT NULL,
  `downvote` INT NULL,
  `created_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `int_UNIQUE` (`id` ASC),
  INDEX `fk_mount_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  CONSTRAINT `fk_mount_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
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
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `join_date`, `email`, `role`) VALUES (1, 'blake', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, '2024/03/04', 'blake', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `join_date`, `email`, `role`) VALUES (2, 'zach', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, '2024/03/04', 'zach', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `join_date`, `email`, `role`) VALUES (3, 'dylan', '$2a$10$nShOi5/f0bKNvHB8x0u3qOpeivazbuN0NE4TO0LGvQiTMafaBxLJS', 1, '2024/03/04', 'dylan', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `quest`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `quest` (`id`, `title`, `description`, `created_date`, `upvote`, `downvote`, `user_id`) VALUES (1, 'get the new armor set', 'go to the darkland to defeat boss and get the new powered up armor kit', '2024/03/04', 0, 0, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `boss`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `boss` (`id`, `name`, `description`, `location`, `created_date`, `upvote`, `downvote`, `user_id`) VALUES (1, 'boss', 'boss description', 'america', '2024/03/04', 0, 0, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mount`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `mount` (`id`, `name`, `description`, `how_obtained`, `upvote`, `downvote`, `created_date`, `user_id`) VALUES (1, 'mounth', 'mount description', 'how to obtain mount', 0, 0, '2024/03/04', 1);

COMMIT;

