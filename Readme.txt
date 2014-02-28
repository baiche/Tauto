------------------------------------------------------------
-- Fichier     : Readme.txt
-- Date        : 17/02/2014
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : ce projet est fait dans un cadre pédagogique pour l'UE Ingénierie des Base de Données Répartis ( IBDR ) . 
--
------------------------------------------------------------


	
Contenue du projet  :
*********************
	
	- le dossier Génération contient le script de création des tables et le scrit de suppression des tables.
	- le dossier peuplement contient les fichiers de peuplement pour chaque table : 
		le nom de chaque fichier est de la forme : numero_Peuplement_nomTable.sql 
		ou le numéro est l'ordre dans lequel se fichier doit etre executé et nomTable le nom de la table a peupler 
	- le dossier Procedures contient les fichiers des procédures stockées . dans chaque fichier on trouve une prcédure.
	- le dossier test contient tout les fichiers de test ( test des procédures, test des contraites de domaines ....etc )
	

pour lancer le projet on a deux maniéres 
	1- il faut d'abord lancer le script de génération et ensuite il faut lancer les script de peuplement dans l'ordre.
	2- lancer le fichier run_peuplement.bat qui génére les tables et les remplies 