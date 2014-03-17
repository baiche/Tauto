@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures_reservation.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

sqlcmd -S %mssqlInstanceName% -i Procedure_createReservation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_deleteReservation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_updateReservation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_disableReservation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_cancelReservation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_notReservedVehicle1.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_isDisponible1.sql

if "%1"=="nopause" goto start
pause
:start