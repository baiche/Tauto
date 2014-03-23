------------------------------------------------------------
-- Fichier     : 20140312_SACT_Tauto_Categorie.sql
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table Categorie
------------------------------------------------------------
USE TAuto_IBDR;

DELETE FROM CatalogueCategorie;
DELETE FROM Categorie;

--Test A.1 et B.1
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('pic-up','', '','false');
	IF (( SELECT COUNT(*)
		FROM Categorie) = 1)
		PRINT('------------------------------Test A.1  NOT OK')
	ELSE
		PRINT('------------------------------Test A.1   OK')
END TRY
BEGIN CATCH
	PRINT('---------------CATCH---------Test A.1 OK')
END CATCH

DELETE FROM Categorie;

--Test A.2
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('4x4','description de la categorie 4x4', 'B','');
		IF((SELECT c.a_supprimer FROM Categorie c WHERE c.nom='4x4')='false')
			PRINT('------------------------------Test A.2  OK')
		ELSE 
			PRINT('------------------------------Test A.2 NOT OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.2 NOT OK')
END CATCH

DELETE FROM Categorie;


--Test A.3
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('pic-up','description du pic-up', 'X','false');
	IF (( SELECT COUNT(*)
		FROM Categorie) = 1)
		PRINT('------------------------------Test A.3  NOT OK')
	ELSE
		PRINT('------------------------------Test A.3   OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.3  OK')
END CATCH

DELETE FROM Categorie;


--Test A.4
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('pic-up','my description avec le caractere @ ....', 'B','false');
	IF (( SELECT COUNT(*)
		FROM Categorie) = 1)
		PRINT('------------------------------Test A.4  NOT OK')
	ELSE
		PRINT('------------------------------Test A.4   OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.4 OK')
END CATCH

DELETE FROM Categorie;

--Test A.5
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('my / Categorie ','my description ', 'B','false');
	IF (( SELECT COUNT(*)
		FROM Categorie) = 1)
		PRINT('------------------------------Test A.5  NOT OK')
	ELSE
		PRINT('------------------------------Test A.5   OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH


DELETE FROM Categorie;

--Test B.1
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('pic-up','my description ', 'B','false');
		
	BEGIN TRY
		INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
			('pic-up','my description ', 'B','false');
		
		IF (( SELECT COUNT(*) FROM Categorie) = 2)
			PRINT('------------------------------Test B.1  NOT OK')
		ELSE
			PRINT('------------------------------Test B.1   OK')
	END TRY
	BEGIN CATCH
		PRINT('------------------------------Test B.1 OK')
	END CATCH
		
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.5 OK')
END CATCH

