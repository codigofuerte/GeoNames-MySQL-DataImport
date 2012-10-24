#!/bin/bash

EXPECTED_ARGS=3

logo() {
	echo "==============================================="
	echo " G E O N A M E S    D A T A    I M P O R T E R "
	echo "==============================================="
}

if [ $# -ne $EXPECTED_ARGS ]; then 
	echo Usage: $0 "[--create-db | --import-dumps | --drop-db | --truncate-db]  <user> <password>"
    echo "--create-db Creates the mysl database structure with no data."
    echo "--import-dumps Imports geonames data into db. A database is previously needed for this to work."
	echo "--drop-db Removes the db completely."
    echo "--truncate-db Removes geonames data from db."
	echo "<user> User name to access database server."
	echo "<password> User password to access database server."
    exit -1
fi

case "$1" in
	"--create-db")
		logo
		echo "Creating \"geonames\" database"
		mysql -u $2 -p$3 < geonames_db_struct.sql
	;;
	"--import-dumps")
		logo
		echo "Importing \"geonames\" data into database"
		mysql -u $2 -p$3 < geonames_db_struct.sql
		mysql -u $2 -p$3 < geonames_import_data.sql
	;;	
	"--drop-db")	
		logo
		echo "Dropping \"geonames\" database"
		mysql -u $2 -p$3 < geonames_drop_database.sql;
	;;
	"--truncate-db")
		logo
		echo "Truncating \"geonames\" database"
		mysql -u $2 -p$3 < geonames_trucate_db.sql;
	;;

esac

if [ $? == 0 ]; then 
	echo "[OK]"
else
	echo "[FAILED]"
fi

exit 0
