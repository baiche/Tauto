@echo off
rem ------------------------------------------------------------
rem -- Fichier     : run_peuplement.bat
rem -- Date        : 17/02/2014
rem -- Version     : 2.0
rem -- Auteur      : Jean-Luc Amitousa Mankoy
rem -- Correcteurs  : Allan Mottier
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

@echo on
sqlcmd -S %mssqlInstanceName% -i ScriptSuppression.sql
sqlcmd -S %mssqlInstanceName% -i Generation.sql -v Param1="%cd%"
pause