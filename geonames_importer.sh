#!/bin/bash

# [BEGIN] CONFIGURATION FOR THE SCRIPT
# -------------------------------------
# Default values for database variables.
dbhost="localhost"
dbport=3306
dbname="geonames"
dbusername= "root"
dbpassword= "root"

# Default value for download folder
download_folder="download"

# Default general dumps to download
dumps= "allCountries.zip alternateNames.zip hierarchy.zip admin1CodesASCII.txt admin2Codes.txt featureCodes_en.txt timeZones.txt countryInfo.txt"
# By default all postal codes ... You can specify a set of the files located at http://download.geonames.org/export/zip/
postal_codes= "allCountries.zip"

# [END] CONFIGURATION FOR THE SCRIPT
# -------------------------------------

logo() {
echo " __________________________________________________________________________________________________________________ "
echo "   _____                                              _____        _          _____                            _    "
echo "  / ____|                                            |  __ \      | |        |_   _|                          | |   "
echo " | |  __  ___  ___  _ __   __ _ _ __ ___   ___  ___  | |  | | __ _| |_ __ _    | |  _ __ ___  _ __   ___  _ __| |_  "
echo " | | |_ |/ _ \/ _ \| '_ \ / _` | '_ ` _ \ / _ \/ __| | |  | |/ _` | __/ _` |   | | | '_ ` _ \| '_ \ / _ \| '__| __| "
echo " | |__| |  __/ (_) | | | | (_| | | | | | |  __/\__ \ | |__| | (_| | || (_| |  _| |_| | | | | | |_) | (_) | |  | |_  "
echo "  \_____|\___|\___/|_| |_|\__,_|_| |_| |_|\___||___/ |_____/ \__,_|\__\__,_| |_____|_| |_| |_| .__/ \___/|_|   \__| "
echo "                                                                                             |_|                    "
echo " __________________________________________________ v 2.0 _________________________________________________________ "
}

usage() {
	logo
	echo "Usage: " $0 "-a <action> "
    echo " Where <action> can be one of this: "
	echo "    download-data: Downloads the last packages of data available in GeoNames. An additional parameter with a download directory should be used."
    echo "    create-db: Creates the mysql database structure with no data."
    echo "    create-tables: Creates the tables in the current database. Useful if we want to import them in an exsiting db."
    echo "    import-dumps: Imports geonames data into db. A database is previously needed for this to work."
	echo "    drop-db: Removes the db completely."
    echo "    truncate-db: Removes geonames data from db."
    echo
    # echo " The rest of parameters indicates the following information:"
	# echo "    -u <user>     User name to access database server."
	# echo "    -p <password> User password to access database server."
	# echo "    -h <host>     Data Base Server address (default: localhost)."
	# echo "    -r <port>     Data Base Server Port (default: 3306)"
	# echo "    -n <dbname>  Data Base Name for the geonames.org data (default: geonames)"
    exit -1
}

dump_db_params() {
    echo "Database parameters being used..."
    echo "Orden: " $action
    echo "UserName: " $dbusername
    echo "Password: " $dbpassword
    echo "DB Host: " $dbhost
    echo "DB Port: " $dbport
    echo "DB Name: " $dbname
}

# download_geonames_data() {
# 	echo "Downloading GeoNames.org data..." 
#     download_folder="$1"
#     dumps="allCountries.zip alternateNames.zip hierarchy.zip admin1CodesASCII.txt admin2Codes.txt featureCodes_en.txt timeZones.txt countryInfo.txt"
#     zip_codes="allCountries.zip"
#     for dump in $dumps; do
#         wget -c -P "$download_folder" http://download.geonames.org/export/dump/$dump
#     done
#     for zip in $zip_codes; do
#         wget -c -P "$download_folder" -O "${zip:0:(-4)}_zip.zip" http://download.geonames.org/export/zip/$zip
#     done
#     unzip "*_zip.zip" -d ./zip
#     rm *_zip.zip
#     unzip "*.zip"
#     rm *.zip
# }

