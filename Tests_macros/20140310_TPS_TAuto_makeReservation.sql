------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeReservation
-- Date        : 18/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure makeReservation qui permet de reserver un vehicule
------------------------------------------------------------
USE TAuto_IBDR;

DELETE FROM ReservationVehicule WHERE  matricule_vehicule='ff456'
DELETE FROM CatalogueCategorie WHERE nom_catalogue='myCatalogue'
DELETE FROM Vehicule WHERE matricule='ff456'
DELETE FROM CategorieModele WHERE nom_categorie='pic-up'
DELETE FROM Modele WHERE marque='Mercedes' AND serie ='GLA'
DELETE FROM Catalogue WHERE  nom='myCatalogue'
DELETE FROM Reservation WHERE id_abonnement=1;

--Test 1
BEGIN TRY
	EXEC makeCatalogue 'myCatalogue',null , '2015-04-25';
	PRINT('ajout d''catalogue--- Test OK');
	
	EXEC makeCategorie 'myCatalogue','pic-up','description du pic-up','B' ;
	PRINT('ajout d''une categorie--- Test OK');
	
	EXEC makeModele 'myCatalogue','pic-up','Mercedes','GLA','Diesel',5,2014,80,0;
	PRINT('ajout d''un Modele--- Test OK');
	
	EXEC makeVehicule 'Mercedes','GLA','Diesel',5,'ff456',12785,'Bleu','8787878754ttt7','pic-up' ;
	PRINT('ajout d''un Vehicule--- Test OK');
	
	-- reserver un vehicule avec l'id de l'abonnement 1 
	EXEC dbo.makeReservation 1,'2014-03-26','2014-04-30','Mercedes','GLA','Diesel',5;
	PRINT ('Vehicule reserve');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO
