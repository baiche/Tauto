@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_location.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : Alexis Deluze
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=%2

sqlcmd -S %mssqlInstanceName% -i Procedure_createLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateLocation.sql

if "%1"=="nopause" goto start
pause
:start