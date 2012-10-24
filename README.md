IMPORTACIÓN DE BASE DE DATOS GEOGRÁFICA A PARTIR DEL CONTENIDO DE GEONAMES
==========================================================================

Existen tres conjuntos de ficheros diferentes:

- .txt: Dumps con la información geográfica descargada de GeoNames.
- .sql: Scripts mySQL para la creación de la base de datos y para la importación de los dumps anteriores.
- geonames_importer.sh:  Script principal para crear, eliminar, recrear etc. la base de datos a partir de los dumps.

En principio el script geonames.sh contiene todas las acciones posibles a realizar para recrear la base de datos.

OPCIONES DE EJECUCIÓN
=====================

 1.- Generación de la base de datos. Unicamente genera la estructura de la BD.
     geonames_importer.sh --create-db

 2.- Importación de dumps en la base de datos.
     geonames_importer.sh --import-dumps

 3.- Eliminación de la base de datos. Elimina estructura y datos de la base de datos.
     geonames_importer.sh --drop-db
 
 4.- Truncado Borrado de datos exclusivamente. Mantiene la estructura de la base de datos.
     geonames_importer.sh --truncate-db

