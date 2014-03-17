@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_typeAbonnement.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs : Mohamed Neti
rem -- Testeurs    : 
rem -- Integrateur : 
rem -- Commentaire : Ajoute les procedures concernant les types d'abonnements
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

sqlcmd -S %mssqlInstanceName% -i Procedure_createTypeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteTypeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateTypeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_disableTypeAbonnement.sql

if "%1"=="nopause" goto start
pause
:start