#!/bin/bash

expected_args=3

logo() {
	echo "================================================================================================"
	echo "                           G E O N A M E S    D A T A    I M P O R T E R                        "
	echo "================================================================================================"
}

usage() {
	logo
	echo Usage 1:  $0 --download-data "(this gets the current in GeoNames.org to the local machine)."
	echo
	echo Usage 2:  $0 "<action> <user> <password> (this is to operate with the database)"
    echo Where action can be one of this:
	echo "    --download-data Downloads the last packages of data available in GeoNames."
    echo "    --create-db Creates the mysl database structure with no data."
    echo "    --import-dumps Imports geonames data into db. A database is previously needed for this to work."
	echo "    --drop-db Removes the db completely."
    echo "    --truncate-db Removes geonames data from db."
    echo
	echo "<user> User name to access database server."
	echo "<password> User password to access database server."
	echo "================================================================================================"
    exit -1
}

logo

if { [ $# == 1 ] && [ "$1" == "--download-data" ]; } then
	echo "Downloading GeoNames.org data..." 
	wget http://download.geonames.org/export/dump/allCountries.zip
	wget http://download.geonames.org/export/dump/alternateNames.zip
	wget http://download.geonames.org/export/dump/admin1CodesASCII.txt
	wget http://download.geonames.org/export/dump/featureCodes_en.txt
	wget http://download.geonames.org/export/dump/timeZones.txt
	wget http://download.geonames.org/export/dump/countryInfo.txt
	unzip allCountries.zip
	unzip alternateNames.zip
	rm allCountries.zip
	rm alternateNames.zip
else
	case "$1" in

		"--create-db")
			echo "Creating \"geonames\" database"
			mysql -u $2 -p$3 < geonames_db_struct.sql
		;;

		"--import-dumps")
			echo "Importing \"geonames\" data into database"
			mysql -u $2 -p$3 < geonames_db_struct.sql
			mysql -u $2 -p$3 < geonames_import_data.sql
		;;	

		"--drop-db")
			echo "Dropping \"geonames\" database"
			mysql -u $2 -p$3 < geonames_drop_database.sql;
		;;

		"--truncate-db")
			echo "Truncating \"geonames\" database"
			mysql -u $2 -p$3 < geonames_trucate_db.sql;
		;;

	esac
fi

if [ $? == 0 ]; then 
	echo "[OK]"
else
	echo "[FAILED]"
fi

exit 0
