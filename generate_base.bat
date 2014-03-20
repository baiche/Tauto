@echo off
rem ------------------------------------------------------------
rem -- Fichier     : generate_base.bat
rem -- Date        : 17/02/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLexpress"


sqlcmd -S %mssqlInstanceName% -i Generation\ScriptSuppression.sql
sqlcmd -S %mssqlInstanceName% -i Generation\Generation.sql -v Param1="%cd%"
sqlcmd -S %mssqlInstanceName% -i Generation\ProcedureAnnexe.sql


call .\ajout_procedures.bat nopause

if "%1"=="nopause" goto start
pause
:start