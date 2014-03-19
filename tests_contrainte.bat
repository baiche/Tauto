@echo off
rem ----------------------------------------------------------------------------
rem -- Fichier     : tests_contrainte.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : La base est censé être créé et vide au lancement des tests
rem ----------------------------------------------------------------------------

SET mssqlInstanceName=".\SQLEXPRESS"

cd Tests

echo Debut des tests > ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test ListeNoire >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140228_SACT_Tauto_ListeNoire.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test RelanceDecouvert >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140228_SACT_Tauto_RelanceDecouvert.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Catalogue >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Catalogue.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test CategorieModele >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_CategorieModele.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test CompteAbonne >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_CompteAbonne.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test CompteAbonneConducteur >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_CompteAbonneConducteur.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Conducteur >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Conducteur.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Entreprise >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Entreprise.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Facturation >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Facturation.sql >> ..\rapport_tests_contrainte.txt

echo Test Particulier >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Particulier.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Permis >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Permis.sql >> ..\rapport_tests_contrainte.txt

echo Test SousPermis >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_SousPermis.sql >> ..\rapport_tests_contrainte.txt

echo Test Location >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140304_SACT_Tauto_Location.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Abonnement >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140305_SACT_Tauto_Abonnement.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Retard >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140305_SACT_Tauto_Retard.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test TypeAbonnement >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140305_SACT_Tauto_TypeAbonnement.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Etat >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140306_SACT_Etat.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Incident >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140306_SACT_Tauto_Incident.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Infraction >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140306_SACT_Tauto_Infraction.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test ConducteurLocation >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140309_SACT_Tauto_ConducteurLocation.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test Reservation >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140309_SACT_Tauto_Reservation.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

echo Test ReservationVehicule >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt
sqlcmd -S %mssqlInstanceName% -i 20140310_SACT_Tauto_ReservationVehicule.sql >> ..\rapport_tests_contrainte.txt
echo. >> ..\rapport_tests_contrainte.txt

pause