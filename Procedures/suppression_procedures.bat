@echo off
rem ------------------------------------------------------------
rem -- Fichier     : suppression_procedures.bat
rem -- Date        : 15/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------

SET mssqlInstanceName=".\SQLexpress"
sqlcmd -S %mssqlInstanceName% -i Procedure_Abonnement\Suppression_Procedure_Abonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Catalogue\Suppression_Procedure_Catalogue.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_CatalogueCategorie\Suppression_Procedure_CatalogueCategorie.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Categorie\Suppression_Procedure_Categorie.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_CategorieModele\Suppression_Procedure_CategorieModele.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_CompteAbonne\Suppression_Procedure_CompteAbonne.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_CompteAbonneConducteur\Suppression_Procedure_CompteAbonneConducteur.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Conducteur\Suppression_Procedure_Conducteur.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_ConducteurLocation\Suppression_Procedure_ConducteurLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_ContratLocation\Suppression_Procedure_ContratLocation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Etat\Suppression_Procedure_Etat.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Facturation\Suppression_Procedure_Facturation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Incident\Suppression_Procedure_Incident.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Infraction\Suppression_Procedure_Infraction.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_ListeNoire\Suppression_Procedure_ListeNoire.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Location\Suppression_Procedure_Location.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Modele\Suppression_Procedure_Modele.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Permis\Suppression_Procedure_Permis.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_RelanceDecouvert\Suppression_Procedure_RelanceDecouvert.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Reservation\Suppression_Procedure_Reservation.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Retard\Suppression_Procedure_Retard.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_SousPermis\Suppression_Procedure_SousPermis.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_TypeAbonnement\Suppression_Procedure_TypeAbonnement.sql
sqlcmd -S %mssqlInstanceName% -i Procedure_Vehicule\Suppression_Procedure_Vehicule.sql
pause