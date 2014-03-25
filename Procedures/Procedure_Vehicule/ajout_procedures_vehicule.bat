@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_vehicule.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : Alexis Deluze
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=%2

sqlcmd -S %mssqlInstanceName% -i Procedure_createVehicule.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteVehicule.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_disableVehicule.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_setKilometrageVehicule.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_setStatutVehicule.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateVehicule.sql

if "%1"=="nopause" goto start
pause
:start