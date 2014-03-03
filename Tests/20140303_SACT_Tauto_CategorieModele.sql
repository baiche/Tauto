------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_CategorieModele.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table CategorieModele
------------------------------------------------------------


USE Tauto_IBDR;

DELETE FROM CategorieModele;
DELETE FROM Categorie;
DELETE FROM Modele;

--Test A.1, B.1, C.1, D.1, E.1
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','206','Diesel',2003,39,0,3);
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
		
	INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) VALUES
		('Peugeot','206','Diesel',3,'Vehicule Simple');
	
	IF (( SELECT COUNT(*)
		FROM CategorieModele) = 1)
		PRINT('------------------------------Test A.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH
DELETE FROM CategorieModele;
DELETE FROM Categorie;
DELETE FROM Modele;

--Test A.2
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','206','Diesel',2003,39,0,3);
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
		
	INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) VALUES
		('Peug','206','Diesel',3,'Vehicule Simple');
		
	PRINT('------------------------------Test A.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH
DELETE FROM CategorieModele;
DELETE FROM Categorie;
DELETE FROM Modele;

--Test B.2
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','206','Diesel',2003,39,0,3);
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
		
	INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) VALUES
		('Peugeot','305','Diesel',3,'Vehicule Simple');
		
	PRINT('------------------------------Test B.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH
DELETE FROM CategorieModele;
DELETE FROM Categorie;
DELETE FROM Modele;

--Test C.2
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','206','Diesel',2003,39,0,3);
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
		
	INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) VALUES
		('Peugeot','206','Electrique',3,'Vehicule Simple');
		
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM CategorieModele;
DELETE FROM Categorie;
DELETE FROM Modele;

--Test D.2
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','206','Diesel',2003,39,0,3);
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
		
	INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) VALUES
		('Peugeot','206','Diesel',7,'Vehicule Simple');
		
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM CategorieModele;
DELETE FROM Categorie;
DELETE FROM Modele;

--Test E.2
BEGIN TRY
	INSERT INTO Modele(marque,serie,type_carburant,annee,prix,reduction,portieres) VALUES
		('Peugeot','206','Diesel',2003,39,0,3);
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
		
	INSERT INTO CategorieModele(marque_modele,serie_modele,type_carburant_modele,portieres_modele,nom_categorie) VALUES
		('Peugeot','206','Diesel',3,'Car');
		
	PRINT('------------------------------Test C.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test C.2 OK')
END CATCH
DELETE FROM CategorieModele;
DELETE FROM Categorie;
DELETE FROM Modele;
