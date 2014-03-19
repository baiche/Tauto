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
echo.
cd Procedure_Abonnement
call .\ajout_procedures_abonnement.bat nopause
echo.

echo ajout des Procedure_Catalogue
echo.
cd ..\Procedure_Catalogue
call .\ajout_procedures_catalogue.bat nopause
echo.

echo ajout des Procedure_CatalogueCategorie
echo.
cd ..\Procedure_CatalogueCategorie
call .\ajout_procedures_catalogueCategorie.bat nopause
echo.

echo ajout des Procedure_Categorie
echo.
cd ..\Procedure_Categorie
call .\ajout_procedures_categorie.bat nopause
echo.

echo ajout des Procedure_CategorieModele
echo.
cd ..\Procedure_CategorieModele 
call .\ajout_procedures_categorieModele.bat nopause
echo.

echo ajout des Procedure_CompteAbonne
echo.
cd ..\Procedure_CompteAbonne
call .\ajout_procedures_compteAbonne.bat nopause
echo.

echo ajout des Procedure_CompteAbonneConducteur
echo.
cd ..\Procedure_CompteAbonneConducteur
call .\ajout_procedures_compteAbonneConducteur.bat nopause
echo.

echo ajout des Procedure_Conducteur
echo.
cd ..\Procedure_Conducteur 
call .\ajout_procedures_conducteur.bat nopause
echo.

echo ajout des Procedure_ConducteurLocation
echo.
cd ..\Procedure_ConducteurLocation 
call .\ajout_procedures_conducteurLocation.bat nopause
echo.

echo ajout des Procedure_Etat
echo.
cd ..\Procedure_Etat 
call .\ajout_procedures_etat.bat nopause
echo.

echo ajout des Procedure_Facturation
cd ..\Procedure_Facturation 
call .\ajout_procedures_facturation.bat nopause
echo.

echo ajout des Procedure_Incident
echo.
cd ..\Procedure_Incident 
call .\ajout_procedures_incident.bat nopause
echo.

echo ajout des Procedure_Infraction
echo.
cd ..\Procedure_Infraction 
call .\ajout_procedures_infraction.bat nopause
echo.

echo ajout des Procedure_ListeNoire
echo.
cd ..\Procedure_ListeNoire  
call .\ajout_procedures_listeNoire.bat nopause
echo.

echo ajout des Procedure_Location
echo.
cd ..\Procedure_Location 
call .\ajout_procedures_location.bat nopause
echo.

echo ajout des Procedure_ContratLocation
echo.
cd ..\Procedure_ContratLocation 
call .\ajout_procedures_contratLocation.bat nopause
echo.

echo ajout des Procedure_Modele
echo.
cd ..\Procedure_Modele 
call .\ajout_procedures_modele.bat nopause
echo.

echo ajout des Procedure_Permis
echo.
cd ..\Procedure_Permis 
call .\ajout_procedures_permis.bat nopause
echo.

echo ajout des Procedure_RelanceDecouvert
echo.
cd ..\Procedure_RelanceDecouvert 
call .\ajout_procedures_relanceDecouvert.bat nopause
echo.

echo ajout des Procedure_Reservation
echo.
cd ..\Procedure_Reservation 
call .\ajout_procedures_reservation.bat nopause
echo.

echo ajout des Procedure_Retard
echo.
cd ..\Procedure_Retard 
call .\ajout_procedures_retard.bat nopause
echo.

echo ajout des Procedure_SousPermis
echo.
cd ..\Procedure_SousPermis  
call .\ajout_procedures_sousPermis.bat nopause
echo.

echo ajout des Procedure_TypeAbonnement
echo.
cd ..\Procedure_TypeAbonnement 
call .\ajout_procedures_typeAbonnement.bat nopause
echo.

echo ajout des Procedure_Vehicule
echo.
cd ..\Procedure_Vehicule 
call .\ajout_procedures_vehicule.bat nopause
echo.

if "%1"=="nopause" goto start
pause
:start