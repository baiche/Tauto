@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_MacroProcedure_Utilisateur.bat
rem -- Date        : 16/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

sqlcmd -S %mssqlInstanceName% -i associateConducteurToLocation.sql
sqlcmd -S %mssqlInstanceName% -i blackListCompte.sql
sqlcmd -S %mssqlInstanceName% -i cancelReservation.sql
sqlcmd -S %mssqlInstanceName% -i closeCompte.sql
sqlcmd -S %mssqlInstanceName% -i declareConducteur.sql
sqlcmd -S %mssqlInstanceName% -i declarePermis.sql
sqlcmd -S %mssqlInstanceName% -i makeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i makeCatalogue.sql
sqlcmd -S %mssqlInstanceName% -i makeCategorie.sql
sqlcmd -S %mssqlInstanceName% -i makeCompteEntreprise.sql
sqlcmd -S %mssqlInstanceName% -i makeCompteParticulier.sql
sqlcmd -S %mssqlInstanceName% -i makeModele.sql
sqlcmd -S %mssqlInstanceName% -i makeReservation.sql
sqlcmd -S %mssqlInstanceName% -i makeVehicule.sql
sqlcmd -S %mssqlInstanceName% -i modifyCompte.sql
sqlcmd -S %mssqlInstanceName% -i modifyConducteur.sql
sqlcmd -S %mssqlInstanceName% -i searchVehicule.sql
sqlcmd -S %mssqlInstanceName% -i turnReservationIntoContratLocation.sql

if "%1"=="nopause" goto start
pause
:start