@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_location.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

@echo on
sqlcmd -S %mssqlInstanceName% -i Procedure_createLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteLocation.sql
pause