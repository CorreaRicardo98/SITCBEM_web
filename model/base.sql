-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sistema_cobach
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sistema_cobach
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistema_cobach` ;
USE `sistema_cobach` ;

-- -----------------------------------------------------
-- Table `sistema_cobach`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`direccion` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `cod_postal` INT NOT NULL,
  `colonia` VARCHAR(45) NULL,
  `municipio` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `tipo_asenta` VARCHAR(45) NULL,
  `calle` VARCHAR(45) NULL,
  `no_int` INT NULL,
  `no_ext` INT NULL,
  PRIMARY KEY (`id_direccion`))
;


-- -----------------------------------------------------
-- Table `sistema_cobach`.`cordinacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`cordinacion` (
  `id_cordinacion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_cordinacion`))
;


-- -----------------------------------------------------
-- Table `sistema_cobach`.`centro_trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`centro_trabajo` (
  `id_centro_trabajo` INT NOT NULL AUTO_INCREMENT,
  `nombre_ct` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `cordinacion_id_cordinacion` INT NOT NULL,
  PRIMARY KEY (`id_centro_trabajo`),
  INDEX `fk_centro_trabajo_cordinacion1_idx` (`cordinacion_id_cordinacion` ) ,
  CONSTRAINT `fk_centro_trabajo_cordinacion1`
    FOREIGN KEY (`cordinacion_id_cordinacion`)
    REFERENCES `sistema_cobach`.`cordinacion` (`id_cordinacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `sistema_cobach`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`status` (
  `id_status` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_status`))
;


-- -----------------------------------------------------
-- Table `sistema_cobach`.`estado_civil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`estado_civil` (
  `id_estado_civil` INT NOT NULL AUTO_INCREMENT,
  `estado_civil` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estado_civil`))
;

insert into estado_civil values(null,'soltero');

insert into estado_civil values(null,'casado');

insert into cordinacion values(null,'morelia','4435986790');

insert into centro_trabajo values(null,'periferico','4455667788',1);

insert into status values(null,'activo','afiliado activo');


insert into status values(null,'inactivo','afiliado inactivo');



-- -----------------------------------------------------
-- Table `sistema_cobach`.`plaza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`plaza` (
  `id_plaza` INT NOT NULL AUTO_INCREMENT,
  `tipo_plaza` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_plaza`))
;

 insert into plaza values(1,'completa');
  insert into plaza values(2,'media');


-- -----------------------------------------------------
-- Table `sistema_cobach`.`afiliado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`afiliado` (
  `id_afiliado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `ap_paterno` VARCHAR(45) NOT NULL,
  `ap_materno` VARCHAR(45) NOT NULL,
  `rfc` VARCHAR(45) NOT NULL,
  `curp` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `foto` TEXT NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `fecha_ingreso` varchar(45) NOT NULL,
  `fecha_nacimiento` VARCHAR(45) NULL,
  `direccion_id_direccion` INT NOT NULL,
  `centro_trabajo_id_centro_trabajo` INT NOT NULL,
  `status_id_status` INT NOT NULL,
  `estado_civil_id_estado_civil` INT NOT NULL,
  `plaza_id_plaza` INT NOT NULL,
  PRIMARY KEY (`id_afiliado`),
  UNIQUE INDEX `email_UNIQUE` (`email` ) ,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ) ,
  INDEX `fk_afiliado_direccion_idx` (`direccion_id_direccion` ) ,
  INDEX `fk_afiliado_centro_trabajo1_idx` (`centro_trabajo_id_centro_trabajo` ) ,
  INDEX `fk_afiliado_status1_idx` (`status_id_status` ) ,
  INDEX `fk_afiliado_estado_civil1_idx` (`estado_civil_id_estado_civil` ) ,
  INDEX `fk_afiliado_plaza1_idx` (`plaza_id_plaza` ) ,
  CONSTRAINT `fk_afiliado_direccion`
    FOREIGN KEY (`direccion_id_direccion`)
    REFERENCES `sistema_cobach`.`direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_afiliado_centro_trabajo1`
    FOREIGN KEY (`centro_trabajo_id_centro_trabajo`)
    REFERENCES `sistema_cobach`.`centro_trabajo` (`id_centro_trabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_afiliado_status1`
    FOREIGN KEY (`status_id_status`)
    REFERENCES `sistema_cobach`.`status` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_afiliado_estado_civil1`
    FOREIGN KEY (`estado_civil_id_estado_civil`)
    REFERENCES `sistema_cobach`.`estado_civil` (`id_estado_civil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_afiliado_plaza1`
    FOREIGN KEY (`plaza_id_plaza`)
    REFERENCES `sistema_cobach`.`plaza` (`id_plaza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `sistema_cobach`.`log_acceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`log_acceso` (
  `id_registro` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `nombre_ct` VARCHAR(60) NULL,
  `rol` VARCHAR(45) NULL,
  `feha_log` VARCHAR(45) NULL,
  `hora_log` VARCHAR(45) NULL,
  `salida_log` VARCHAR(45) NULL,
  `status` TINYINT(1) NULL,
  `id_usuarios` INT NULL,
  PRIMARY KEY (`id_registro`))
;


-- -----------------------------------------------------
-- Table `sistema_cobach`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`Roles` (
  `idRoles` INT NOT NULL,
  `nombre_rol` VARCHAR(45) NULL,
  PRIMARY KEY (`idRoles`))
;

insert into Roles values(1,'Administrador');
insert into Roles values(2,'Operador');
insert into Roles values(3,'Secretario');


-- -----------------------------------------------------
-- Table `sistema_cobach`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_cobach`.`Usuario` (
  `id_usuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(45) NULL,
  `ap_mat_usuario` VARCHAR(45) NULL,
  `ap_pat_usuario` VARCHAR(45) NULL,
  `Roles_idRoles` INT NOT NULL,
  `email_usuario` VARCHAR(45) NULL,
  `pass_usuario` VARCHAR(45) NULL,
  PRIMARY KEY (`id_usuarios`),
  INDEX `fk_Usuario_Roles1_idx` (`Roles_idRoles` ) ,
  CONSTRAINT `fk_Usuario_Roles1`
    FOREIGN KEY (`Roles_idRoles`)
    REFERENCES `sistema_cobach`.`Roles` (`idRoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

insert into Usuario values(1,'ricardo','correa','bautista',1,'ricardo@gmail.com','1213151998');



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
