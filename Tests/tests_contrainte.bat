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

@echo on

echo Test des contraintes de la table ListeNoire
sqlcmd -S %mssqlInstanceName% -i 20140228_SACT_Tauto_ListeNoire.sql
sqlcmd -S %mssqlInstanceName% -i 20140228_SACT_Tauto_RelanceDecouvert.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Catalogue.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_CategorieModele.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_CompteAbonne.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_CompteAbonneConducteur.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Conducteur.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Entreprise.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Facturation.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Particulier.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_Permis.sql
sqlcmd -S %mssqlInstanceName% -i 20140303_SACT_Tauto_SousPermis.sql
sqlcmd -S %mssqlInstanceName% -i 20140304_SACT_Tauto_Location.sql
sqlcmd -S %mssqlInstanceName% -i 20140305_SACT_Tauto_Abonnement.sql
sqlcmd -S %mssqlInstanceName% -i 20140305_SACT_Tauto_Retard.sql
sqlcmd -S %mssqlInstanceName% -i 20140305_SACT_Tauto_TypeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i 20140306_SACT_Etat.sql
sqlcmd -S %mssqlInstanceName% -i 20140306_SACT_Tauto_Incident.sql
sqlcmd -S %mssqlInstanceName% -i 20140306_SACT_Tauto_Infraction.sql
sqlcmd -S %mssqlInstanceName% -i 20140309_SACT_Tauto_ConducteurLocation.sql
sqlcmd -S %mssqlInstanceName% -i 20140309_SACT_Tauto_Reservation.sql
echo Test des contraintes de la table ReservationVehicule
sqlcmd -S %mssqlInstanceName% -i 20140310_SACT_Tauto_ReservationVehicule.sql
pause