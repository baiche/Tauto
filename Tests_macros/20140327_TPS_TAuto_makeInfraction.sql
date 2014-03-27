------------------------------------------------------------
-- Fichier     : 20140318_TPS_TAuto_makeInfraction
-- Date        : 18/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure makeInfraction qui permet a l'utilisateur de creer une categorie
------------------------------------------------------------

USE TAuto_IBDR;

DELETE FROM CatalogueCategorie;
DELETE FROM Catalogue;
DELETE FROM Categorie;

--Test 1
BEGIN TRY
	
	EXEC makeInfraction '0775896wt','2014-02-16','exces de vitesse',75,'roule a 90 km en plein aglomeration' ;
	
	PRINT('infraction cree--- Test OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO