-- MySQL dump 10.13  Distrib 5.5.24, for osx10.6 (i386)
--
-- Host: localhost    Database: breedb
-- ------------------------------------------------------
-- Server version	5.5.24-log

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
-- Table structure for table `ad_address`
--

DROP TABLE IF EXISTS `ad_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad_address` (
  `addr` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'address code of a person, institute, company, etc.',
  `address` varchar(75) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'street and number',
  `cnt` varchar(3) COLLATE utf8_unicode_ci NOT NULL COMMENT 'country code',
  `instituteName` varchar(75) COLLATE utf8_unicode_ci NOT NULL COMMENT 'full name of the institute',
  `instituteAcronym` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instituteDepartment` varchar(75) COLLATE utf8_unicode_ci DEFAULT NULL,
  `institutePlace` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'city, town or village of the institute',
  `institutePhone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postalCode` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'postal code',
  `website` varchar(75) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LocToInstitute` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Institute (addrcode) for this experimental field or station',
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`addr`),
  KEY `cnt` (`cnt`),
  KEY `LocToInstitute` (`LocToInstitute`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `ad_address_ibfk_4` FOREIGN KEY (`cnt`) REFERENCES `ad_country` (`cnt`) ON UPDATE CASCADE,
  CONSTRAINT `ad_address_ibfk_5` FOREIGN KEY (`LocToInstitute`) REFERENCES `ad_address` (`addr`) ON UPDATE CASCADE,
  CONSTRAINT `ad_address_ibfk_6` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Decode table for address codes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_address`
--

LOCK TABLES `ad_address` WRITE;
/*!40000 ALTER TABLE `ad_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_country`
--

DROP TABLE IF EXISTS `ad_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad_country` (
  `cnt` varchar(3) COLLATE utf8_unicode_ci NOT NULL COMMENT 'code for the country',
  `country` varchar(40) COLLATE utf8_unicode_ci NOT NULL COMMENT 'country name',
  PRIMARY KEY (`cnt`),
  UNIQUE KEY `country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Decode table for country codes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_country`
--

LOCK TABLES `ad_country` WRITE;
/*!40000 ALTER TABLE `ad_country` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_groups`
--

DROP TABLE IF EXISTS `ad_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad_groups` (
  `groupID` int(7) NOT NULL,
  `groupDescription` varchar(200) NOT NULL,
  `groupVisibility` enum('Yes','No') NOT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`groupID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `ad_groups_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='User groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_groups`
--

LOCK TABLES `ad_groups` WRITE;
/*!40000 ALTER TABLE `ad_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_permissions`
--

DROP TABLE IF EXISTS `ad_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad_permissions` (
  `permissionID` int(7) NOT NULL AUTO_INCREMENT,
  `userID` int(7) NOT NULL,
  `groupID` int(7) NOT NULL,
  `roleID` int(7) NOT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`permissionID`),
  KEY `roleID` (`roleID`),
  KEY `groupID` (`groupID`),
  KEY `userID` (`userID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `ad_permissions_ibfk_10` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`),
  CONSTRAINT `ad_permissions_ibfk_7` FOREIGN KEY (`userID`) REFERENCES `ad_users` (`userID`),
  CONSTRAINT `ad_permissions_ibfk_8` FOREIGN KEY (`groupID`) REFERENCES `ad_groups` (`groupID`),
  CONSTRAINT `ad_permissions_ibfk_9` FOREIGN KEY (`roleID`) REFERENCES `ad_userRole` (`roleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Global permission table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_permissions`
--

LOCK TABLES `ad_permissions` WRITE;
/*!40000 ALTER TABLE `ad_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_remarks`
--

DROP TABLE IF EXISTS `ad_remarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad_remarks` (
  `remarkID` int(7) NOT NULL,
  `remark` text NOT NULL,
  `inTable` varchar(40) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`remarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Remarks made within the database';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_remarks`
--

LOCK TABLES `ad_remarks` WRITE;
/*!40000 ALTER TABLE `ad_remarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_remarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_userRole`
--

DROP TABLE IF EXISTS `ad_userRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad_userRole` (
  `roleID` int(7) NOT NULL AUTO_INCREMENT,
  `roleDescription` varchar(255) NOT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`roleID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `ad_userRole_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='User roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_userRole`
--

LOCK TABLES `ad_userRole` WRITE;
/*!40000 ALTER TABLE `ad_userRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_userRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_users`
--

DROP TABLE IF EXISTS `ad_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad_users` (
  `userID` int(7) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `lastName` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `userName` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'login name',
  `password` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'password of the user',
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'email address of the user',
  `telephone` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'telephone number of the user',
  `addr` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'address code of the database user',
  `defaultGroupID` int(7) DEFAULT NULL COMMENT 'Default GroupID of the user',
  `workpackage` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `loginCount` int(5) NOT NULL DEFAULT '0' COMMENT 'number of logins',
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userID`),
  KEY `user` (`userName`),
  KEY `ad_users_ibfk_1` (`addr`),
  KEY `remarkID` (`remarkID`),
  KEY `defaultGroupID` (`defaultGroupID`),
  CONSTRAINT `ad_users_ibfk_1` FOREIGN KEY (`addr`) REFERENCES `ad_address` (`addr`) ON UPDATE CASCADE,
  CONSTRAINT `ad_users_ibfk_2` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ad_users_ibfk_3` FOREIGN KEY (`defaultGroupID`) REFERENCES `ad_groups` (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='User specific information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_users`
--

LOCK TABLES `ad_users` WRITE;
/*!40000 ALTER TABLE `ad_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cd_association_parameters`
--

DROP TABLE IF EXISTS `cd_association_parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cd_association_parameters` (
  `associationID` int(10) NOT NULL AUTO_INCREMENT,
  `populationID` int(10) NOT NULL,
  `experimentID` int(3) NOT NULL,
  `mapID` int(3) NOT NULL,
  `markerSetID` int(7) NOT NULL,
  `traitID` int(7) NOT NULL,
  `correction` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Non',
  `userID` int(7) NOT NULL,
  `runStatus` enum('running','finished','failed') COLLATE utf8_unicode_ci NOT NULL,
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`associationID`),
  KEY `populationID` (`populationID`),
  KEY `experimentID` (`experimentID`),
  KEY `mapID` (`mapID`),
  KEY `traitID` (`traitID`),
  KEY `markerSetID` (`markerSetID`),
  CONSTRAINT `cd_association_parameters_ibfk_1` FOREIGN KEY (`populationID`) REFERENCES `pp_population` (`populationID`) ON UPDATE CASCADE,
  CONSTRAINT `cd_association_parameters_ibfk_2` FOREIGN KEY (`experimentID`) REFERENCES `ph_exp_info` (`experimentID`) ON UPDATE CASCADE,
  CONSTRAINT `cd_association_parameters_ibfk_4` FOREIGN KEY (`traitID`) REFERENCES `ph_trait` (`traitID`) ON UPDATE CASCADE,
  CONSTRAINT `cd_association_parameters_ibfk_5` FOREIGN KEY (`mapID`) REFERENCES `ma_maps_info` (`mapID`) ON UPDATE CASCADE,
  CONSTRAINT `cd_association_parameters_ibfk_6` FOREIGN KEY (`markerSetID`) REFERENCES `gt_marker_set` (`markerSetID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cd_association_parameters`
--

LOCK TABLES `cd_association_parameters` WRITE;
/*!40000 ALTER TABLE `cd_association_parameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `cd_association_parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cd_association_results`
--

DROP TABLE IF EXISTS `cd_association_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cd_association_results` (
  `associationID` int(7) NOT NULL,
  `markerID` int(7) NOT NULL,
  `score` double(10,7) NOT NULL,
  PRIMARY KEY (`associationID`,`markerID`),
  KEY `markerID` (`markerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cd_association_results`
--

LOCK TABLES `cd_association_results` WRITE;
/*!40000 ALTER TABLE `cd_association_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `cd_association_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cd_structure_parameters`
--

DROP TABLE IF EXISTS `cd_structure_parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cd_structure_parameters` (
  `structureID` int(10) NOT NULL AUTO_INCREMENT,
  `markerSetID` int(7) NOT NULL,
  `populationID` int(7) NOT NULL,
  `numInds` int(10) NOT NULL,
  `numLoci` int(10) NOT NULL,
  `maxPop` int(2) NOT NULL,
  `runStatus` enum('running','finished','failed') NOT NULL,
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`structureID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cd_structure_parameters`
--

LOCK TABLES `cd_structure_parameters` WRITE;
/*!40000 ALTER TABLE `cd_structure_parameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `cd_structure_parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cd_structure_results`
--

DROP TABLE IF EXISTS `cd_structure_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cd_structure_results` (
  `structureID` int(10) NOT NULL,
  `genoID` varchar(11) NOT NULL,
  `groupName` varchar(25) NOT NULL,
  `groupAffinity` double(8,5) NOT NULL,
  PRIMARY KEY (`structureID`,`genoID`,`groupName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cd_structure_results`
--

LOCK TABLES `cd_structure_results` WRITE;
/*!40000 ALTER TABLE `cd_structure_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `cd_structure_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cr_crossComb`
--

DROP TABLE IF EXISTS `cr_crossComb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cr_crossComb` (
  `crossID` int(7) NOT NULL,
  `genoIDMother` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `genoIDFather` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userID` int(7) NOT NULL COMMENT 'Where was the cross made?',
  `crossType` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Type of the cross',
  `dateCross` date DEFAULT NULL COMMENT 'date of the cross',
  `storageID` int(7) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`crossID`),
  KEY `mother` (`genoIDMother`),
  KEY `father` (`genoIDFather`),
  KEY `addr` (`userID`),
  KEY `storageID` (`storageID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `cr_crossComb_ibfk_13` FOREIGN KEY (`storageID`) REFERENCES `se_seedStorage` (`storageID`),
  CONSTRAINT `cr_crossComb_ibfk_14` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`),
  CONSTRAINT `cr_crossComb_ibfk_15` FOREIGN KEY (`genoIDMother`) REFERENCES `pp_genotype` (`genoID`) ON UPDATE CASCADE,
  CONSTRAINT `cr_crossComb_ibfk_16` FOREIGN KEY (`genoIDFather`) REFERENCES `pp_genotype` (`genoID`) ON UPDATE CASCADE,
  CONSTRAINT `cr_crossComb_ibfk_17` FOREIGN KEY (`userID`) REFERENCES `ad_users` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cr_crossComb`
--

LOCK TABLES `cr_crossComb` WRITE;
/*!40000 ALTER TABLE `cr_crossComb` DISABLE KEYS */;
/*!40000 ALTER TABLE `cr_crossComb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exp_scale_ordinal`
--

DROP TABLE IF EXISTS `exp_scale_ordinal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exp_scale_ordinal` (
  `expScaleOrdinalID` int(11) NOT NULL AUTO_INCREMENT,
  `scaleID` int(7) NOT NULL COMMENT 'ID of the scale',
  `scaleOrder` int(2) NOT NULL COMMENT 'Rank of the scale',
  `scaleDescription` text NOT NULL COMMENT 'Description of the rank',
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`expScaleOrdinalID`),
  UNIQUE KEY `scaleID` (`scaleID`,`scaleOrder`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `exp_scale_ordinal_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores the information about the ordinal scales.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exp_scale_ordinal`
--

LOCK TABLES `exp_scale_ordinal` WRITE;
/*!40000 ALTER TABLE `exp_scale_ordinal` DISABLE KEYS */;
/*!40000 ALTER TABLE `exp_scale_ordinal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ft_feature`
--

DROP TABLE IF EXISTS `ft_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ft_feature` (
  `featureID` int(10) NOT NULL,
  `featureType` enum('SNP','INDEL','SFP') NOT NULL,
  `featureDescription` enum('delA','delC','delG','delT','A->T','A->C','A->G','C->A','C->G','C->T','G->A','G->T','G->C','T->A','T->G','T->C','InsA','InsT','InsG','InsC') DEFAULT NULL,
  `featureReference` varchar(10) DEFAULT NULL,
  `featurePosition` int(7) DEFAULT NULL,
  `featureStart` int(9) DEFAULT NULL,
  `featureStop` int(9) DEFAULT NULL,
  `parentFeature` int(10) DEFAULT NULL,
  `xrefPublicDatabaseID` int(7) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`featureID`),
  KEY `parentFeature` (`parentFeature`),
  KEY `xrefPublicDatabaseID` (`xrefPublicDatabaseID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `ft_feature_ibfk_5` FOREIGN KEY (`parentFeature`) REFERENCES `ft_feature` (`featureID`),
  CONSTRAINT `ft_feature_ibfk_6` FOREIGN KEY (`xrefPublicDatabaseID`) REFERENCES `xr_externalReference` (`xrefPublicDatabaseID`),
  CONSTRAINT `ft_feature_ibfk_7` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='identified features';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ft_feature`
--

LOCK TABLES `ft_feature` WRITE;
/*!40000 ALTER TABLE `ft_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `ft_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gt_marker`
--

DROP TABLE IF EXISTS `gt_marker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gt_marker` (
  `markerID` int(7) NOT NULL,
  `genoID` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'genotype ID. This should start serving as a link between genotypes and other tables. The genotype names have '' in their name''s which breaks part of the scripts',
  `score` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'marker score',
  `linkagePhase` enum('{0-}','{-0}','{1-}','{-1}','{00}','{01}','{10}','{11}','1','0','99') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'linkage phase of the marker',
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'last edit',
  PRIMARY KEY (`markerID`,`genoID`),
  KEY `remarkID` (`remarkID`),
  KEY `genoID` (`genoID`),
  CONSTRAINT `gt_marker_ibfk_2` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `gt_marker_ibfk_3` FOREIGN KEY (`genoID`) REFERENCES `pp_genotype` (`genoID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gt_marker_ibfk_4` FOREIGN KEY (`markerID`) REFERENCES `gt_marker_info` (`markerID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Score of the molecular markers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gt_marker`
--

LOCK TABLES `gt_marker` WRITE;
/*!40000 ALTER TABLE `gt_marker` DISABLE KEYS */;
/*!40000 ALTER TABLE `gt_marker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gt_marker_alleles`
--

DROP TABLE IF EXISTS `gt_marker_alleles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gt_marker_alleles` (
  `markerID` int(7) NOT NULL,
  `AA` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AB` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BB` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`markerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gt_marker_alleles`
--

LOCK TABLES `gt_marker_alleles` WRITE;
/*!40000 ALTER TABLE `gt_marker_alleles` DISABLE KEYS */;
/*!40000 ALTER TABLE `gt_marker_alleles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gt_marker_audit`
--

DROP TABLE IF EXISTS `gt_marker_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gt_marker_audit` (
  `counter` int(11) NOT NULL AUTO_INCREMENT,
  `action` enum('update','delete','insert') NOT NULL,
  `markerID` int(7) NOT NULL,
  `markerInfoID` int(7) NOT NULL,
  `markerSetID` int(7) DEFAULT NULL,
  `oldMarkerType` enum('CAPS','dCAPS','SCAR','AFLP','RFLP','SNP','COS2','DArT') DEFAULT NULL,
  `newMarkerType` enum('CAPS','dCAPS','SCAR','AFLP','RFLP','SNP','COS2','DArT') NOT NULL,
  `oldLinkagePhase` enum('{0-}','{-0}','{1-}','{-1}','{00}','{01}','{10}','{11}','null','1','0','99') DEFAULT NULL,
  `newLinkagePhase` enum('{0-}','{-0}','{1-}','{-1}','{00}','{01}','{10}','{11}','null','1','0','99') DEFAULT NULL,
  `oldSegregationType` varchar(7) DEFAULT NULL,
  `newSegregationType` varchar(7) DEFAULT NULL,
  `oldClassificationType` varchar(15) DEFAULT NULL,
  `newClassificationType` varchar(15) DEFAULT NULL,
  `oldRestrictionEnzyme` varchar(7) DEFAULT NULL,
  `newRestrictionEnzyme` varchar(7) DEFAULT NULL,
  `changed` date NOT NULL,
  PRIMARY KEY (`counter`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gt_marker_audit`
--

LOCK TABLES `gt_marker_audit` WRITE;
/*!40000 ALTER TABLE `gt_marker_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `gt_marker_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gt_marker_generalInfo`
--

DROP TABLE IF EXISTS `gt_marker_generalInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gt_marker_generalInfo` (
  `markerInfoID` int(7) NOT NULL AUTO_INCREMENT,
  `markerName` varchar(75) NOT NULL,
  `primerSetID` int(7) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`markerInfoID`),
  UNIQUE KEY `markerName` (`markerName`),
  KEY `remarkID` (`remarkID`),
  KEY `primerSetID` (`primerSetID`),
  CONSTRAINT `gt_marker_generalInfo_ibfk_5` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `gt_marker_generalInfo_ibfk_6` FOREIGN KEY (`primerSetID`) REFERENCES `ol_primerSet` (`primerSetID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Meta information about a potential marker';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gt_marker_generalInfo`
--

LOCK TABLES `gt_marker_generalInfo` WRITE;
/*!40000 ALTER TABLE `gt_marker_generalInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `gt_marker_generalInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gt_marker_infinium`
--

DROP TABLE IF EXISTS `gt_marker_infinium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gt_marker_infinium` (
  `markerID` int(10) NOT NULL,
  `genoID` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `score` double(10,8) DEFAULT NULL,
  `theta` double(10,8) DEFAULT NULL,
  `r` double(10,8) DEFAULT NULL,
  PRIMARY KEY (`markerID`,`genoID`),
  KEY `genoID` (`genoID`),
  CONSTRAINT `gt_marker_infinium_ibfk_1` FOREIGN KEY (`markerID`) REFERENCES `gt_marker_info` (`markerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gt_marker_infinium_ibfk_2` FOREIGN KEY (`genoID`) REFERENCES `pp_genotype` (`genoID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gt_marker_infinium`
--

LOCK TABLES `gt_marker_infinium` WRITE;
/*!40000 ALTER TABLE `gt_marker_infinium` DISABLE KEYS */;
/*!40000 ALTER TABLE `gt_marker_infinium` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gt_marker_info`
--

DROP TABLE IF EXISTS `gt_marker_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gt_marker_info` (
  `markerID` int(7) NOT NULL AUTO_INCREMENT COMMENT 'Name of the marker',
  `markerInfoID` int(7) NOT NULL,
  `markerSetID` int(7) DEFAULT NULL,
  `addr` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `markerType` enum('CAPS','dCAPS','SCAR','AFLP','RFLP','SNP','COS2','DArT') COLLATE utf8_unicode_ci NOT NULL COMMENT 'type of the marker (e.g. SSR/AFLP/etc)',
  `mobility` int(3) DEFAULT NULL COMMENT 'size of the scored fragment',
  `absence` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'In which parent is the band absent?',
  `linkagePhase` enum('{0-}','{-0}','{1-}','{-1}','{00}','{01}','{10}','{11}','null','1','0','99') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'linkage phase of the marker',
  `segregationType` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Classification of the marker',
  `classificationType` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkagePhaseID` int(7) DEFAULT NULL COMMENT 'linkage phase of the marker',
  `restrictionEnzyme` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL,
  `featureID` int(7) DEFAULT NULL,
  `methodID` int(7) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`markerID`),
  KEY `markerSetID` (`markerSetID`),
  KEY `featureID` (`featureID`),
  KEY `addr` (`addr`),
  KEY `markerInfoID` (`markerInfoID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `gt_marker_info_ibfk_52` FOREIGN KEY (`markerInfoID`) REFERENCES `gt_marker_generalInfo` (`markerInfoID`),
  CONSTRAINT `gt_marker_info_ibfk_54` FOREIGN KEY (`addr`) REFERENCES `ad_address` (`addr`),
  CONSTRAINT `gt_marker_info_ibfk_56` FOREIGN KEY (`featureID`) REFERENCES `ft_feature` (`featureID`),
  CONSTRAINT `gt_marker_info_ibfk_57` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`),
  CONSTRAINT `gt_marker_info_ibfk_58` FOREIGN KEY (`markerSetID`) REFERENCES `gt_marker_set` (`markerSetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Detailed information about a markers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gt_marker_info`
--

LOCK TABLES `gt_marker_info` WRITE;
/*!40000 ALTER TABLE `gt_marker_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `gt_marker_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `new_marker_insert` BEFORE INSERT ON `gt_marker_info`
 FOR EACH ROW BEGIN
INSERT INTO gt_marker_audit
SET action='insert',
markerID = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'gt_marker_info'),
markerInfoID = NEW.markerInfoID,
markerSetID = NEW.markerSetID,
newMarkerType = NEW.markerType,
newLinkagePhase = NEW.linkagePhase,
newSegregationType = NEW.segregationType,
newClassificationType = NEW.classificationType,
newRestrictionEnzyme = NEW.restrictionEnzyme,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_marker_update` BEFORE UPDATE ON `gt_marker_info`
 FOR EACH ROW BEGIN
INSERT INTO gt_marker_audit
SET action='update',
markerID = OLD.markerID,
markerInfoID = OLD.markerInfoID,
markerSetID = OLD.markerSetID,
oldMarkerType = OLD.markerType,
newMarkerType = NEW.markerType,
oldLinkagePhase = OLD.linkagePhase,
newLinkagePhase = NEW.linkagePhase,
oldSegregationType = OLD.segregationType,
newSegregationType = NEW.segregationType,
oldClassificationType = OLD.classificationType,
newClassificationType = NEW.classificationType,
oldRestrictionEnzyme = OLD.restrictionEnzyme,
newRestrictionEnzyme = NEW.restrictionEnzyme,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `gt_marker_model`
--

DROP TABLE IF EXISTS `gt_marker_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gt_marker_model` (
  `associationID` int(10) NOT NULL,
  `markerID` int(7) NOT NULL,
  `pvalue` decimal(20,15) NOT NULL,
  `explv` decimal(20,15) NOT NULL,
  `mk_eff` decimal(20,15) NOT NULL,
  `mk_sed` decimal(20,15) NOT NULL,
  `tot_explv` decimal(20,15) NOT NULL,
  `intercept` decimal(20,15) NOT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`associationID`,`markerID`),
  KEY `remarkID` (`remarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gt_marker_model`
--

LOCK TABLES `gt_marker_model` WRITE;
/*!40000 ALTER TABLE `gt_marker_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `gt_marker_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gt_marker_revisions`
--

DROP TABLE IF EXISTS `gt_marker_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gt_marker_revisions` (
  `action` enum('create','update','delete') COLLATE utf8_unicode_ci NOT NULL,
  `marker` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'name of the marker',
  `genoID` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'name of the genotype',
  `score` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'marker score',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'last edit',
  PRIMARY KEY (`marker`,`lastUpdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Score of the molecular markers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gt_marker_revisions`
--

LOCK TABLES `gt_marker_revisions` WRITE;
/*!40000 ALTER TABLE `gt_marker_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `gt_marker_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gt_marker_set`
--

DROP TABLE IF EXISTS `gt_marker_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gt_marker_set` (
  `markerSetID` int(7) NOT NULL,
  `markerSetInfo` text NOT NULL,
  `publiclyAccessible` enum('Yes','No') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No' COMMENT 'Is the markerset publicly accessible?',
  `addr` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `groupID` int(10) DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`markerSetID`),
  KEY `addr` (`addr`),
  KEY `remarkID` (`remarkID`),
  KEY `groupID` (`groupID`),
  CONSTRAINT `gt_marker_set_ibfk_1` FOREIGN KEY (`addr`) REFERENCES `ad_address` (`addr`),
  CONSTRAINT `gt_marker_set_ibfk_2` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `gt_marker_set_ibfk_3` FOREIGN KEY (`groupID`) REFERENCES `ad_groups` (`groupID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Marker sets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gt_marker_set`
--

LOCK TABLES `gt_marker_set` WRITE;
/*!40000 ALTER TABLE `gt_marker_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `gt_marker_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lt_authors`
--

DROP TABLE IF EXISTS `lt_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lt_authors` (
  `authorID` int(4) NOT NULL COMMENT 'authorID',
  `authorName` varchar(40) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Author Name (First name, Last Name)',
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`authorID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `lt_authors_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Decode table for authors';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lt_authors`
--

LOCK TABLES `lt_authors` WRITE;
/*!40000 ALTER TABLE `lt_authors` DISABLE KEYS */;
/*!40000 ALTER TABLE `lt_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lt_journals`
--

DROP TABLE IF EXISTS `lt_journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lt_journals` (
  `journalID` int(3) NOT NULL AUTO_INCREMENT COMMENT 'journalID',
  `journal` varchar(40) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the Journal',
  PRIMARY KEY (`journalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Decode table for journalID''s';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lt_journals`
--

LOCK TABLES `lt_journals` WRITE;
/*!40000 ALTER TABLE `lt_journals` DISABLE KEYS */;
/*!40000 ALTER TABLE `lt_journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lt_pop_title`
--

DROP TABLE IF EXISTS `lt_pop_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lt_pop_title` (
  `populationID` int(2) NOT NULL COMMENT 'PopulationID',
  `titleID` int(3) NOT NULL COMMENT 'titleID',
  PRIMARY KEY (`populationID`,`titleID`),
  KEY `titleID` (`titleID`),
  CONSTRAINT `lt_pop_title_ibfk_2` FOREIGN KEY (`titleID`) REFERENCES `lt_titles` (`titleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Population to Literature cross ref';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lt_pop_title`
--

LOCK TABLES `lt_pop_title` WRITE;
/*!40000 ALTER TABLE `lt_pop_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `lt_pop_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lt_title_authors`
--

DROP TABLE IF EXISTS `lt_title_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lt_title_authors` (
  `titleID` int(3) NOT NULL COMMENT 'journalID',
  `authorID` int(4) NOT NULL COMMENT 'authorID',
  PRIMARY KEY (`titleID`,`authorID`),
  KEY `authID` (`authorID`),
  CONSTRAINT `lt_title_authors_ibfk_1` FOREIGN KEY (`titleID`) REFERENCES `lt_titles` (`titleID`) ON UPDATE CASCADE,
  CONSTRAINT `lt_title_authors_ibfk_2` FOREIGN KEY (`authorID`) REFERENCES `lt_authors` (`authorID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Decode table for title to author';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lt_title_authors`
--

LOCK TABLES `lt_title_authors` WRITE;
/*!40000 ALTER TABLE `lt_title_authors` DISABLE KEYS */;
/*!40000 ALTER TABLE `lt_title_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lt_titles`
--

DROP TABLE IF EXISTS `lt_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lt_titles` (
  `titleID` int(3) NOT NULL AUTO_INCREMENT COMMENT 'titleID',
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT 'title of the aricle',
  `journalID` int(4) NOT NULL COMMENT 'published in which jounal?',
  `edition` int(4) DEFAULT NULL COMMENT 'edition',
  `volume` int(4) DEFAULT NULL COMMENT 'volume',
  `publicationYear` int(4) NOT NULL COMMENT 'publised in',
  `pages` varchar(11) COLLATE utf8_unicode_ci NOT NULL COMMENT 'pages',
  `pdf` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'link to pdf?',
  PRIMARY KEY (`titleID`),
  UNIQUE KEY `title` (`title`),
  KEY `journalID` (`journalID`),
  CONSTRAINT `lt_titles_ibfk_1` FOREIGN KEY (`journalID`) REFERENCES `lt_journals` (`journalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Titles of articles related to data stored in this database';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lt_titles`
--

LOCK TABLES `lt_titles` WRITE;
/*!40000 ALTER TABLE `lt_titles` DISABLE KEYS */;
/*!40000 ALTER TABLE `lt_titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ma_maps`
--

DROP TABLE IF EXISTS `ma_maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ma_maps` (
  `markerName` varchar(75) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Marker name',
  `mapID` int(2) NOT NULL COMMENT 'map ID',
  `lgName` varchar(25) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Linkage group name',
  `cM` float(15,2) NOT NULL COMMENT 'Position (cM)',
  `LOD` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LOD score',
  `remarkID` int(7) DEFAULT NULL COMMENT 'Remars',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`markerName`,`mapID`,`lgName`,`cM`),
  KEY `mapID` (`mapID`),
  KEY `remarkID` (`remarkID`),
  KEY `markerName` (`markerName`),
  CONSTRAINT `ma_maps_ibfk_1` FOREIGN KEY (`mapID`) REFERENCES `ma_maps_info` (`mapID`),
  CONSTRAINT `ma_maps_ibfk_2` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Genetic linkage maps';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ma_maps`
--

LOCK TABLES `ma_maps` WRITE;
/*!40000 ALTER TABLE `ma_maps` DISABLE KEYS */;
/*!40000 ALTER TABLE `ma_maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ma_maps_info`
--

DROP TABLE IF EXISTS `ma_maps_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ma_maps_info` (
  `mapID` int(3) NOT NULL AUTO_INCREMENT COMMENT 'map ID',
  `mapName` varchar(75) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the map as displayed in the selection box',
  `mapDescription` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description of the map',
  `publiclyAccessible` enum('Yes','No') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No' COMMENT 'Public Or Private Map',
  `mapType` enum('genetic','physical','schematic') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'genetic',
  `mapSoftware` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Software used to calculate the map',
  `calculatedBy` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'map calculated by',
  `addr` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `groupID` int(10) DEFAULT NULL,
  `mapDate` date NOT NULL COMMENT 'when was the map calculated?',
  `revisionNumber` int(2) NOT NULL DEFAULT '1',
  `origin` enum('father','mother','integrated') COLLATE utf8_unicode_ci NOT NULL,
  `crossID` int(7) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mapID`),
  KEY `addr` (`addr`),
  KEY `remarkID` (`remarkID`),
  KEY `groupID` (`groupID`),
  CONSTRAINT `ma_maps_info_ibfk_6` FOREIGN KEY (`addr`) REFERENCES `ad_address` (`addr`) ON UPDATE CASCADE,
  CONSTRAINT `ma_maps_info_ibfk_7` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `ma_maps_info_ibfk_8` FOREIGN KEY (`groupID`) REFERENCES `ad_groups` (`groupID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Detailed information about the genetic linkage maps';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ma_maps_info`
--

LOCK TABLES `ma_maps_info` WRITE;
/*!40000 ALTER TABLE `ma_maps_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `ma_maps_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ol_primerSet`
--

DROP TABLE IF EXISTS `ol_primerSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ol_primerSet` (
  `primerSetID` int(7) NOT NULL,
  `forwardPrimerID` int(7) NOT NULL,
  `reversePrimerID` int(7) NOT NULL,
  `Tm` int(2) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`primerSetID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `ol_primerSet_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Primersets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ol_primerSet`
--

LOCK TABLES `ol_primerSet` WRITE;
/*!40000 ALTER TABLE `ol_primerSet` DISABLE KEYS */;
/*!40000 ALTER TABLE `ol_primerSet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ol_primers`
--

DROP TABLE IF EXISTS `ol_primers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ol_primers` (
  `primerID` int(7) NOT NULL,
  `primerName` varchar(50) NOT NULL,
  `primerSequence` varchar(50) NOT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`primerID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `ol_primers_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Information about primers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ol_primers`
--

LOCK TABLES `ol_primers` WRITE;
/*!40000 ALTER TABLE `ol_primers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ol_primers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `on_traitOntology`
--

DROP TABLE IF EXISTS `on_traitOntology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `on_traitOntology` (
  `ontologyID` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `parentOntologyID` varchar(10) DEFAULT NULL,
  `traitName` varchar(40) NOT NULL,
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ontologyID`),
  KEY `refToID` (`parentOntologyID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `on_traitOntology_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Trait ontology as defined on the SGN';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `on_traitOntology`
--

LOCK TABLES `on_traitOntology` WRITE;
/*!40000 ALTER TABLE `on_traitOntology` DISABLE KEYS */;
/*!40000 ALTER TABLE `on_traitOntology` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_exp_design`
--

DROP TABLE IF EXISTS `ph_exp_design`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_exp_design` (
  `genoID` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Unique EU-SOL identifyer',
  `plantID` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'ExpNR (3), Year (2) en PlantID (5)',
  `experimentID` int(3) NOT NULL COMMENT 'experimentID',
  `compartiment` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `block` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Experimental block',
  `rowNumber` int(2) DEFAULT NULL COMMENT 'row',
  `columnNumber` int(2) DEFAULT NULL COMMENT 'location of the experiment. Can something be done with point(x,y)?',
  `plot` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'Plot number. Combine several adjecent plants of the same genotype',
  `treatmentsID` int(3) NOT NULL DEFAULT '0',
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`plantID`),
  KEY `e_nr` (`experimentID`),
  KEY `remarkID` (`remarkID`),
  KEY `treatmentsID` (`treatmentsID`),
  KEY `genoID` (`genoID`),
  CONSTRAINT `ph_exp_design_ibfk_47` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_exp_design_ibfk_48` FOREIGN KEY (`genoID`) REFERENCES `pp_genotype` (`genoID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_exp_design_ibfk_50` FOREIGN KEY (`treatmentsID`) REFERENCES `ph_exp_design_treatment` (`treatmentsID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_exp_design_ibfk_51` FOREIGN KEY (`experimentID`) REFERENCES `ph_exp_info` (`experimentID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Design of the experiment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_exp_design`
--

LOCK TABLES `ph_exp_design` WRITE;
/*!40000 ALTER TABLE `ph_exp_design` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_exp_design` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_exp_design_treatment`
--

DROP TABLE IF EXISTS `ph_exp_design_treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_exp_design_treatment` (
  `expDesTreatmentID` int(11) NOT NULL AUTO_INCREMENT,
  `treatmentDescriptionID` int(2) NOT NULL,
  `treatmentsID` int(3) NOT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`expDesTreatmentID`),
  UNIQUE KEY `treatmentDescriptionID` (`treatmentDescriptionID`,`treatmentsID`),
  KEY `treatmentsID` (`treatmentsID`),
  CONSTRAINT `ph_exp_design_treatment_ibfk_1` FOREIGN KEY (`treatmentDescriptionID`) REFERENCES `ph_exp_treatment` (`treatmentDescriptionID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_exp_design_treatment`
--

LOCK TABLES `ph_exp_design_treatment` WRITE;
/*!40000 ALTER TABLE `ph_exp_design_treatment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_exp_design_treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_exp_imageCategories`
--

DROP TABLE IF EXISTS `ph_exp_imageCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_exp_imageCategories` (
  `experimentCode` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `categoryHeader` varchar(75) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`experimentCode`,`category`),
  CONSTRAINT `ph_exp_imageCategories_ibfk_1` FOREIGN KEY (`experimentCode`) REFERENCES `ph_exp_info` (`experimentCode`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Utility table for experiments with images in categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_exp_imageCategories`
--

LOCK TABLES `ph_exp_imageCategories` WRITE;
/*!40000 ALTER TABLE `ph_exp_imageCategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_exp_imageCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_exp_info`
--

DROP TABLE IF EXISTS `ph_exp_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_exp_info` (
  `experimentID` int(3) NOT NULL AUTO_INCREMENT COMMENT 'code of the experiment',
  `experimentCode` varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'TBE' COMMENT 'code of the experiment',
  `experimentCode_long` varchar(80) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long version of the experiment code',
  `publiclyAccessible` enum('Yes','No') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No',
  `addr` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'location of the experiment',
  `project` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'For which project was this experiment performed?',
  `userID` int(7) NOT NULL,
  `groupID` int(10) DEFAULT NULL,
  `workpackage` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'In the scope of which workpackage was this experiment performed?',
  `experimentDescription` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'description of the experiment',
  `imageHeader` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'TBE' COMMENT 'Header to show in the database',
  `imageAvailable` enum('Yes','No') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No' COMMENT 'Are there images for this experiment?',
  `imageWithSubCategories` enum('Yes','No') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No' COMMENT 'Were the images stored using a subStructure?',
  `searchFieldNumber` enum('Yes','No') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No' COMMENT 'Allow field number search',
  `experimentYear` int(4) NOT NULL COMMENT 'expYear',
  `sowingDate` date DEFAULT NULL COMMENT 'Sowing date of the experiment',
  `titleID` int(3) DEFAULT NULL COMMENT 'Published experiments in',
  `experimentType` enum('raw','lmEstimate','bluesEstimate') COLLATE utf8_unicode_ci NOT NULL,
  `rawExperimentID` int(3) DEFAULT NULL COMMENT 'experimentID of the experiment containing the raw data (used for processed experiment)',
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`experimentID`),
  UNIQUE KEY `e_code` (`experimentCode`),
  KEY `titleID` (`titleID`),
  KEY `addr` (`addr`),
  KEY `remarkID` (`remarkID`),
  KEY `userID` (`userID`),
  KEY `groupID` (`groupID`),
  CONSTRAINT `ph_exp_info_ibfk_10` FOREIGN KEY (`groupID`) REFERENCES `ad_groups` (`groupID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_exp_info_ibfk_11` FOREIGN KEY (`groupID`) REFERENCES `ad_groups` (`groupID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_exp_info_ibfk_5` FOREIGN KEY (`addr`) REFERENCES `ad_address` (`addr`) ON UPDATE CASCADE,
  CONSTRAINT `ph_exp_info_ibfk_6` FOREIGN KEY (`titleID`) REFERENCES `lt_titles` (`titleID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_exp_info_ibfk_7` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_exp_info_ibfk_8` FOREIGN KEY (`userID`) REFERENCES `ad_users` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Description of the experiment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_exp_info`
--

LOCK TABLES `ph_exp_info` WRITE;
/*!40000 ALTER TABLE `ph_exp_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_exp_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `new_experiment_insert` BEFORE INSERT ON `ph_exp_info`
 FOR EACH ROW BEGIN
INSERT INTO ph_exp_info_audit
SET action='insert',
experimentID = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ph_exp_info'),
newExperimentCode = NEW.experimentCode,
newExperimentCodeLong = NEW.experimentCode_long,
newPubliclyAccessible = NEW.publiclyAccessible,
newAddr = NEW.addr,
newProject = NEW.project,
newWorkPackage = NEW.workpackage,
newExperimentDescription = NEW.experimentDescription,
newExperimentYear = NEW.experimentYear,
newExperimentType = NEW.experimentType,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_experiment_update` BEFORE UPDATE ON `ph_exp_info`
 FOR EACH ROW BEGIN
INSERT INTO ph_exp_info_audit
SET action='update',
experimentID = OLD.experimentID,
oldExperimentCode = OLD.experimentCode,
newExperimentCode = NEW.experimentCode,
oldExperimentCodeLong = OLD.experimentCode_long,
newExperimentCodeLong = NEW.experimentCode_long,
oldPubliclyAccessible = OLD.publiclyAccessible,
newPubliclyAccessible = NEW.publiclyAccessible,
oldAddr = OLD.addr,
newAddr = NEW.addr,
oldProject = OLD.project,
newProject = NEW.project,
userID = OLD.userID,
oldWorkPackage = OLD.workpackage,
newWorkPackage = NEW.workpackage,
oldExperimentDescription = OLD.experimentDescription,
newExperimentDescription = NEW.experimentDescription,
oldExperimentYear = OLD.experimentYear,
newExperimentYear = NEW.experimentYear,
oldExperimentType = OLD.experimentType,
newExperimentType = NEW.experimentType,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ph_exp_info_audit`
--

DROP TABLE IF EXISTS `ph_exp_info_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_exp_info_audit` (
  `counter` int(11) NOT NULL AUTO_INCREMENT,
  `action` enum('update','delete','insert') NOT NULL,
  `experimentID` int(10) NOT NULL,
  `oldExperimentCode` varchar(8) DEFAULT NULL,
  `newExperimentCode` varchar(8) NOT NULL,
  `oldExperimentCodeLong` varchar(80) DEFAULT NULL,
  `newExperimentCodeLong` varchar(80) NOT NULL,
  `oldPubliclyAccessible` enum('Yes','No') DEFAULT NULL,
  `newPubliclyAccessible` enum('Yes','No') NOT NULL DEFAULT 'No',
  `oldAddr` varchar(7) DEFAULT NULL,
  `newAddr` varchar(7) NOT NULL,
  `oldProject` varchar(10) DEFAULT NULL,
  `newProject` varchar(10) DEFAULT NULL,
  `userID` int(10) NOT NULL,
  `oldWorkPackage` varchar(5) DEFAULT NULL,
  `newWorkPackage` varchar(5) DEFAULT NULL,
  `oldExperimentDescription` text,
  `newExperimentDescription` text NOT NULL,
  `oldExperimentYear` int(4) DEFAULT NULL,
  `newExperimentYear` int(4) NOT NULL,
  `oldExperimentType` enum('raw','lmEstimate','bluesEstimate') DEFAULT NULL,
  `newExperimentType` enum('raw','lmEstimate','bluesEstimate') NOT NULL,
  `changed` date NOT NULL,
  PRIMARY KEY (`counter`)
) ENGINE=MyISAM AUTO_INCREMENT=185 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_exp_info_audit`
--

LOCK TABLES `ph_exp_info_audit` WRITE;
/*!40000 ALTER TABLE `ph_exp_info_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_exp_info_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_exp_treatment`
--

DROP TABLE IF EXISTS `ph_exp_treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_exp_treatment` (
  `treatmentDescriptionID` int(2) NOT NULL COMMENT 'treatmentID',
  `treatmentDescription` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description of the treatment',
  `remarkID` int(7) DEFAULT NULL COMMENT 'remark',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`treatmentDescriptionID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `ph_exp_treatment_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Decode table for treatment codes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_exp_treatment`
--

LOCK TABLES `ph_exp_treatment` WRITE;
/*!40000 ALTER TABLE `ph_exp_treatment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_exp_treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_method`
--

DROP TABLE IF EXISTS `ph_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_method` (
  `methodID` int(7) NOT NULL COMMENT 'MethodID',
  `methodDescription` varchar(900) COLLATE utf8_unicode_ci NOT NULL COMMENT 'description of the method',
  `unitID` int(7) NOT NULL DEFAULT '0',
  `scaleType` enum('continuous','ordinal','categories','TBC-single') COLLATE utf8_unicode_ci DEFAULT NULL,
  `scaleID` int(7) DEFAULT NULL,
  `observationType` enum('time','single','divide','TBC-text','TBC') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'single',
  `fileID` int(7) DEFAULT NULL COMMENT 'external link to pdf/word document?',
  `titleID` int(3) DEFAULT NULL COMMENT 'link to article with the most resent description of the method',
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`methodID`),
  KEY `titleID` (`titleID`),
  KEY `remarkID` (`remarkID`),
  KEY `scaleID` (`scaleID`),
  KEY `unitID` (`unitID`),
  KEY `fileID` (`fileID`),
  CONSTRAINT `ph_method_ibfk_2` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_method_ibfk_4` FOREIGN KEY (`titleID`) REFERENCES `lt_titles` (`titleID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_method_ibfk_6` FOREIGN KEY (`fileID`) REFERENCES `xr_externalFiles` (`fileID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_method_ibfk_7` FOREIGN KEY (`scaleID`) REFERENCES `exp_scale_ordinal` (`scaleID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_method_ibfk_8` FOREIGN KEY (`unitID`) REFERENCES `ph_units` (`unitID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Description of the method';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_method`
--

LOCK TABLES `ph_method` WRITE;
/*!40000 ALTER TABLE `ph_method` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_method` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `new_method_insert` BEFORE INSERT ON `ph_method`
 FOR EACH ROW BEGIN
INSERT INTO ph_method_audit
SET action='insert',
methodID = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ph_method'),
newMethodDescription = NEW.methodDescription,
newUnitID = NEW.unitID,
newScaleID = NEW.scaleID,
newScaleType = NEW.scaleType,
newObservationType = NEW.observationType,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_method_update` BEFORE UPDATE ON `ph_method`
 FOR EACH ROW BEGIN
INSERT INTO ph_method_audit
SET action='update',
methodID = OLD.methodID,
oldMethodDescription = OLD.methodDescription,
newMethodDescription = NEW.methodDescription,
oldUnitID = OLD.unitID,
newUnitID = NEW.unitID,
oldScaleID = OLD.scaleID,
newScaleID = NEW.scaleID,
oldScaleType = OLD.scaleType,
newScaleType = NEW.scaleType,
oldObservationType = OLD.observationType,
newObservationType = NEW.observationType,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ph_method_audit`
--

DROP TABLE IF EXISTS `ph_method_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_method_audit` (
  `counter` int(11) NOT NULL AUTO_INCREMENT,
  `action` enum('update','delete','insert') NOT NULL,
  `methodID` int(10) NOT NULL,
  `oldMethodDescription` varchar(900) DEFAULT NULL,
  `newMethodDescription` varchar(900) NOT NULL,
  `oldUnitID` int(10) DEFAULT NULL,
  `newUnitID` int(10) NOT NULL DEFAULT '0',
  `oldScaleID` int(7) DEFAULT NULL,
  `newScaleID` int(7) DEFAULT NULL,
  `oldScaleType` enum('continuous','ordinal','categories','TBC-single') DEFAULT NULL,
  `newScaleType` enum('continuous','ordinal','categories','TBC-single') DEFAULT NULL,
  `oldObservationType` enum('time','single','divide','TBC-text','TBC') DEFAULT NULL,
  `newObservationType` enum('time','single','divide','TBC-text','TBC') NOT NULL DEFAULT 'single',
  `changed` date NOT NULL,
  PRIMARY KEY (`counter`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_method_audit`
--

LOCK TABLES `ph_method_audit` WRITE;
/*!40000 ALTER TABLE `ph_method_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_method_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_observation`
--

DROP TABLE IF EXISTS `ph_observation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_observation` (
  `plantID` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Specific observation of plant',
  `methodID` int(7) NOT NULL DEFAULT '1' COMMENT 'which method is used?',
  `traitID` int(7) NOT NULL COMMENT 'which trait is stored',
  `replicate` int(1) NOT NULL DEFAULT '1' COMMENT 'Replicate measurements',
  `subDivide` int(2) NOT NULL DEFAULT '1' COMMENT 'used for: Leaf numbers, truss numbers  or any other trait which needs a subdevision',
  `observationDate` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT 'date of the observation',
  `numericScore` double(30,7) DEFAULT NULL COMMENT 'observation',
  `textScore` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`plantID`,`observationDate`,`traitID`,`replicate`,`subDivide`),
  KEY `meth` (`methodID`),
  KEY `trt, t_score` (`traitID`,`textScore`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `ph_observation_ibfk_14` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_observation_ibfk_15` FOREIGN KEY (`methodID`) REFERENCES `ph_method` (`methodID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_observation_ibfk_16` FOREIGN KEY (`traitID`) REFERENCES `ph_trait` (`traitID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_observation_ibfk_17` FOREIGN KEY (`plantID`) REFERENCES `ph_exp_design` (`plantID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Score of traits';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_observation`
--

LOCK TABLES `ph_observation` WRITE;
/*!40000 ALTER TABLE `ph_observation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_observation` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `new_observation_insert` BEFORE INSERT ON `ph_observation`
 FOR EACH ROW BEGIN
INSERT INTO ph_observation_audit
SET action='insert',
plantID = NEW.plantID,
traitID = NEW.traitID,
methodID = NEW.methodID,
newReplicate = NEW.replicate,
newSubdivide = NEW.subDivide,
newTextScore = NEW.textScore,
newNumericScore = NEW.numericScore,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_observation_update` BEFORE UPDATE ON `ph_observation`
 FOR EACH ROW BEGIN
INSERT INTO ph_observation_audit
SET action='update',
traitID = OLD.traitID,
plantID = OLD.plantID,
methodID = OLD.methodID,
oldReplicate = OLD.replicate,
newReplicate = NEW.replicate,
oldSubdivide = OLD.subDivide,
newSubdivide = NEW.subDivide,
oldTextScore = OLD.textScore,
newTextScore = NEW.textScore,
oldNumericScore = OLD.numericScore,
newNumericScore = NEW.numericScore,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ph_observation_audit`
--

DROP TABLE IF EXISTS `ph_observation_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_observation_audit` (
  `counter` int(11) NOT NULL AUTO_INCREMENT,
  `action` enum('update','delete','insert') NOT NULL,
  `traitID` int(7) NOT NULL,
  `plantID` varchar(10) NOT NULL,
  `methodID` int(7) NOT NULL,
  `oldReplicate` int(1) DEFAULT NULL,
  `newReplicate` int(1) NOT NULL DEFAULT '1',
  `oldSubdivide` int(2) DEFAULT NULL,
  `newSubdivide` int(2) NOT NULL DEFAULT '1',
  `oldTextScore` varchar(25) DEFAULT NULL,
  `newTextScore` varchar(25) DEFAULT NULL,
  `oldNumericScore` double(30,7) DEFAULT NULL,
  `newNumericScore` double(30,7) DEFAULT NULL,
  `changed` date NOT NULL,
  PRIMARY KEY (`counter`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_observation_audit`
--

LOCK TABLES `ph_observation_audit` WRITE;
/*!40000 ALTER TABLE `ph_observation_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_observation_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_trait`
--

DROP TABLE IF EXISTS `ph_trait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_trait` (
  `traitID` int(7) NOT NULL AUTO_INCREMENT COMMENT 'tratiID',
  `traitDescription` tinytext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description of the trait',
  `traitCode` varchar(25) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Short header for the trait',
  `traitCode_long` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'secondary header for the trait',
  `traitGroup` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'To which group of measurements does this trait belong to?',
  `breedingTarget` enum('High','Medium','Low','Unknown') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Unknown',
  `ontologyID` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`traitID`),
  UNIQUE KEY `trtcode` (`traitCode`),
  KEY `remarkID` (`remarkID`),
  KEY `ontologyID` (`ontologyID`),
  CONSTRAINT `ph_trait_ibfk_8` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_trait_ibfk_9` FOREIGN KEY (`ontologyID`) REFERENCES `on_traitOntology` (`ontologyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Decode table for trait codes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_trait`
--

LOCK TABLES `ph_trait` WRITE;
/*!40000 ALTER TABLE `ph_trait` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_trait` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_trait_audit`
--

DROP TABLE IF EXISTS `ph_trait_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_trait_audit` (
  `counter` int(11) NOT NULL AUTO_INCREMENT,
  `action` enum('update','delete') NOT NULL,
  `traitID` int(10) NOT NULL,
  `oldTraitCode` varchar(12) NOT NULL,
  `newTraitCode` varchar(12) NOT NULL,
  `oldTraitCode_long` varchar(35) NOT NULL,
  `newTraitCode_long` varchar(35) NOT NULL,
  `oldTraitDescription` varchar(200) NOT NULL,
  `newTraitDescription` varchar(200) NOT NULL,
  `oldTraitGroup` varchar(30) NOT NULL,
  `newTraitGroup` varchar(30) NOT NULL,
  `changed` date NOT NULL,
  PRIMARY KEY (`counter`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_trait_audit`
--

LOCK TABLES `ph_trait_audit` WRITE;
/*!40000 ALTER TABLE `ph_trait_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_trait_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ph_units`
--

DROP TABLE IF EXISTS `ph_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ph_units` (
  `unitID` int(7) NOT NULL,
  `unitName` varchar(255) NOT NULL,
  `unitAbbreviation` varbinary(10) DEFAULT NULL,
  `unitDescription` varchar(255) DEFAULT NULL,
  `referenceFactor` float NOT NULL,
  `referenceID` int(7) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`unitID`),
  KEY `remarkID` (`remarkID`),
  KEY `referenceID` (`referenceID`),
  CONSTRAINT `ph_units_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `ph_units_ibfk_2` FOREIGN KEY (`referenceID`) REFERENCES `ph_units` (`unitID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Description of the Units used within the database';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ph_units`
--

LOCK TABLES `ph_units` WRITE;
/*!40000 ALTER TABLE `ph_units` DISABLE KEYS */;
/*!40000 ALTER TABLE `ph_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_accession`
--

DROP TABLE IF EXISTS `pp_accession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_accession` (
  `accessionID` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `accessionName` varchar(125) DEFAULT NULL,
  `accessionDescription` varchar(150) DEFAULT NULL COMMENT 'Description of the accession',
  `fromGenebank` varchar(50) DEFAULT NULL COMMENT 'Accession is obtained from this genebank',
  `fromGenebankID` varchar(12) DEFAULT NULL,
  `fromGenebankID2` varchar(12) DEFAULT NULL COMMENT 'Alternative ID',
  `spp` varchar(15) DEFAULT NULL,
  `speciesName` varchar(35) DEFAULT NULL,
  `taxonomyID` int(7) DEFAULT NULL,
  `subTaxaID` int(7) DEFAULT NULL,
  `gpsLat` varchar(12) DEFAULT NULL,
  `gpsLat_txt` varchar(30) DEFAULT NULL,
  `gpsLong` varchar(12) DEFAULT NULL,
  `gpsLong_txt` varchar(30) DEFAULT NULL,
  `adm1` varchar(40) DEFAULT NULL,
  `adm2` varchar(40) DEFAULT NULL,
  `collectionSiteCountry` varchar(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'unk',
  `adm0` varchar(5) DEFAULT NULL,
  `collectionSite` varchar(40) DEFAULT NULL COMMENT 'Collection site',
  `collectionSiteDetails` tinytext,
  `collectionSiteProvence` varchar(40) DEFAULT NULL COMMENT 'Provence of the collection site',
  `collectionDate` date DEFAULT NULL COMMENT 'Collection date',
  `colNu_IPD` varchar(30) DEFAULT NULL COMMENT 'Collection number',
  `elevation` mediumint(8) DEFAULT NULL,
  `chromosomeNumber` varchar(8) DEFAULT NULL,
  `germplasmStatus` varchar(15) DEFAULT NULL,
  `MTA` varchar(25) DEFAULT NULL,
  `ploidy` varchar(15) DEFAULT NULL,
  `storageID` int(7) DEFAULT NULL,
  `remarkID` int(10) DEFAULT NULL COMMENT 'Remark ID',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`accessionID`),
  KEY `fromGenebank` (`fromGenebank`),
  KEY `storageID` (`storageID`),
  KEY `taxonomyID` (`taxonomyID`),
  KEY `subTaxaID` (`subTaxaID`),
  KEY `remarkID` (`remarkID`),
  KEY `colSiteCountry` (`collectionSiteCountry`),
  CONSTRAINT `pp_accession_ibfk_5` FOREIGN KEY (`taxonomyID`) REFERENCES `pp_taxonomies` (`taxonomyID`),
  CONSTRAINT `pp_accession_ibfk_6` FOREIGN KEY (`subTaxaID`) REFERENCES `pp_subtaxa` (`subTaxaID`),
  CONSTRAINT `pp_accession_ibfk_7` FOREIGN KEY (`storageID`) REFERENCES `se_seedStorage` (`storageID`),
  CONSTRAINT `pp_accession_ibfk_8` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `pp_accession_ibfk_9` FOREIGN KEY (`collectionSiteCountry`) REFERENCES `ad_country` (`cnt`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_accession`
--

LOCK TABLES `pp_accession` WRITE;
/*!40000 ALTER TABLE `pp_accession` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_accession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_collection`
--

DROP TABLE IF EXISTS `pp_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_collection` (
  `genoID` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Accession ID',
  `collection` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description of the collection',
  PRIMARY KEY (`genoID`,`collection`),
  CONSTRAINT `pp_collection_ibfk_1` FOREIGN KEY (`genoID`) REFERENCES `pp_genotype` (`genoID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Describes to which collection a given accession belongs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_collection`
--

LOCK TABLES `pp_collection` WRITE;
/*!40000 ALTER TABLE `pp_collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_genebank`
--

DROP TABLE IF EXISTS `pp_genebank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_genebank` (
  `accessionID` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'accession ID',
  `genebank` varchar(5) NOT NULL COMMENT 'Genebank Code',
  `genebankID` varchar(10) NOT NULL COMMENT 'Genebank ID',
  PRIMARY KEY (`accessionID`,`genebank`),
  CONSTRAINT `pp_genebank_ibfk_1` FOREIGN KEY (`accessionID`) REFERENCES `pp_genotype` (`accessionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Which Genebanks holds information about a given accession?';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_genebank`
--

LOCK TABLES `pp_genebank` WRITE;
/*!40000 ALTER TABLE `pp_genebank` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_genebank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_genotype`
--

DROP TABLE IF EXISTS `pp_genotype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_genotype` (
  `accessionID` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Accession identifyer',
  `genoID` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'genotype ID',
  `genotypeName` varchar(125) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Genotype',
  `populationID` int(7) DEFAULT NULL COMMENT 'Individual is part of this population',
  `populationSort` int(3) NOT NULL DEFAULT '0' COMMENT 'For sort if genotypes does not allow this',
  `crossID` int(7) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `storageID` int(7) DEFAULT NULL COMMENT 'storage data tables to be included from this table!',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`genoID`),
  KEY `popID` (`populationID`),
  KEY `storageID` (`storageID`),
  KEY `accessionID` (`accessionID`),
  KEY `remarkID` (`remarkID`),
  KEY `genotypeName` (`genotypeName`),
  CONSTRAINT `pp_genotype_ibfk_24` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `pp_genotype_ibfk_25` FOREIGN KEY (`storageID`) REFERENCES `se_seedStorage` (`storageID`) ON UPDATE CASCADE,
  CONSTRAINT `pp_genotype_ibfk_26` FOREIGN KEY (`accessionID`) REFERENCES `pp_accession` (`accessionID`) ON UPDATE CASCADE,
  CONSTRAINT `pp_genotype_ibfk_27` FOREIGN KEY (`populationID`) REFERENCES `pp_population` (`populationID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Genotype informatie';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_genotype`
--

LOCK TABLES `pp_genotype` WRITE;
/*!40000 ALTER TABLE `pp_genotype` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_genotype` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `new_genotype_insert` BEFORE INSERT ON `pp_genotype`
 FOR EACH ROW BEGIN
INSERT INTO pp_genotype_audit
SET action='insert',
genoID= NEW.genoID,
newGenotypeName = NEW.genotypeName,
newPopulationSort = NEW.populationSort,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_genotype_update` BEFORE UPDATE ON `pp_genotype`
 FOR EACH ROW BEGIN
INSERT INTO pp_genotype_audit
SET action='update',
accessionID = OLD.accessionID,
genoID = OLD.genoID,
oldGenotypeName = OLD.genotypeName,
newGenotypeName = NEW.genotypeName,
populationID=OLD.populationID,
oldPopulationSort = OLD.populationSort,
newPopulationSort = NEW.populationSort,
changed = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pp_genotype_audit`
--

DROP TABLE IF EXISTS `pp_genotype_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_genotype_audit` (
  `counter` int(11) NOT NULL AUTO_INCREMENT,
  `action` enum('update','delete','insert') NOT NULL,
  `accessionID` varchar(10) DEFAULT NULL,
  `genoID` varchar(20) NOT NULL,
  `oldGenotypeName` varchar(125) DEFAULT NULL,
  `newGenotypeName` varchar(125) NOT NULL,
  `populationID` int(7) DEFAULT NULL,
  `oldPopulationSort` int(3) DEFAULT NULL,
  `newPopulationSort` int(3) NOT NULL DEFAULT '0',
  `changed` date NOT NULL,
  PRIMARY KEY (`counter`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_genotype_audit`
--

LOCK TABLES `pp_genotype_audit` WRITE;
/*!40000 ALTER TABLE `pp_genotype_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_genotype_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_population`
--

DROP TABLE IF EXISTS `pp_population`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_population` (
  `populationID` int(7) NOT NULL AUTO_INCREMENT COMMENT 'PopulationID',
  `defaultMapID` int(7) DEFAULT NULL COMMENT 'Default map, if none is choosen.',
  `populationDescription` varchar(80) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description of the population',
  `populationType` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'population type (e.g. IL/F2/RIL/etc)',
  `groupID` int(7) DEFAULT NULL,
  `ploidy` int(2) DEFAULT '2' COMMENT 'Ploidy of the population',
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`populationID`),
  KEY `remarkID` (`remarkID`),
  KEY `groupID` (`groupID`),
  CONSTRAINT `pp_population_ibfk_5` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`),
  CONSTRAINT `pp_population_ibfk_6` FOREIGN KEY (`groupID`) REFERENCES `ad_groups` (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Description of the (mapping) population';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_population`
--

LOCK TABLES `pp_population` WRITE;
/*!40000 ALTER TABLE `pp_population` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_population` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_seedorder`
--

DROP TABLE IF EXISTS `pp_seedorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_seedorder` (
  `accessionID` varchar(10) DEFAULT NULL COMMENT 'accession Identifyer',
  `genoID` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `userName` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `orderYear` int(4) NOT NULL,
  `orderProcessed` enum('Yes','No') NOT NULL DEFAULT 'No' COMMENT 'Is the order already processed?',
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`genoID`,`userName`),
  KEY `remarkID` (`remarkID`),
  KEY `user` (`userName`),
  CONSTRAINT `pp_seedorder_ibfk_2` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `pp_seedorder_ibfk_4` FOREIGN KEY (`userName`) REFERENCES `ad_users` (`userName`) ON UPDATE CASCADE,
  CONSTRAINT `pp_seedorder_ibfk_5` FOREIGN KEY (`genoID`) REFERENCES `pp_genotype` (`genoID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Seeds ordered by companies';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_seedorder`
--

LOCK TABLES `pp_seedorder` WRITE;
/*!40000 ALTER TABLE `pp_seedorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_seedorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_subtaxa`
--

DROP TABLE IF EXISTS `pp_subtaxa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_subtaxa` (
  `subTaxaID` int(7) NOT NULL,
  `subtaxaAuthor` varchar(255) DEFAULT NULL,
  `taxonomicIdentifier` varchar(255) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`subTaxaID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `pp_subtaxa_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Subtaxa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_subtaxa`
--

LOCK TABLES `pp_subtaxa` WRITE;
/*!40000 ALTER TABLE `pp_subtaxa` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_subtaxa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_taxonomies`
--

DROP TABLE IF EXISTS `pp_taxonomies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pp_taxonomies` (
  `taxonomyID` int(7) NOT NULL,
  `genus` varchar(255) NOT NULL,
  `species` varchar(255) NOT NULL,
  `speciesAuthor` varchar(255) DEFAULT NULL,
  `cropName` varchar(266) DEFAULT NULL,
  `ploidy` int(2) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`taxonomyID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `pp_taxonomies_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='taxonomy';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_taxonomies`
--

LOCK TABLES `pp_taxonomies` WRITE;
/*!40000 ALTER TABLE `pp_taxonomies` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_taxonomies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `se_seedStorage`
--

DROP TABLE IF EXISTS `se_seedStorage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `se_seedStorage` (
  `storageID` int(7) NOT NULL,
  `addr` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(40) NOT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`storageID`),
  KEY `addr` (`addr`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `se_seedStorage_ibfk_3` FOREIGN KEY (`addr`) REFERENCES `ad_address` (`addr`),
  CONSTRAINT `se_seedStorage_ibfk_4` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Where are seed batches stored';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `se_seedStorage`
--

LOCK TABLES `se_seedStorage` WRITE;
/*!40000 ALTER TABLE `se_seedStorage` DISABLE KEYS */;
/*!40000 ALTER TABLE `se_seedStorage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sq_sequence`
--

DROP TABLE IF EXISTS `sq_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sq_sequence` (
  `sequenceID` int(7) NOT NULL,
  `sequenceInfoID` int(7) NOT NULL,
  `genoID` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sequenceName` varchar(25) NOT NULL,
  `sequenceString` text NOT NULL,
  `sequenceType` enum('forward','reverse','consensus') NOT NULL,
  `sequencePrimerID` int(7) DEFAULT NULL,
  `fileID` int(7) DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sequenceID`),
  KEY `geno` (`genoID`),
  KEY `sequenceInfoID` (`sequenceInfoID`),
  KEY `remarkID` (`remarkID`),
  KEY `sequencePrimerID` (`sequencePrimerID`),
  KEY `fileID` (`fileID`),
  CONSTRAINT `sq_sequence_ibfk_15` FOREIGN KEY (`sequencePrimerID`) REFERENCES `ol_primers` (`primerID`) ON UPDATE CASCADE,
  CONSTRAINT `sq_sequence_ibfk_17` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `sq_sequence_ibfk_18` FOREIGN KEY (`sequenceInfoID`) REFERENCES `sq_sequence_info` (`sequenceInfoID`) ON UPDATE CASCADE,
  CONSTRAINT `sq_sequence_ibfk_19` FOREIGN KEY (`genoID`) REFERENCES `pp_genotype` (`genoID`) ON UPDATE CASCADE,
  CONSTRAINT `sq_sequence_ibfk_20` FOREIGN KEY (`fileID`) REFERENCES `xr_externalFiles` (`fileID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Sequencing of DNA fragments are stored in this table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sq_sequence`
--

LOCK TABLES `sq_sequence` WRITE;
/*!40000 ALTER TABLE `sq_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `sq_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sq_sequence_info`
--

DROP TABLE IF EXISTS `sq_sequence_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sq_sequence_info` (
  `sequenceInfoID` int(7) NOT NULL,
  `xrefPublicDatabaseID` int(7) NOT NULL,
  `primerSetID` int(7) DEFAULT NULL,
  `fragmentLength` int(9) DEFAULT NULL,
  `addr` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sequenceInfoID`),
  KEY `xrefPublicDatabaseID` (`xrefPublicDatabaseID`),
  KEY `addr` (`addr`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `sq_sequence_info_ibfk_2` FOREIGN KEY (`xrefPublicDatabaseID`) REFERENCES `xr_externalReference` (`xrefPublicDatabaseID`),
  CONSTRAINT `sq_sequence_info_ibfk_3` FOREIGN KEY (`addr`) REFERENCES `ad_address` (`addr`) ON UPDATE CASCADE,
  CONSTRAINT `sq_sequence_info_ibfk_4` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='General fragemnt sequence information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sq_sequence_info`
--

LOCK TABLES `sq_sequence_info` WRITE;
/*!40000 ALTER TABLE `sq_sequence_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `sq_sequence_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tg_breeding_target`
--

DROP TABLE IF EXISTS `tg_breeding_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tg_breeding_target` (
  `breedingTargetID` int(10) NOT NULL,
  `traitID` int(10) NOT NULL,
  `breedingTarget` enum('High','Medium','Low','Unknown') NOT NULL DEFAULT 'Unknown',
  `dateCreated` date NOT NULL,
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`breedingTargetID`),
  KEY `traitID` (`traitID`),
  CONSTRAINT `tg_breeding_target_ibfk_1` FOREIGN KEY (`traitID`) REFERENCES `ph_trait` (`traitID`) ON UPDATE CASCADE,
  CONSTRAINT `tg_breeding_target_ibfk_2` FOREIGN KEY (`breedingTargetID`) REFERENCES `tg_breeding_target_info` (`breedingTargetID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tg_breeding_target`
--

LOCK TABLES `tg_breeding_target` WRITE;
/*!40000 ALTER TABLE `tg_breeding_target` DISABLE KEYS */;
/*!40000 ALTER TABLE `tg_breeding_target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tg_breeding_target_info`
--

DROP TABLE IF EXISTS `tg_breeding_target_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tg_breeding_target_info` (
  `breedingTargetID` int(10) NOT NULL,
  `userID` int(10) NOT NULL,
  `groupID` int(10) DEFAULT NULL,
  `breedingTarget` varchar(75) NOT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`breedingTargetID`),
  KEY `userID` (`userID`),
  KEY `groupID` (`groupID`),
  CONSTRAINT `tg_breeding_target_info_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `ad_users` (`userID`) ON UPDATE CASCADE,
  CONSTRAINT `tg_breeding_target_info_ibfk_2` FOREIGN KEY (`groupID`) REFERENCES `ad_groups` (`groupID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tg_breeding_target_info`
--

LOCK TABLES `tg_breeding_target_info` WRITE;
/*!40000 ALTER TABLE `tg_breeding_target_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `tg_breeding_target_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wl_DNAIsolation`
--

DROP TABLE IF EXISTS `wl_DNAIsolation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wl_DNAIsolation` (
  `accessionID` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `userName` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `plateName` varchar(50) COLLATE latin1_bin NOT NULL,
  `xCoordinate` int(4) NOT NULL DEFAULT '0',
  `yCoordinate` int(4) NOT NULL DEFAULT '0',
  `DNAStatus` enum('ok','degraded','empty') COLLATE latin1_bin NOT NULL DEFAULT 'ok',
  `storageID` int(10) DEFAULT NULL,
  `remarkID` int(10) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`accessionID`,`userName`,`plateName`,`xCoordinate`),
  KEY `user` (`userName`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `wl_DNAIsolation_ibfk_4` FOREIGN KEY (`userName`) REFERENCES `ad_users` (`userName`) ON UPDATE CASCADE,
  CONSTRAINT `wl_DNAIsolation_ibfk_6` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `wl_DNAIsolation_ibfk_7` FOREIGN KEY (`accessionID`) REFERENCES `pp_genotype` (`accessionID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin COMMENT='Presence and status of isolated DNA';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wl_DNAIsolation`
--

LOCK TABLES `wl_DNAIsolation` WRITE;
/*!40000 ALTER TABLE `wl_DNAIsolation` DISABLE KEYS */;
/*!40000 ALTER TABLE `wl_DNAIsolation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xr_crossFeature`
--

DROP TABLE IF EXISTS `xr_crossFeature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xr_crossFeature` (
  `crossID` int(7) NOT NULL,
  `featureID` int(10) NOT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`crossID`,`featureID`),
  KEY `featureID` (`featureID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `xr_crossFeature_ibfk_3` FOREIGN KEY (`crossID`) REFERENCES `cr_crossComb` (`crossID`),
  CONSTRAINT `xr_crossFeature_ibfk_4` FOREIGN KEY (`featureID`) REFERENCES `ft_feature` (`featureID`),
  CONSTRAINT `xr_crossFeature_ibfk_5` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Features for each potential cross';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xr_crossFeature`
--

LOCK TABLES `xr_crossFeature` WRITE;
/*!40000 ALTER TABLE `xr_crossFeature` DISABLE KEYS */;
/*!40000 ALTER TABLE `xr_crossFeature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xr_externalFiles`
--

DROP TABLE IF EXISTS `xr_externalFiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xr_externalFiles` (
  `fileID` int(7) NOT NULL AUTO_INCREMENT,
  `fileDescription` varchar(200) NOT NULL,
  `filePath` varchar(255) NOT NULL,
  `remarkID` int(7) DEFAULT NULL COMMENT 'remarks',
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`fileID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `xr_externalFiles_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_remarks` (`remarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Link to external files on the filesystem';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xr_externalFiles`
--

LOCK TABLES `xr_externalFiles` WRITE;
/*!40000 ALTER TABLE `xr_externalFiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `xr_externalFiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xr_externalReference`
--

DROP TABLE IF EXISTS `xr_externalReference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xr_externalReference` (
  `xrefPublicDatabaseID` int(7) NOT NULL,
  `externalDatabase` varchar(20) NOT NULL,
  `externalDatabaseID` varchar(20) NOT NULL,
  `startPosition` int(9) NOT NULL,
  `stopPosition` int(9) NOT NULL,
  `linkType` varchar(25) NOT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`xrefPublicDatabaseID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `xr_externalReference_ibfk_1` FOREIGN KEY (`remarkID`) REFERENCES `ad_address` (`remarkID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='xref from internal to external data resources';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xr_externalReference`
--

LOCK TABLES `xr_externalReference` WRITE;
/*!40000 ALTER TABLE `xr_externalReference` DISABLE KEYS */;
/*!40000 ALTER TABLE `xr_externalReference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xr_sequenceFeature`
--

DROP TABLE IF EXISTS `xr_sequenceFeature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xr_sequenceFeature` (
  `referenceSequenceID` int(7) NOT NULL,
  `sequence2` int(7) NOT NULL,
  `sequence2geno` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `featureID` int(7) NOT NULL,
  `remarkID` int(7) DEFAULT NULL,
  `dateCreated` date NOT NULL DEFAULT '2000-01-01',
  `lastUpdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`referenceSequenceID`,`sequence2`,`featureID`),
  KEY `sequence2` (`sequence2`),
  KEY `featureID` (`featureID`),
  KEY `remarkID` (`remarkID`),
  CONSTRAINT `xr_sequenceFeature_ibfk_10` FOREIGN KEY (`sequence2`) REFERENCES `sq_sequence` (`sequenceID`) ON UPDATE CASCADE,
  CONSTRAINT `xr_sequenceFeature_ibfk_11` FOREIGN KEY (`featureID`) REFERENCES `ft_feature` (`featureID`) ON UPDATE CASCADE,
  CONSTRAINT `xr_sequenceFeature_ibfk_12` FOREIGN KEY (`remarkID`) REFERENCES `ad_address` (`remarkID`) ON UPDATE CASCADE,
  CONSTRAINT `xr_sequenceFeature_ibfk_9` FOREIGN KEY (`referenceSequenceID`) REFERENCES `sq_sequence` (`sequenceID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='xref from sequence to feature';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xr_sequenceFeature`
--

LOCK TABLES `xr_sequenceFeature` WRITE;
/*!40000 ALTER TABLE `xr_sequenceFeature` DISABLE KEYS */;
/*!40000 ALTER TABLE `xr_sequenceFeature` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-29 11:54:37