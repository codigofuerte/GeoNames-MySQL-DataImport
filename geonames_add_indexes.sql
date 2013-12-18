ALTER TABLE admin1CodesAscii ADD INDEX (code);
ALTER TABLE admin1CodesAscii ADD INDEX (name(20));
ALTER TABLE admin1CodesAscii ADD INDEX (nameAscii(20));
ALTER TABLE admin1CodesAscii ADD INDEX (geonameid);

ALTER TABLE admin2Codes ADD INDEX (code);
ALTER TABLE admin2Codes ADD INDEX (name(80));
ALTER TABLE admin2Codes ADD INDEX (nameAscii(80));
ALTER TABLE admin2Codes ADD INDEX (geonameid);

ALTER TABLE alternatename ADD INDEX (geonameid);
ALTER TABLE alternatename ADD INDEX (isoLanguage);
ALTER TABLE alternatename ADD INDEX (alternateName);

ALTER TABLE continentCodes ADD INDEX (code);
ALTER TABLE continentCodes ADD INDEX (name);
ALTER TABLE continentCodes ADD INDEX (geonameid);

ALTER TABLE countryinfo ADD INDEX (iso_alpha2);
ALTER TABLE countryinfo ADD INDEX (iso_alpha3);
ALTER TABLE countryinfo ADD INDEX (iso_numeric);
ALTER TABLE countryinfo ADD INDEX (fips_code);
ALTER TABLE countryinfo ADD INDEX (name);

ALTER TABLE featureCodes ADD INDEX (code);
ALTER TABLE featureCodes ADD INDEX (name);

ALTER TABLE geoname ADD INDEX (name);
ALTER TABLE geoname ADD INDEX (asciiname);
ALTER TABLE geoname ADD INDEX (latitude);
ALTER TABLE geoname ADD INDEX (longitude);
ALTER TABLE geoname ADD INDEX (fclass);
ALTER TABLE geoname ADD INDEX (fcode);
ALTER TABLE geoname ADD INDEX (country);
ALTER TABLE geoname ADD INDEX (cc2);
ALTER TABLE geoname ADD INDEX (admin1);
ALTER TABLE geoname ADD INDEX (population);
ALTER TABLE geoname ADD INDEX (elevation);
ALTER TABLE geoname ADD INDEX (timezone);

ALTER TABLE hierarchy ADD INDEX (parentid);
ALTER TABLE hierarchy ADD INDEX (childid);
ALTER TABLE hierarchy ADD INDEX (type);