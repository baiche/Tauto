Utilisation du rendu :
*********************

Les scripts sont a lancer dans l'ordre de leur numerotation.

Contenu du rendu :
******************
Dossiers :
	- 5.5_script_taches_planifiees : script ajout du lancement des taches planifiees dans le task scheduler de windows. 
									Penser à modifier la variable PATHTOBATCH pour qu'elle contienne le chemin absolu vers ce dossier.
	- 7_scenarios_demonstration : Contient les scripts de lancement des differents scenarios
	- Ressources : Contient les dll necessaires a la base de donnee.
	
Fichiers :
	- 0_suppression.sql : Script de suppression de la base.
	- 1_creation.sql : Script de creation de la base. Penser a modifier le chemin vers la dll : SQLServerCLR.dll
	- 2_peuplement.sql : Script de peuplement de la base. (Contient des erreurs)
	- 3_procedures.sql : Script d'ajout des procedures dans la base.
	- 4_declencheurs.sql : Script d'ajout des triggers dans la base.
	- 5_taches_planifiables.sql : Script d'ajout des procedures devant etre lancee periodiquement.
	- 6_procedures_demonstrations.sql : Script d'ajout des procedures de demonstration
	- README.txt

Procedures a disposition de l'utilisateur :
*******************************************

makeCompteParticulier
makeCompteEntreprise
makeAbonnement
declareConducteur
associateConducteurToLocation
searchVehicule
makeReservation
cancelReservation
turnReservationIntoContratLocat
modifyCompte
modifyConducteur
declarePermis
makeCatalogue
makeCategorie
makeModele
makeVehicule
closeCompte
blackListCompteAbonne
makeTypeAbonnement
makeEtat
endEtat
endContratLocation
extendContratLocation
findOtherVehicule
closeVehicule
extendReservation
modifyAbonnement
findOtherVehiculeWithElevation
deleteTrigger
checkImpayeTrigger
makeInfraction
fixInfraction
showInfraction
fixVehicule
fixFacturation