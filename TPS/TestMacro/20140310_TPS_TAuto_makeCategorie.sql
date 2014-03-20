------------------------------------------------------------
-- Fichier     : 20140318_TPS_TAuto_makeCategorie
-- Date        : 18/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure makeCategorie qui permet a l'utilisateur de creer une categorie
------------------------------------------------------------

USE TAuto_IBDR;

DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

--Test 1
BEGIN TRY
	EXEC makeCatalogue 'myCatalogue',null , '2015-04-25';
	PRINT('ajout d''catalogue--- Test OK');
	
	EXEC makeCategorie 'myCatalogue','pic-up','description du pic-up','B' ;
	PRINT('ajout d''une categorie--- Test OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO