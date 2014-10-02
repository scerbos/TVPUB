SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `tvpub` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `tvpub` ;

-- -----------------------------------------------------
-- Table `tvpub`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(255) NOT NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `hash` TEXT NOT NULL ,
  `picture` VARCHAR(255) NULL ,
  `salt` TEXT NOT NULL ,
  `role` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`series`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`series` (
  `id` INT NOT NULL ,
  `air_day` DATE NULL ,
  `air_time` TIME NULL ,
  `IMDB_ID` INT NULL ,
  `network` VARCHAR(45) NULL ,
  `overview` TEXT NULL ,
  `rating_tvdb` DECIMAL(8) NULL ,
  `runtime` INT NULL ,
  `name` VARCHAR(255) NULL ,
  `status` VARCHAR(45) NULL ,
  `banner` VARCHAR(255) NULL ,
  `fanart` VARCHAR(255) NULL ,
  `poster` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`user_to_series`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`user_to_series` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `rating` DECIMAL(8) NULL ,
  `comment` TEXT NULL ,
  `user_id` INT NULL ,
  `series_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `user_id_idx` (`user_id` ASC) ,
  INDEX `series_id_idx` (`series_id` ASC) ,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_to_series_id` )
    REFERENCES `tvpub`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `series_to_user_id`
    FOREIGN KEY (`series_id` )
    REFERENCES `tvpub`.`series` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`episode`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`episode` (
  `id` INT NOT NULL ,
  `director` VARCHAR(255) NULL ,
  `name` VARCHAR(255) NULL ,
  `episode_number` INT NULL ,
  `air_date` DATE NULL ,
  `overview` TEXT NULL ,
  `rating_tvdb` DECIMAL(8) NULL ,
  `season_number` INT NULL ,
  `combined_episode_number` INT NULL ,
  `guest_stars` TEXT NULL ,
  `writers` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`series_to_episode`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`series_to_episode` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `series_id` INT NULL ,
  `episode_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `series_id_idx` (`series_id` ASC) ,
  INDEX `episode_id_idx` (`episode_id` ASC) ,
  CONSTRAINT `series_to_episode_id`
    FOREIGN KEY (`series_id` )
    REFERENCES `tvpub`.`series` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `episode_to_series_id`
    FOREIGN KEY (`episode_id` )
    REFERENCES `tvpub`.`episode` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`actor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`actor` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`series_to_actor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`series_to_actor` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `actor_id` INT NULL ,
  `series_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `actor_id_idx` (`actor_id` ASC) ,
  INDEX `series_id_idx` (`series_id` ASC) ,
  CONSTRAINT `actor_to_series_id`
    FOREIGN KEY (`actor_id` )
    REFERENCES `tvpub`.`actor` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `series_to_actor_id`
    FOREIGN KEY (`series_id` )
    REFERENCES `tvpub`.`series` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`genre`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`genre` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `genre` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`genre_to_series`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`genre_to_series` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `genre_id` INT NULL ,
  `series_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `genre_id_idx` (`genre_id` ASC) ,
  INDEX `series_id_idx` (`series_id` ASC) ,
  CONSTRAINT `genre_to_series_id`
    FOREIGN KEY (`genre_id` )
    REFERENCES `tvpub`.`genre` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `series_to_genre_id`
    FOREIGN KEY (`series_id` )
    REFERENCES `tvpub`.`series` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`user_to_user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`user_to_user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order` INT NULL ,
  `circle` VARCHAR(255) NULL ,
  `user1_id` INT NULL ,
  `user2_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `user1_id_idx` (`user1_id` ASC) ,
  INDEX `user_id_idx` (`user2_id` ASC) ,
  CONSTRAINT `user1_to_user2_id`
    FOREIGN KEY (`user1_id` )
    REFERENCES `tvpub`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user2_to_user1_id`
    FOREIGN KEY (`user2_id` )
    REFERENCES `tvpub`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tvpub`.`message`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tvpub`.`message` (
  `id` VARCHAR(255) NOT NULL ,
  `sender_id` INT NOT NULL ,
  `receiver_id` INT NOT NULL ,
  `message` TEXT NOT NULL ,
  `visible` TINYINT(1) NULL ,
  `episode_id` INT NULL ,
  `message_id` VARCHAR(255) NULL ,
  `group_id` VARCHAR(255) NULL ,
  `date_time` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `group_id_UNIQUE` (`group_id` ASC) ,
  INDEX `sender1_id_idx` (`sender_id` ASC) ,
  INDEX `receiver_id_idx` (`receiver_id` ASC) ,
  INDEX `message_id_idx` (`message_id` ASC) ,
  INDEX `episode_id_idx` (`episode_id` ASC) ,
  CONSTRAINT `sender_id`
    FOREIGN KEY (`sender_id` )
    REFERENCES `tvpub`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `receiver_id`
    FOREIGN KEY (`receiver_id` )
    REFERENCES `tvpub`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `message_id`
    FOREIGN KEY (`message_id` )
    REFERENCES `tvpub`.`message` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `episode_id`
    FOREIGN KEY (`episode_id` )
    REFERENCES `tvpub`.`episode` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