if [ $# -lt 1 ]; then
	usage
	exit 1
fi

logo

# Deals operation mode 1 (Download data bundles from geonames.org)
#if { [ "$1" == "--download-data" ]; } then
#	if { [ "$2" != "" ]; } then
#		if [ ! -d "$2" ]; then
#			echo "Folder '$2' doesn't exists. Run mkdir..."
#			mkdir "$2"
#		fi
#		download_folder="$2"
#	fi
#	echo "download_folder=$download_folder"
#	download_geonames_data "$download_folder"
#fi

# Deals with operation mode 2 (Database issues...)
# Parses command line parameters.
while getopts "a:u:p:h:r:n:" opt; 
do
    case $opt in
        a) action=$OPTARG ;;
        u) dbusername=$OPTARG ;;
        p) dbpassword=$OPTARG ;;
        h) dbhost=$OPTARG ;;
        r) dbport=$OPTARG ;;
        n) dbname=$OPTARG ;;
    esac
done


case $action in
    download-data)
        echo "STARTING DATA DOWNLOAD !!"
        # Checks if a download folder has been specified.
        if { [ "$3" != "" ]; } then
            if [ ! -d "$3" ]; then
                echo "Temporary download data folder '$3' doesn't exists. Creating it."
                mkdir -p "$3"
            fi
            download_folder="`pwd`/$3"
        else
            if [ ! -d "$download_folder" ]; then
                echo "Temporary download data folder '$download_folder' doesn't exists. Creating it."
                mkdir -p "$download_folder"
            fi
        fi

        # Dumps General data.
        echo "Downloading general files"
        for dump in $dumps; do
            echo "Downloading $dump into $download_folder"
            wget -c -P "$download_folder" http://download.geonames.org/export/dump/$dump
            if [ ${dump: -4} == ".zip" ]; then
                echo "Unzipping $dump into `pwd`"
                unzip "$download_folder/$dump" -d "`pwd`"
            fi
        done

        # Dumps Postal Code data.
        echo "Downloading postal code information"
        if [ ! -d "$download_folder/zip_codes" ]; then
                echo "Temporary download data folder '$download_folder/zip_codes' doesn't exists. Creating it."
                mkdir -p "$download_folder/zip_codes"
            fi        
        for postal_code_file in $postal_codes; do
            echo "Downloading $postal_code_file into $download_folder/zip_codes"
            wget -c -P "$download_folder/zip_codes" http://download.geonames.org/export/zip/$postal_code_file
            if [ ${dump: -4} == ".zip" ]; then
                echo "Unzipping Postal Code file $postal_code_file into $download_folder/zip_codes"
                unzip "$download_folder/zip_codes/$postal_code_file" -d "$download_folder/zip_codes"
            fi 
        done
        echo "DATA DOWNLOAD FINISH !!"
        exit 0
    ;;
esac

# if [ -z $dbusername ]; then
#     echo "No user name provided for accessing the database. Please write some value in parameter -u..."
#     exit 1
# fi

# if [ -z $dbpassword ]; then
#     echo "No user password provided for accessing the database. Please write some value in parameter -p..."
#     exit 1
# fi

case "$action" in
    create-db)
        echo "Creating database $dbname..."
        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword -Bse "DROP DATABASE IF EXISTS $dbname;"
        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword -Bse "CREATE DATABASE $dbname DEFAULT CHARACTER SET utf8;" 
        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword -Bse "USE $dbname;" 
        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword $dbname < `pwd`/geonames_db_struct.sql
    ;;
        
    create-tables)
        echo "Creating tables for database $dbname..."
        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword -Bse "USE $dbname;" 
        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword $dbname < `pwd`/geonames_db_struct.sql
    ;;
    
    import-dumps)
        echo "Importing geonames dumps into database $dbname"
        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword --local-infile=1 $dbname < `pwd`/geonames_import_data.sql
    ;;    
    
    drop-db)
        echo "Dropping $dbname database"
        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword -Bse "DROP DATABASE IF EXISTS $dbname;"
    ;;
        
    truncate-db)
        echo "Truncating \"geonames\" database"
        mysql -h $dbhost -P $dbport -u $dbusername -p$dbpassword $dbname < `pwd`/geonames_truncate_db.sql
    ;;
esac

if [ $? == 0 ]; then 
	echo "[OK]"
else
	echo "[FAILED]"
fi

exit 0
