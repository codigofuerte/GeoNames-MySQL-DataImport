-- MySQL dump 10.11
--
-- Host: localhost    Database: geonames
-- ------------------------------------------------------
-- Server version	5.0.67

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
-- Table structure for table `admin1Codes`
--

DROP TABLE IF EXISTS `admin1Codes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `admin1Codes` (
  `code` char(10) default NULL,
  `name` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `admin1CodesAscii`
--

DROP TABLE IF EXISTS `admin1CodesAscii`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `admin1CodesAscii` (
  `code` char(10) default NULL,
  `name` text,
  `nameAscii` text,
  `geonameid` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `alternatename`
--

DROP TABLE IF EXISTS `alternatename`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `alternatename` (
  `alternatenameId` int(11) NOT NULL,
  `geonameid` int(11) default NULL,
  `isoLanguage` varchar(7) default NULL,
  `alternateName` varchar(200) default NULL,
  `isPreferredName` tinyint(1) default NULL,
  `isShortName` tinyint(1) default NULL,
  PRIMARY KEY  (`alternatenameId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `continentCodes`
--

DROP TABLE IF EXISTS `continentCodes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `continentCodes` (
  `code` char(2) default NULL,
  `name` varchar(20) default NULL,
  `geonameid` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `countryinfo`
--

DROP TABLE IF EXISTS `countryinfo`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `countryinfo` (
  `iso_alpha2` char(2) default NULL,
  `iso_alpha3` char(3) default NULL,
  `iso_numeric` int(11) default NULL,
  `fips_code` varchar(3) default NULL,
  `name` varchar(200) default NULL,
  `capital` varchar(200) default NULL,
  `areainsqkm` bigint(20) default NULL,
  `population` int(11) default NULL,
  `continent` char(2) default NULL,
  `tld` varchar(4) default NULL,
  `currency_code` char(3) default NULL,
  `currency_name` varchar(32) default NULL,
  `phone` varchar(16) default NULL,
  `postal_code_format` varchar(64) default NULL,
  `postal_code_regex` varchar(256) default NULL,
  `languages` varchar(200) default NULL,
  `geonameId` int(11) default NULL,
  `neighbours` varchar(64) default NULL,
  `equivalent_fips_code` varchar(3) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `featureCodes`
--

DROP TABLE IF EXISTS `featureCodes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `featureCodes` (
  `code` char(7) default NULL,
  `name` varchar(200) default NULL,
  `description` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `geoname`
--

DROP TABLE IF EXISTS `geoname`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `geoname` (
  `geonameid` int(11) NOT NULL,
  `name` varchar(200) default NULL,
  `asciiname` varchar(200) default NULL,
  `alternatenames` varchar(4000) default NULL,
  `latitude` decimal(10,7) default NULL,
  `longitude` decimal(10,7) default NULL,
  `fclass` char(1) default NULL,
  `fcode` varchar(10) default NULL,
  `country` varchar(2) default NULL,
  `cc2` varchar(60) default NULL,
  `admin1` varchar(20) default NULL,
  `admin2` varchar(80) default NULL,
  `admin3` varchar(20) default NULL,
  `admin4` varchar(20) default NULL,
  `population` int(11) default NULL,
  `elevation` int(11) default NULL,
  `gtopo30` int(11) default NULL,
  `timezone` varchar(40) default NULL,
  `moddate` date default NULL,
  PRIMARY KEY  (`geonameid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `geonames`
--

DROP TABLE IF EXISTS `geonames`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `geonames` (
  `geonameid` int(10) unsigned NOT NULL default '0',
  `name` varchar(200) NOT NULL default '',
  `ansiname` varchar(200) NOT NULL default '',
  `alternames` varchar(2000) NOT NULL default '',
  `latitude` double NOT NULL default '0',
  `longitude` double NOT NULL default '0',
  `feature_class` char(1) default NULL,
  `feature_code` varchar(10) default NULL,
  `country_code` char(2) default NULL,
  `cc2` varchar(60) default NULL,
  `admin1_code` varchar(20) default '',
  `admin2_code` varchar(80) default '',
  `admin3_code` varchar(20) default '',
  `admin4_code` varchar(20) default '',
  `population` int(11) default '0',
  `elevation` int(11) default '0',
  `gtopo30` int(11) default '0',
  `timezone` varchar(40) default NULL,
  `modification_date` date default '0000-00-00',
  PRIMARY KEY  (`geonameid`),
  KEY `cc2` (`cc2`),
  KEY `timezone` (`timezone`),
  KEY `latlong` (`latitude`,`longitude`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `geonames_admin2codes`
--

DROP TABLE IF EXISTS `geonames_admin2codes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `geonames_admin2codes` (
  `code` char(10) default NULL,
  `name_local` text,
  `name` text NOT NULL,
  `geonameid` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `iso_languagecodes`
--

DROP TABLE IF EXISTS `iso_languagecodes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `iso_languagecodes` (
  `iso_639_3` char(4) default NULL,
  `iso_639_2` varchar(50) default NULL,
  `iso_639_1` varchar(50) default NULL,
  `language_name` varchar(200) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `timeZones`
--

DROP TABLE IF EXISTS `timeZones`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `timeZones` (
  `timeZoneId` varchar(200) default NULL,
  `GMT_offset` decimal(3,1) default NULL,
  `DST_offset` decimal(3,1) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-02-09  0:52:34
