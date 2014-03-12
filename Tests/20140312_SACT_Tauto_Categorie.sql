------------------------------------------------------------
-- Fichier     : 20140312_SACT_Tauto_Categorie.sql
-- Date        : 03/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : test de la table Categorie
------------------------------------------------------------


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
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH

DELETE FROM Categorie;

--Test A.2
BEGIN TRY
	INSERT INTO Categorie(nom,description,nom_typepermis,a_supprimer) VALUES
		('4x4','description de la categorie 4x4', 'B','');
		IF((SELECT c.a_suurpimer FROM Categorie c WHERE c.nom='4x4')='false')
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
		('pic-up','', '','false');
	IF (( SELECT COUNT(*)
		FROM Categorie) = 1)
		PRINT('------------------------------Test A.1  NOT OK')
	ELSE
		PRINT('------------------------------Test A.1   OK')
END TRY
BEGIN CATCH
	PRINT('------------------------------Test A.1 NOT OK')
END CATCH

DELETE FROM Categorie;