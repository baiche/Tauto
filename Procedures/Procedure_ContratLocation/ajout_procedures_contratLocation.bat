@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_contratLocation.bat
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
sqlcmd -S %mssqlInstanceName% -i Procedure_canExtendContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_createContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_endContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_extendContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_printContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateContratLocation.sql
pause