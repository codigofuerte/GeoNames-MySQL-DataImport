##Shell Script for importing geonames.org data dumps into a mysql database.
This repository contains a linux shell script that downloads and imports the geonames.org geographical data dumps into a MySQL database.

So, there are two operation modes supported in the script.

###Downloading last geonames.org dumps
In order to get the latest dumps from geonames.org you can invoke the script in this way.

    geonames_importer.sh ----download-data

The result files should be:

* admin1CodesASCII.txt
* allCountries.txt
* alternateNames.txt
* countryInfo.txt
* featureCodes_en.txt
* iso-languagecodes.txt
* timeZones.txt

###Creating and dealing with the geographic database
There are some individual operations that you could use:

1.- Create a new database struct.

    geonames_importer.sh --create-db <user> <password>

2.- Import the dumps obtained in the previous operation mode into the database.

    geonames_importer.sh --import-dumps <user> <password>

3.- Dropping the geographic database (you will lose struct and data, so type with care!!!).
 
    geonames_importer.sh --drop-db <user> <password>
 
4.- Truncates geographic data from the database. This will delete all the data contained in the database but will keep the whole struct.

    geonames_importer.sh --truncate-db <user> <password>

