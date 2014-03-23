------------------------------------------------------------
-- Fichier     : Readme.txt
-- Date        : 17/02/2014
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Ce projet est fait dans un cadre pédagogique pour l'UE Ingénierie des Base de Données Répartis ( IBDR ) . 
--
------------------------------------------------------------


	
Contenue du projet  :
*********************
	
	- le dossier "Generation" : contient le necessaire pour générer la base de donnée.
	
	- le dossier "Peuplement" : contient les fichiers de peuplement pour chaque table.
		le nom de chaque fichier est de la forme : numero_Peuplement_nomTable.sql 
		ou le numéro est l'ordre dans lequel se fichier doit etre executé et nomTable le nom de la table a peupler.
		
	- le dossier "Procedures" : contient les fichiers des procédures stockées . dans chaque fichier on trouve une procédure.
		- le sous-dossier MacroProcedure_Utilisateur contient les procedures qui seront fournie à l'utilisateur final 
		- les autres sous-dossier contiennent des procédures basiques concernant les différents table de la base.
		
	- le dossier "Tests" : contient tout les fichiers de tests de contrainte de la base.
	
	- le dossier "Test_macros" : contient les tests des macros_procedures de l'utilisateur.
	
	- le dossier "TPS" : contient les tests des procédures stockées.
	
	- le script "ajout_procedures.bat" : ajoute l'ensemble des procedures dans la base.
	
	- le script "generate_base.bat" : genere la base.
	
	- le script "run_peuplement.bat" : peuple la base.
	
	- le script "suppression_procedures.bat" : vide la base de l'ensemble des procédures.
	
	- le script "tests_contrainte.bat" : execute l'ensemble des tests de contraintes.
	
	- le script "tests_macros.bat" : execute l'ensemble des tests concernant les macro-procedures.
	
	- le "Readme.txt" : explique la structure du projet.
	
Pour lancer le projet :
	1- pour avoir la base vide : "generate_base.bat"
	2- pour avoir la base peuplée : "run_peuplement.bat"
	3- pour executer les tests des contraintes de la base de donnée : tests_contrainte.bat
	4- pour executer les tests  des macro-procédures : test_macros.bat 