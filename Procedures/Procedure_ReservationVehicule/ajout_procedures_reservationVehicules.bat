@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_reservationVehicule.bat
rem -- Date        : 24/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Baiche Mourad
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\"

sqlcmd -S %mssqlInstanceName% -i Procedure_addVehiculeToReservation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_removeVehiculeFromReservation.sql

if "%1"=="nopause" goto start
pause
:start