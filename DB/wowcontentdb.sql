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
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (1, 'Slay the defiler', 'the defiler is attacking the village', 'https://i.ibb.co/qmXdjgN/45b15b37-2337-4cf7-a20d-aca019baf3ee.webp', '2024-03-04', 1, '2024-03-04', 1, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (2, 'Shadow - Flying Dark Horse', 'huge dark mount with wings', 'https://i.ibb.co/HY78YJ0/DALL-E-2024-03-08-14-15-36-A-majestic-and-massive-dark-mount-with-expansive-wings-inspired-by-the-ae.webp', '2024-03-04', 1, '2024-03-04', 2, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (3, 'End Game Boss - End of Time', 'embodies the essence of cosmic power and control over spacetime', 'https://i.ibb.co/0BWwzx1/DALL-E-2024-03-08-16-03-30-Imagine-a-grand-and-menacing-end-game-boss-for-a-fantasy-video-game-dubbe.webp', 3, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (4, 'History of Dwarfs', 'dwarfs began many years ago ......', 'https://i.ibb.co/h9kKQZp/DALL-E-2024-03-08-14-26-07-Create-a-visual-montage-representing-the-history-of-dwarves-in-a-World-of.webp', '2024-03-04', 1, '2024-03-04', 4, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (5, 'Moonlight Staff', 'long radiant metallic staff', 'https://i.ibb.co/yfQqNHv/DALL-E-2024-03-08-14-30-05-Imagine-a-mystical-staff-inspired-by-the-World-of-Warcraft-theme-named-Mo.webp', '2024-03-04', 1, '2024-03-04', 5, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (6, 'Dragonic Chestplate', 'blackened, charred, spiked chestplate', 'https://i.ibb.co/KqwjJq8/DALL-E-2024-03-08-14-32-44-Design-a-fantastical-chestplate-with-a-dragon-theme-inspired-by-World-of.webp', '2024-03-04', 1, '2024-03-04', 6, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (7, 'Land of Emerald', 'a shimmering gem land with elfs and gem creature', 'https://i.ibb.co/8N1xP6Q/DALL-E-2024-03-08-14-34-55-Visualize-a-breathtaking-and-fantastical-land-called-Land-of-Emeralds-the.webp', '2024-03-04', 1, '2024-03-04', 7, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (8, 'Raid - StormBreach', 'two team charge the breach', 'https://i.ibb.co/RjB0dwv/DALL-E-2024-03-08-14-38-48-Depict-an-epic-scene-for-a-World-of-Warcraft-themed-raid-called-Stormbrea.webp', '2024-03-04', 1, '2024-03-04', 8, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (9, 'More dungeons', 'i want more dungeons in the world', 'https://i.ibb.co/WFf6g9V/DALL-E-2024-03-08-14-40-00-Imagine-a-detailed-and-atmospheric-dungeon-scene-inspired-by-the-World-of.webp', '2024-03-04', 1, '2024-03-04', 9, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (10, 'FishTank', 'player can have a pet fish in a tank the they haul around on their mount', 'https://i.ibb.co/nzpWL7B/DALL-E-2024-03-08-14-41-05-Design-a-whimsical-and-unique-pet-for-World-of-Warcraft-shaped-like-a-fis.webp', '2024-03-04', 1, '2024-03-04', 10, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (11, 'Nightguard', 'a class that uses shadow magic, range, and stealth', 'https://i.ibb.co/DwP1rg6/DALL-E-2024-03-08-14-42-30-Visualize-a-Night-Guard-a-class-from-World-of-Warcraft-that-specializes-i.webp', '2024-03-04', 1, '2024-03-04', 11, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (12, 'Tigaria', 'a race of majestic tigers', 'https://i.ibb.co/F7S9ddw/DALL-E-2024-03-08-14-44-12-Envision-a-new-race-within-the-World-of-Warcraft-universe-named-Tigaria-T.webp', '2024-03-04', 1, '2024-03-04', 12, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (13, 'Whirlwind Fury', 'a talent that attacks all enemies nearby', 'https://i.ibb.co/VLwcbjL/DALL-E-2024-03-08-14-45-44-Visualize-a-World-of-Warcraft-themed-talent-called-Whirlwind-where-a-warr.webp', '2024-03-04', 1, '2024-03-04', 13, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (14, 'The Trench', 'a battleground of trenches ', 'https://i.ibb.co/FYkk9DH/DALL-E-2024-03-08-14-48-44-Imagine-a-World-of-Warcraft-themed-battleground-named-The-Trench-This-sce.webp', '2024-03-04', 1, '2024-03-04', 14, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (15, 'PvP Arena', 'PvP Arena', 'https://i.ibb.co/cc88X9B/DALL-E-2024-03-08-14-47-41-Imagine-a-World-of-Warcraft-themed-Pv-P-Player-vs-Player-Arena-set-in-a-g.webp', '2024-03-04', 1, '2024-03-04', 15, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (16, 'Yismere', 'a npc that guides your through early game content if you want', 'https://i.ibb.co/SnCWcLY/DALL-E-2024-03-08-14-50-26-Visualize-Yismere-a-friendly-non-player-character-NPC-from-the-World-of-W.webp', '2024-03-04', 1, '2024-03-04', 16, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (17, 'Castle Lochrim', 'a dungeon with many bosses and hordes of enemies', 'https://i.ibb.co/Bzzc0Gx/DALL-E-2024-03-08-14-50-20-Depict-the-grand-and-foreboding-Castle-Lochrim-a-dungeon-from-the-World-o.webp', '2024-03-04', 1, '2024-03-04', 17, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (18, 'Parcher', 'a enemy of slime and recongifured plant material', 'https://i.ibb.co/VmP2Y8R/DALL-E-2024-03-08-14-51-46-Imagine-a-new-enemy-from-the-World-of-Warcraft-universe-named-Parcher-com.webp', '2024-03-04', 1, '2024-03-04', 18, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (19, 'Gardening', 'a profession of planting crops', 'https://ibb.co/nfzsdNB"><img src="https://i.ibb.co/5vBWpgk/DALL-E-2024-03-08-14-56-22-Visualize-a-new-profession-in-the-World-of-Warcraft-universe-focused-on-g.webp', '2024-03-04', 1, '2024-03-04', 19, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (20, 'Random Idea', 'how about all players have the options to start at the lvl they want', 'https://i.ibb.co/6tYZVHT/DALL-E-2024-03-08-14-58-14-Imagine-a-whimsical-non-player-character-NPC-in-the-World-of-Warcraft-uni.webp', '2024-03-04', 1, '2024-03-04', 20, 1);
INSERT INTO `content` (`id`, `name`, `description`, `image_url`, `created_date`, `user_id`, `last_update`, `content_category_id`, `enabled`) VALUES (21, 'Found bug', 'found a bug i spawn in the ocean', 'https://i.ibb.co/fNHPYmF/DALL-E-2024-03-08-14-53-39-Imagine-a-humorous-scene-in-the-World-of-Warcraft-universe-depicting-a-co.webp', '2024-03-04', 1, '2024-03-04', 21, 1);

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

