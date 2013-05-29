SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `faseDB` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `faseDB` ;

-- -----------------------------------------------------
-- Table `faseDB`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`usuario` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `username_UNIQUE` ON `faseDB`.`usuario` (`username` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`eps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`eps` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`eps` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`eps` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`tipo_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`tipo_documento` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`tipo_documento` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`tipo_documento` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`sexo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`sexo` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`sexo` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`sexo` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`estado_civil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`estado_civil` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`estado_civil` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`estado_civil` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`usuario_informacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`usuario_informacion` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`usuario_informacion` (
  `usuario_id` INT NOT NULL ,
  `num_documento` VARCHAR(20) NOT NULL ,
  `nombre` VARCHAR(50) NOT NULL ,
  `apellidos` VARCHAR(50) NOT NULL ,
  `fecha_nacimiento` DATE NOT NULL ,
  `ciudad_origen` VARCHAR(50) NULL ,
  `barrio` VARCHAR(50) NULL ,
  `direccion` VARCHAR(100) NULL ,
  `telefono_fijo` VARCHAR(15) NULL ,
  `telefono_celular` VARCHAR(15) NULL ,
  `email` VARCHAR(50) NULL ,
  `eps_id` INT NULL ,
  `nombre_acudiente` VARCHAR(100) NULL ,
  `telefono_acudiente` VARCHAR(15) NULL ,
  `tipo_documento_id` INT NOT NULL ,
  `sexo_id` INT NOT NULL ,
  `estado_civil_id` INT NOT NULL ,
  PRIMARY KEY (`usuario_id`) ,
  CONSTRAINT `fk_usuario_informacion_usuario`
    FOREIGN KEY (`usuario_id` )
    REFERENCES `faseDB`.`usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_informacion_eps1`
    FOREIGN KEY (`eps_id` )
    REFERENCES `faseDB`.`eps` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_informacion_tipo_documento1`
    FOREIGN KEY (`tipo_documento_id` )
    REFERENCES `faseDB`.`tipo_documento` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_informacion_sexo1`
    FOREIGN KEY (`sexo_id` )
    REFERENCES `faseDB`.`sexo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_informacion_estado_civil1`
    FOREIGN KEY (`estado_civil_id` )
    REFERENCES `faseDB`.`estado_civil` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_usuario_informacion_eps1_idx` ON `faseDB`.`usuario_informacion` (`eps_id` ASC) ;

CREATE INDEX `fk_usuario_informacion_tipo_documento1_idx` ON `faseDB`.`usuario_informacion` (`tipo_documento_id` ASC) ;

CREATE INDEX `fk_usuario_informacion_sexo1_idx` ON `faseDB`.`usuario_informacion` (`sexo_id` ASC) ;

CREATE INDEX `fk_usuario_informacion_estado_civil1_idx` ON `faseDB`.`usuario_informacion` (`estado_civil_id` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`sede`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`sede` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`sede` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(60) NOT NULL ,
  `telefono` VARCHAR(15) NULL ,
  `direccion` VARCHAR(100) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`sede` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`asignatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`asignatura` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`asignatura` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(60) NULL ,
  `descripcion` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`asignatura` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`periodo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`periodo` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`periodo` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Periodo académico con formato \"AAPP\" (AA: año, PP: número periodo). Ejemplos: 1130, 1210, 1220, etc.' ,
  `nombre` VARCHAR(10) NOT NULL ,
  `fecha_inicio` DATE NOT NULL ,
  `fecha_fin` DATE NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`periodo` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`asignatura_en_periodo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`asignatura_en_periodo` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`asignatura_en_periodo` (
  `asignatura_id` INT NOT NULL ,
  `periodo_id` INT NOT NULL ,
  `precio_inscripcion` INT NOT NULL DEFAULT 0 ,
  `precio_semestre` INT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`asignatura_id`, `periodo_id`) ,
  CONSTRAINT `fk_asignatura_has_periodo_asignatura1`
    FOREIGN KEY (`asignatura_id` )
    REFERENCES `faseDB`.`asignatura` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asignatura_has_periodo_periodo1`
    FOREIGN KEY (`periodo_id` )
    REFERENCES `faseDB`.`periodo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_asignatura_has_periodo_periodo1_idx` ON `faseDB`.`asignatura_en_periodo` (`periodo_id` ASC) ;

CREATE INDEX `fk_asignatura_has_periodo_asignatura1_idx` ON `faseDB`.`asignatura_en_periodo` (`asignatura_id` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`nivel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`nivel` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`nivel` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `minedad` INT(3) NOT NULL ,
  `maxedad` INT(3) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`nivel` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`modo_ensenanza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`modo_ensenanza` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`modo_ensenanza` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`modo_ensenanza` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`curso` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`curso` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `sede_id` INT NOT NULL ,
  `asignatura_en_periodo_asignatura_id` INT NOT NULL ,
  `asignatura_en_periodo_periodo_id` INT NOT NULL ,
  `total_cupos` INT(3) NOT NULL DEFAULT 30 ,
  `actual_cupos` INT(3) NOT NULL DEFAULT 30 ,
  `nivel_id` INT NOT NULL ,
  `profesor_id` INT NOT NULL ,
  `modo_ensenanza_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_curso_sede1`
    FOREIGN KEY (`sede_id` )
    REFERENCES `faseDB`.`sede` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_asignatura_en_periodo1`
    FOREIGN KEY (`asignatura_en_periodo_asignatura_id` , `asignatura_en_periodo_periodo_id` )
    REFERENCES `faseDB`.`asignatura_en_periodo` (`asignatura_id` , `periodo_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_nivel1`
    FOREIGN KEY (`nivel_id` )
    REFERENCES `faseDB`.`nivel` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_usuario1`
    FOREIGN KEY (`profesor_id` )
    REFERENCES `faseDB`.`usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_modo_ensenanza1`
    FOREIGN KEY (`modo_ensenanza_id` )
    REFERENCES `faseDB`.`modo_ensenanza` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_curso_sede1_idx` ON `faseDB`.`curso` (`sede_id` ASC) ;

CREATE INDEX `fk_curso_asignatura_en_periodo1_idx` ON `faseDB`.`curso` (`asignatura_en_periodo_asignatura_id` ASC, `asignatura_en_periodo_periodo_id` ASC) ;

CREATE INDEX `fk_curso_nivel1_idx` ON `faseDB`.`curso` (`nivel_id` ASC) ;

CREATE INDEX `fk_curso_usuario1_idx` ON `faseDB`.`curso` (`profesor_id` ASC) ;

CREATE INDEX `fk_curso_modo_ensenanza1_idx` ON `faseDB`.`curso` (`modo_ensenanza_id` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`horario` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`horario` (
  `curso_id` INT NOT NULL ,
  `id` INT NOT NULL AUTO_INCREMENT ,
  `dia` VARCHAR(10) NULL ,
  `hora_inicial` TIME NULL ,
  `hora_final` TIME NULL ,
  `salon` VARCHAR(30) NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_horario_curso1`
    FOREIGN KEY (`curso_id` )
    REFERENCES `faseDB`.`curso` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `faseDB`.`estado_pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`estado_pago` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`estado_pago` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`estado_pago` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`usuario_en_curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`usuario_en_curso` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`usuario_en_curso` (
  `usuario_id` INT NOT NULL ,
  `curso_id` INT NOT NULL ,
  `numero_recibo` INT(15) NULL ,
  `calificacion` VARCHAR(45) NULL ,
  `estado_pago_id` INT NOT NULL ,
  PRIMARY KEY (`usuario_id`, `curso_id`) ,
  CONSTRAINT `fk_usuario_has_curso_usuario1`
    FOREIGN KEY (`usuario_id` )
    REFERENCES `faseDB`.`usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_curso_curso1`
    FOREIGN KEY (`curso_id` )
    REFERENCES `faseDB`.`curso` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_en_curso_estado_pago1`
    FOREIGN KEY (`estado_pago_id` )
    REFERENCES `faseDB`.`estado_pago` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_usuario_has_curso_curso1_idx` ON `faseDB`.`usuario_en_curso` (`curso_id` ASC) ;

CREATE INDEX `fk_usuario_has_curso_usuario1_idx` ON `faseDB`.`usuario_en_curso` (`usuario_id` ASC) ;

CREATE INDEX `fk_usuario_en_curso_estado_pago1_idx` ON `faseDB`.`usuario_en_curso` (`estado_pago_id` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`rol` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`rol` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `faseDB`.`rol` (`nombre` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`rol_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`rol_usuario` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`rol_usuario` (
  `rol_id` INT NOT NULL ,
  `usuario_id` INT NOT NULL ,
  PRIMARY KEY (`rol_id`, `usuario_id`) ,
  CONSTRAINT `fk_rol_has_usuario_rol1`
    FOREIGN KEY (`rol_id` )
    REFERENCES `faseDB`.`rol` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_has_usuario_usuario1`
    FOREIGN KEY (`usuario_id` )
    REFERENCES `faseDB`.`usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_rol_has_usuario_usuario1_idx` ON `faseDB`.`rol_usuario` (`usuario_id` ASC) ;

CREATE INDEX `fk_rol_has_usuario_rol1_idx` ON `faseDB`.`rol_usuario` (`rol_id` ASC) ;


-- -----------------------------------------------------
-- Table `faseDB`.`prerrequisito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `faseDB`.`prerrequisito` ;

CREATE  TABLE IF NOT EXISTS `faseDB`.`prerrequisito` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `asignatura_id` INT NOT NULL ,
  `prerrequisito_id` INT NOT NULL ,
  PRIMARY KEY (`id`, `asignatura_id`) ,
  CONSTRAINT `fk_prerrequisito_asignatura1`
    FOREIGN KEY (`asignatura_id` )
    REFERENCES `faseDB`.`asignatura` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prerrequisito_asignatura2`
    FOREIGN KEY (`prerrequisito_id` )
    REFERENCES `faseDB`.`asignatura` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_prerrequisito_asignatura1_idx` ON `faseDB`.`prerrequisito` (`asignatura_id` ASC) ;

CREATE INDEX `fk_prerrequisito_asignatura2_idx` ON `faseDB`.`prerrequisito` (`prerrequisito_id` ASC) ;

USE `faseDB` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
