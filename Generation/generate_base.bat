@echo off
rem ------------------------------------------------------------
rem -- Fichier     : genarate_base.bat
rem -- Date        : 17/02/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

@echo on
sqlcmd -S %mssqlInstanceName% -i ScriptSuppression.sql
sqlcmd -S %mssqlInstanceName% -i Generation.sql -v Param1="%cd%"
pause