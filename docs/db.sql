SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `rentorento` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `rentorento`;

-- -----------------------------------------------------
-- Table `rentorento`.`user_type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`user_type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `description` VARCHAR(45) NOT NULL ,
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
  `name` VARCHAR(45) NULL ,
  `lastname` VARCHAR(45) NULL ,
  `url` VARCHAR(255) NULL ,
  `phone` VARCHAR(20) NULL ,
  `cellphone` VARCHAR(20) NULL ,
  `address` MEDIUMTEXT NULL ,
  `zip` VARCHAR(5) NULL ,
  `city` VARCHAR(45) NOT NULL ,
  `state` VARCHAR(45) NOT NULL ,
  `country` VARCHAR(45) NOT NULL ,
  `pic` VARCHAR(125) NULL ,
  `status` ENUM('A','B') NOT NULL DEFAULT 'A' ,
  `user_type_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_user_user_type`
    FOREIGN KEY (`user_type_id` )
    REFERENCES `rentorento`.`user_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE INDEX `fk_user_user_type` ON `rentorento`.`user` (`user_type_id` ASC) ;


-- -----------------------------------------------------
-- Table `rentorento`.`type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `description` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentorento`.`rent`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`rent` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `col` VARCHAR(45) NOT NULL ,
  `zip` VARCHAR(5) NOT NULL ,
  `address` TEXT NOT NULL ,
  `city` VARCHAR(45) NOT NULL ,
  `state` VARCHAR(45) NOT NULL ,
  `country` VARCHAR(45) NOT NULL ,
  `lat` FLOAT NULL ,
  `long` FLOAT NULL ,
  `observations` TEXT NULL ,
  `created` DATETIME NOT NULL ,
  `status` ENUM('A','B') NULL DEFAULT 'A' ,
  `rooms` INT NULL ,
  `restrooms` INT NULL ,
  `levels` INT NULL ,
  `price` DOUBLE NOT NULL ,
  `type_id` INT NULL ,
  `user_id` INT NULL ,
  `tags` TEXT NULL,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_rent_type`
    FOREIGN KEY (`type_id` )
    REFERENCES `rentorento`.`type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rent_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `rentorento`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_rent_type` ON `rentorento`.`rent` (`type_id` ASC) ;

CREATE INDEX `fk_rent_user` ON `rentorento`.`rent` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `rentorento`.`pic`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`pic` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `source` VARCHAR(128) NOT NULL ,
  `rent_id` INT NOT NULL ,
  PRIMARY KEY (`id`, `rent_id`) ,
  CONSTRAINT `fk_pic_rent`
    FOREIGN KEY (`rent_id` )
    REFERENCES `rentorento`.`rent` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pic_rent` ON `rentorento`.`pic` (`rent_id` ASC) ;


-- -----------------------------------------------------
-- Table `rentorento`.`history`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`history` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `rent_id` INT NOT NULL ,
  PRIMARY KEY (`id`, `user_id`, `rent_id`) ,
  CONSTRAINT `fk_history_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `rentorento`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_history_rent`
    FOREIGN KEY (`rent_id` )
    REFERENCES `rentorento`.`rent` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_history_user` ON `rentorento`.`history` (`user_id` ASC) ;

CREATE INDEX `fk_history_rent` ON `rentorento`.`history` (`rent_id` ASC) ;


-- -----------------------------------------------------
-- Table `rentorento`.`comments`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rentorento`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `comment` TEXT NULL ,
  `email` VARCHAR(128) NOT NULL ,
  `user`  VARCHAR(45) NOT NULL ,
  `rent_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_comments_rent`
    FOREIGN KEY (`rent_id` )
    REFERENCES `rentorento`.`rent` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_comments_rent` ON `rentorento`.`comments` (`rent_id` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
