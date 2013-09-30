-- DROP DATABASE IF EXISTS geonames; 
-- CREATE DATABASE geonames DEFAULT CHARACTER SET utf8;
-- USE geonames;

CREATE TABLE geoname (
    geonameid int PRIMARY KEY,
    name varchar(200),
    asciiname varchar(200),
    alternatenames varchar(4000),
    latitude decimal(10,7),
    longitude decimal(10,7),
    fclass char(1),
    fcode varchar(10),
    country varchar(2),
    cc2 varchar(60),
    admin1 varchar(20),
    admin2 varchar(80),
    admin3 varchar(20),
    admin4 varchar(20),
    population int,
    elevation int,
    gtopo30 int,
    timezone varchar(40),
    moddate date,
    PRIMARY KEY (geonameid)
) CHARACTER SET utf8;


CREATE TABLE alternatename (
    alternatenameId int PRIMARY KEY,
    geonameid int,
    isoLanguage varchar(7),
    alternateName varchar(200),
    isPreferredName BOOLEAN,
    isShortName BOOLEAN,
    isColloquial BOOLEAN,
    isHistoric BOOLEAN,
    PRIMARY KEY (alternatenameId)
) CHARACTER SET utf8;


CREATE TABLE countryinfo (
    iso_alpha2 char(2),
    iso_alpha3 char(3),
    iso_numeric integer,
    fips_code varchar(3),
    name varchar(200),
    capital varchar(200),
    areainsqkm double,
    population integer,
    continent char(2),
    tld char(3),
    currency char(3),
    currencyName char(20),
    Phone char(10),
    postalCodeFormat varchar(100),
    postalCodeRegex varchar(255),
    geonameId int,
    languages varchar(200),
    neighbours char(100),
    equivalentFipsCode char(10),
    PRIMARY KEY (iso_alpha2)
) CHARACTER SET utf8;


CREATE TABLE iso_languagecodes(
    iso_639_3 CHAR(4),
    iso_639_2 VARCHAR(50),
    iso_639_1 VARCHAR(50),
    language_name VARCHAR(200),
    PRIMARY KEY (iso_639_3)
) CHARACTER SET utf8;


CREATE TABLE admin1CodesAscii (
    code CHAR(6),
    name TEXT,
    nameAscii TEXT,
    geonameid int,
    PRIMARY KEY (code, geonameid)
) CHARACTER SET utf8;


CREATE TABLE admin2Codes (
    code CHAR(15),
    name TEXT,
    nameAscii TEXT,
    geonameid int,
    PRIMARY KEY (code, geonameid)
) CHARACTER SET utf8;


CREATE TABLE hierarchy (
    parentId int,
    childId int,
    type VARCHAR(50),
    PRIMARY KEY (hierarchyId)
) CHARACTER SET utf8;


CREATE TABLE featureCodes (
    code CHAR(7),
    name VARCHAR(200),
    description TEXT,
    PRIMARY KEY (code)
) CHARACTER SET utf8;


CREATE TABLE timeZones (
    id int NOT NULL AUTO_INCREMENT,
    timeZoneId VARCHAR(200),
    GMT_offset DECIMAL(3,1),
    DST_offset DECIMAL(3,1),
    PRIMARY KEY (id)
) CHARACTER SET utf8;


CREATE TABLE continentCodes (
    code CHAR(2),
    name VARCHAR(20),
    geonameid INT,
    PRIMARY KEY (code)
) CHARACTER SET utf8;
