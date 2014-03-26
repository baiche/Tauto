@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_etat.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs : Mohamed Neti, David Lecoconnier
rem -- Testeurs    : 
rem -- Integrateur : Alexis Deluze
rem -- Commentaire : Ajouter les procedures concernant les etats
rem ------------------------------------------------------------

SET mssqlInstanceName=%2

sqlcmd -S %mssqlInstanceName% -i Procedure_createEtat.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateEtat.sql

if "%1"=="nopause" goto start
pause
:start