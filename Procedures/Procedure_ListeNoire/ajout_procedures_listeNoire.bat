@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_listeNoire.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : Alexis Deluze
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=%2

sqlcmd -S %mssqlInstanceName% -i Procedure_createListeNoire.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteListeNoire.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateListeNoire.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_isInListeNoire.sql

if "%1"=="nopause" goto start
pause
:start