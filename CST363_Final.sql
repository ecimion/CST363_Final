-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema cst363final
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cst363final
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cst363final` DEFAULT CHARACTER SET utf8 ;
USE `cst363final` ;

-- -----------------------------------------------------
-- Table `cst363final`.`Movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cst363final`.`Movies` (
  `MovieId` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NOT NULL,
  `Year` INT NOT NULL,
  `Genre` VARCHAR(15) NOT NULL,
  UNIQUE INDEX `MovieId_UNIQUE` (`MovieId` ASC),
  PRIMARY KEY (`MovieId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cst363final`.`Actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cst363final`.`Actors` (
  `ActorId` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(30) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `AcademyAwardWinner` CHAR(1) NOT NULL,
  PRIMARY KEY (`ActorId`),
  UNIQUE INDEX `ActorId_UNIQUE` (`ActorId` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cst363final`.`Director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cst363final`.`Director` (
  `DirectorId` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(30) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DirectorId`),
  UNIQUE INDEX `DirectorId_UNIQUE` (`DirectorId` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cst363final`.`MovieStats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cst363final`.`MovieStats` (
  `MovieId` INT NOT NULL,
  `Budget` DECIMAL(15,2) NULL DEFAULT NULL,
  `Gross` DECIMAL(15,2) NULL,
  `AcademyAwards` INT NOT NULL DEFAULT 0,
  `AvgUserRating` DECIMAL(2,2) NULL DEFAULT 0.00,
  PRIMARY KEY (`MovieId`),
  CONSTRAINT `MovieId`
    FOREIGN KEY (`MovieId`)
    REFERENCES `cst363final`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cst363final`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cst363final`.`Users` (
  `UserId` INT NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(15) NOT NULL,
  `FirstName` VARCHAR(30) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC),
  UNIQUE INDEX `UserId_UNIQUE` (`UserId` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cst363final`.`CastCrew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cst363final`.`CastCrew` (
  `MovieId` INT NOT NULL,
  `LeadActor` INT NOT NULL,
  `Director` INT NOT NULL,
  PRIMARY KEY (`MovieId`),
  INDEX `FK_LeadActor_idx` (`LeadActor` ASC),
  INDEX `FK_Director_idx` (`Director` ASC),
  CONSTRAINT `FK_LeadActor`
    FOREIGN KEY (`LeadActor`)
    REFERENCES `cst363final`.`Actors` (`ActorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Director`
    FOREIGN KEY (`Director`)
    REFERENCES `cst363final`.`Director` (`DirectorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MovieId`
    FOREIGN KEY (`MovieId`)
    REFERENCES `cst363final`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cst363final`.`MovieRatings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cst363final`.`MovieRatings` (
  `MovieId` INT NOT NULL,
  `UserId` INT NOT NULL,
  `Rating` DECIMAL(2,2) NULL DEFAULT 0.00,
  PRIMARY KEY (`MovieId`, `UserId`),
  INDEX `fk_Movies_has_Users_Users1_idx` (`UserId` ASC),
  INDEX `fk_Movies_has_Users_Movies1_idx` (`MovieId` ASC),
  CONSTRAINT `fk_Movies_Users_Movies1`
    FOREIGN KEY (`MovieId`)
    REFERENCES `cst363final`.`Movies` (`MovieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movies_Users_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `cst363final`.`Users` (`UserId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
