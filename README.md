### V 2.0 Shell Script for importing geonames.org data dumps into a MySQL database.

Usage: geonames_importer.sh -a "action"

Where "action" can be: 
  
- **download-data** Downloads the last packages of data available in GeoNames. An additional parameter with a download directory should be used.
- **create-db** Creates the mysql database structure with no data.
- **create-tables** Creates the tables in the current database. Useful if we want to import them in an exsiting db.
- **import-dumps** Imports geonames data into db. A database is previously needed for this to work.
- **drop-db** Removes the db completely.
- **truncate-db** Removes geonames data from db.
    
The <a href="http://codigofuerte.github.com/GeoNames-MySQL-DataImport" target="_blank">reference site</a> is still under construction for this new version. Stay tuned to this site.
