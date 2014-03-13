@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_facturation.bat
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
sqlcmd -S %mssqlInstanceName% -i Procedure_createFacturation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_printFacturation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateFacturation.sql

if "%1"=="nopause" goto start
pause
:start
