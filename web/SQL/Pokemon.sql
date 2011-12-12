SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `Pokemon` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `Pokemon` ;

-- -----------------------------------------------------
-- Table `Pokemon`.`User`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Pokemon`.`User` (
  `userid` BIGINT auto_increment NOT NULL ,
  `username` VARCHAR(16) NOT NULL ,
  `password` VARCHAR(160) NOT NULL ,
  `type` SMALLINT NOT NULL,
  PRIMARY KEY (`userid`) ,
  UNIQUE KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

