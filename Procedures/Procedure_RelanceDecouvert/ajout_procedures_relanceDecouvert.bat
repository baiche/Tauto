@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_relanceDecouvert.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

sqlcmd -S %mssqlInstanceName% -i Procedure_createRelanceDecouvert.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteRelanceDecouvert.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_disableRelanceDecouvert.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_relanceRelanceDecouvert.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateNiveauRelanceDecouvert.sql

if "%1"=="nopause" goto start
pause
:start