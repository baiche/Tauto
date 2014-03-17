@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_etat.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs : Mohamed Neti
rem -- Testeurs    : 
rem -- Integrateur : 
rem -- Commentaire : Ajouter les procedures concernant les etats
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

sqlcmd -S %mssqlInstanceName% -i Procedure_createEtat.sql

if "%1"=="nopause" goto start
pause
:start