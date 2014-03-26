@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_catalogueCategorie.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : Alexis Deluze
rem -- Commentaire : 
rem ------------------------------------------------------------


SET mssqlInstanceName=%2

sqlcmd -S %mssqlInstanceName% -i Procedure_addCategorieToCatalogue.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_removeCategorieFromCatalogue.sql

if "%1"=="nopause" goto start
pause
:start