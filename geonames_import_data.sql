SELECT '########## Loading allCountries.txt... ##########';
LOAD DATA LOCAL INFILE 'allCountries.txt'
INTO TABLE geoname
CHARACTER SET 'UTF8'
(geonameid, name, asciiname, alternatenames, latitude, longitude, fclass, fcode, country, cc2, admin1, admin2, admin3, admin4, population, elevation, gtopo30, timezone, moddate);

SELECT '########## Loading alternateNames.txt... ##########';
LOAD DATA LOCAL INFILE 'alternateNames.txt'
INTO TABLE alternatename
CHARACTER SET 'UTF8'
(alternatenameid, geonameid, isoLanguage, alternateName, isPreferredName, isShortName, isColloquial, isHistoric);

SELECT '########## Loading iso-languagecodes.txt... ##########';
LOAD DATA LOCAL INFILE 'iso-languagecodes.txt'
INTO TABLE iso_languagecodes
CHARACTER SET 'UTF8'
IGNORE 1 LINES
(iso_639_3, iso_639_2, iso_639_1, language_name);

SELECT '########## Loading admin1CodesASCII.txt... ##########';
LOAD DATA LOCAL INFILE 'admin1CodesASCII.txt'
INTO TABLE admin1CodesAscii
CHARACTER SET 'UTF8'
(code, name, nameAscii, geonameid);

SELECT '########## Loading admin2Codes.txt... ##########';
LOAD DATA LOCAL INFILE 'admin2Codes.txt'
INTO TABLE admin2Codes
CHARACTER SET 'UTF8'
(code, name, nameAscii, geonameid);

SELECT '########## Loading hierarchy.txt... ##########';
LOAD DATA LOCAL INFILE 'hierarchy.txt'
INTO TABLE hierarchy
CHARACTER SET 'UTF8'
(parentId, childId, type);

SELECT '########## Loading featureCodes_en.txt... ##########';
LOAD DATA LOCAL INFILE 'featureCodes_en.txt'
INTO TABLE featureCodes
CHARACTER SET 'UTF8'
(code, name, description);

SELECT '########## Loading timeZones.txt... ##########';
LOAD DATA LOCAL INFILE 'timeZones.txt'
INTO TABLE timeZones
CHARACTER SET 'UTF8'
IGNORE 1 LINES
(timeZoneId, GMT_offset, DST_offset);

SELECT '########## Loading countryInfo.txt... ##########';
LOAD DATA LOCAL INFILE 'countryInfo.txt'
INTO TABLE countryinfo
CHARACTER SET 'UTF8'
IGNORE 51 LINES
(iso_alpha2, iso_alpha3, iso_numeric, fips_code, name, capital, areaInSqKm, population, continent, tld, currency, currencyName, phone, postalCodeFormat, postalCodeRegex, languages, geonameid, neighbours, equivalentFipsCode);

SELECT '########## Loading continentCodes.txt... ##########';
LOAD DATA LOCAL INFILE 'continentCodes.txt'
INTO TABLE continentCodes
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ','
(code, name, geonameId);

SELECT '########## Loading zipcodes/allCountries.txt... ##########';
LOAD DATA LOCAL INFILE 'zipcodes/allCountries.txt'
INTO TABLE postalCodes
CHARACTER SET 'UTF8'
(country, postal_code, name, admin1_name, admin1_code, admin2_name, admin2_code, admin3_name, admin3_code, latitude, longitude, accuracy);
