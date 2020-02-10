cls
@::!/dos/rocks
@echo off
goto :init

:header
    echo %__NAME% v%__VERSION%
    echo This is a simple batch file to import ganames.org-data
    echo.
    echo.
    echo parameters being used:
    echo UserName:     %dbusername%   
    echo Password:     %dbpassword% !!!! may remove this echo from batch file..
    echo DB Host:      %dbhost%   
    echo DB Port:      %dbport%   
    echo DB Name:      %dbname%
    echo working_dir:  %working_dir%
    echo data_dir:     %data_dir%
    echo.
    echo repos being used:
    echo %geonames_general_data_repo%
    echo %geonames_postal_code_repo%
    echo.
    echo.

    goto :eof

:usage
    echo Usage: %__BAT_NAME% 'action'
    echo   Where 'action' can be one of this:
    echo     download-data  Downloads the last packages of data available in GeoNames.
    echo     create-db      Creates the mysql database structure with no data.
    echo     create-tables  Creates the tables in the current database.
    echo                    Useful if we want to import them in an exsiting db.
    echo     import-dumps   Imports geonames data into db. 
    echo                    A database is previously needed for this to work.
    echo     drop-db        Removes the db completely.
    echo     truncate-db    Removes geonames data from db.
    echo.
    echo.  /?, --help           shows this help
    echo.  /v, --version        shows the version
    echo.
    goto :eof

:version
    if "%~1"=="full" call :header & goto :eof
    echo %__VERSION%
    goto :eof

:missing_argument
    call :header
    call :usage
    echo.
    echo ****                                   ****
    echo ****    MISSING "REQUIRED ARGUMENT"    ****
    echo ****                                   ****
    echo.
    goto :eof

:init
    set "__NAME=%~n0"
    set "__VERSION=0.1"
    set "__YEAR=2020"

    set "__BAT_FILE=%~0"
    set "__BAT_PATH=%~dp0"
    set "__BAT_NAME=%~nx0"

    set "OptHelp="
    set "OptVersion="
    set "OptVerbose="

    set "UnNamedArgument="
    set "UnNamedOptionalArg="
    set "NamedFlag="

    set working_dir=%cd%
    set data_dir=%working_dir%\data
    set zip_codes_dir=%working_dir%\data\zip_codes

rem Geonames URLs:
    set geonames_general_data_repo=http://download.geonames.org/export/dump/
    set geonames_postal_code_repo=http://download.geonames.org/export/zip/

rem Default values for database variables:
    set dbhost=localhost
    set dbport=3306
    set dbname=geonames
    set dbusername=geonames
    set dbpassword=geonames
    set sqlpath=c:\Program Files\MariaDB 10.4\bin\

rem Default value for download folder:
    set download_folder=%working_dir%\download
    set download_folder_zip=%download_folder%\zip

rem Default general dumps to download
    set dumps=allCountries.zip alternateNames.zip hierarchy.zip admin1CodesASCII.txt admin2Codes.txt featureCodes_en.txt timeZones.txt countryInfo.txt
rem By default all postal codes ... You can specify a set of the files located at http://download.geonames.org/export/zip/
    set postal_codes=allCountries.zip

:parse
    if "%~1"=="" call :missing_argument & goto :end

    if /i "%~1"=="/?"         call :header & call :usage "%~2" & goto :end
    if /i "%~1"=="-?"         call :header & call :usage "%~2" & goto :end
    if /i "%~1"=="--help"     call :header & call :usage "%~2" & goto :end

    if /i "%~1"=="/v"         call :version      & goto :end
    if /i "%~1"=="-v"         call :version      & goto :end
    if /i "%~1"=="--version"  call :version full & goto :end

    if /i "%~1"=="download-data"   call :header & call :download-data & goto :end
    if /i "%~1"=="create-db"       call :header & call :create-db     & goto :end
    if /i "%~1"=="create-tables"   call :header & call :create-tables & goto :end
    if /i "%~1"=="import-dumps"    call :header & call :import-dumps  & goto :end
    if /i "%~1"=="drop-db"         call :header & call :drop-db       & goto :end
    if /i "%~1"=="truncate-db"     call :header & call :truncate-db   & goto :end

    if /i "%~1"=="--flag"     set "NamedFlag=%~2"   & shift & shift & goto :end

    if not defined UnNamedArgument     set "UnNamedArgument=%~1"     & shift & goto :parse
    if not defined UnNamedOptionalArg  set "UnNamedOptionalArg=%~1"  & shift & goto :parse

    shift
    call :missing_argument & goto :end

