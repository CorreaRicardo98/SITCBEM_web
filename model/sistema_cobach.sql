-- MariaDB dump 10.18  Distrib 10.4.17-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: sistema_cobach
-- ------------------------------------------------------
-- Server version	10.4.17-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `afiliado`
--

CREATE SCHEMA IF NOT EXISTS `sistema_cobach` ;
USE `sistema_cobach` ;

DROP TABLE IF EXISTS `afiliado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `afiliado` (
  `id_afiliado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `ap_paterno` varchar(45) NOT NULL,
  `ap_materno` varchar(45) NOT NULL,
  `rfc` varchar(45) NOT NULL,
  `curp` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `foto` text NOT NULL,
  `telefono` varchar(12) NOT NULL,
  `fecha_ingreso` varchar(45) NOT NULL,
  `fecha_nacimiento` varchar(45) DEFAULT NULL,
  `direccion_id_direccion` int(11) NOT NULL,
  `centro_trabajo_id_centro_trabajo` int(11) NOT NULL,
  `status_id_status` int(11) NOT NULL,
  `estado_civil_id_estado_civil` int(11) NOT NULL,
  `plaza_id_plaza` int(11) NOT NULL,
  PRIMARY KEY (`id_afiliado`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `telefono_UNIQUE` (`telefono`),
  KEY `fk_afiliado_direccion_idx` (`direccion_id_direccion`),
  KEY `fk_afiliado_centro_trabajo1_idx` (`centro_trabajo_id_centro_trabajo`),
  KEY `fk_afiliado_status1_idx` (`status_id_status`),
  KEY `fk_afiliado_estado_civil1_idx` (`estado_civil_id_estado_civil`),
  KEY `fk_afiliado_plaza1_idx` (`plaza_id_plaza`),
  CONSTRAINT `fk_afiliado_centro_trabajo1` FOREIGN KEY (`centro_trabajo_id_centro_trabajo`) REFERENCES `centro_trabajo` (`id_centro_trabajo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_afiliado_direccion` FOREIGN KEY (`direccion_id_direccion`) REFERENCES `direccion` (`id_direccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_afiliado_estado_civil1` FOREIGN KEY (`estado_civil_id_estado_civil`) REFERENCES `estado_civil` (`id_estado_civil`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_afiliado_plaza1` FOREIGN KEY (`plaza_id_plaza`) REFERENCES `plaza` (`id_plaza`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_afiliado_status1` FOREIGN KEY (`status_id_status`) REFERENCES `status` (`id_status`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `afiliado`
--

LOCK TABLES `afiliado` WRITE;
/*!40000 ALTER TABLE `afiliado` DISABLE KEYS */;
INSERT INTO `afiliado` VALUES (1,'Ricardo','Giron','Colorado','GICR981027','GICR981027HMNRLC01','rgiron98@gmail.com','../../src/img/people/rgiron98@gmail.com.png','4432207350','24/01/2021','27/10/1998',1,1,1,1,1),(2,'José','Villegas','Paniagua','josesito','josesito','jose23@gmail.com','../../src/img/people/josesito@gmail.com.png','5566778899','21/11/2021','24/10/1991',2,1,1,1,1),(3,'David Adolfo','Pérez Negron','Aguilar','DAVID1234','DAVID5678','david@gmail.com','../../src/img/people/david@gmail.com.png','4432567812','25/01/2021','13/08/1998',3,1,1,1,1),(5,'Yesenia Patricia','Paredes','Gallegos','YESS1234','YESS5678','yess@gmail.com','../../src/img/people/yess@gmail.com.png','55679823','25/01/2021','23/04/1998',5,1,1,1,2),(6,'Ricardo','Correa','Bautista','CORREA1234','CORREA5678','ricardo_correa@gmail.com','../../src/img/people/ricardo_correa@gmail.com.png','4431456612','25/01/2021','15/12/1998',6,1,1,2,2),(7,'Erick Omar','Ramirez','Viveros','RAMIREZ1234','RAMIREZ5678','erick_omar2@gmail.com','../../src/img/people/erick_omar2@gmail.com.png','4433783455','25/01/2021','11/05/1998',7,1,1,1,1);
/*!40000 ALTER TABLE `afiliado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centro_trabajo`
--

DROP TABLE IF EXISTS `centro_trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centro_trabajo` (
  `id_centro_trabajo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_ct` varchar(45) NOT NULL,
  `telefono_ct` varchar(12) NOT NULL,
  `cordinacion_id_cordinacion` int(11) NOT NULL,
  PRIMARY KEY (`id_centro_trabajo`),
  KEY `fk_centro_trabajo_cordinacion1_idx` (`cordinacion_id_cordinacion`),
  CONSTRAINT `fk_centro_trabajo_cordinacion1` FOREIGN KEY (`cordinacion_id_cordinacion`) REFERENCES `cordinacion` (`id_cordinacion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro_trabajo`
--

LOCK TABLES `centro_trabajo` WRITE;
/*!40000 ALTER TABLE `centro_trabajo` DISABLE KEYS */;
INSERT INTO `centro_trabajo` VALUES (1,'periferico','4455667788',1);
/*!40000 ALTER TABLE `centro_trabajo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cordinacion`
--

DROP TABLE IF EXISTS `cordinacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cordinacion` (
  `id_cordinacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `telefono_coord` varchar(45) NOT NULL,
  PRIMARY KEY (`id_cordinacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cordinacion`
--

LOCK TABLES `cordinacion` WRITE;
/*!40000 ALTER TABLE `cordinacion` DISABLE KEYS */;
INSERT INTO `cordinacion` VALUES (1,'morelia','4435986790');
/*!40000 ALTER TABLE `cordinacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `direccion` (
  `id_direccion` int(11) NOT NULL AUTO_INCREMENT,
  `cod_postal` int(11) NOT NULL,
  `colonia` varchar(45) DEFAULT NULL,
  `municipio` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `tipo_asenta` varchar(45) DEFAULT NULL,
  `calle` varchar(45) DEFAULT NULL,
  `no_int` int(11) DEFAULT NULL,
  `no_ext` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_direccion`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
INSERT INTO `direccion` VALUES (1,58980,'Quer?ndaro','Quer?ndaro','Michoac?n','Casa','Allende ',0,23),(2,12345,'Realito','Morelia','Michoac?n','Casa','Rio Yaqui',0,101),(3,78342,'Calvario','Maravatio','Michoac?n','Casa','Mora',0,23),(4,58957,'Centro','Pueblo Viejo','Michoac?n','Casa','Miguel Hidalgo',0,13),(5,23561,'Guadalupe','Ac?mbaro','Guanajuato','Casa','Benito Ju?rez',3,23),(6,58965,'Centro','Pueblo Viejo','Michoac?n','Casa','Miguel Hidalgo',0,13),(7,55671,'Centro','Morelia','Michoac?n','Casa','Alamo',0,81);
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_civil`
--

DROP TABLE IF EXISTS `estado_civil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado_civil` (
  `id_estado_civil` int(11) NOT NULL AUTO_INCREMENT,
  `estado_civil` varchar(45) NOT NULL,
  PRIMARY KEY (`id_estado_civil`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_civil`
--

LOCK TABLES `estado_civil` WRITE;
/*!40000 ALTER TABLE `estado_civil` DISABLE KEYS */;
INSERT INTO `estado_civil` VALUES (1,'soltero'),(2,'casado');
/*!40000 ALTER TABLE `estado_civil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_acceso`
--

DROP TABLE IF EXISTS `log_acceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_acceso` (
  `id_registro` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) DEFAULT NULL,
  `nombre_ct` varchar(60) DEFAULT NULL,
  `rol` varchar(45) DEFAULT NULL,
  `feha_log` varchar(45) DEFAULT NULL,
  `hora_log` varchar(45) DEFAULT NULL,
  `salida_log` varchar(45) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `id_usuarios` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_registro`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_acceso`
--

LOCK TABLES `log_acceso` WRITE;
/*!40000 ALTER TABLE `log_acceso` DISABLE KEYS */;
INSERT INTO `log_acceso` VALUES (1,'ricardo@gmail.com','ricardo bautista correa','Administrador','01/24/2021','17:13:9','19:24:58',0,1),(2,'ricardo@gmail.com','ricardo bautista correa','Administrador','01/24/2021','19:25:7','19:25:44',0,1),(3,'rgiron98@gmail.com','Ricardo Giron Colorado','Operador','01/24/2021','19:25:55','19:42:27',0,2),(4,'rgiron98@gmail.com','Ricardo Giron Colorado','Operador','01/24/2021','19:42:37','23:30:3',0,2),(5,'ricardo@gmail.com','ricardo bautista correa','Administrador','01/24/2021','23:30:22','23:36:30',0,1),(6,'ricardo@gmail.com','Ricardo Correa Bautista','Administrador','01/24/2021','23:36:43','23:36:44',0,1),(7,'ricardo@gmail.com','Ricardo Correa Bautista','Administrador','01/24/2021','23:36:54','0:29:7',0,1),(8,'ricardo@gmail.com','Ricardo Correa Bautista','Administrador','01/25/2021','13:22:27','13:26:21',0,1),(9,'rgiron98@gmail.com','Ricardo Giron Colorado','Operador','01/25/2021','13:26:28','13:27:58',0,2),(10,'erick_omar@gmail.com','Erick Omar Ramirez Viveros','Secretario','01/25/2021','13:28:40','13:28:46',0,3),(11,'ricardo@gmail.com','Ricardo Correa Bautista','Administrador','01/25/2021','13:28:54',NULL,1,1);
/*!40000 ALTER TABLE `log_acceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plaza`
--

DROP TABLE IF EXISTS `plaza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plaza` (
  `id_plaza` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_plaza` varchar(45) NOT NULL,
  PRIMARY KEY (`id_plaza`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plaza`
--

LOCK TABLES `plaza` WRITE;
/*!40000 ALTER TABLE `plaza` DISABLE KEYS */;
INSERT INTO `plaza` VALUES (1,'completa'),(2,'media');
/*!40000 ALTER TABLE `plaza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `idRoles` int(11) NOT NULL,
  `nombre_rol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idRoles`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador'),(2,'Operador'),(3,'Secretario');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `id_status` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'activo','afiliado activo'),(2,'inactivo','afiliado inactivo');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuarios` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(45) DEFAULT NULL,
  `ap_mat_usuario` varchar(45) DEFAULT NULL,
  `ap_pat_usuario` varchar(45) DEFAULT NULL,
  `Roles_idRoles` int(11) NOT NULL,
  `email_usuario` varchar(45) DEFAULT NULL,
  `pass_usuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_usuarios`),
  KEY `fk_Usuario_Roles1_idx` (`Roles_idRoles`),
  CONSTRAINT `fk_Usuario_Roles1` FOREIGN KEY (`Roles_idRoles`) REFERENCES `roles` (`idRoles`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Ricardo','Bautista','Correa',1,'ricardo@gmail.com','1213151998'),(2,'Ricardo','Colorado','Giron',2,'rgiron98@gmail.com','rgiron98'),(3,'Erick Omar','Viveros','Ramirez',3,'erick_omar@gmail.com','erick_omar'),(4,'David Adolfo','Aguilar','Pérez Negron',3,'david_A@gmail.com','david123'),(5,'Yesenia Patricia','Gallegos','Paredes',2,'yess2@gmail.com','yess123');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-25 13:35:15
