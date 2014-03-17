@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_abonnement.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

sqlcmd -S %mssqlInstanceName% -i Procedure_createAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_disableAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateTypeAbonnementForAbonnement.sql

if "%1"=="nopause" goto start
pause
:start
