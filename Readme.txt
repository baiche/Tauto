------------------------------------------------------------
-- Fichier     : Readme.txt
-- Date        : 17/02/2014
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : ce projet est fait dans un cadre p�dagogique pour l'UE Ing�nierie des Base de Donn�es R�partis ( IBDR ) . 
--
------------------------------------------------------------


	
Contenue du projet  :
*********************
	
	- le dossier G�n�ration contient le script de cr�ation des tables et le scrit de suppression des tables.
	- le dossier peuplement contient les fichiers de peuplement pour chaque table : 
		le nom de chaque fichier est de la forme : numero_Peuplement_nomTable.sql 
		ou le num�ro est l'ordre dans lequel se fichier doit etre execut� et nomTable le nom de la table a peupler 
	- le dossier Procedures contient les fichiers des proc�dures stock�es . dans chaque fichier on trouve une prc�dure.
	- le dossier test contient tout les fichiers de test ( test des proc�dures, test des contraites de domaines ....etc )
	

pour lancer le projet on a deux mani�res 
	1- il faut d'abord lancer le script de g�n�ration et ensuite il faut lancer les script de peuplement dans l'ordre.
	2- lancer le fichier run_peuplement.bat qui g�n�re les tables et les remplies 