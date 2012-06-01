SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `rentorento` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `rentorento` ;

-- -----------------------------------------------------
-- Table `rentorento`.`role`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentorento`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(128) NOT NULL ,
  `status` BIT NOT NULL DEFAULT 0 ,
  `role_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `fk_user_role1` (`role_id` ASC) ,
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`role_id` )
    REFERENCES `rentorento`.`role` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentorento`.`user_profile`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`user_profile` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `lastname` VARCHAR(45) NOT NULL ,
  `phone` VARCHAR(20) NULL ,
  `cellphone` VARCHAR(20) NULL ,
  `address` MEDIUMTEXT NULL ,
  `zip` VARCHAR(5) NULL ,
  `city` VARCHAR(45) NOT NULL ,
  `state` VARCHAR(45) NOT NULL ,
  `country` VARCHAR(45) NOT NULL ,
  `url` VARCHAR(255) NULL ,
  `pic` VARCHAR(125) NULL ,
  `created_date` TIMESTAMP NOT NULL ,
  `last_login` TIMESTAMP NULL ,
  `user_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_user_profile_user1` (`user_id` ASC) ,
  CONSTRAINT `fk_user_profile_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `rentorento`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `rentorento`.`estate_type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`estate_type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `type` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentorento`.`estate`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`estate` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `city` VARCHAR(45) NOT NULL ,
  `state` VARCHAR(45) NOT NULL ,
  `country` VARCHAR(45) NOT NULL ,
  `address` TEXT NOT NULL ,
  `zip` VARCHAR(5) NOT NULL ,
  `zone` VARCHAR(45) NOT NULL ,
  `lat` FLOAT NULL ,
  `long` FLOAT NULL ,
  `description` TEXT NULL ,
  `price` DOUBLE NOT NULL ,
  `create_date` TIMESTAMP NOT NULL ,
  `status` BIT NOT NULL DEFAULT 1 ,
  `views` INT NOT NULL DEFAULT 0 ,
  `user_id` INT NOT NULL ,
  `estate_type_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_estate_user1` (`user_id` ASC) ,
  INDEX `fk_estate_estate_type1` (`estate_type_id` ASC) ,
  CONSTRAINT `fk_estate_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `rentorento`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estate_estate_type1`
    FOREIGN KEY (`estate_type_id` )
    REFERENCES `rentorento`.`estate_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentorento`.`estate_picture`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`estate_picture` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `source` VARCHAR(128) NOT NULL ,
  `estate_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_estate_picture_estate1` (`estate_id` ASC) ,
  CONSTRAINT `fk_estate_picture_estate1`
    FOREIGN KEY (`estate_id` )
    REFERENCES `rentorento`.`estate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentorento`.`log`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`log` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` TIMESTAMP NOT NULL ,
  `type` INT NULL ,
  `description` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentorento`.`comments`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(128) NULL ,
  `comment` TEXT NOT NULL ,
  `post_date` TIMESTAMP NOT NULL ,
  `estate_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_comments_estate1` (`estate_id` ASC) ,
  CONSTRAINT `fk_comments_estate1`
    FOREIGN KEY (`estate_id` )
    REFERENCES `rentorento`.`estate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentorento`.`estate_stats`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`estate_stats` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `view` TIMESTAMP NULL ,
  `location` VARCHAR(45) NULL COMMENT 'Ubicación Lat;Long de la persona que ve el inmuble con el fin de mostrar en un mapa todas las ubicaciones de donde ha sido visitado.' ,
  `estate_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_estate_stats_estate1` (`estate_id` ASC) ,
  CONSTRAINT `fk_estate_stats_estate1`
    FOREIGN KEY (`estate_id` )
    REFERENCES `rentorento`.`estate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
