@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_compteAbonne.bat
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
sqlcmd -S %mssqlInstanceName% -i Procedure_backListCompteAbonne.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_createCompteAbonne.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteCompteAbonne.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_disableCompteAbonne.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_getCompteAbonneReservations.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_greyListCompteAbonne.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateCompteAbonne.sql
pause