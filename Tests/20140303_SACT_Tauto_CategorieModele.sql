------------------------------------------------------------
-- Fichier     : 20140303_SACT_Tauto_CatalogueCategorie.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table CatalogueCategorie
------------------------------------------------------------


DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

--Test A.1 et B.1
BEGIN TRY
	INSERT INTO Catalogue(nom,date_debut,date_fin) VALUES
		('printemps 2014','2014-03-20', '2014-06-20');
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
	INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie) VALUES
		('printemps 2014', 'Vehicule simple');
	IF (( SELECT COUNT(*)
		FROM CatalogueCategorie) = 1)
		PRINT('------------------------------Test A.1 et B.1 OK')
	ELSE
		PRINT('------------------------------Test A.1 et B.1 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 et B.1 NOT OK')
END CATCH
DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

--Test A.2
BEGIN TRY
	INSERT INTO Catalogue(nom,date_debut,date_fin) VALUES
		('printemps 2014','2014-03-20', '2014-06-20');
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
	INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie) VALUES
		('printemps', 'Vehicule simple');
	PRINT('------------------------------Test A.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 OK')
END CATCH
DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;


--Test B.2
BEGIN TRY
	INSERT INTO Catalogue(nom,date_debut,date_fin) VALUES
		('printemps 2014','2014-03-20', '2014-06-20');
	INSERT INTO Categorie(nom,description,nom_typepermis) VALUES
		('Vehicule simple','tout type de véhicule simple a 4 roues','B');
	INSERT INTO CatalogueCategorie(nom_catalogue, nom_categorie) VALUES
		('printemps 2014', 'simple');
	PRINT('------------------------------Test B.2 NOT OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test B.2 OK')
END CATCH
DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;