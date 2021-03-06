@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_contratLocation.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : Alexis Deluze
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=%2

sqlcmd -S %mssqlInstanceName% -i Procedure_updateContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_canExtendContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_createContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_endContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_extendContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_printContratLocation.sql

if "%1"=="nopause" goto start
pause
:start