CREATE DATABASE  IF NOT EXISTS `ccexchange` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ccexchange`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 172.16.1.181    Database: ccexchange
-- ------------------------------------------------------
-- Server version	5.5.60-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `celije`
--

DROP TABLE IF EXISTS `celije`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `celije` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `redId` int(11) NOT NULL,
  `colona` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vrijednost` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKRedCelija_idx` (`redId`),
  CONSTRAINT `FKRedCelija` FOREIGN KEY (`redId`) REFERENCES `redovi` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=395407 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `celije`
--

LOCK TABLES `celije` WRITE;
/*!40000 ALTER TABLE `celije` DISABLE KEYS */;
/*!40000 ALTER TABLE `celije` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nalozi`
--

DROP TABLE IF EXISTS `nalozi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nalozi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fajala` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parametriId` int(11) DEFAULT NULL,
  `naziv` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `stauts` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  `user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fileName` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKParamNaloga_idx` (`parametriId`),
  CONSTRAINT `FKParamNaloga` FOREIGN KEY (`parametriId`) REFERENCES `parametri` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nalozi`
--

LOCK TABLES `nalozi` WRITE;
/*!40000 ALTER TABLE `nalozi` DISABLE KEYS */;
/*!40000 ALTER TABLE `nalozi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `naloziLog`
--

DROP TABLE IF EXISTS `naloziLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `naloziLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ts` datetime DEFAULT NULL,
  `userId` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opis` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isError` bit(1) NOT NULL,
  `nalogId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fkNalogIf_idx` (`nalogId`),
  CONSTRAINT `fkNalogIf` FOREIGN KEY (`nalogId`) REFERENCES `nalozi` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `naloziLog`
--

LOCK TABLES `naloziLog` WRITE;
/*!40000 ALTER TABLE `naloziLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `naloziLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametri`
--

DROP TABLE IF EXISTS `parametri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parametri` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `naziv` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `ts` datetime NOT NULL,
  `userId` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `comandTip` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `active` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametri`
--

LOCK TABLES `parametri` WRITE;
/*!40000 ALTER TABLE `parametri` DISABLE KEYS */;
/*!40000 ALTER TABLE `parametri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametriStavke`
--

DROP TABLE IF EXISTS `parametriStavke`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parametriStavke` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parametarId` int(11) NOT NULL,
  `tip` int(11) NOT NULL,
  `vrijednost` varchar(450) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rbr` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FkParamDocs_idx` (`parametarId`),
  KEY `FkParamTip_idx` (`tip`),
  CONSTRAINT `FkParamDocs` FOREIGN KEY (`parametarId`) REFERENCES `parametri` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FkParamTip` FOREIGN KEY (`tip`) REFERENCES `parametriTip` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametriStavke`
--

LOCK TABLES `parametriStavke` WRITE;
/*!40000 ALTER TABLE `parametriStavke` DISABLE KEYS */;
/*!40000 ALTER TABLE `parametriStavke` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametriTip`
--

DROP TABLE IF EXISTS `parametriTip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parametriTip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codeName` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `storeType` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametriTip`
--

LOCK TABLES `parametriTip` WRITE;
/*!40000 ALTER TABLE `parametriTip` DISABLE KEYS */;
/*!40000 ALTER TABLE `parametriTip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `redovi`
--

DROP TABLE IF EXISTS `redovi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redovi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nalogId` int(11) NOT NULL,
  `status` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `rbr` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FkNaloziRedovi_idx` (`nalogId`),
  CONSTRAINT `FkNaloziRedovi` FOREIGN KEY (`nalogId`) REFERENCES `nalozi` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=220609 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `redovi`
--

LOCK TABLES `redovi` WRITE;
/*!40000 ALTER TABLE `redovi` DISABLE KEYS */;
/*!40000 ALTER TABLE `redovi` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-24 10:19:11
