@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_MacroProcedure_Utilisateur.bat
rem -- Date        : 16/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : NETI Mohamed
rem -- Testeurs     : 
rem -- Integrateur : Alexis Deluze
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=%2


sqlcmd -S %mssqlInstanceName% -i associateConducteurToLocation.sql
sqlcmd -S %mssqlInstanceName% -i blackListCompte.sql
sqlcmd -S %mssqlInstanceName% -i cancelReservation.sql
sqlcmd -S %mssqlInstanceName% -i closeCatalogue.sql
sqlcmd -S %mssqlInstanceName% -i closeCategorie.sql
sqlcmd -S %mssqlInstanceName% -i closeCompte.sql
sqlcmd -S %mssqlInstanceName% -i closeModele.sql
sqlcmd -S %mssqlInstanceName% -i closeVehicule.sql
sqlcmd -S %mssqlInstanceName% -i declareConducteur.sql
sqlcmd -S %mssqlInstanceName% -i declarePermis.sql
sqlcmd -S %mssqlInstanceName% -i deleteTrigger.sql
sqlcmd -S %mssqlInstanceName% -i fixFacturation.sql
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

echo ajout des MacroProcedure_Utilisateur V2
echo.
cd .\V2 
sqlcmd -S %mssqlInstanceName% -i endContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i endEtat.sql
sqlcmd -S %mssqlInstanceName% -i extendContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i extendReservation.sql
sqlcmd -S %mssqlInstanceName% -i findOtherVehicule.sql
sqlcmd -S %mssqlInstanceName% -i makeEtat.sql
sqlcmd -S %mssqlInstanceName% -i makeTypeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i modifyAbonnement.sql

echo ajout des MacroProcedure_Utilisateur V3
echo.
cd ..\V3
sqlcmd -S %mssqlInstanceName% -i checkContratLocationTrigger.sql
sqlcmd -S %mssqlInstanceName% -i checkImpayeTrigger.sql
sqlcmd -S %mssqlInstanceName% -i checkReservationTrigger.sql
sqlcmd -S %mssqlInstanceName% -i closeCatalogue.sql
sqlcmd -S %mssqlInstanceName% -i closeCategorie.sql
sqlcmd -S %mssqlInstanceName% -i closeModele.sql
sqlcmd -S %mssqlInstanceName% -i closeTypeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i findOtherVehiculeWithElevation.sql
sqlcmd -S %mssqlInstanceName% -i fixInfraction.sql
sqlcmd -S %mssqlInstanceName% -i fixRetard.sql
sqlcmd -S %mssqlInstanceName% -i fixVehicule.sql
sqlcmd -S %mssqlInstanceName% -i makeIncident.sql
sqlcmd -S %mssqlInstanceName% -i makeInfraction.sql
sqlcmd -S %mssqlInstanceName% -i makeRetard.sql
sqlcmd -S %mssqlInstanceName% -i modifyTypeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i showInfraction.sql

cd ..

if "%1"=="nopause" goto start
pause
:start