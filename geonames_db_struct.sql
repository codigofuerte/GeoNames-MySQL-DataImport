-- DROP DATABASE IF EXISTS geonames; 
-- CREATE DATABASE geonames DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
-- USE geonames;

-- Create syntax for TABLE 'admin1CodesAscii'
CREATE TABLE `admin1CodesAscii` (
  `code` char(15) DEFAULT NULL,
  `name` text,
  `nameAscii` text,
  `geonameid` int(11) DEFAULT NULL,
  KEY `code` (`code`),
  KEY `name` (`name`(20)),
  KEY `nameAscii` (`nameAscii`(20)),
  KEY `geonameid` (`geonameid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'admin2Codes'
CREATE TABLE `admin2Codes` (
  `code` char(15) DEFAULT NULL,
  `name` text,
  `nameAscii` text,
  `geonameid` int(11) DEFAULT NULL,
  KEY `code` (`code`),
  KEY `name` (`name`(80)),
  KEY `nameAscii` (`nameAscii`(80)),
  KEY `geonameid` (`geonameid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'alternatename'
CREATE TABLE `alternatename` (
  `alternatenameId` int(11) NOT NULL,
  `geonameid` int(11) DEFAULT NULL,
  `isoLanguage` varchar(7) DEFAULT NULL,
  `alternateName` varchar(200) DEFAULT NULL,
  `isPreferredName` tinyint(1) DEFAULT NULL,
  `isShortName` tinyint(1) DEFAULT NULL,
  `isColloquial` tinyint(1) DEFAULT NULL,
  `isHistoric` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`alternatenameId`),
  KEY `geonameid` (`geonameid`),
  KEY `isoLanguage` (`isoLanguage`),
  KEY `alternateName` (`alternateName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'continentCodes'
CREATE TABLE `continentCodes` (
  `code` char(2) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `geonameid` int(11) DEFAULT NULL,
  KEY `code` (`code`),
  KEY `name` (`name`),
  KEY `geonameid` (`geonameid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'countryinfo'
CREATE TABLE `countryinfo` (
  `iso_alpha2` char(2) DEFAULT NULL,
  `iso_alpha3` char(3) DEFAULT NULL,
  `iso_numeric` int(11) DEFAULT NULL,
  `fips_code` varchar(3) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `capital` varchar(200) DEFAULT NULL,
  `areainsqkm` double DEFAULT NULL,
  `population` int(11) DEFAULT NULL,
  `continent` char(2) DEFAULT NULL,
  `tld` char(3) DEFAULT NULL,
  `currency` char(3) DEFAULT NULL,
  `currencyName` char(20) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL,
  `postalCodeFormat` varchar(100) DEFAULT NULL,
  `postalCodeRegex` varchar(255) DEFAULT NULL,
  `geonameId` int(11) DEFAULT NULL,
  `languages` varchar(200) DEFAULT NULL,
  `neighbours` char(100) DEFAULT NULL,
  `equivalentFipsCode` char(10) DEFAULT NULL,
  KEY `iso_alpha2` (`iso_alpha2`),
  KEY `iso_alpha3` (`iso_alpha3`),
  KEY `iso_numeric` (`iso_numeric`),
  KEY `fips_code` (`fips_code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'featureCodes'
CREATE TABLE `featureCodes` (
  `code` char(7) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `description` text,
  KEY `code` (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'geoname'
CREATE TABLE `geoname` (
  `geonameid` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `asciiname` varchar(200) DEFAULT NULL,
  `alternatenames` varchar(4000) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `fclass` char(1) DEFAULT NULL,
  `fcode` varchar(10) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `cc2` varchar(60) DEFAULT NULL,
  `admin1` varchar(20) DEFAULT NULL,
  `admin2` varchar(80) DEFAULT NULL,
  `admin3` varchar(20) DEFAULT NULL,
  `admin4` varchar(20) DEFAULT NULL,
  `population` int(11) DEFAULT NULL,
  `elevation` int(11) DEFAULT NULL,
  `gtopo30` int(11) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL,
  `moddate` date DEFAULT NULL,
  PRIMARY KEY (`geonameid`),
  KEY `name` (`name`),
  KEY `asciiname` (`asciiname`),
  KEY `latitude` (`latitude`),
  KEY `longitude` (`longitude`),
  KEY `fclass` (`fclass`),
  KEY `fcode` (`fcode`),
  KEY `country` (`country`),
  KEY `cc2` (`cc2`),
  KEY `admin1` (`admin1`),
  KEY `population` (`population`),
  KEY `elevation` (`elevation`),
  KEY `timezone` (`timezone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'hierarchy'
CREATE TABLE `hierarchy` (
  `parentId` int(11) DEFAULT NULL,
  `childId` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  KEY `parentId` (`parentId`),
  KEY `childId` (`childId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'iso_languagecodes'
CREATE TABLE `iso_languagecodes` (
  `iso_639_3` char(4) DEFAULT NULL,
  `iso_639_2` varchar(50) DEFAULT NULL,
  `iso_639_1` varchar(50) DEFAULT NULL,
  `language_name` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'timeZones'
CREATE TABLE `timeZones` (
  `timeZoneId` varchar(200) DEFAULT NULL,
  `GMT_offset` decimal(3,1) DEFAULT NULL,
  `DST_offset` decimal(3,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;

-- Create syntax for TABLE 'postalCodes'
CREATE TABLE `postalCodes` (
  `country` char(2) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `name` varchar(180) DEFAULT NULL,
  `admin1_name` varchar(100) DEFAULT NULL,
  `admin1_code` varchar(20) DEFAULT NULL,
  `admin2_name` varchar(100) DEFAULT NULL,
  `admin2_code` varchar(20) DEFAULT NULL,
  `admin3_name` varchar(100) DEFAULT NULL,
  `admin3_code` varchar(20) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `accuracy` tinyint(2) DEFAULT NULL,
  KEY `admin1_code` (`admin1_code`),
  KEY `country` (`country`),
  KEY `name` (`name`),
  KEY `postal_code` (`postal_code`),
  KEY `latitude` (`latitude`),
  KEY `longitude` (`longitude`),
  KEY `admin1_name` (`admin1_name`),
  KEY `admin1_code_2` (`admin1_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci;
