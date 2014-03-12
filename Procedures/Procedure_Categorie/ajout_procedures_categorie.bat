@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_categorie.bat
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
sqlcmd -S %mssqlInstanceName% -i Procedure_createCategorie.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteCategorie.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_disableCategorie.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateCategorie.sql
pause