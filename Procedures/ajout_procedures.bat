@echo off
rem ------------------------------------------------------------
rem -- Fichier     : ajout_procedures.bat
rem -- Date        : 12/03/2014
rem -- Version     : 2.0
rem -- Auteur      : Boris de Finance
rem -- Correcteurs  : 
rem -- Testeurs     : 
rem -- Integrateur : 
rem -- Commentaire : 
rem ------------------------------------------------------------


echo ajout des Procedure_Abonnement
cd Procedure_Abonnement
call .\ajout_procedures_abonnement.bat nopause

echo ajout des Procedure_Catalogue
cd ..\Procedure_Catalogue
call .\ajout_procedures_catalogue.bat nopause


echo ajout des Procedure_CatalogueCategorie
cd ..\Procedure_CatalogueCategorie
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Categorie
cd ..\Procedure_Categorie
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_CategorieModele
cd ..\Procedure_CategorieModele 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_CompteAbonne
cd ..\Procedure_CompteAbonne
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_CompteAbonneConducteur
cd ..\Procedure_CompteAbonneConducteur
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Conducteur
cd ..\Procedure_Conducteur 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_ConducteurLocation
cd ..\Procedure_ConducteurLocation 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_ContratLocation
cd ..\Procedure_ContratLocation 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Etat
cd ..\Procedure_Etat 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Facturation
cd ..\Procedure_Facturation 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Incident
cd ..\Procedure_Incident 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Infraction
cd ..\Procedure_Infraction 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_ListeNoire
cd ..\Procedure_ListeNoire  
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Location
cd ..\Procedure_Location 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Modele
cd ..\Procedure_Modele 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Permis
cd ..\Procedure_Permis 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_RelanceDecouvert
cd ..\Procedure_RelanceDecouvert 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Reservation
cd ..\Procedure_Reservation 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Retard
cd ..\Procedure_Retard 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_SousPermis
cd ..\Procedure_SousPermis  
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_TypeAbonnement
cd ..\Procedure_TypeAbonnement 
call .\ajout_procedures_catalogue.bat nopause

echo ajout des Procedure_Vehicule
cd ..\Procedure_Vehicule 
call .\ajout_procedures_catalogue.bat nopause

pause