:validate
    if not defined UnNamedArgument call :missing_argument & goto :end

rem ####################    download data   ####################
:download-data
    echo starting data download...
    if not exist %download_folder%\ mkdir %download_folder%
    if not exist %download_folder_zip%\ mkdir %download_folder_zip%
    if not exist %data_dir%\ mkdir %data_dir%
    if not exist %zip_codes_dir%\ mkdir %zip_codes_dir%

(for %%a in (%dumps%) do ( 
    echo "Downloading %%a into %download_folder%
    bitsadmin.exe /transfer "%%a" "%geonames_general_data_repo%/%%a" "%download_folder%/%%a"

    if "%%~na.zip"=="%%a" (
        powershell Expand-Archive "%download_folder%\%%a" -DestinationPath %data_dir%
    ) ELSE (
        move "%download_folder%\%%a" %data_dir%
    )
))

(for %%a in (%postal_codes%) do ( 
    echo "Downloading %%a into %download_folder%
    bitsadmin.exe /transfer "%%a" "%geonames_postal_code_repo%/%%a" "%download_folder_zip%/%%a"

    if "%%~na.zip"=="%%a" (
        powershell Expand-Archive "%download_folder_zip%\%%a" -DestinationPath %zip_codes_dir%
    ) ELSE (
        move "%download_folder_zip%\%%a" %zip_codes_dir%
    )
))

goto :eof

rem ####################    create-db       ####################
:create-db
    echo Creating database %dbname%...
    "%sqlpath%mysql" -h %dbhost% -P %dbport% -u %dbusername% -p%dbpassword% -Bse "DROP DATABASE IF EXISTS %dbname%;"
    "%sqlpath%mysql" -h %dbhost% -P %dbport% -u %dbusername% -p%dbpassword% -Bse "CREATE DATABASE %dbname% DEFAULT CHARACTER SET utf8mb4;" 
    "%sqlpath%mysql" -h %dbhost% -P %dbport% -u %dbusername% -p%dbpassword% -Bse "USE %dbname%;" 
    "%sqlpath%mysql" -h %dbhost% -P %dbport% -u %dbusername% -p%dbpassword% %dbname% < "%working_dir%/geonames_db_struct.sql"
    echo batch done
goto :eof

rem ####################    create-tables   ####################
:create-tables
    echo Creating tables for database %dbname%...
    "%sqlpath%mysql" -h %dbhost% -P %dbport% -u %dbusername% -p%dbpassword% -Bse "USE %dbname%;" 
    "%sqlpath%mysql" -h %dbhost% -P %dbport% -u %dbusername% -p%dbpassword% %dbname% < "%working_dir%/geonames_db_struct.sql"
    echo batch done
goto :eof

rem ####################    import-dumps    ####################
:import-dumps
    echo Importing geonames dumps into database %dbname%
    "%sqlpath%mysql" -h %dbhost% -P %dbport% -u %dbusername% -p%dbpassword% --local-infile=1 %dbname% < "%working_dir%/geonames_import_data.sql"
    echo batch done
goto :eof

rem ####################    drop-db         ####################
:drop-db
    echo Dropping %dbname% database
    "%sqlpath%mysql" -h %dbhost% -P %dbport% -u %dbusername% -p%dbpassword% -Bse "DROP DATABASE IF EXISTS %dbname%;"
    echo batch done
goto :eof

rem ####################    truncate-db     ####################
:truncate-db
    echo Truncating %geonames% database
    "%sqlpath%mysql" -h %dbhost% -P %dbport% -u %dbusername% -p%dbpassword% %dbname% < %working_dir%/geonames_truncate_db.sql"
    echo batch done
goto :eof

:end
    call :cleanup
    exit /B

:cleanup
    REM The cleanup function is only really necessary if you
    REM are _not_ using SETLOCAL.
    set "__NAME="
    set "__VERSION="
    set "__YEAR="

    set "__BAT_FILE="
    set "__BAT_PATH="
    set "__BAT_NAME="

    set "OptHelp="
    set "OptVersion="
    set "OptVerbose="

    set "UnNamedArgument="
    set "UnNamedArgument2="
    set "NamedFlag="

    goto :eof
