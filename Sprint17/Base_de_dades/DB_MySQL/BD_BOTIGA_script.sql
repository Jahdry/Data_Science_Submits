-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BD_Botiga
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BD_Botiga
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD_Botiga` DEFAULT CHARACTER SET utf8 ;
USE `BD_Botiga` ;

-- -----------------------------------------------------
-- Table `BD_Botiga`.`PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`PERSONA` (
  `DNI` VARCHAR(45) NOT NULL,
  `Nom` VARCHAR(45) NULL,
  `Cognoms` VARCHAR(45) NULL,
  `Adress` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Telefons` VARCHAR(45) NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Botiga`.`CLIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`CLIENT` (
  `CodiClient` INT NOT NULL,
  `PERSONA_DNI` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodiClient`, `PERSONA_DNI`),
  INDEX `fk_CLIENT_PERSONA1_idx` (`PERSONA_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENT_PERSONA1`
    FOREIGN KEY (`PERSONA_DNI`)
    REFERENCES `BD_Botiga`.`PERSONA` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Botiga`.`TREBALLADOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`TREBALLADOR` (
  `CodiTreb` INT NOT NULL,
  `Torn` VARCHAR(45) NULL,
  `Salari` VARCHAR(45) NULL,
  `PERSONA_DNI` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodiTreb`, `PERSONA_DNI`),
  INDEX `fk_TREBALLADOR_PERSONA1_idx` (`PERSONA_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_TREBALLADOR_PERSONA1`
    FOREIGN KEY (`PERSONA_DNI`)
    REFERENCES `BD_Botiga`.`PERSONA` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Botiga`.`ESTABLIMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`ESTABLIMENT` (
  `CodiEstab` INT NOT NULL,
  `NomEstab` VARCHAR(45) NULL,
  `AdreçaEstab` VARCHAR(150) NULL,
  `TREBALLADOR_CodiTreb` INT NOT NULL,
  PRIMARY KEY (`CodiEstab`),
  INDEX `fk_ESTABLIMENT_TREBALLADOR1_idx` (`TREBALLADOR_CodiTreb` ASC) VISIBLE,
  CONSTRAINT `fk_ESTABLIMENT_TREBALLADOR1`
    FOREIGN KEY (`TREBALLADOR_CodiTreb`)
    REFERENCES `BD_Botiga`.`TREBALLADOR` (`CodiTreb`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Botiga`.`TIPUS_PRODUCTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`TIPUS_PRODUCTE` (
  `TipusID` INT NOT NULL,
  `TipusNom` VARCHAR(45) NULL,
  `Caduca` VARCHAR(2) BINARY NULL,
  PRIMARY KEY (`TipusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Botiga`.`TRANSACCIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`TRANSACCIO` (
  `TransID` INT NOT NULL,
  `TransTipus` VARCHAR(45) NOT NULL,
  `Data` DATETIME NULL,
  `Pagament` VARCHAR(10) NULL,
  `TransSubtotal` DECIMAL(2) NULL,
  `CLIENT_CodiClient` INT NOT NULL,
  `ESTABLIMENT_CodiEstab` INT NOT NULL,
  `TREBALLADOR_CodiTreb` INT NOT NULL,
  PRIMARY KEY (`TransID`, `TransTipus`),
  INDEX `fk_TRANSACCIO_CLIENT1_idx` (`CLIENT_CodiClient` ASC) VISIBLE,
  INDEX `fk_TRANSACCIO_ESTABLIMENT1_idx` (`ESTABLIMENT_CodiEstab` ASC) VISIBLE,
  INDEX `fk_TRANSACCIO_TREBALLADOR1_idx` (`TREBALLADOR_CodiTreb` ASC) VISIBLE,
  CONSTRAINT `fk_TRANSACCIO_CLIENT1`
    FOREIGN KEY (`CLIENT_CodiClient`)
    REFERENCES `BD_Botiga`.`CLIENT` (`CodiClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRANSACCIO_ESTABLIMENT1`
    FOREIGN KEY (`ESTABLIMENT_CodiEstab`)
    REFERENCES `BD_Botiga`.`ESTABLIMENT` (`CodiEstab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TRANSACCIO_TREBALLADOR1`
    FOREIGN KEY (`TREBALLADOR_CodiTreb`)
    REFERENCES `BD_Botiga`.`TREBALLADOR` (`CodiTreb`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Botiga`.`PRODUCTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`PRODUCTE` (
  `ProductID` INT NOT NULL,
  `ProductNom` VARCHAR(45) NULL,
  `ProductPreu` VARCHAR(45) NULL,
  `TIPUS_PRODUCTE_TipusID` INT NOT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `fk_PRODUCTE_TIPUS_PRODUCTE1_idx` (`TIPUS_PRODUCTE_TipusID` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTE_TIPUS_PRODUCTE1`
    FOREIGN KEY (`TIPUS_PRODUCTE_TipusID`)
    REFERENCES `BD_Botiga`.`TIPUS_PRODUCTE` (`TipusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Botiga`.`STOCK`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`STOCK` (
  `ESTABLIMENT_CodiEstab` INT NOT NULL,
  `PRODUCTE_ProductID` INT NOT NULL,
  `Quantitat` INT NULL,
  PRIMARY KEY (`ESTABLIMENT_CodiEstab`, `PRODUCTE_ProductID`),
  INDEX `fk_ESTABLIMENT_has_PRODUCTE_PRODUCTE1_idx` (`PRODUCTE_ProductID` ASC) VISIBLE,
  INDEX `fk_ESTABLIMENT_has_PRODUCTE_ESTABLIMENT1_idx` (`ESTABLIMENT_CodiEstab` ASC) VISIBLE,
  CONSTRAINT `fk_ESTABLIMENT_has_PRODUCTE_ESTABLIMENT1`
    FOREIGN KEY (`ESTABLIMENT_CodiEstab`)
    REFERENCES `BD_Botiga`.`ESTABLIMENT` (`CodiEstab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ESTABLIMENT_has_PRODUCTE_PRODUCTE1`
    FOREIGN KEY (`PRODUCTE_ProductID`)
    REFERENCES `BD_Botiga`.`PRODUCTE` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Botiga`.`DISTRIBUCIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`DISTRIBUCIO` (
  `TIPUS_PRODUCTE_TipusID` INT NOT NULL,
  `ESTABLIMENT_CodiEstab` INT NOT NULL,
  `Seccio` VARCHAR(45) NULL,
  PRIMARY KEY (`TIPUS_PRODUCTE_TipusID`, `ESTABLIMENT_CodiEstab`),
  INDEX `fk_TIPUS_PRODUCTE_has_ESTABLIMENT_ESTABLIMENT1_idx` (`ESTABLIMENT_CodiEstab` ASC) VISIBLE,
  INDEX `fk_TIPUS_PRODUCTE_has_ESTABLIMENT_TIPUS_PRODUCTE1_idx` (`TIPUS_PRODUCTE_TipusID` ASC) VISIBLE,
  CONSTRAINT `fk_TIPUS_PRODUCTE_has_ESTABLIMENT_TIPUS_PRODUCTE1`
    FOREIGN KEY (`TIPUS_PRODUCTE_TipusID`)
    REFERENCES `BD_Botiga`.`TIPUS_PRODUCTE` (`TipusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TIPUS_PRODUCTE_has_ESTABLIMENT_ESTABLIMENT1`
    FOREIGN KEY (`ESTABLIMENT_CodiEstab`)
    REFERENCES `BD_Botiga`.`ESTABLIMENT` (`CodiEstab`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Botiga`.`LINEAS TRANSACCIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Botiga`.`LINEAS TRANSACCIO` (
  `TRANSACCIO_TransID` INT NOT NULL,
  `TRANSACCIO_TransTipus` VARCHAR(45) NOT NULL,
  `PRODUCTE_ProductID` INT NOT NULL,
  `Quantitat` INT NULL,
  `Descompte` INT NULL,
  `LienaSubtotal` INT NULL,
  PRIMARY KEY (`TRANSACCIO_TransID`, `TRANSACCIO_TransTipus`, `PRODUCTE_ProductID`),
  INDEX `fk_PRODUCTE_has_TRANSACCIO_TRANSACCIO1_idx` (`TRANSACCIO_TransID` ASC, `TRANSACCIO_TransTipus` ASC) VISIBLE,
  INDEX `fk_PRODUCTE_has_TRANSACCIO_PRODUCTE1_idx` (`PRODUCTE_ProductID` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTE_has_TRANSACCIO_PRODUCTE1`
    FOREIGN KEY (`PRODUCTE_ProductID`)
    REFERENCES `BD_Botiga`.`PRODUCTE` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTE_has_TRANSACCIO_TRANSACCIO1`
    FOREIGN KEY (`TRANSACCIO_TransID` , `TRANSACCIO_TransTipus`)
    REFERENCES `BD_Botiga`.`TRANSACCIO` (`TransID` , `TransTipus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
