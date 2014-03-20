@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_modele.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLexpress"

sqlcmd -S %mssqlInstanceName% -i Procedure_deleteModele.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_disableModele.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updatePrixModele.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateReductionModele.sql

if "%1"=="nopause" goto start
pause
:start