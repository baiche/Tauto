@echo off
rem ------------------------------------------------------------
rem -- Fichier     : run_peuplement.bat
rem -- Date        : 17/02/2014
rem -- Version     : 2.0
rem -- Auteur      : Jean-Luc Amitousa Mankoy
rem -- Correcteurs  : Allan Mottier
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\"

@echo on
sqlcmd -S %mssqlInstanceName% -i ..\Generation\ScriptSuppression.sql
sqlcmd -S %mssqlInstanceName% -i ..\Generation\Generation.sql -v Param1="%cd%"
sqlcmd -S %mssqlInstanceName% -i .\00_Peuplement_TypeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i .\01_Peuplement_Permis.sql
sqlcmd -S %mssqlInstanceName% -i .\02_Peuplement_SousPermis.sql
sqlcmd -S %mssqlInstanceName% -i .\03_Peuplement_Conducteur.sql
sqlcmd -S %mssqlInstanceName% -i .\04_Peuplement_Particulier.sql
sqlcmd -S %mssqlInstanceName% -i .\05_Peuplement_Entreprise.sql
sqlcmd -S %mssqlInstanceName% -i .\06_Peuplement_Catalogue.sql
sqlcmd -S %mssqlInstanceName% -i .\07_Peuplement_ListeNoire.sql
sqlcmd -S %mssqlInstanceName% -i .\08_Peuplement_Modele.sql
sqlcmd -S %mssqlInstanceName% -i .\09_Peuplement_Vehicule.sql
sqlcmd -S %mssqlInstanceName% -i .\10_Peuplement_Abonnement.sql
sqlcmd -S %mssqlInstanceName% -i .\11_Peuplement_Categorie.sql
sqlcmd -S %mssqlInstanceName% -i .\12_Peuplement_Facturation.sql
sqlcmd -S %mssqlInstanceName% -i .\13_Peuplement_ContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i .\14_Peuplement_LocationEtat.sql
sqlcmd -S %mssqlInstanceName% -i .\15_Peuplement_Retard.sql
sqlcmd -S %mssqlInstanceName% -i .\16_Peuplement_Reservation.sql
sqlcmd -S %mssqlInstanceName% -i .\17_Peuplement_Incident.sql
sqlcmd -S %mssqlInstanceName% -i .\18_Peuplement_Infraction.sql
sqlcmd -S %mssqlInstanceName% -i .\19_Peuplement_CategorieModel.sql
sqlcmd -S %mssqlInstanceName% -i .\20_Peuplement_RelanceDecouvert.sql
sqlcmd -S %mssqlInstanceName% -i .\21_Peuplement_CatalogueCategorie.sql
sqlcmd -S %mssqlInstanceName% -i .\22_Peuplement_CompteAbonneConducteur.sql
sqlcmd -S %mssqlInstanceName% -i .\23_Peuplement_ConducteurLocation.sql
sqlcmd -S %mssqlInstanceName% -i .\24_Peuplement_ReservationVehicule.sql
pause