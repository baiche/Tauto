@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_abonnement.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs : Mohamed Neti
rem -- Testeurs    : 
rem -- Integrateur : 
rem -- Commentaire : Ajoute les procedures concernant les abonnements de la base.
rem ------------------------------------------------------------

SET mssqlInstanceName=".\"

sqlcmd -S %mssqlInstanceName% -i Procedure_createAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_disableAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateTypeAbonnementForAbonnement.sql

if "%1"=="nopause" goto start
pause
:start
