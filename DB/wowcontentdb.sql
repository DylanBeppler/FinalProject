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
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (1, 'Quests', '', 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/63ee7afd388fe3520cb02fee0f8b58a51f00b0bf.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (2, 'Mounts', '', 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/7de44c39332154e58370af227f95c155756b7286.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (3, 'Bosses', '', 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/7de44c39332154e58370af227f95c155756b7286.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (4, 'Lore', '', 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/39a0034512f6fbb16e490230efd967b1a1acc419.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (5, 'Weapons', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/17918ffe1591a61cc2539b8dfedc0d237eee424c.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (6, 'Armour', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/220a7009100920c2c60aa5e0a40ecef84c9519ec.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (7, 'Maps', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/d2ee0bfd0246a33ae9d21d8efde7bffa62acc19f.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (8, 'Raids', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/c1d985cd6bd161dff6bf57efa884044cc300bc18.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (9, 'World Content', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/d2ee0bfd0246a33ae9d21d8efde7bffa62acc19f.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (10, 'Pets', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/9176d7d24ad4ca88ac253d00178d7d3934ffddf5.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (11, 'Classes', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/f734c67ef0107959d7283bd5b4616ac90fab6c8e.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (12, 'Races', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/7b1055295ce3be6b346a54c4ffc35dacd7a19ac4.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (13, 'Talents', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/f734c67ef0107959d7283bd5b4616ac90fab6c8e.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (14, 'Battlegrounds', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/17918ffe1591a61cc2539b8dfedc0d237eee424c.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (15, 'PvP Arenas', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/17918ffe1591a61cc2539b8dfedc0d237eee424c.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (16, 'NPCs', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/39a0034512f6fbb16e490230efd967b1a1acc419.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (17, 'Dungeons', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/c1d985cd6bd161dff6bf57efa884044cc300bc18.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (18, 'Enemies', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/17918ffe1591a61cc2539b8dfedc0d237eee424c.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (19, 'Professions', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/011314afd12d685b507d463b256e13277e5511fc.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (20, 'Other', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/561423e9a5ffc89fd1a6f61ae4afe623104a17d4.png');
INSERT INTO `content_category` (`id`, `name`, `description`, `image_url`) VALUES (21, 'Bugs', NULL, 'https://assets-wowusen-blz-prod-us.s3.dualstack.us-west-2.amazonaws.com/original/1X/c36047da3a5849e44de9160a102c554099003b40.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `content`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (1, 'Slay the defiler', 'the defiler is attacking the village', 'https://files.oaiusercontent.com/file-0woEcUwHVZZUUv1ucpOUYASY?se=2024-03-08T19%3A55%3A55Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D45b15b37-2337-4cf7-a20d-aca019baf3ee.webp&sig=U47V9OuOEH9AFPeqbiykSbK1LTmtnMsmyHp9Jw2I3fA%3D', '2024-03-04', 1, '2024-03-04', 1, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (2, 'Shadow - Flying Dark Horse', 'huge dark mount with wings', 'https://files.oaiusercontent.com/file-9cRvW4GorXGG9ffj4SZRYy2x?se=2024-03-08T19%3A58%3A33Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D0f2170d9-5e40-413f-98e7-1d6b66e0251c.webp&sig=AkNklXZKfrS31KsoSyF73t1OLpJaGul3KGf4ld4kpuk%3D', '2024-03-04', 1, '2024-03-04', 2, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (3, 'Bolrag - the flame demon', 'giant flame moss in the mine of moria', 'https://upload.wikimedia.org/wikipedia/en/thumb/7/7f/Balrog500ppx.png/300px-Balrog500ppx.png', '2024-03-04', 1, '2024-03-04', 3, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (4, 'History of Dwarfs', 'dwarfs began many years ago ......', 'https://files.oaiusercontent.com/file-4PdWdtM7Ke5eBimeT47qLO6h?se=2024-03-08T20%3A00%3A46Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D18f64cd2-a63e-4f3c-bfe5-6488c477391b.webp&sig=dVj1Alqb/QcFRHk%2Bid777uSCQAj96OhDWPFkdjmNz34%3D', '2024-03-04', 1, '2024-03-04', 4, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (5, 'Moonlight Staff', 'long radiant metallic staff', 'https://files.oaiusercontent.com/file-1uAd2ExnaFFGhE0rGZFIBO86?se=2024-03-08T20%3A02%3A26Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D85632ac7-b7fe-49d4-b0ff-2222cbea5441.webp&sig=2c7mjEt5nfyYsVXVi7dxFXvB/ZaXFtugRCXtQ/SXY4c%3D', '2024-03-04', 1, '2024-03-04', 5, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (6, 'Dragonic Chestplate', 'blackened, charred, spiked chestplate', 'https://files.oaiusercontent.com/file-C1hlC1QTjc73JU8XdIqFS461?se=2024-03-08T20%3A05%3A18Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D5fa48961-9c7b-45e0-a416-5768937fcb7d.webp&sig=b4SvE2IEKpDwNp2FXxpEyPupZrkFclErbXTjNzbqyX8%3D', '2024-03-04', 1, '2024-03-04', 6, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (7, 'Land of Emerald', 'a shimmering gem land with elfs and gem creature', 'https://files.oaiusercontent.com/file-Z90XdLT07WdWkvNLT7nMAvsM?se=2024-03-08T20%3A06%3A35Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3Dea297742-a43b-45b7-af96-7cc741cbd0a9.webp&sig=sy8sYROG8ARVKWk3XwKTSvoa/CnTLj1FN2I2%2BuVNr2g%3D', '2024-03-04', 1, '2024-03-04', 7, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (8, 'Raid - StormBreach', 'two team charge the breach', 'https://files.oaiusercontent.com/file-SXd00BN5f37co4w58w2ILfly?se=2024-03-08T20%3A08%3A14Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D16971f29-4062-4eca-9948-c5227bd1dfe6.webp&sig=PCjA8rCT9bLcGoFI9TfbFf8H3iDscAzLuEs38PLLWnk%3D', '2024-03-04', 1, '2024-03-04', 8, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (9, 'More dungeons', 'i want more dungeons in the world', 'https://files.oaiusercontent.com/file-jKucwoLNwxtEkIgSVkJFvUZe?se=2024-03-08T20%3A10%3A04Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D1904ccdb-54c3-4f4b-9c75-e6ea42fc80b3.webp&sig=oIZE4EWT5fF/X5uODvdjtpes%2Bs0zlUafvHmywXMry%2B0%3D', '2024-03-04', 1, '2024-03-04', 9, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (10, 'FishTank', 'player can have a pet fish in a tank the they haul around on their mount', 'https://files.oaiusercontent.com/file-MjJfWw9pQ7jmQKq4VpFRZi91?se=2024-03-08T20%3A11%3A35Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D1fec9d87-9ec4-4322-9af5-3b25adb064b9.webp&sig=j7o/AsafZpRRm/98Vs6j8djN8cNlRhF1PEbikvxpQMc%3D', '2024-03-04', 1, '2024-03-04', 10, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (11, 'Nightguard', 'a class that uses shadow magic, range, and stealth', 'https://files.oaiusercontent.com/file-IWGlnTb2IYQfC9o6v4V535x1?se=2024-03-08T20%3A13%3A46Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D188fc83a-73bf-4f3b-a6f7-2ff2c02ad9ed.webp&sig=hzu3UeEOLJh7AupsmexcMzJVkn35AS2knBg91z2tQao%3D', '2024-03-04', 1, '2024-03-04', 11, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (12, 'Tigaria', 'a race of majestic tigers', 'https://files.oaiusercontent.com/file-3sfVbzXz8BoHPig9iczHalYt?se=2024-03-08T20%3A15%3A24Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D4b4c8c64-0d89-4990-aa23-5089bcbab8d5.webp&sig=40BcKHh6srkzvdscWISjbvrk8imc5gAzpmcSp/OAkI4%3D', '2024-03-04', 1, '2024-03-04', 12, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (13, 'Whirlwind Fury', 'a talent that attacks all enemies nearby', 'https://files.oaiusercontent.com/file-3OqVD4M9EH1dzRrvMY6437hW?se=2024-03-08T20%3A17%3A24Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3Da31f7647-5c7d-46cf-8e35-d441a520e756.webp&sig=rv/J9ocnoZC2%2BX4xTWHL94RN0CAipPMDDMRyRyDstcs%3D', '2024-03-04', 1, '2024-03-04', 13, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (14, 'The Trench', 'a battleground of trenches ', 'https://files.oaiusercontent.com/file-WcrxqhyHExZzPGjFHRm85VH7?se=2024-03-08T20%3A21%3A41Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D70c1c856-d0d2-478f-9c2a-8ef6361843a6.webp&sig=iHM/8XgunaZrOIERttayjatLlDhYNzhOtO5g5m/rh60%3D', '2024-03-04', 1, '2024-03-04', 14, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (15, 'PvP Arena', 'PvP Arena', 'https://files.oaiusercontent.com/file-P23IrSmzJbmNvyCRkJiguiHY?se=2024-03-08T20%3A18%3A35Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D7befacb4-c944-481a-b2d0-801f38763d8e.webp&sig=AlmPv25X9vPjrdUgapgmGzICtZdshmUp%2B/tOk79XLho%3D', '2024-03-04', 1, '2024-03-04', 15, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (16, 'Yismere', 'a npc that guides your through early game content if you want', 'https://files.oaiusercontent.com/file-q9UwIHIgPSmYCnimWOgxhr9i?se=2024-03-08T20%3A19%3A47Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D1a242abc-ffb5-4734-b50c-4900c44e4e54.webp&sig=gZ7ekvHtEYGhDc0lvcKseuloKuNuvnSbPgDBuaaNJHk%3D', '2024-03-04', 1, '2024-03-04', 16, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (17, 'Castle Lochrim', 'a dungeon with many bosses and hordes of enemies', 'https://files.oaiusercontent.com/file-HzyExwfO2LkR1HjI7UOwg2Vz?se=2024-03-08T20%3A22%3A49Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D95cf4c2a-9bcc-4950-92cb-f259dcad7537.webp&sig=n1E/IcccAZOOxYfMxU0oEg5PLnQEZsMwqWTmT/secZY%3D', '2024-03-04', 1, '2024-03-04', 17, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (18, 'Parcher', 'a enemy of slime and recongifured plant material', 'https://files.oaiusercontent.com/file-RtZy9sxtPOlgyV4utQJmhcBk?se=2024-03-08T20%3A24%3A21Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D05f815e8-f7d1-46db-aace-2760a0bfa035.webp&sig=rmjXd7BAXp7jc8R4Jz6VYCMisN8RjMvOuc1OCbYHcMM%3D', '2024-03-04', 1, '2024-03-04', 18, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (19, 'Gardening', 'a profession of planting crops', 'https://files.oaiusercontent.com/file-qQHEvPDAAa3P3USBPTe5evTT?se=2024-03-08T20%3A25%3A34Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D894b7f62-cdc5-4f6d-9b9b-7d8bbf2f203d.webp&sig=/lG2pWmFOZaoRJFgtYj4XWKIcAPGrj/bd%2BTfXJ6OZxg%3D', '2024-03-04', 1, '2024-03-04', 19, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (20, 'Random Idea', 'how about all players have the options to start at the lvl they want', 'https://files.oaiusercontent.com/file-WODHdPi6qqIDOc7dktjYqOfR?se=2024-03-08T20%3A28%3A56Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D41af5993-af97-4183-a883-f906d139f2ed.webp&sig=ihuwpGA0lj3SGp8r2UY8W1PDWE9CanhftLFSHjHLdr4%3D', '2024-03-04', 1, '2024-03-04', 20, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (21, 'Found bug', 'found a bug i spawn in the ocean', 'https://files.oaiusercontent.com/file-uxgeJkkfxIVzbDg8EbFPpmwq?se=2024-03-08T20%3A27%3A48Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3De8af5ffe-70f9-43ac-95c3-027edc4eee92.webp&sig=Cjb3Q9HWGKl0cNWA0PTDwUdaPwqE9RoUdTHIjsyYwSw%3D', '2024-03-04', 1, '2024-03-04', 21, 1);

COMMIT;



-- -----------------------------------------------------
-- Data for table `content_has_content`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `content_has_content` (`content_id`, `content_id1`) VALUES (1, 2);
INSERT INTO `content_has_content` (`content_id`, `content_id1`) VALUES (1, 3);
INSERT INTO `content_has_content` (`content_id`, `content_id1`) VALUES (1, 7);

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
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (2, '2024/03/04', 'test', 1, 2, 2, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (3, '2024/03/04', 'test', 1, 3, 3, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (4, '2024/03/04', 'test', 1, 4, 4, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (5, '2024/03/04', 'test', 1, 5, 5, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (6, '2024/03/04', 'test', 1, 6, 6, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (7, '2024/03/04', 'test', 1, 7, 7, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (8, '2024/03/04', 'test', 1, 8, 8, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (9, '2024/03/04', 'test', 1, 9, 9, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (10, '2024/03/04', 'test', 1, 10, 10, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (11, '2024/03/04', 'test', 1, 11, 11, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (12, '2024/03/04', 'test', 1, 12, 12, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (13, '2024/03/04', 'test', 1, 13, 13, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (14, '2024/03/04', 'test', 1, 14, 14, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (15, '2024/03/04', 'test', 1, 15, 15, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (16, '2024/03/04', 'test', 1, 16, 16, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (17, '2024/03/04', 'test', 1, 17, 17, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (18, '2024/03/04', 'test', 1, 18, 18, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (19, '2024/03/04', 'test', 1, 19, 19, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (20, '2024/03/04', 'test', 1, 20, 20, 1, 'test', '2024/03/24');
INSERT INTO `content_comment` (`id`, `comment_date`, `message`, `user_id`, `content_id`, `reply_to_id`, `enabled`, `image_url`, `updated_date`) VALUES (21, '2024/03/04', 'test', 1, 21, 21, 1, 'test', '2024/03/24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `content_vote`
-- -----------------------------------------------------
START TRANSACTION;
USE `wowcontentdb`;
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (1, 1, 1, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (2, 1, 2, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (3, 1, 3, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (4, 1, 4, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (5, 1, 5, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (6, 1, 6, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (7, 1, 7, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (8, 1, 8, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (9, 1, 9, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (10, 1, 10, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (11, 1, 11, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (12, 1, 12, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (13, 1, 13, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (14, 1, 14, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (15, 1, 15, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (16, 1, 16, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (17, 1, 17, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (18, 1, 18, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (19, 1, 19, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (20, 1, 20, false, '2024/03/05');
INSERT INTO `content_vote` (`id`, `user_id`, `content_id`, `upvoted`, `vote_date`) VALUES (21, 1, 21, false, '2024/03/05');

COMMIT;

