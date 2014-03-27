------------------------------------------------------------
-- Fichier     : 20140318_TPS_TAuto_showInfraction
-- Date        : 18/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la proc�dure showInfraction qui permet d'afficher l'etat d'une infraction
------------------------------------------------------------

USE TAuto_IBDR;


--Test 1
BEGIN TRY
	
	EXEC dbo.makeInfraction '0775896wt','2014-02-16T00:00:00','exces de vitesse',75,'roule a 90 km en plein aglomeration' ;	
	EXEC dbo.showInfraction '0775896wt','2014-02-16T00:00:00';
	
	EXEC dbo.fixInfraction '0775896wt','Marshall','Michel',75,2,'2014-02-16T00:00:00';
	EXEC dbo.showInfraction '0775896wt','2014-02-16T00:00:00';
	
	PRINT('infraction affich� --- Test OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO