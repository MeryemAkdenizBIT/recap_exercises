-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `id_rate` INT NOT NULL AUTO_INCREMENT,
  `overtime_rate` TIME NOT NULL,
  PRIMARY KEY (`id_rate`),
  UNIQUE INDEX `id_rate_UNIQUE` (`id_rate` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `id_doctor` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  `Address` VARCHAR(80) NOT NULL,
  `Phone_number` INT NOT NULL,
  `Salary` INT NOT NULL,
  `Medical_id_rate` INT NOT NULL,
  `Medical_id_rate1` INT NOT NULL,
  UNIQUE INDEX `Phone_number_UNIQUE` (`Phone_number` ASC) VISIBLE,
  PRIMARY KEY (`id_doctor`, `Medical_id_rate`, `Medical_id_rate1`),
  UNIQUE INDEX `id_doctor_UNIQUE` (`id_doctor` ASC) VISIBLE,
  INDEX `fk_Doctor_Medical2_idx` (`Medical_id_rate1` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Medical2`
    FOREIGN KEY (`Medical_id_rate1`)
    REFERENCES `mydb`.`Medical` (`id_rate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `id_specialist` INT NOT NULL AUTO_INCREMENT,
  `field_area` VARCHAR(45) NOT NULL,
  `Doctor_id_doctor` INT NOT NULL,
  `Doctor_Medical_id_rate` INT NOT NULL,
  PRIMARY KEY (`id_specialist`, `Doctor_id_doctor`, `Doctor_Medical_id_rate`),
  UNIQUE INDEX `id_specialist_UNIQUE` (`id_specialist` ASC) VISIBLE,
  INDEX `fk_Specialist_Doctor1_idx` (`Doctor_id_doctor` ASC, `Doctor_Medical_id_rate` ASC) VISIBLE,
  CONSTRAINT `fk_Specialist_Doctor1`
    FOREIGN KEY (`Doctor_id_doctor` , `Doctor_Medical_id_rate`)
    REFERENCES `mydb`.`Doctor` (`id_doctor` , `Medical_id_rate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `id_patient` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phone_number` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  PRIMARY KEY (`id_patient`),
  UNIQUE INDEX `id_patient_UNIQUE` (`id_patient` ASC) VISIBLE,
  UNIQUE INDEX `Phone_number_UNIQUE` (`Phone_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `id_appointment` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `time` TIME NULL,
  `Patient_id_patient` INT NOT NULL,
  PRIMARY KEY (`id_appointment`, `Patient_id_patient`),
  UNIQUE INDEX `id_appointment_UNIQUE` (`id_appointment` ASC) VISIBLE,
  INDEX `fk_Appointment_Patient_idx` (`Patient_id_patient` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient`
    FOREIGN KEY (`Patient_id_patient`)
    REFERENCES `mydb`.`Patient` (`id_patient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `id_bill` INT NOT NULL,
  `Total` FLOAT NULL,
  PRIMARY KEY (`id_bill`),
  UNIQUE INDEX `id_bill_UNIQUE` (`id_bill` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `id_payment` INT NOT NULL AUTO_INCREMENT,
  `Details` VARCHAR(45) NOT NULL,
  `Method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_payment`),
  UNIQUE INDEX `id_payment_UNIQUE` (`id_payment` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill_has_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill_has_Payment` (
  `Bill_id_bill` INT NOT NULL,
  `Payment_id_payment` INT NOT NULL,
  `Patient_id_patient` INT NOT NULL,
  PRIMARY KEY (`Bill_id_bill`, `Payment_id_payment`, `Patient_id_patient`),
  INDEX `fk_Bill_has_Payment_Payment1_idx` (`Payment_id_payment` ASC) VISIBLE,
  INDEX `fk_Bill_has_Payment_Bill1_idx` (`Bill_id_bill` ASC) VISIBLE,
  INDEX `fk_Bill_has_Payment_Patient1_idx` (`Patient_id_patient` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_has_Payment_Bill1`
    FOREIGN KEY (`Bill_id_bill`)
    REFERENCES `mydb`.`Bill` (`id_bill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Payment1`
    FOREIGN KEY (`Payment_id_payment`)
    REFERENCES `mydb`.`Payment` (`id_payment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Patient1`
    FOREIGN KEY (`Patient_id_patient`)
    REFERENCES `mydb`.`Patient` (`id_patient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment_has_Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment_has_Doctor` (
  `Appointment_id_appointment` INT NOT NULL,
  `Appointment_Patient_id_patient` INT NOT NULL,
  `Doctor_id_doctor` INT NOT NULL,
  `Doctor_Medical_id_rate` INT NOT NULL,
  `Doctor_Medical_id_rate1` INT NOT NULL,
  PRIMARY KEY (`Appointment_id_appointment`, `Appointment_Patient_id_patient`, `Doctor_id_doctor`, `Doctor_Medical_id_rate`, `Doctor_Medical_id_rate1`),
  INDEX `fk_Appointment_has_Doctor_Doctor1_idx` (`Doctor_id_doctor` ASC, `Doctor_Medical_id_rate` ASC, `Doctor_Medical_id_rate1` ASC) VISIBLE,
  INDEX `fk_Appointment_has_Doctor_Appointment1_idx` (`Appointment_id_appointment` ASC, `Appointment_Patient_id_patient` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_has_Doctor_Appointment1`
    FOREIGN KEY (`Appointment_id_appointment` , `Appointment_Patient_id_patient`)
    REFERENCES `mydb`.`Appointment` (`id_appointment` , `Patient_id_patient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_has_Doctor_Doctor1`
    FOREIGN KEY (`Doctor_id_doctor` , `Doctor_Medical_id_rate` , `Doctor_Medical_id_rate1`)
    REFERENCES `mydb`.`Doctor` (`id_doctor` , `Medical_id_rate` , `Medical_id_rate1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
