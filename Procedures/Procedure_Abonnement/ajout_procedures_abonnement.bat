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

@echo on
sqlcmd -S %mssqlInstanceName% -i Procedure_canDeleteAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_createAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateAbonnement.sql
pause