------------------------------------------------------------
-- Fichier     : 9_tests_macro_procedures.sql
-- Date        : 31/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : execution des tests des differentes 
-- macro-procedures.
------------------------------------------------------------


SET NOCOUNT ON
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_cancelReservation
-- Date        : 18/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure makeReservation qui permet de reserver un vehicule
------------------------------------------------------------
PRINT('--------------------------------------')
PRINT('test de cancelReservation')
PRINT('--------------------------------------')

EXEC dbo.videTables
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
	EXEC dbo.makeReservation 1,'2014-03-26','2014-03-26','Mercedes','GLA','Diesel',5;
	
	EXEC dbo.cancelReservation 'ff456','2014-03-26','2014-03-26';
	PRINT ('Reservation annulee');
END TRY
BEGIN CATCH
		DECLARE @msg varchar(4000)
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_declareConducteur
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de déclaration d'un conducteur à un compte abonne
------------------------------------------------------------
PRINT('--------------------------------------')
PRINT('test de declareConducteur')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;


BEGIN TRY

	DECLARE @ReturnValue int,
	
			@nbSousPermis_Avant int,
			@nbPermis_Avant int,
			@nbConducteur_Avant int,
			@nbCompteAbonneConducteur_Avant int,
			@CompteAbonne_Avant int,
			
			@nbSousPermis_Apres int,
			@nbPermis_Apres int,
			@nbConducteur_Apres int,
			@nbCompteAbonneConducteur_Apres int,
			@CompteAbonne_Apres int,
			
			@tmp_nbSousPermis_Avant int,
			@tmp_nbPermis_Avant int,
			@tmp_nbConducteur_Avant int,
			@tmp_nbCompteAbonneConducteur_Avant int,
			@tmp_CompteAbonne_Avant int,
			
			@tmp_nbSousPermis_Apres int,
			@tmp_nbPermis_Apres int,
			@tmp_nbConducteur_Apres int,
			@tmp_nbCompteAbonneConducteur_Apres int,
			@tmp_CompteAbonne_Apres int;
			
			
--Test 1	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );
		
	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= NULL,
			@prenom 			= NULL,
			@date_naissance 	= NULL,
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= NULL,
			@nationalite 		= NULL,
			@numero_permis		= NULL,
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - KO');
	END

--Test 2
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );
	
	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Diallo',
			@prenom 			= 'Abdoul',
			@date_naissance 	= '1989-03-26',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= NULL,
			@nationalite 		= NULL,
			@numero_permis		= NULL,
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
			
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - KO');
	END
	
--Test 3	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );

	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Diallo',
			@prenom 			= 'Abdoul',
			@date_naissance 	= '1989-03-26',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '123456009',
			@nationalite 		= 'Francais',
			@numero_permis		= NULL,
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
			
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - KO');
	END
	
--Test 4
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );

	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@numero_permis		= '0000000002',
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
	
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
			
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - KO');
	END
	
--Test 5
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );

	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@numero_permis		= NULL,
			@nom_typepermis 	= 'A2',
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
			
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - KO');
	END
	
--Test 6
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );

	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@numero_permis		= NULL,
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2008-12-02',
			@periode_probatoire = NULL,
			@date_expiration 	= '2007-11-05',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
			
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - KO');
	END
	
--Test 7
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );

	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@numero_permis		= NULL,
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2015-12-02',
			@periode_probatoire = NULL,
			@date_expiration 	= '2016-11-05',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
			
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 7 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - KO');
	END
	
--Test 8
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );

	SET @tmp_nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = 'A2'
															   AND   numero_permis =  '0000000001'
															   AND	 date_obtention = '2001-12-02'
															   AND	 date_expiration = '2018-11-05'
															   AND	 periode_probatoire = '3');
															   
	SET @tmp_nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
																					   AND	prenom_compteabonne = 'Jean-Luc'
																					   AND	date_naissance_compteabonne = '1990-07-18'
																					   AND	piece_identite_conducteur = '123456789'
																					   AND	nationalite_conducteur = 'Francais');

	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@numero_permis		= NULL,
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2001-12-02',
			@periode_probatoire = NULL,
			@date_expiration 	= '2018-11-05',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
			
	SET @tmp_nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = 'A2'
															   AND   numero_permis =  '0000000001'
															   AND	 date_obtention = '2001-12-02'
															   AND	 date_expiration = '2018-11-05'
															   AND	 periode_probatoire = '3');
															   
	SET @tmp_nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
																					   AND	prenom_compteabonne = 'Jean-Luc'
																					   AND	date_naissance_compteabonne = '1990-07-18'
																					   AND	piece_identite_conducteur = '123456789'
																					   AND	nationalite_conducteur = 'Francais');
																					   
																					   
	
	IF (@nbSousPermis_Avant +1 = @nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant +1 = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@tmp_nbSousPermis_Avant=0 AND 
		@tmp_nbSousPermis_Apres=1 AND 
		@tmp_nbCompteAbonneConducteur_Avant=0 AND 
		@tmp_nbCompteAbonneConducteur_Apres=1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 8 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 8 - KO');
	END
	DELETE  FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
										AND	   prenom_compteabonne = 'Jean-Luc'
										AND	   date_naissance_compteabonne = '1990-07-18'
										AND	   piece_identite_conducteur = '123456789'
										AND	   nationalite_conducteur = 'Francais';
										
	DELETE FROM SousPermis WHERE nom_typepermis = 'A2'
						   AND   numero_permis =  '0000000001'
						   AND	 date_obtention = '2001-12-02'
						   AND	 date_expiration = '2018-11-05'
						   AND	 periode_probatoire = '3';
	

--Test 9
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );

	SET @tmp_nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = 'A2'
															   AND   numero_permis =  '0000000001'
															   AND	 date_obtention = '2001-12-02'
															   AND	 date_expiration = '2018-11-05'
															   AND	 periode_probatoire = '0');
															   
	SET @tmp_nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
																					   AND	prenom_compteabonne = 'Jean-Luc'
																					   AND	date_naissance_compteabonne = '1990-07-18'
																					   AND	piece_identite_conducteur = ' 123456789'
																					   AND	nationalite_conducteur = ' Francais');

	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@numero_permis		= NULL,
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2001-12-02',
			@periode_probatoire = '0',
			@date_expiration 	= '2018-11-05',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
			
	SET @tmp_nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = 'A2'
															   AND   numero_permis =  '0000000001'
															   AND	 date_obtention = '2001-12-02'
															   AND	 date_expiration = '2018-11-05'
															   AND	 periode_probatoire = '0');
															   
	SET @tmp_nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
																					   AND	prenom_compteabonne = 'Jean-Luc'
																					   AND	date_naissance_compteabonne = '1990-07-18'
																					   AND	piece_identite_conducteur = '123456789'
																					   AND	nationalite_conducteur = 'Francais');
																					   
	IF (@nbSousPermis_Avant +1 = @nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant +1 = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@tmp_nbSousPermis_Avant=0 AND 
		@tmp_nbSousPermis_Apres=1 AND 
		@tmp_nbCompteAbonneConducteur_Avant=0 AND 
		@tmp_nbCompteAbonneConducteur_Apres=1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 9 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 9 - KO');
	END
	
	DELETE FROM SousPermis WHERE nom_typepermis = 'A2'
						   AND   numero_permis =  '0000000001'
						   AND	 date_obtention = '2001-12-02'
						   AND	 date_expiration = '2018-11-05'
						   AND	 periode_probatoire = '0';
															   
	DELETE FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
									   AND	prenom_compteabonne = 'Jean-Luc'
									   AND	date_naissance_compteabonne = '1990-07-18'
									   AND	piece_identite_conducteur = '123456789'
									   AND	nationalite_conducteur = 'Francais';
	

--Test 10
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );

	SET @tmp_nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = 'A1'
															   AND   numero_permis =  '0000000003'
															   AND	 date_obtention = '2001-12-02'
															   AND	 date_expiration = '2018-11-05'
															   AND	 periode_probatoire = '0');
															   
	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '100000001',
			@nationalite 		= 'Anglais',
			@numero_permis		= NULL,
			@nom_typepermis 	= 'A1',
			@date_obtention 	= '2001-12-02',
			@periode_probatoire = '0',
			@date_expiration 	= '2018-11-05',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
			
	SET @tmp_nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = 'A1'
															   AND   numero_permis =  '0000000003'
															   AND	 date_obtention = '2001-12-02'
															   AND	 date_expiration = '2018-11-05'
															   AND	 periode_probatoire = '0');
																					   

	
	IF (@nbSousPermis_Avant +1 = @nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@tmp_nbSousPermis_Avant=0 AND 
		@tmp_nbSousPermis_Apres=1 AND 
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 10 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 10 - KO');
	END
	
	DELETE FROM SousPermis WHERE nom_typepermis = 'A1'
						   AND   numero_permis =  '0000000003'
						   AND	 date_obtention = '2001-12-02'
						   AND	 date_expiration = '2018-11-05'
						   AND	 periode_probatoire = '0';
	
	

--Test 11
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );
															   
	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '100000001',
			@nationalite 		= 'Anglais',
			@numero_permis		= NULL,
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2001-12-02',
			@periode_probatoire = '0',
			@date_expiration 	= '2018-11-05',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
																					  
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 11 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 11 - KO');
	END


--Test 12
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );
	
	SET @tmp_nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
																					   AND	prenom_compteabonne = 'Jean-Luc'
																					   AND	date_naissance_compteabonne = '1990-07-18'
																					   AND	piece_identite_conducteur = '123456789'
																					   AND	nationalite_conducteur = 'Francais');
	
														   
	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@numero_permis		= NULL,
			@nom_typepermis 	= 'B',
			@date_obtention 	= '2001-12-02',
			@periode_probatoire = '0',
			@date_expiration 	= '2018-11-05',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
	
	SET @tmp_nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
																					   AND	prenom_compteabonne = 'Jean-Luc'
																					   AND	date_naissance_compteabonne = '1990-07-18'
																					   AND	piece_identite_conducteur = '123456789'
																					   AND	nationalite_conducteur = 'Francais');

																					  
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant+1 = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@tmp_nbCompteAbonneConducteur_Avant = 0 AND
		@tmp_nbCompteAbonneConducteur_Apres = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 12 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 12 - KO');
	END
	
	DELETE FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
									   AND	prenom_compteabonne = 'Jean-Luc'
									   AND	date_naissance_compteabonne = '1990-07-18'
									   AND	piece_identite_conducteur = '123456789'
									   AND	nationalite_conducteur = 'Francais';


--Test 13
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );
														   
	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '300000003',
			@nationalite 		= 'Francais',
			@numero_permis		= NULL,
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
																					  
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 13 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 13 - KO');
	END	


--Test 14
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );
														   
	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '300000003',
			@nationalite 		= 'Francais',
			@numero_permis		= '0000000005',
			@nom_typepermis 	= 'B',
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
																					  
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 14 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 14 - KO');
	END	


--Test 15
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );
														   
	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= NULL,
			@prenom_conducteur	= NULL,
			@piece_identite 	= '300000003',
			@nationalite 		= 'Francais',
			@numero_permis		= '0000000005',
			@nom_typepermis 	= 'B',
			@date_obtention 	= '2001-12-02',
			@periode_probatoire = NULL,
			@date_expiration 	= '2015-10-09',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
																				  
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 15 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 15 - KO');
	END	


--Test 16
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Avant = (SELECT COUNT(*) FROM CompteAbonne );
	
	SET @tmp_nbPermis_Avant = (SELECT COUNT(*) FROM Permis WHERE numero = '0000000005'
														   AND   valide = 'true'
														   AND   points_estimes = '12');
														   
	SET @tmp_nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = 'B'
																   AND   numero_permis =  '0000000005'
															       AND	 date_obtention = '2001-12-02'
															       AND	 date_expiration = '2015-10-09'
															       AND	 periode_probatoire = '3');	
	
	SET @tmp_nbConducteur_Avant	= (SELECT COUNT(*) FROM Conducteur WHERE piece_identite = '300000003'
																   AND   nationalite =  'Francais'
																   AND   nom = 'Boulila'
																   AND	 prenom = 'Louiza'
																   AND   id_permis = '0000000005');										

	SET @tmp_nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
																					   AND	prenom_compteabonne = 'Jean-Luc'
																					   AND	date_naissance_compteabonne = '1990-07-18'
																					   AND	piece_identite_conducteur = '300000003'
																					   AND	nationalite_conducteur = 'Francais');
														   
	EXEC @ReturnValue = dbo.declareConducteur
			@nom 				= 'Amitousa Mankoy',
			@prenom 			= 'Jean-Luc',
			@date_naissance 	= '1990-07-18',
			@nom_conducteur		= 'Boulila',
			@prenom_conducteur	= 'Louiza',
			@piece_identite 	= '300000003',
			@nationalite 		= 'Francais',
			@numero_permis		= '0000000005',
			@nom_typepermis 	= 'B',
			@date_obtention 	= '2001-12-02',
			@periode_probatoire = NULL,
			@date_expiration 	= '2015-10-09',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	SET @CompteAbonne_Apres = (SELECT COUNT(*) FROM CompteAbonne );
	
	SET @tmp_nbPermis_Apres = (SELECT COUNT(*) FROM Permis WHERE numero = '0000000005'
														   AND   valide = 'true'
														   AND   points_estimes = '12');
														   
	SET @tmp_nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis WHERE nom_typepermis = 'B'
																   AND   numero_permis =  '0000000005'
															       AND	 date_obtention = '2001-12-02'
															       AND	 date_expiration = '2015-10-09'
															       AND	 periode_probatoire = '3');	
	
	SET @tmp_nbConducteur_Apres	= (SELECT COUNT(*) FROM Conducteur WHERE piece_identite = '300000003'
																   AND   nationalite =  'Francais'
																   AND   nom = 'Boulila'
																   AND	 prenom = 'Louiza'
																   AND   id_permis = '0000000005');										

	SET @tmp_nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur WHERE  nom_compteabonne = 'Amitousa Mankoy'
																					   AND	prenom_compteabonne = 'Jean-Luc'
																					   AND	date_naissance_compteabonne = '1990-07-18'
																					   AND	piece_identite_conducteur = '300000003'
																					   AND	nationalite_conducteur = 'Francais');

	IF (@nbSousPermis_Avant+1=@nbSousPermis_Apres AND 
		@nbPermis_Avant+1=@nbPermis_Apres AND 
		@nbConducteur_Avant+1 = @nbConducteur_Apres AND
		@nbCompteAbonneConducteur_Avant+1 = @nbCompteAbonneConducteur_Apres AND
		@CompteAbonne_Avant = @CompteAbonne_Apres AND
		
		@tmp_nbSousPermis_Avant =0 AND
		@tmp_nbPermis_Avant =0 AND
		@tmp_nbConducteur_Avant =0 AND
		@tmp_nbCompteAbonneConducteur_Avant =0 AND
		
		@tmp_nbSousPermis_Apres =1 AND
		@tmp_nbPermis_Apres =1 AND
		@tmp_nbConducteur_Apres =1 AND
		@tmp_nbCompteAbonneConducteur_Apres =1 AND
		
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 16 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 16 - KO');
	END	
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test NOT -- OKI');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_modifyConducteur
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test la procedure qui modifie les information d'un conducteur
------------------------------------------------------------
PRINT('--------------------------------------')
PRINT('test de modifyConducteur')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;


BEGIN TRY

	DECLARE @ReturnValue int,
	
			@nbSousPermis_Avant int,
			@nbPermis_Avant int,
			@nbConducteur_Avant int,
			
			@nbSousPermis_Apres int,
			@nbPermis_Apres int,
			@nbConducteur_Apres int,
			
			@tmp_nbSousPermis_Avant1 int,
			@tmp_nbSousPermis_Avant2 int,
			@tmp_nbPermis_Avant1 int,
			@tmp_nbPermis_Avant2 int,
			@tmp_nbConducteur_Avant1 int,
			@tmp_nbConducteur_Avant2 int,
			
			@tmp_nbSousPermis_Apres1 int,
			@tmp_nbSousPermis_Apres2 int,
			@tmp_nbPermis_Apres1 int,
			@tmp_nbPermis_Apres2 int,
			@tmp_nbConducteur_Apres1 int,
			@tmp_nbConducteur_Apres2 int;
			
			
--Test 1	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
		
	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= NULL,
			@nationalite 		= NULL,
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - KO');
	END

--Test 2	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );														   
		
	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '300000003',
			@nationalite 		= 'Anglais',
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );														   
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - KO');
	END
	
--Test 3	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	
	
	SET @tmp_nbConducteur_Avant1 = (SELECT COUNT(*) FROM  Conducteur
													WHERE piece_identite = '123456789'
													AND	  nationalite =	'Francais'	
													AND   nom = 'de Finance'
													AND   prenom = 'Boris'
													AND   id_permis = '0000000001');
	SET @tmp_nbConducteur_Avant2 = (SELECT COUNT(*) FROM  Conducteur
													WHERE piece_identite = '123456789'
													AND	  nationalite =	'Francais'	
													AND   nom = 'de Finance TEST'
													AND   prenom = 'Boris'
													AND   id_permis = '0000000001');

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= 'de Finance TEST',
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	

	SET @tmp_nbConducteur_Apres1 = (SELECT COUNT(*) FROM  Conducteur
													WHERE piece_identite = '123456789'
													AND	  nationalite =	'Francais'	
													AND   nom = 'de Finance'
													AND   prenom = 'Boris'
													AND   id_permis = '0000000001');
	SET @tmp_nbConducteur_Apres2 = (SELECT COUNT(*) FROM  Conducteur
													WHERE piece_identite = '123456789'
													AND	  nationalite =	'Francais'	
													AND   nom = 'de Finance TEST'
													AND   prenom = 'Boris'
													AND   id_permis = '0000000001');
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@tmp_nbConducteur_Avant1 = 1 AND
		@tmp_nbConducteur_Avant2 = 0 AND
		@tmp_nbConducteur_Apres1 = 0 AND
		@tmp_nbConducteur_Apres2 = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 3 - KO');
	END
	UPDATE Conducteur
	SET nom = 'de Finance'
	WHERE piece_identite = '123456789'
	AND   nationalite = 'Francais';

--Test 4	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	
	
	SET @tmp_nbConducteur_Avant1 = (SELECT COUNT(*) FROM  Conducteur
													WHERE piece_identite = '123456789'
													AND	  nationalite =	'Francais'	
													AND   nom = 'de Finance'
													AND   prenom = 'Boris'
													AND   id_permis = '0000000001');
	SET @tmp_nbConducteur_Avant2 = (SELECT COUNT(*) FROM  Conducteur
													WHERE piece_identite = '123456789'
													AND	  nationalite =	'Francais'	
													AND   nom = 'de Finance'
													AND   prenom = 'Boris TEST'
													AND   id_permis = '0000000001');

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= 'Boris TEST',
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	

	SET @tmp_nbConducteur_Apres1 = (SELECT COUNT(*) FROM  Conducteur
													WHERE piece_identite = '123456789'
													AND	  nationalite =	'Francais'	
													AND   nom = 'de Finance'
													AND   prenom = 'Boris'
													AND   id_permis = '0000000001');
	SET @tmp_nbConducteur_Apres2 = (SELECT COUNT(*) FROM  Conducteur
													WHERE piece_identite = '123456789'
													AND	  nationalite =	'Francais'	
													AND   nom = 'de Finance'
													AND   prenom = 'Boris TEST'
													AND   id_permis = '0000000001');
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@tmp_nbConducteur_Avant1 = 1 AND
		@tmp_nbConducteur_Avant2 = 0 AND
		@tmp_nbConducteur_Apres1 = 0 AND
		@tmp_nbConducteur_Apres2 = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 4 - KO');
	END
	UPDATE Conducteur
	SET prenom = 'Boris'
	WHERE piece_identite = '123456789'
	AND   nationalite = 'Francais';

--Test 5	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	
	
	SET @tmp_nbPermis_Avant1 = (SELECT COUNT(*) FROM  Permis
													WHERE numero = '0000000001'
													AND	  valide =	'true'	
													AND   points_estimes = '12');
													
	SET @tmp_nbPermis_Avant2 = (SELECT COUNT(*) FROM  Permis
													WHERE numero = '0000000001'
													AND	  valide =	'false'	
													AND   points_estimes = '12');

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= 'false',
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	

	SET @tmp_nbPermis_Apres1 = (SELECT COUNT(*) FROM  Permis
													WHERE numero = '0000000001'
													AND	  valide =	'true'	
													AND   points_estimes = '12');
													
	SET @tmp_nbPermis_Apres2 = (SELECT COUNT(*) FROM  Permis
													WHERE numero = '0000000001'
													AND	  valide =	'false'	
													AND   points_estimes = '12');
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@tmp_nbPermis_Avant1 = 1 AND
		@tmp_nbPermis_Avant2 = 0 AND
		@tmp_nbPermis_Apres1 = 0 AND
		@tmp_nbPermis_Apres2 = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 5 - KO');
	END
	UPDATE Permis
	SET valide = 'true'
	WHERE numero = '0000000001';	
	
--Test 6	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	
	
	SET @tmp_nbPermis_Avant1 = (SELECT COUNT(*) FROM  Permis
													WHERE numero = '0000000001'
													AND	  valide =	'true'	
													AND   points_estimes = '12');
													
	SET @tmp_nbPermis_Avant2 = (SELECT COUNT(*) FROM  Permis
													WHERE numero = '0000000001'
													AND	  valide =	'true'	
													AND   points_estimes = '1');

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= NULL,
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= '1'
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	

	SET @tmp_nbPermis_Apres1 = (SELECT COUNT(*) FROM  Permis
													WHERE numero = '0000000001'
													AND	  valide =	'true'	
													AND   points_estimes = '12');
													
	SET @tmp_nbPermis_Apres2 = (SELECT COUNT(*) FROM  Permis
													WHERE numero = '0000000001'
													AND	  valide =	'true'	
													AND   points_estimes = '1');
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@tmp_nbPermis_Avant1 = 1 AND
		@tmp_nbPermis_Avant2 = 0 AND
		@tmp_nbPermis_Apres1 = 0 AND
		@tmp_nbPermis_Apres2 = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 6 - KO');
	END
	UPDATE Permis
	SET points_estimes = '12'
	WHERE numero = '0000000001';	
	
--Test 7	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A2',
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 7 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - KO');
	END	
	
--Test 8	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2008-12-01',
			@periode_probatoire = NULL,
			@date_expiration 	= '2007-11-03',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 8 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 8 - KO');
	END	
	
--Test 9	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2016-12-01',
			@periode_probatoire = NULL,
			@date_expiration 	= '2007-11-03',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 9 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 9 - KO');
	END	
	
--Test 10	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2008-12-01',
			@periode_probatoire = NULL,
			@date_expiration 	= '2010-11-03',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 10 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 10 - KO');
	END	

--Test 11	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	
													
	SET @tmp_nbSousPermis_Avant1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A2'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2008-12-01'
													AND	  date_expiration = '2018-11-03'
													AND   periode_probatoire = '3');

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2008-12-01',
			@periode_probatoire = NULL,
			@date_expiration 	= '2018-11-03',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	

	SET @tmp_nbSousPermis_Apres1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A2'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2008-12-01'
													AND	  date_expiration = '2018-11-03'
													AND   periode_probatoire = '3');
	
	IF (@nbSousPermis_Avant+1=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@tmp_nbSousPermis_Avant1 = 0 AND
		@tmp_nbSousPermis_Apres1 = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 11 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 11 - KO');
	END
	DELETE FROM SousPermis WHERE nom_typepermis = 'A2'
							AND	  numero_permis = '0000000001'	
							AND   date_obtention = '2008-12-01'
							AND	  date_expiration = '2018-11-03'
							AND   periode_probatoire = '3';

--Test 12	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	
													
	SET @tmp_nbSousPermis_Avant1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A2'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2008-12-01'
													AND	  date_expiration = '2018-11-03'
													AND   periode_probatoire = '0');

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A2',
			@date_obtention 	= '2008-12-01',
			@periode_probatoire = '0',
			@date_expiration 	= '2018-11-03',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	

	SET @tmp_nbSousPermis_Apres1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A2'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2008-12-01'
													AND	  date_expiration = '2018-11-03'
													AND   periode_probatoire = '0');
	
	IF (@nbSousPermis_Avant+1=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@tmp_nbSousPermis_Avant1 = 0 AND
		@tmp_nbSousPermis_Apres1 = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 12 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 12 - KO');
	END
	DELETE FROM SousPermis WHERE nom_typepermis = 'A2'
							AND	  numero_permis = '0000000001'	
							AND   date_obtention = '2008-12-01'
							AND	  date_expiration = '2018-11-03'
							AND   periode_probatoire = '0';

--Test 13	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A1',
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 13 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 13 - KO');
	END

--Test 14	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	
													
	SET @tmp_nbSousPermis_Avant1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '0');
													
	SET @tmp_nbSousPermis_Avant2 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2000-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '0');												

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A1',
			@date_obtention 	= '2000-01-03',
			@periode_probatoire = NULL,
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	

	SET @tmp_nbSousPermis_Apres1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '0');
	
	SET @tmp_nbSousPermis_Apres2 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2000-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '0');												
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@tmp_nbSousPermis_Avant1 = 1 AND
		@tmp_nbSousPermis_Avant2 = 0 AND
		@tmp_nbSousPermis_Apres1 = 0 AND
		@tmp_nbSousPermis_Apres2 = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 14 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 14 - KO');
	END
	UPDATE SousPermis SET date_obtention = '2001-01-03'
							WHERE nom_typepermis = 'A1'
							AND	  numero_permis = '0000000001';

--Test 15	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	
													
	SET @tmp_nbSousPermis_Avant1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '0');
													
	SET @tmp_nbSousPermis_Avant2 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '2018-02-15'
													AND   periode_probatoire = '0');												

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A1',
			@date_obtention 	= NULL,
			@periode_probatoire = NULL,
			@date_expiration 	= '2018-02-15',
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	

	SET @tmp_nbSousPermis_Apres1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '0');
	
	SET @tmp_nbSousPermis_Apres2 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '2018-02-15'
													AND   periode_probatoire = '0');												
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@tmp_nbSousPermis_Avant1 = 1 AND
		@tmp_nbSousPermis_Avant2 = 0 AND
		@tmp_nbSousPermis_Apres1 = 0 AND
		@tmp_nbSousPermis_Apres2 = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 15 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 15 - KO');
	END
	UPDATE SousPermis SET date_expiration = '9999-12-31'
							WHERE nom_typepermis = 'A1'
							AND	  numero_permis = '0000000001';

--Test 16	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Avant = (SELECT COUNT(*) FROM Conducteur );	
													
	SET @tmp_nbSousPermis_Avant1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '0');
													
	SET @tmp_nbSousPermis_Avant2 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '2');												

	EXEC @ReturnValue = dbo.modifyConducteur
			@nom				= NULL,
			@prenom				= NULL,
			@piece_identite 	= '123456789',
			@nationalite 		= 'Francais',
			@nom_typepermis 	= 'A1',
			@date_obtention 	= NULL,
			@periode_probatoire = '2',
			@date_expiration 	= NULL,
			@valide				= NULL,
			@points_estimes		= NULL
			
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	SET @nbConducteur_Apres = (SELECT COUNT(*) FROM Conducteur );	

	SET @tmp_nbSousPermis_Apres1 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '0');
	
	SET @tmp_nbSousPermis_Apres2 = (SELECT COUNT(*) FROM  SousPermis
													WHERE nom_typepermis = 'A1'
													AND	  numero_permis = '0000000001'	
													AND   date_obtention = '2001-01-03'
													AND	  date_expiration = '9999-12-31'
													AND   periode_probatoire = '2');												
	
	IF (@nbSousPermis_Avant=@nbSousPermis_Apres AND 
		@nbPermis_Avant=@nbPermis_Apres AND 
		@nbConducteur_Avant = @nbConducteur_Apres AND
		@tmp_nbSousPermis_Avant1 = 1 AND
		@tmp_nbSousPermis_Avant2 = 0 AND
		@tmp_nbSousPermis_Apres1 = 0 AND
		@tmp_nbSousPermis_Apres2 = 1 AND
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 16 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 16 - KO');
	END
	UPDATE SousPermis SET periode_probatoire = '0'
							WHERE nom_typepermis = 'A1'
							AND	  numero_permis = '0000000001';

END TRY
BEGIN CATCH
	PRINT('------------------------------Test NOT -- OKI');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_endContratLocation
-- Date        : 22/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de fin d'un état
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de endContratLocation')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.endContratLocation
	@idContratLocation	int, -- PK
	@date_fin_effective datetime -- nullable
*/

--Test 1
-- cas normal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endContratLocation
		@idContratLocation = 3,
		@date_fin_effective = '2014-04-01T18:55:00';
		
	DECLARE @nbContratLoc int;
	SELECT @nbContratLoc = COUNT (*) FROM ContratLocation WHERE
			id = 3 AND
			date_fin_effective = '2014-04-01T18:55:00'

	IF ( @nbContratLoc = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
-- Test des valeurs nulles
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endContratLocation
		@idContratLocation = 5,
		@date_fin_effective = NULL;
		
	DECLARE @nbContratLoc int;
	SELECT @nbContratLoc = COUNT (*) FROM ContratLocation WHERE
			id = 5 AND
			date_fin_effective = GETDATE()

	IF ( @nbContratLoc = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 2 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - - OK');
END CATCH
GO

--Test 3
-- Calcul de la facture de la location avec un incident non pénalisable
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endContratLocation
		@idContratLocation = 4,
		@date_fin_effective = NULL;
		
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 3 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 NOT - - OK');
END CATCH
GO

--Test 4
-- Calcul de la facture de la location avec un incident pénalisable
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endContratLocation
		@idContratLocation = 8,
		@date_fin_effective = NULL;

	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 4 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 NOT - - OK');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_endEtat
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de fin d'un état
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de endEtat')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.endEtat
	@idContratLocation	int, -- FK
	@matricule			nvarchar(50), -- FK
	@date_apres	 		datetime, -- nullable
	@km_apres 			int,
	@fiche_apres		nvarchar(50),
	@degat 				bit, -- nullable, mettre faux si rien n'est indiqué
	@vehicule_statut	nvarchar(50) -- nullable, met dispo par défaut
*/

--Test 1
-- Insertion normale, en remplissant tous les champs
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896we',
		@date_apres = '2014-03-25T10:00:00',
		@km_apres = 15000,
		@fiche_apres = 'fichetest1',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	DECLARE @nbEtat int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres = '2014-03-25T10:00:00' AND
			km_apres = 15000 AND
			fiche_apres = 'fichetest1' AND
			degat = 'false'
			
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	
	IF ( @nbEtat = 1 AND @factVal = 90.00 )
	BEGIN
		PRINT('------------------------------Test 1 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
-- Test des valeurs nulles
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896wi',
		@date_apres = NULL,
		@km_apres = 130000,
		@fiche_apres = 'fichetest2',
		@degat = NULL,
		@vehicule_statut = NULL;
		
	DECLARE @nbEtat int, @nbVeh int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres IS NOT NULL AND
			km_apres = 130000 AND
			fiche_apres = 'fichetest2' AND
			degat = 'false';
	SELECT @nbVeh = COUNT(*) FROM Vehicule WHERE matricule = '0775896wi' AND statut LIKE 'Disponible';
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	IF ( @nbEtat = 1 AND @nbVeh = 1 AND @factVal = 100.00 )
	BEGIN
		PRINT('------------------------------Test 2 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
	
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - - OK');
END CATCH
GO

--Test 3
-- Calcul de la facture de la location avec un incident non pénalisable
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896wy',
		@date_apres = '2014-03-25T12:00:00',
		@km_apres = 30075,
		@fiche_apres = 'fichetest3',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	DECLARE @nbEtat int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres = '2014-03-25T12:00:00' AND
			km_apres = 30075 AND
			fiche_apres = 'fichetest3' AND
			degat = 'false'
			
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	
	IF ( @nbEtat = 1 AND @factVal = 90.00 )
	BEGIN
		PRINT('------------------------------Test 3 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 NOT - - OK');
END CATCH
GO

--Test 4
-- Calcul de la facture de la location avec un incident pénalisable
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896wr',
		@date_apres = '2014-03-25T12:00:00',
		@km_apres = 30075,
		@fiche_apres = 'fichetest4',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	DECLARE @nbEtat int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres = '2014-03-25T12:00:00' AND
			km_apres = 30075 AND
			fiche_apres = 'fichetest4' AND
			degat = 'false'
			
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	
	IF ( @nbEtat = 1 AND @factVal = 140.00 )
	BEGIN
		PRINT('------------------------------Test 4 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 NOT - - OK');
END CATCH
GO

--Test 5
-- Calcul de la facture de la location avec une infraction de 100€ non regle
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896wt',
		@date_apres = '2014-03-25T10:00:00',
		@km_apres = 35050,
		@fiche_apres = 'fichetest5',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	DECLARE @nbEtat int, @factVal money;
	SELECT @nbEtat = COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			date_apres = '2014-03-25T10:00:00' AND
			km_apres = 35050 AND
			fiche_apres = 'fichetest5' AND
			degat = 'false'
			
	SELECT @factVal = montant FROM Facturation WHERE id = (SELECT id_facturation FROM Location WHERE id_etat = @ReturnValue);
	
	
	IF ( @nbEtat = 1 AND @factVal = 190.00 )
	BEGIN
		PRINT('------------------------------Test 5 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 NOT - - OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_extendContratLocation
-- Date        : 22/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'extension d'un contrat de location
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de extendContratLocation')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.extendContratLocation
	@idContratLocation	int, -- PK
	@extension			int
*/

--Test 1
-- cas normal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.extendContratLocation
		@idContratLocation = 3,
		@extension = 2;
		
	DECLARE @nbContratLoc int;
	SELECT @nbContratLoc = COUNT (*) FROM ContratLocation WHERE
			id = 3 AND
			extension = 2

	IF ( @nbContratLoc = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
-- Test des valeurs nulles
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.extendContratLocation
		@idContratLocation = 5,
		@extension = -1;
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - OK');
END CATCH
GO

--Test 3
-- Calcul de la facture de la location avec un incident non pénalisable
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.extendContratLocation
		@idContratLocation = 7,
		@extension = 3;

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - OK');
END CATCH
GO
------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_extendReservation
-- Date        : 22/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'extension d'un contrat de location
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de extendReservation')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.extendReservation
	@id_reservation			int, -- FK
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint -- PK
*/

--Test 1
-- cas normal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.extendReservation
		@id_reservation = 3,
		@marque = 'Peugeot',
		@serie = '206',
		@type_carburant = 'Essence',
		@portieres = 3;
		
	DECLARE @nbContratLoc int;
	SELECT @nbContratLoc = COUNT (*) FROM ReservationVehicule WHERE
			id_reservation = 3 AND
			matricule_vehicule = '0775896wy'

	IF ( @nbContratLoc = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
-- 14 & 15, chevauchement de deux réservations, un autre exemplaire est libre
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.extendReservation
		@id_reservation = 14,
		@marque = 'Peugeot',
		@serie = '206',
		@type_carburant = 'Diesel',
		@portieres = 5;
		
	DECLARE @nbContratLoc int;
	SELECT @nbContratLoc = COUNT (*) FROM ReservationVehicule WHERE
			id_reservation = 14 AND
			matricule_vehicule = '0775896wi'
	IF ( @nbContratLoc = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - OK');
END CATCH
GO

--Test 3
--  14 & 15, chevauchement de deux réservations, aucun autre exemplaire de libre
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.extendReservation
		@id_reservation = 16,
		@marque = 'Peugeot',
		@serie = '206',
		@type_carburant = 'Essence',
		@portieres = 3;
		
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_findOtherVehicule
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de findOtherVehicule')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase
USE TAuto_IBDR;
SET NOCOUNT ON

BEGIN TRY

	DECLARE @ReturnValue int,
	
			@nbReservationVehicule_Avant int,
			@nbContratLocation_Avant int,
			
			@nbReservationVehicule_Apres int,
			@nbContratLocation_Apres int,
			
			@tmp_ReservationVehicule_Avant int,
			@tmp_ContratLocation_Avant int,
			
			@tmp_ReservationVehicule_Apres int,
			@tmp_ContratLocation_Apres int;
			
			
--Test 1 si le matricule est bien renseigne
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= NULL,
			@itMustBeDone			= NULL,
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - KO');
	END

--Test 2 s'il existe bien un vehicule pour le matricule renseigne	
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= '0000000zz',
			@itMustBeDone			= NULL,
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - KO');
	END
	
--Test 3 si la date de fin est bien renseigner pour une demande d'extention de location
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= '0775896we',
			@itMustBeDone			= 'false',
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - KO');
	END
	
--Test 4 si la date de fin est coherente : 	@date_fin < GETDATE()
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= '0775896we',
			@itMustBeDone			= 'false',
			@date_fin				= '2008-12-03'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - KO');
	END
	
--Test 5 si il existe bien une location en cours pour la demande d'extension de location
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= '0775896wx',
			@itMustBeDone			= 'false',
			@date_fin				= '2016-12-03'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - KO');
	END
	
--Test 6	
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= '0775896wr',
			@itMustBeDone			= 'false',
			@date_fin				= '2014-03-30T00:00:00'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - KO');
	END
------tout vider et inserer
DELETE FROM ReservationVehicule;
DELETE FROM Reservation;
DELETE FROM ConducteurLocation;
DELETE FROM Retard;
DELETE FROM Incident; 
DELETE FROM Infraction;
DELETE FROM Location;
DELETE FROM Facturation;
DELETE FROM Etat;
DELETE FROM ContratLocation;
DELETE FROM Vehicule;
DECLARE @id_facturation int,
		@id_contratLocation int,
		@id_etat int,
		@idAbonnementDavid int,
		@idReservation int;
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('AX-580-VT','140000','Gris','Disponible','VF3 8C4HXF 81100000','Peugeot','406','5','Essence','false');

INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2013-03-27','2014-03-28','15.35');

SET @id_facturation = SCOPE_IDENTITY();
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
		('2014-03-07T09:00:00', '2014-04-01T19:00:00', null, 0, 2);
SET @id_contratLocation = SCOPE_IDENTITY();
INSERT INTO Etat(date_avant,km_avant,fiche_avant,date_apres,km_apres,fiche_apres) VALUES
		('2013-03-07T08:00:00',300,'0005','20130328 10:00:00',400,'0006');
SET @id_etat = SCOPE_IDENTITY();
INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('AX-580-VT',@id_facturation,@id_etat,@id_contratLocation);

SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-04-15T08:00:00', '2014-04-26T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-15T08:00:00' AND date_fin = '2014-04-26T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT'); 

SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-02T08:00:00', '2014-05-08T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-02T08:00:00' AND date_fin = '2014-05-08T17:00:00';
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT'); 
		
SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-26T08:00:00', '2014-06-01T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-26T08:00:00' AND date_fin = '2014-06-01T17:00:00'; 
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT');		
----------------------
	
--Test 7 si le vehicule es dispo pour la prolongation
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'false',
			@date_fin				= '2014-04-04T19:00:00'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 7 - KO');
	END
	
--Test 8 si le vehicule n'es pas dispo pour la prolongation
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'false',
			@date_fin				= '2014-04-16T19:00:00'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 8 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 8 - KO');
	END
	
--Test 9 test ki remplace le cehicule endomager  pour les reservations concerné
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('AX-581-VT','140000','Gris','Disponible','VF3 8C4HXF 81100000','Peugeot','406','5','Essence','false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('AX-582-VT','140000','Gris','Disponible','VF3 8C4HXF 81100000','Peugeot','406','5','Essence','false');

SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-04-17T08:00:00', '2014-04-22T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-17T08:00:00' AND date_fin = '2014-04-22T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-581-VT'); 
		
SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-04T08:00:00', '2014-05-27T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-04T08:00:00' AND date_fin = '2014-05-27T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-582-VT'); 

		
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'true',
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 9 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 9 - KO');
	END
	
--Test 10 test ou le remplacement ne peut satisfaire toute les reservations
DELETE FROM ReservationVehicule;
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-15T08:00:00' AND date_fin = '2014-04-26T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT');
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-02T08:00:00' AND date_fin = '2014-05-08T17:00:00';
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT'); 
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-26T08:00:00' AND date_fin = '2014-06-01T17:00:00'; 
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT');
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-17T08:00:00' AND date_fin = '2014-04-22T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-581-VT'); 
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-04T08:00:00' AND date_fin = '2014-05-27T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-582-VT');		
		
SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-02T08:00:00', '2014-05-10T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-02T08:00:00' AND date_fin = '2014-05-10T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-581-VT'); 
		
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehicule
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'true',
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 10 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 10 - KO');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test NOT -- OKI');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeCatalogue
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de création de catalogue
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de makeCatalogue')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase
USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.makeCatalogue
	@nom 					nvarchar(50), -- PK
	@date_debut 			date, -- nullable, la date par défaut est la date du jour
	@date_fin		 		date  -- vérifier debut <= fin
*/

--Test 1
-- Insertion normale, en remplissant tous les champs
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCatalogue 
			@nom = 'monCatalogue',
			@date_debut = '2014-03-15',
			@date_fin = '2014-03-17'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM Catalogue WHERE
			nom = 'monCatalogue' AND
			date_debut = '2014-03-15' AND
			date_fin = '2014-03-17'
		) = 1)
	BEGIN
		PRINT('------------------------------Test 1 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT -- OK');
END CATCH
GO

--Test 2
-- Insertion en mettant la date de debut à nulle.
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.makeCatalogue 
			@nom = 'monCatalogue2',
			@date_debut = NULL,
			@date_fin = '2014-06-17'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM Catalogue WHERE
			nom = 'monCatalogue2' AND date_debut = CONVERT(date, GETDATE()) AND date_fin = '2014-06-17')
		= 1)
	BEGIN
		PRINT('------------------------------Test 2 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - - OK');
END CATCH
GO

--Test 3
-- Insertion en mettant une date de fin < date de début
BEGIN TRY
	EXEC dbo.addConducteurToLocation 
			@nom = 'monCatalogue3',
			@date_debut = '2014-03-15T00:00:00',
			@date_fin = '2014-02-17T00:00:00';
			
	PRINT('------------------------------Test 3 NOT -- OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 OK');
END CATCH
GO

--Test 4
-- Insertion en mettant une date de fin < date du jour
BEGIN TRY
	EXEC dbo.addConducteurToLocation 
			@nom = 'monCatalogue4',
			@date_debut = NULL,
			@date_fin = '2013-06-17T00:00:00';

	PRINT('------------------------------Test 4 NOT -- OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 OK');
END CATCH
GO

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

PRINT('--------------------------------------')
PRINT('test de makeCategorie')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

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

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeCompteParticulier
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'ajout d'un compte
--				pour un particulier
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de makeCompteParticulier')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON
/*dbo.makeCompteParticulier
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50)
*/

--Test 1
-- Utilisation nominale 
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Bon',
			@prenom = 'Jean', 		
			@date_naissance = '1951-05-21',
			@iban = 'LU2800194006447500001234567',
			@courriel = 'blabla@mail.com',
			@telephone = '0324858889'
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de l'Ajout dans CompteAbonne
		IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'Bon'
			AND	prenom = 'Jean'
			AND date_naissance = '1951-05-21'
			AND iban = 'LU2800194006447500001234567'
			AND courriel = 'blabla@mail.com'
			AND	telephone = '0324858889') = 1)
		BEGIN
			--verification de l'insertion dans Particulier
			IF((SELECT COUNT(*) FROM Particulier
				WHERE nom_compte = 'Bon'
				AND prenom_compte = 'Jean'
				AND date_naissance_compte = '1951-05-21') = 1)
			BEGIN
				PRINT('------------------------------Test 1 - OK');
			END
			ELSE 
			BEGIN
				PRINT('------------------------------Test 1 - Erreur insertion dans Particulier - KO');
			END
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 1 - Erreur insertion dans CompteAbonne - KO');
		END
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
-- Utilisation avec le paramètre nom à NULL

BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = NULL,
			@prenom = 'Carmen', 		
			@date_naissance = '1990-09-10',
			@iban = 'LU2800194006456500001234567',
			@courriel = 'blubla@mail.com',
			@telephone = '0324858789'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - La fonction accepte un nom NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO


--Test 3
-- Utilisation avec le paramètre prenom à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = NULL, 		
			@date_naissance = '1990-09-10',
			@iban = 'LU2800194006456500001234567',
			@courriel = 'blubla@mail.com',
			@telephone = '0324858789'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - La fonction accepte un prenom NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO


--Test 4
-- Utilisation avec le paramètre date_naissance à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = 'Carmen', 		
			@date_naissance = NULL,
			@iban = 'LU2800194006456500001234567',
			@courriel = 'blubla@mail.com',
			@telephone = '0324858789'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - La fonction accepte une date de naissance NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
-- Utilisation avec le paramètre iban à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = 'Carmen', 		
			@date_naissance = '1990-09-10',
			@iban = NULL,
			@courriel = 'blubla@mail.com',
			@telephone = '0324858789'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - La fonction accepte un iban NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO

--Test 6
-- Utilisation avec le paramètre courriel à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = 'Carmen', 		
			@date_naissance = '1990-09-10',
			@iban = 'LU2800194006456500001234567',
			@courriel = NULL,
			@telephone = '0324858789'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - La fonction accepte un courriel NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - Exception leve - KO');
END CATCH
GO

--Test 7
-- Utilisation avec le paramètre telephone à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteParticulier 
			@nom = 'Durand',
			@prenom = 'Carmen', 		
			@date_naissance = '1990-09-10',
			@iban = 'LU2800194006456500001234567',
			@courriel = 'blubla@mail.com',
			@telephone = NULL
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - La fonction accepte un telephone NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - Exception leve - KO');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeEtat
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de création d'un état
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de makeEtat')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.makeEtat
	@idContratLocation	int, -- FK
	@matricule			nvarchar(50), -- FK
	@date_avant	 		datetime,
	@km_avant 			int,
	@fiche_avant		nvarchar(50)
*/

--Test 1
-- Insertion normale, en remplissant tous les champs
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeEtat
		@idContratLocation = 7,
		@matricule = '0775896we',
		@date_avant = '2014-03-10T10:00:00',
		@km_avant = NULL,
		@fiche_avant = 'fichetest1';
		
	/*IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple inséré');
	END*/
	
	IF (  (SELECT COUNT (*) FROM Location WHERE
			id_contratLocation = 7 AND
			id_etat = @ReturnValue
		) = 1)
	BEGIN
		PRINT('------------------------------Test 1 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
-- Insertion en mettant la date de debut à nulle.
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeEtat
		@idContratLocation = 7,
		@matricule = '0775896wr',
		@date_avant = '2014-03-10T10:00:00',
		@km_avant = NULL,
		@fiche_avant = 'fichetest2';
		
	EXEC @ReturnValue = dbo.makeEtat
		@idContratLocation = 7,
		@matricule = '0775896wr',
		@date_avant = '2014-03-10T10:00:00',
		@km_avant = NULL,
		@fiche_avant = 'fichetest2';
		

	PRINT('------------------------------Test 2 NOT -- OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 OK');
END CATCH
GO

--Test 3
-- Insertion en mettant une date de fin < date de début
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeEtat
		@idContratLocation = 7,
		@matricule = '0775896wt',
		@date_avant = NULL,
		@km_avant = 35000,
		@fiche_avant = 'fichetest3';

	/*IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 3 - Tuple non inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - Tuple inséré');
	END*/

	IF (  (SELECT COUNT (*) FROM Etat WHERE
			id = 9 AND
			date_avant = GETDATE()
		) = 1)
	BEGIN
		PRINT('------------------------------Test 3 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 NOT - - OK');
END CATCH
GO

--Test 4
-- Insertion en mettant une date de fin < date du jour
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeEtat
		@idContratLocation = 7,
		@matricule = '0775896wy',
		@date_avant = NULL,
		@km_avant = NULL,
		@fiche_avant = 'fichetest4';
			
	IF (  (SELECT COUNT (*) FROM Etat WHERE
			id = @ReturnValue AND
			km_avant = 30000
		) = 1)
	BEGIN
		PRINT('------------------------------Test 4 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 NOT - - OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeModele
-- Date        : 18/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure makeModele qui permet a l'utilisateur de creer une un Modele
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de makeModele')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;


DELETE FROM CatalogueCategorie;
DELETE FROM CategorieModele;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM ConducteurLocation;
DELETE FROM Location;
DELETE FROM ReservationVehicule;
DELETE FROM Vehicule;
DELETE FROM Modele;
DELETE FROM Catalogue;
DELETE FROM Categorie;

--Test 1
BEGIN TRY
	EXEC makeCatalogue 'myCatalogue',null , '2015-04-25';
	PRINT('ajout d''catalogue--- Test OK');
	
	EXEC makeCategorie 'myCatalogue','pic-up','description du pic-up','B' ;
	PRINT('ajout d''une categorie--- Test OK');
	
	EXEC makeModele 'myCatalogue','pic-up','Mercedes','GLA','Diesel',5,2014,80,0;
	PRINT('ajout d''un Modele--- Test OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO

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

PRINT('--------------------------------------')
PRINT('test de makeReservation')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

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
	EXEC dbo.makeReservation 1,'2014-03-26T00:00:00','2014-04-30T00:00:00','Mercedes','GLA','Diesel',5;
	PRINT ('Vehicule reserve');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OKI');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeTypeAbonnement
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de création de TypeAbonnement
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de makeTypeAbonnement')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.makeTypeAbonnement
	@nom 				nvarchar(50), -- PK
	@prix 				money,
	@nb_max_vehicules 	int, -- nullable
	@km					int -- nullable
*/

--Test 1
-- Insertion normale, en remplissant tous les champs
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeTypeAbonnement
			@nom = 'monTypeAbonnement',
			@prix = 50,
			@nb_max_vehicules = 2,
			@km = 20;
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM TypeAbonnement WHERE
			nom = 'monTypeAbonnement' AND
			prix = 50 AND
			nb_max_vehicules = 2 AND
			km = 20
		) = 1)
	BEGIN
		PRINT('------------------------------Test 1 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
-- Insertion en mettant la date de debut à nulle.
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.makeTypeAbonnement 
			@nom = 'monTypeAbonnement2',
			@prix = 50,
			@nb_max_vehicules = NULL,
			@km = 20;
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM TypeAbonnement WHERE
			nom = 'monTypeAbonnement2' AND
			prix = 50 AND
			nb_max_vehicules = 1 AND
			km = 20
		) = 1)
	BEGIN
		PRINT('------------------------------Test 2 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - - OK');
END CATCH
GO

--Test 3
-- Insertion en mettant une date de fin < date de début
BEGIN TRY
	EXEC dbo.makeTypeAbonnement 
			@nom = 'monTypeAbonnement3',
			@prix = 50,
			@nb_max_vehicules = 2,
			@km = NULL;
			
	IF (  (SELECT COUNT (*) FROM TypeAbonnement WHERE
			nom = 'monTypeAbonnement3' AND
			prix = 50 AND
			nb_max_vehicules = 2 AND
			km = 1000
		) = 1)
	BEGIN
		PRINT('------------------------------Test 3 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 NOT - - OK');
END CATCH
GO

--Test 4
-- Insertion en mettant une date de fin < date du jour
BEGIN TRY
	EXEC dbo.makeTypeAbonnement 
			@nom = 'monTypeAbonnement4',
			@prix = 10,
			@nb_max_vehicules = 5,
			@km = 50;
	EXEC dbo.makeTypeAbonnement 
			@nom = 'monTypeAbonnement4',
			@prix = 50,
			@nb_max_vehicules = 2,
			@km = 20;
			
	IF (  (SELECT COUNT (*) FROM TypeAbonnement WHERE
			nom = 'monTypeAbonnement4' AND
			prix = 10 AND
			nb_max_vehicules = 5 AND
			km = 50
		) = 1)
	BEGIN
		PRINT('------------------------------Test 4 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 NOT - - OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_makeVehicule
-- Date        : 18/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure makeVehicule qui permet a l'utilisateur de creer une un Vehicule
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de makeVehicule')
PRINT('--------------------------------------')
EXEC dbo.videTables

USE TAuto_IBDR;


DELETE FROM CatalogueCategorie;
DELETE FROM CategorieModele;
DELETE FROM Incident;
DELETE FROM Infraction;
DELETE FROM Retard;
DELETE FROM ConducteurLocation;
DELETE FROM Location;
DELETE FROM ReservationVehicule;
DELETE FROM Vehicule;
DELETE FROM Modele;
DELETE FROM Catalogue;
DELETE FROM Categorie;

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
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_turnReservationIntoContratLocat
-- Date        : 19/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de création de catalogue
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de turnReservationIntoContratLocat')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.turnReservationIntoContratLocat
	@id_reservation 		int, -- PK
	@km_reservation			int -- nombre de kilomètres autorisés pendant la location
*/

--Test 1
-- Transformation d'une réservation
BEGIN TRY
	DECLARE @ReturnValue int;
	DECLARE @Location_T TABLE (
		matricule_vehicule 	nvarchar(50),
		id_facturation 		int,
		id_etat			 	int,
		km					int	
	);
	
	EXEC @ReturnValue = dbo.turnReservationIntoContratLocat 
			@id_reservation = 8,
			@km_reservation = 5
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non insere');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple insere');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			id = @ReturnValue
		) = 0)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non trouve');
	END
	
	INSERT INTO @Location_T (matricule_vehicule, id_facturation, id_etat, km)
		(SELECT matricule_vehicule, id_facturation, id_etat, km FROM Location WHERE id_contratLocation = @ReturnValue)
	
	IF (  (SELECT COUNT (*) FROM @Location_T) = 2)
	BEGIN
		PRINT('------------------------------Test 1 - 2 tuples inseres');
	END
	
	IF (  (SELECT COUNT (*) FROM Reservation WHERE
			id = 8 AND a_supprimer = 'true'
		) = 1)
	BEGIN
		PRINT('------------------------------Test 1 - reservation supprimee');
	END
	PRINT('------------------------------Test 1 OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT -- OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_makeCompteEntreprise
-- Date        : 23/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'ajout d'un compte
--				pour une entreprise
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de makeCompteEntreprise')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON
/*dbo.makeCompteEntreprise
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@iban 				nvarchar(50),
	@courriel 			nvarchar(50),
	@telephone 			nvarchar(50),
	@siret 				nvarchar(50),
	@nom_entreprise		nvarchar(50)
*/

--Test 1
-- Utilisation nominale 
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de l'Ajout dans CompteAbonne
		IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'Pierre'
			AND	prenom = 'Louis'
			AND date_naissance = '1911-01-16'
			AND iban = 'LU2800194006447508901234567'
			AND courriel = 'ta2014@mail.com'
			AND	telephone = '0324858889') = 1)
		BEGIN
			--verification de l'insertion dans Particulier
			IF((SELECT COUNT(*) FROM Entreprise
				WHERE nom_compte = 'Pierre'
				AND prenom_compte = 'Louis'
				AND date_naissance_compte = '1911-01-16'
				AND siret = '56321478569587'
				AND nom = 'TA') = 1)
			BEGIN
				PRINT('------------------------------Test 1 - OK');
			END
			ELSE 
			BEGIN
				PRINT('------------------------------Test 1 - Erreur insertion dans Particulier - KO');
			END
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 1 - Erreur insertion dans CompteAbonne - KO');
		END
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
-- Utilisation avec le paramètre nom à NULL

BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC dbo.makeCompteEntreprise
			@nom = NULL,
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - La fonction accepte un nom NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO


--Test 3
-- Utilisation avec le paramètre prenom à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = NULL, 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - La fonction accepte un prenom NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO


--Test 4
-- Utilisation avec le paramètre date_naissance à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = NULL,
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - La fonction accepte une date de naissance NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
-- Utilisation avec le paramètre iban à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue =dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = NULL,
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - La fonction accepte un iban NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO

--Test 6
-- Utilisation avec le paramètre courriel à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = NULL,
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - La fonction accepte un courriel NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - Exception leve - KO');
END CATCH
GO

--Test 7
-- Utilisation avec le paramètre telephone à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = NULL,
			@siret = '56321478569587',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - La fonction accepte un telephone NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - Exception leve - KO');
END CATCH
GO

--Test 8
-- Utilisation avec le paramètre siret à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = NULL,
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 8 - La fonction accepte un telephone NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 8 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - Exception leve - KO');
END CATCH
GO

--Test 9
-- Utilisation avec le paramètre nom_entreprise à NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Pierre',
			@prenom = 'Louis', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587',
			@nom_entreprise = NULL
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 9 - La fonction accepte un telephone NULL - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 9 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 9 - Exception leve - KO');
END CATCH
GO


-- Test 10
-- Entrer un numéro siret plus pour voir si le numero est tronqué automatiquement,
-- si oui rajouter le test dans la méthode.

BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeCompteEntreprise
			@nom = 'Aude',
			@prenom = 'Chloe', 		
			@date_naissance = '1911-01-16',
			@iban = 'LU2800194006447508901234567',
			@courriel = 'ta2014@mail.com',
			@telephone = '0324858889',
			@siret = '56321478569587789',
			@nom_entreprise = 'TA'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 10 - La fonction accepte un numero siret trop long - KO')
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 10 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 10 - Exception leve - KO');
END CATCH
GO
			
			
------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_modifyCompte
-- Date        : 23/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de modification un 
--				compte
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de modifyCompte')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON
/*dbo.modifyCompte
	@nom 					nvarchar(50), -- PK
	@prenom 				nvarchar(50), -- PK
	@date_naissance 		date,		  -- PK
	@nouveau_nom			nvarchar(50), -- nullable
	@nouveau_prenom			nvarchar(50), -- nullable
	@iban 					nvarchar(50), -- nullable
	@courriel 				nvarchar(50), -- nullable
	@telephone 				nvarchar(50), -- nullable
	@siret 					nvarchar(50), -- nullable
	@nom_entreprise			nvarchar(50), -- nullable
	@greyList				bit, 		  -- nullable
	@renouvellement_auto	bit 		  -- nullable
*/

--Test 1
-- Utilisation de tous les champs 
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = 'TASociety',
		@prenom = 'TASociety',				
		@date_naissance = '2014-02-24',		
		@nouveau_nom = 'TAEnterprise',		
		@nouveau_prenom	= 'TACorp',	
		@iban =	'LU2800194006447545001234568',			
		@courriel =	'tasociety@hotmail.fr',			
		@telephone = '0506038406',			
		@siret = '73282932014786',				
		@nom_entreprise = 'PromoTA',		
		@greyList =	'true'			
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la modification du compte
			IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'TAEnterprise'
			AND	prenom = 'TACorp'
			AND date_naissance = '2014-02-24'
			AND iban = 'LU2800194006447545001234568'
			AND courriel = 'tasociety@hotmail.fr'
			AND	telephone = '0506038406'
			AND liste_grise = 'true') = 1)
		BEGIN
			--verification de la modification dans Particulier
			IF((SELECT COUNT(*) FROM Entreprise
				WHERE nom_compte = 'TAEnterprise'
				AND prenom_compte = 'TACorp'
				AND date_naissance_compte = '2014-02-24'
				AND siret = '73282932014786'
				AND nom = 'PromoTA') = 1)
			BEGIN
				PRINT('------------------------------Test 1 - OK');
			END
			ELSE 
			BEGIN
				PRINT('------------------------------Test 1 - Erreur de modification dans Entreprise - KO');
			END
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 1 - Erreur de modification dans Particulier - KO');
		END
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
-- Test de la valeur NULL pour nom
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = NULL,
		@prenom = 'TACorp',				
		@date_naissance = '2014-02-24',		
		@nouveau_nom = 'Enterprise',		
		@nouveau_prenom	= 'Corp',	
		@iban =	'LU2800194006448545001234568',			
		@courriel =	'society@hotmail.fr',			
		@telephone = '0506038407',			
		@siret = '73282932014786',				
		@nom_entreprise = 'PromotionTA',		
		@greyList =	'false'			
			
	IF ( @ReturnValue = 1)
	BEGIN	
				PRINT('------------------------------Test 2 -acceptation d''un nom NULL -  KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - OK')
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO


--Test 3
-- Test de la valeur NULL pour prenom
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = 'TAEnterprise',
		@prenom = NULL,				
		@date_naissance = '2014-02-24',		
		@nouveau_nom = 'Enterprise',		
		@nouveau_prenom	= 'Corp',	
		@iban =	'LU2800194006448545001234568',			
		@courriel =	'society@hotmail.fr',			
		@telephone = '0506038407',			
		@siret = '73282932014786',				
		@nom_entreprise = 'PromotionTA',		
		@greyList =	'false'			
			
	IF ( @ReturnValue = 1)
	BEGIN	
				PRINT('------------------------------Test 3 - acceptation d''un prenom NULL - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - OK')
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO


--Test 4
-- Test de la valeur NULL pour date_naissance
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = 'TAEnterprise',
		@prenom = 'TACorp',				
		@date_naissance = NULL,		
		@nouveau_nom = 'Enterprise',		
		@nouveau_prenom	= 'Corp',	
		@iban =	'LU2800194006448545001234568',			
		@courriel =	'society@hotmail.fr',			
		@telephone = '0506038407',			
		@siret = '73282932014786',				
		@nom_entreprise = 'PromotionTA',		
		@greyList =	'false'			
			
	IF ( @ReturnValue = 1)
	BEGIN	
				PRINT('------------------------------Test 4 - acceptation d''une date_naissance NULL - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - OK')
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
-- Test de la modification d'un particulier 
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyCompte
		@nom = 'De Finance',
		@prenom = 'Boris',				
		@date_naissance = '1990-09-08',		
		@nouveau_nom = 'de Finance de Clairbois',		
		@nouveau_prenom	= 'Yves',	
		@iban =	NULL,			
		@courriel =	'bdefinance@mail.com',			
		@telephone = NULL,			
		@siret = NULL,				
		@nom_entreprise = NULL,		
		@greyList =	NULL			
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la modification du compte
			IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'de Finance de Clairbois'
			AND	prenom = 'Yves'
			AND date_naissance = '1990-09-08'
			AND iban = 'LU2800194006447500001234567'
			AND courriel = 'bdefinance@mail.com'
			AND	telephone = '0601020304'
			AND liste_grise = 'false') = 1)
		BEGIN
			--verification de la modification dans Particulier
			IF((SELECT COUNT(*) FROM Particulier
				WHERE nom_compte = 'de Finance de Clairbois'
				AND prenom_compte = 'Yves'
				AND date_naissance_compte = '1990-09-08'
) = 1)
			BEGIN
				PRINT('------------------------------Test 5 - OK');
			END
			ELSE 
			BEGIN
				PRINT('------------------------------Test 5 - Erreur de modification dans Particulier - KO');
			END
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 5 - Erreur de modification dans CompteAbonne - KO');
		END
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_closeCompte
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de fermeture d'un 
--				compte
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de closeCompte')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON
/* dbo.closeCompte
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date -- PK
*/

--Test 1
-- Desactivation d'un compte utilisateur actif
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'De Finance',
	@prenom = 'Boris',
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la modification du compte
			IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'De Finance'
			AND	prenom = 'Boris'
			AND date_naissance = '1990-09-08'
			AND actif = 'false') = 1)
				PRINT('------------------------------Test 1 - OK');
			ELSE
				PRINT('------------------------------Test 1 - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
-- Desactivation d'un compte utilisateur inactif
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'De Finance',
	@prenom = 'Boris',
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 2 - Erreur valeur de retour - KO');
	END
	ELSE
	BEGIN
	IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'De Finance'
			AND	prenom = 'Boris'
			AND date_naissance = '1990-09-08'
			AND actif = 'false') = 1)
				PRINT('------------------------------Test 2 - OK');
			ELSE
				PRINT('------------------------------Test 2 - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO

--Test3
--Fermeture d'un compte qui n'existe pas
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'DeFinance',
	@prenom = 'Boris',
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 3 - Erreur valeur de retour - KO');
	END
	ELSE
	BEGIN
	IF ((SELECT COUNT(*) FROM CompteAbonne
			WHERE nom = 'DeFinance'
			AND	prenom = 'Boris'
			AND date_naissance = '1990-09-08'
			AND actif = 'false') = 0)
				PRINT('------------------------------Test 3 - OK');
			ELSE
				PRINT('------------------------------Test 3 - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO

--Test 4
--Test d'un nom NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = NULL,
	@prenom = 'Boris',
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 4 - Erreur valeur de retour - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
--Test d'un prenom NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'De Finance',
	@prenom = NULL,
	@date_naissance = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 5 - Erreur valeur de retour - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO

--Test 6
--Test d'une date_naissance NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeCompte
	@nom = 'De Finance',
	@prenom = 'Boris',
	@date_naissance = NULL
			
	IF ( @ReturnValue = 1)
	BEGIN
			PRINT('------------------------------Test 6 - Erreur valeur de retour - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - Exception leve - KO');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_makeAbonnement
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la création d'un abonnement
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de makeAbonnement')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON
/* dbo.makeAbonnement
	@date_debut 						date,
	@duree 								int,
	@renouvellement_auto 				bit,
	@nom_typeabonnement 				nvarchar(50), -- FK
	@nom_compteabonne 					nvarchar(50), -- FK
	@prenom_compteabonne 				nvarchar(50), -- FK
	@date_naissance_compteabonne 		date 		  -- FK
*/

--Test 1
-- Creation d'un abonnement dans le cas nominal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la creation de l'abonnement
			IF ((SELECT COUNT(*) FROM Abonnement
			WHERE date_debut = '2015-03-25'
			AND duree = 90
			AND renouvellement_auto = 'false'
			AND nom_typeabonnement = '10vehicules'
			AND nom_compteabonne = 'De Finance'
			AND prenom_compteabonne = 'Boris'
			AND date_naissance_compteabonne = '1990-09-08') = 1)
				PRINT('------------------------------Test 1 - OK');
			ELSE
				PRINT('------------------------------Test 1 - abonnement non ajoute - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
--Test pour une date_debut NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = NULL,					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - abonnement ajoute - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO

--Test 3
--Test pour une duree NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = NULL,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - abonnement ajoute - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO

--Test 4
--Test pour un renouvellement_auto NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = NULL,
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - abonnement ajoute - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
--Test pour un nom_typeabonnement NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = NULL, 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - abonnement ajoute - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO

--Test 6
--Test pour une nom_compteabonne NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	NULL,
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - abonnement ajoute - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - Exception leve - KO');
END CATCH
GO

--Test 7
--Test pour une prenom_compteabonne NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = NULL, 
	@date_naissance_compteabonne = '1990-09-08'
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - abonnement ajoute - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - Exception leve - KO');
END CATCH
GO

--Test 8
--Test pour une date_naissance_compteabonne NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.makeAbonnement
	@date_debut = '2015-03-25',					
	@duree = 90,
	@renouvellement_auto = 'false',
	@nom_typeabonnement = '10vehicules', 
	@nom_compteabonne =	'De Finance',
	@prenom_compteabonne = 'Boris', 
	@date_naissance_compteabonne = NULL
			
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 8 - abonnement ajoute - KO');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 8 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - Exception leve - KO');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_modifyAbonnement
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la modification d'un abonnement
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de modifyAbonnement')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.modifyAbonnement
	@id 					int, -- PK
	@renouvellement_auto	bit
*/

--Test 1
-- cas normal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyAbonnement
		@id = 1,
		@renouvellement_auto = 'true';
		
	DECLARE @nbAbon int;
	SELECT @nbAbon = COUNT (*) FROM Abonnement WHERE
			id = 1 AND
			renouvellement_auto = 'true'

	IF ( @nbAbon = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 NOT - - OK');
END CATCH
GO

--Test 2
-- 14 & 15, chevauchement de deux réservations, un autre exemplaire est libre
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyAbonnement
		@id = 4,
		@renouvellement_auto = 'false';
		
	DECLARE @nbAbon int;
	SELECT @nbAbon = COUNT (*) FROM Abonnement WHERE
			id = 4 AND
			renouvellement_auto = 'false'
			
	IF ( @nbAbon = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - OK');
END CATCH
GO

--Test 3
--  14 & 15, chevauchement de deux réservations, aucun autre exemplaire de libre
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyAbonnement
		@id = 5,
		@renouvellement_auto = NULL;
		
	DECLARE @nbAbon int;
	SELECT @nbAbon = COUNT (*) FROM Abonnement WHERE
			id = 5 AND
			renouvellement_auto = 'false'

	IF ( @nbAbon = 1 AND @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - OK');
END CATCH
GO
	
	
------------------------------------------------------------
-- Fichier     : 20140324_TPS_TAuto_searchVehicule
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure recherche d'un
--				 véhicule
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de searchVehicule')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON

/*dbo.searchVehicule
	@nom_categorie			nvarchar(50), -- nullable
	@marque 				nvarchar(50), -- nullable
	@serie 					nvarchar(50), -- nullable
	@type_carburant 		nvarchar(50), -- nullable
	@portieres 				tinyint, -- nullable
	@prix_max 				money, -- nullable
	@prix_min 				money, -- nullable
	@date_debut 			date, -- nullable
	@date_fin 				date -- nullable
*/

--Test 1
-- Utilisation de tous les champs 
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			5,
			1000,
			0,
			'2014-03-29',
			'2014-03-31',
			'Noir'
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO

--Test 2
-- Pas de date de réservation
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			5,
			1000,
			0,
			NULL,
			NULL,
			'Noir'
		)
			WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO


--Test 3
-- Pas de date de réservation, pas de prix
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			5,
			NULL,
			NULL,
			NULL,
			NULL,
			'Noir'
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO


--Test 4
-- Pas de date de réservation, pas de prix, pas de couleur
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			5,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO


--Test 5
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO


--Test 6
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			'5 F10 M5',
			'Diesel',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO


--Test 7
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes, pas de numéro de série
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			'BMW',
			NULL,
			'Diesel',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 3)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO


--Test 8
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes, pas de numéro de série, pas de marque
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			NULL,
			NULL,
			'Diesel',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '0775896wi'
			OR matricule = '0775896wr'
			OR matricule = '0775896wt'
			OR matricule = '1775896we'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt' ) = 6)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO


--Test 9
-- Pas de date de réservation, pas de prix, pas de couleur, pas de nombre de portes, pas de numéro de série, pas de marque, pas de carburant
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			'Vehicule Simple',
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '0775896we'
			OR matricule = '0775896wi'
			OR matricule = '0775896wr'
			OR matricule = '0775896wt'
			OR matricule = '0775896wy'
			OR matricule = '1775896we'
			OR matricule = '1775896wi'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt'
			OR matricule = '1775896wy' ) = 10)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO


--Test 10
-- Tous les champs à NULL
BEGIN
	IF((
		SELECT COUNT(*)
		FROM dbo.searchVehicule(
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL
		)
		WHERE matricule = '0775896we'
			OR matricule = '0775896wi'
			OR matricule = '0775896wr'
			OR matricule = '0775896wt'
			OR matricule = '0775896wy'
			OR matricule = '1775896we'
			OR matricule = '1775896wi'
			OR matricule = '1775896wr'
			OR matricule = '1775896wt'
			OR matricule = '1775896wy' ) = 10)
		PRINT ('searchVehicule OK');
	ELSE
		PRINT ('searchVehicule KO');
END
GO


------------------------------------------------------------
-- Fichier     : 20140325_TPS_TAuto_closeVehicule
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la suppression 
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de closeVehicule')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON
/*dbo.closeVehicule
	@matricule varchar(50)--PK
*/

--Test 1
-- cas nominal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '1775896wy';
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du vehicule
		IF ((SELECT COUNT(*) FROM Vehicule
			WHERE matricule = '1775896wy'
			AND	a_supprimer= 'true') = 1)
		BEGIN
			PRINT('------------------------------Test 1 - OK');
		END
		ELSE 
		BEGIN
			PRINT('------------------------------Test 1 - Erreur de suppression du vehicule - KO');
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
-- matricule NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = NULL;
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Ne drevrais pas etre accepte - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO

--Test 3
-- matricule inexistant
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '1435896wy';
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - Ne drevrais pas etre accepte - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO

--Test 4
--vehicule present dans des reservation non remplacable
BEGIN TRY
	--lie aux reservations 7,8,16 
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '0775896we';
	IF ( @ReturnValue = 1)
	BEGIN
		IF((SELECT COUNT(*) 
		FROM ReservationVehicule
		WHERE id_reservation = 7
		OR id_reservation = 8
		OR id_reservation = 16
		AND  matricule_vehicule = '0775896we') <> 0)
		BEGIN
			PRINT('------------------------------Test 4 - Erreur de remplacement - KO');
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 4 - OK');
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
--vehicule present dans des reservations remplacable
BEGIN TRY
	--lie aux reservations 6,11
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '0775896wi';
	IF ( @ReturnValue = 1)
	BEGIN
		IF((SELECT COUNT(*) 
		FROM ReservationVehicule
		WHERE (id_reservation = 6
		OR id_reservation = 11)
		AND  matricule_vehicule = '0775896wi') <> 0)
		BEGIN
			PRINT('------------------------------Test 5 - Erreur de remplacement - KO');
		END
		ELSE
		BEGIN
			PRINT('------------------------------Test 5 - OK');
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 5 - Ne drevrais pas etre accepte - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140325_TPS_TAuto_declarePermis.sql
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "declarePermis"
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de declarePermis')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
GO

--Test 1 : ERROR Les informations concernant le conducteur sont incompletes

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = NULL,
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2013-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 1 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - - NOT OK');
END CATCH
GO


--Test 2 : ERROR Les informations concernant le type de permis sont incompletes

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = NULL,
		@date_obtention = '2013-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 2 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - - NOT OK');
END CATCH
GO


--Test 3 : ERROR Les informations concernant le conducteur sont incorrectes

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '999999999',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2013-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 3 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - - NOT OK');
END CATCH
GO


--Test 4 : ERROR Le type de permis est incorrect

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'M',
		@date_obtention = '2013-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 4 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - - NOT OK');
END CATCH
GO


--Test 5 : ERROR La date d'obtention est postéreure à la date d'aujourd'hui

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2015-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 5 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - - NOT OK');
END CATCH
GO


--Test 6 : ERROR La date d'expiration est antérieure à la date d'aujourd'hui

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2010-03-01',
		@periode_probatoire = NULL,
		@date_expiration = '2013-03-01'
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 6 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - - NOT OK');
END CATCH
GO


--Test 7 : le numero de permis doit etre renseigne

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '330000033',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2010-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 7 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - - NOT OK');
END CATCH
GO


--Test 8 : ERROR Le type de permis est deja enregistre

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'B',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 8 -- OK');
		DELETE FROM SousPermis WHERE nom_typepermis = 'E' AND numero_permis = '0000000001';
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 8 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - - NOT OK');
END CATCH
GO


--Test 9 : declarePermis OK

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = 1 AND
	     @nbSousPermis_Avant+1 = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 9 -- OK');
		DELETE FROM SousPermis WHERE nom_typepermis = 'E' AND numero_permis = '0000000001';
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 9 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 9 - - NOT OK');
END CATCH
GO


--Test 10 : declarePermis OK

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int, @date_expiration_apres date;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = '2018-03-01'
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	SELECT @date_expiration_apres = date_expiration 
	FROM SousPermis 
	WHERE nom_typepermis = 'E' AND numero_permis = '0000000001'
	
	IF ( @ReturnValue = 1 AND
	     @nbSousPermis_Avant+1 = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres AND
	     @date_expiration_apres = '2018-03-01')
	BEGIN
		PRINT('------------------------------Test 10 -- OK');
		DELETE FROM SousPermis WHERE nom_typepermis = 'E' AND numero_permis = '0000000001';
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 10 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 10 - - NOT OK');
END CATCH
GO


--Test 11 : declarePermis OK

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int, @periode_probatoire_apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2012-03-01',
		@periode_probatoire = 2,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	SELECT @periode_probatoire_apres = periode_probatoire 
	FROM SousPermis 
	WHERE nom_typepermis = 'E' AND numero_permis = '0000000001'
	
	IF ( @ReturnValue = 1 AND
	     @nbSousPermis_Avant+1 = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres AND
	     @periode_probatoire_apres = 2 )
	BEGIN
		PRINT('------------------------------Test 11 -- OK');
		DELETE FROM SousPermis WHERE nom_typepermis = 'E' AND numero_permis = '0000000001';
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 11 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 11 - - NOT OK');
END CATCH
GO


--Test 12 : ERROR Le numero de permis renseigne est le numero de permis d'un autre conducteur

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int,
			@id_permis_conducteur_avant nvarchar(50), @id_permis_conducteur_apres nvarchar(50);
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	SELECT @id_permis_conducteur_avant = id_permis 
	FROM Conducteur 
	WHERE  piece_identite = '330000033' AND nationalite = 'Francais';
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '330000033',
		@nationalite = 'Francais',
		@numero = '0000000004',
		@nom_typepermis = 'B',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	SELECT @id_permis_conducteur_apres = id_permis 
	FROM Conducteur 
	WHERE  piece_identite = '330000033' AND nationalite = 'Francais';
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres AND
	     @id_permis_conducteur_avant IS NULL AND
	     @id_permis_conducteur_apres IS NULL)
	BEGIN
		PRINT('------------------------------Test 12 -- OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 12 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 12 - - NOT OK');
END CATCH
GO


--Test 13 : declarePermis OK

BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int,
			@id_permis_conducteur_avant nvarchar(50), @id_permis_conducteur_apres nvarchar(50);
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	SELECT @id_permis_conducteur_avant = id_permis 
	FROM Conducteur 
	WHERE  piece_identite = '330000033' AND nationalite = 'Francais';
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '330000033',
		@nationalite = 'Francais',
		@numero = '0000000055',
		@nom_typepermis = 'B',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	SELECT @id_permis_conducteur_apres = id_permis 
	FROM Conducteur 
	WHERE  piece_identite = '330000033' AND nationalite = 'Francais';
	
	IF ( @ReturnValue = 1 AND
	     @nbSousPermis_Avant+1 = @nbSousPermis_Apres AND 
	     @nbPermis_Avant+1 = @nbPermis_Apres AND
	     @id_permis_conducteur_avant IS NULL AND
	     @id_permis_conducteur_apres = '0000000055')
	BEGIN
		PRINT('------------------------------Test 13 -- OK');
		UPDATE Conducteur
		SET id_permis = NULL
		WHERE piece_identite = '330000033' AND nationalite = 'Francais';
		DELETE FROM SousPermis WHERE nom_typepermis = 'B' AND numero_permis = '0000000055';
		DELETE FROM Permis WHERE numero = '0000000055';

	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 13 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 13 - - NOT OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140325_TPS_TAuto_deleteTrigger
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la suppression 
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de deleteTrigger')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON
/*dbo.closeVehicule
	@matricule varchar(50)--PK
*/

--Test 1
-- test de la suppression d'un catalogue
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Catalogue
	SET a_supprimer = 'true'
	WHERE nom = 'automne 2014'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du catalogue
		IF ((SELECT COUNT(*) FROM Catalogue
			WHERE nom = 'automne 2014') <> 0)
		BEGIN
			PRINT('------------------------------Test 1 - erreur de suppression dans la table Catalogue -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM CatalogueCategorie
			WHERE nom_catalogue = 'automne 2014') <> 0  )
			BEGIN
				PRINT('------------------------------Test 1 - Erreur de suppression dans la table CatalogueCategorie - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 1 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
--test de la suppression d'une categorie
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Categorie
	SET a_supprimer = 'true'
	WHERE nom = '4x4'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression de la categorie
		IF ((SELECT COUNT(*) FROM Categorie
			WHERE nom = '4x4') <> 0)
		BEGIN
			PRINT('------------------------------Test 2 - erreur de suppression dans la table Categorie -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM CatalogueCategorie
			WHERE nom_catalogue = '4x4') <> 0  )
			BEGIN
				PRINT('------------------------------Test 2 - Erreur de suppression dans la table CatalogueCategorie - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 2 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 2 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO


--Test 3
--test de la suppression d'un vehicule
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Vehicule
	SET a_supprimer = 'true'
	WHERE matricule = '0775896we'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du vehicule
		IF ((SELECT COUNT(*) FROM ReservationVehicule
			WHERE  matricule_vehicule = '0775896we') <> 0)
		BEGIN
			PRINT('------------------------------Test 3 - erreur de suppression dans la table ReservationVehicule -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Location
			WHERE matricule_vehicule = '0775896we') <> 0  )
			BEGIN
				PRINT('------------------------------Test 3 - Erreur de suppression dans la table Location - KO');
			END
			ELSE
			BEGIN
				IF((SELECT COUNT(*) FROM Vehicule
				WHERE matricule = '0775896we') <> 0)
				BEGIN
					PRINT('------------------------------Test 3 - Erreur de suppression dans la table Vehicule - KO');
				END
				ELSE
				BEGIN
					PRINT('------------------------------Test 3 - OK');
				END
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 3 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO


--Test 4
--test de la suppression d'un modele
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Modele
	SET a_supprimer = 'true'
	WHERE marque = 'BMW'
	AND serie = '5 F10 M5'
	AND type_carburant = 'Essence'
	AND portieres = 5
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du modele
		IF ((SELECT COUNT(*) FROM CategorieModele
			WHERE  marque_modele = 'BMW'
			AND serie_modele = '5 F10 M5'
			AND type_carburant_modele = 'Essence'
			AND portieres_modele = 5) <> 0)
		BEGIN
			PRINT('------------------------------Test 4 - erreur de suppression dans la table CategorieModele -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Vehicule
			WHERE  marque_modele = 'BMW'
			AND serie_modele = '5 F10 M5'
			AND type_carburant_modele = 'Essence'
			AND portieres_modele = 5) <> 0)
			BEGIN
				PRINT('------------------------------Test 4 - Erreur de suppression dans la table Vehicule - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 4 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 4 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO


--Test5
--test de la suppression d'une reservation
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Reservation
	SET a_supprimer = 'true'
	WHERE id = 1
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression de la reservation
		IF ((SELECT COUNT(*) FROM ReservationVehicule
			WHERE  id_reservation = 1) <> 0)
		BEGIN
			PRINT('------------------------------Test 5 - erreur de suppression dans la table ReservationVehicule -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Reservation
			WHERE  id = 1) <> 0)
			BEGIN
				PRINT('------------------------------Test 5 - Erreur de suppression dans la table Reservation - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 5 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 5 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO

--Test6
--test de la suppression abonnement
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE Abonnement
	SET a_supprimer = 'true'
	WHERE id = 13
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression de l'abonnement
		IF ((SELECT COUNT(*) FROM Reservation
			WHERE  id_abonnement = 13) <> 0)
		BEGIN
			PRINT('------------------------------Test 6 - erreur de suppression dans la table Reservation -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM ContratLocation
			WHERE  id_abonnement = 13) <> 0)
			BEGIN
				PRINT('------------------------------Test 6 - Erreur de suppression dans la table ContratLocation - KO');
			END
			ELSE
			BEGIN
				IF((SELECT COUNT(*) FROM Abonnement
				WHERE id = 13) <> 0)
				BEGIN
					PRINT('------------------------------Test 6 - Erreur de suppression dans la table Abonnement - KO');
				END
				ELSE
				BEGIN
					PRINT('------------------------------Test 6 - OK');
				END
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 6 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - Exception leve - KO');
END CATCH
GO

--Test 7
--Test de la suppression d'un type d'abonnement
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE TypeAbonnement
	SET a_supprimer = 'true'
	WHERE nom = '1vehicules'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du type d'abonnement
		IF ((SELECT COUNT(*) FROM Abonnement
			WHERE  nom_typeabonnement = '1vehicules') <> 0)
		BEGIN
			PRINT('------------------------------Test 7 - erreur de suppression dans la table Abonnement -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM TypeAbonnement
			WHERE  nom = '1vehicules') <> 0)
			BEGIN
				PRINT('------------------------------Test 7  - Erreur de suppression dans la table TypeAbonnement - KO');
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 7 - OK');
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 7 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - Exception leve - KO');
END CATCH
GO

--Test 8
--Test de la suppression d'un compte particulier
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE CompteAbonne
	SET a_supprimer = 'true'
	WHERE nom = 'De Finance'
	AND prenom = 'Boris'
	AND date_naissance = '1990-09-08'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du compte particulier
		IF ((SELECT COUNT(*) FROM Abonnement
			WHERE  nom_compteabonne = 'De Finance'
			AND prenom_compteabonne = 'Boris'
			AND date_naissance_compteabonne = '1990-09-08') <> 0)
		BEGIN
			PRINT('------------------------------Test 8 - erreur de suppression dans la table Abonnement -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Particulier
			WHERE  nom_compte = 'De Finance'
			AND prenom_compte = 'Boris'
			AND date_naissance_compte = '1990-09-08') <> 0)
			BEGIN
				PRINT('------------------------------Test 8  - Erreur de suppression dans la table Particulier - KO');
			END
			ELSE
			BEGIN
				IF((SELECT COUNT(*) FROM Entreprise
				WHERE  nom_compte = 'De Finance'
				AND prenom_compte = 'Boris'
				AND date_naissance_compte = '1990-09-08') <> 0)
				BEGIN
					PRINT('------------------------------Test 8  - Erreur de suppression dans la table Entreprise - KO');
				END
				ELSE
				BEGIN
					IF((SELECT COUNT(*) FROM CompteAbonneConducteur
					WHERE  nom_compteabonne = 'De Finance'
					AND prenom_compteabonne = 'Boris'
					AND date_naissance_compteabonne = '1990-09-08') <> 0)
					BEGIN
						PRINT('------------------------------Test 8  - Erreur de suppression dans la table CompteAbonneConducteur - KO');
					END
					ELSE
					BEGIN
						IF((SELECT COUNT(*) FROM RelanceDecouvert
						WHERE  nom_compteabonne = 'De Finance'
						AND prenom_compteabonne = 'Boris'
						AND date_naissance_compteabonne = '1990-09-08') <> 0)
						BEGIN
							PRINT('------------------------------Test 8  - Erreur de suppression dans la table RelanceDecouvert - KO');
						END
						ELSE
						BEGIN
							IF((SELECT COUNT(*) FROM CompteAbonne
							WHERE  nom = 'De Finance'
							AND prenom = 'Boris'
							AND date_naissance = '1990-09-08') <> 0)
							BEGIN
								PRINT('------------------------------Test 8  - Erreur de suppression dans la table CompteAbonne - KO');
							END
							ELSE
							BEGIN
								PRINT('------------------------------Test 8 - OK');
							END
						END
					END
				END
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 8 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - Exception leve - KO');
END CATCH
GO

--Test 9
--Test de la suppression d'un compte d'Entreprise
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE CompteAbonne
	SET a_supprimer = 'true'
	WHERE nom = 'TASociety'
	AND prenom = 'TASociety'
	AND date_naissance = '2014-02-24'
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du compte particulier
		IF ((SELECT COUNT(*) FROM Abonnement
			WHERE  nom_compteabonne = 'TASociety'
			AND prenom_compteabonne = 'TASociety'
			AND date_naissance_compteabonne = '2014-02-24') <> 0)
		BEGIN
			PRINT('------------------------------Test 9 - erreur de suppression dans la table Abonnement -  KO');
		END
		ELSE 
		BEGIN
			IF((SELECT COUNT(*) FROM Particulier
			WHERE  nom_compte = 'TASociety'
			AND prenom_compte = 'TASociety'
			AND date_naissance_compte = '2014-02-24') <> 0)
			BEGIN
				PRINT('------------------------------Test 9  - Erreur de suppression dans la table Particulier - KO');
			END
			ELSE
			BEGIN
				IF((SELECT COUNT(*) FROM Entreprise
				WHERE  nom_compte = 'TASociety'
				AND prenom_compte = 'TASociety'
				AND date_naissance_compte = '2014-02-24') <> 0)
				BEGIN
					PRINT('------------------------------Test 9  - Erreur de suppression dans la table Entreprise - KO');
				END
				ELSE
				BEGIN
					IF((SELECT COUNT(*) FROM CompteAbonneConducteur
					WHERE  nom_compteabonne = 'TASociety'
					AND prenom_compteabonne = 'TASociety'
					AND date_naissance_compteabonne = '2014-02-24') <> 0)
					BEGIN
						PRINT('------------------------------Test 9  - Erreur de suppression dans la table CompteAbonneConducteur - KO');
					END
					ELSE
					BEGIN
						IF((SELECT COUNT(*) FROM RelanceDecouvert
						WHERE  nom_compteabonne = 'TASociety'
						AND prenom_compteabonne = 'TASociety'
						AND date_naissance_compteabonne = '2014-02-24') <> 0)
						BEGIN
							PRINT('------------------------------Test 9  - Erreur de suppression dans la table RelanceDecouvert - KO');
						END
						ELSE
						BEGIN
							IF((SELECT COUNT(*) FROM CompteAbonne
							WHERE  nom = 'TASociety'
							AND prenom = 'TASociety'
							AND date_naissance = '2014-02-24') <> 0)
							BEGIN
								PRINT('------------------------------Test 9  - Erreur de suppression dans la table CompteAbonne - KO');
							END
							ELSE
							BEGIN
								PRINT('------------------------------Test 9 - OK');
							END
						END
					END
				END
			END
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 9 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 9 - Exception leve - KO');
END CATCH
GO

--Test 10 
--Test de la suppression d'une relance decouvert
BEGIN TRY
	DECLARE @ReturnValue int;
	UPDATE RelanceDecouvert
	SET a_supprimer = 'true'
	WHERE date = '20140226 11:00:00' 
	AND nom_compteabonne = 'Lecoconier'
	AND prenom_compteabonne = 'David'
	AND date_naissance_compteabonne = '1990-02-02'
	
	
	EXEC @ReturnValue = dbo.deleteTrigger
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du type d'abonnement
		IF ((SELECT COUNT(*) FROM RelanceDecouvert
			WHERE date = '20140226 11:00:00' 
			AND nom_compteabonne = 'Lecoconier'
			AND prenom_compteabonne = 'David'
			AND date_naissance_compteabonne = '1990-02-02') <> 0)
		BEGIN
			PRINT('------------------------------Test 10 - erreur de suppression dans la table Abonnement -  KO');
		END
		ELSE
		BEGIN 	
			PRINT('------------------------------Test 10 - OK');
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 10 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 10 - Exception leve - KO');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140326_TPS_TAuto_associateConducteurToLocation.sql
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "associateConducteurToLocation"
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de associateConducteurToLocation')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
GO

--Test 1 : ERROR Les informations concernant le conducteur sont incompletes

BEGIN TRY
	DECLARE @ReturnValue int, @nbConducteurLocation_Avant int, @nbCompteAbonneConducteur_Avant int, 
			@nbConducteurLocation_Apres int, @nbCompteAbonneConducteur_Apres int;
	
	SET @nbConducteurLocation_Avant = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	EXEC @ReturnValue = dbo.associateConducteurToLocation
		@id_location = 1,
		@piece_identite_conducteur = '123456789',
		@nationalite_conducteur = NULL
		
	SET @nbConducteurLocation_Apres = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	IF ( @ReturnValue = -1 AND
	     @nbConducteurLocation_Avant = @nbConducteurLocation_Apres AND 
	     @nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres )
	BEGIN
		PRINT('------------------------------Test 1 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - - NOT OK');
END CATCH
GO


--Test 2 : ERROR L'identifiant de la location n'est pas renseigne

BEGIN TRY
	DECLARE @ReturnValue int, @nbConducteurLocation_Avant int, @nbCompteAbonneConducteur_Avant int, 
			@nbConducteurLocation_Apres int, @nbCompteAbonneConducteur_Apres int;
	
	SET @nbConducteurLocation_Avant = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	EXEC @ReturnValue = dbo.associateConducteurToLocation
		@id_location = NULL,
		@piece_identite_conducteur = '123456789',
		@nationalite_conducteur = 'Francais'
		
	SET @nbConducteurLocation_Apres = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	IF ( @ReturnValue = -1 AND
	     @nbConducteurLocation_Avant = @nbConducteurLocation_Apres AND 
	     @nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres )
	BEGIN
		PRINT('------------------------------Test 2 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - - NOT OK');
END CATCH
GO


--Test 3 : ERROR Les informations concernant le conducteur sont incorrectes

BEGIN TRY
	DECLARE @ReturnValue int, @nbConducteurLocation_Avant int, @nbCompteAbonneConducteur_Avant int, 
			@nbConducteurLocation_Apres int, @nbCompteAbonneConducteur_Apres int;
	
	SET @nbConducteurLocation_Avant = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	EXEC @ReturnValue = dbo.associateConducteurToLocation
		@id_location = 1,
		@piece_identite_conducteur = '999999999',
		@nationalite_conducteur = 'Francais'
		
	SET @nbConducteurLocation_Apres = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	IF ( @ReturnValue = -1 AND
	     @nbConducteurLocation_Avant = @nbConducteurLocation_Apres AND 
	     @nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres )
	BEGIN
		PRINT('------------------------------Test 3 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - - NOT OK');
END CATCH
GO


--Test 4 : ERROR L'identifiant de la location est incorrect

BEGIN TRY
	DECLARE @ReturnValue int, @nbConducteurLocation_Avant int, @nbCompteAbonneConducteur_Avant int, 
			@nbConducteurLocation_Apres int, @nbCompteAbonneConducteur_Apres int;
	
	SET @nbConducteurLocation_Avant = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	EXEC @ReturnValue = dbo.associateConducteurToLocation
		@id_location = -1,
		@piece_identite_conducteur = '123456789',
		@nationalite_conducteur = 'Francais'
		
	SET @nbConducteurLocation_Apres = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	IF ( @ReturnValue = -1 AND
	     @nbConducteurLocation_Avant = @nbConducteurLocation_Apres AND 
	     @nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres )
	BEGIN
		PRINT('------------------------------Test 4 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - - NOT OK');
END CATCH
GO


--Test 5 : ERROR Le conducteur est deja associe a la location

BEGIN TRY
	DECLARE @ReturnValue int, @nbConducteurLocation_Avant int, @nbCompteAbonneConducteur_Avant int, 
			@nbConducteurLocation_Apres int, @nbCompteAbonneConducteur_Apres int,
			@exists_Cond_Loc_avant bit;
	
	-- pre
	SET @nbConducteurLocation_Avant = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	SET @exists_Cond_Loc_avant = 0;
	IF exists (SELECT 1
	           FROM ConducteurLocation
	           WHERE id_location = 1 AND piece_identite_conducteur = '987654321' AND nationalite_conducteur = 'Francais')
	BEGIN
		SET @exists_Cond_Loc_avant = 1;
	END
	
	-- test
	EXEC @ReturnValue = dbo.associateConducteurToLocation
		@id_location = 1,
		@piece_identite_conducteur = '987654321',
		@nationalite_conducteur = 'Francais'
	
	-- post
	SET @nbConducteurLocation_Apres = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	-- verification
	IF ( @ReturnValue = -1 AND
	     @nbConducteurLocation_Avant = @nbConducteurLocation_Apres AND 
	     @nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
	     @exists_Cond_Loc_avant = 1
	   )
	BEGIN
		PRINT('------------------------------Test 5 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - - NOT OK');
END CATCH
GO


--Test 6 : associateConducteurToLocation OK

BEGIN TRY
	DECLARE @ReturnValue int, @nbConducteurLocation_Avant int, @nbCompteAbonneConducteur_Avant int, 
			@nbConducteurLocation_Apres int, @nbCompteAbonneConducteur_Apres int, 
			@exists_Cond_Loc_avant bit, @exists_Cond_Loc_apres bit,
			@exists_CompteAbonne_Cond_avant bit, @exists_CompteAbonne_Cond_apres bit;
			
	SET @exists_Cond_Loc_apres = 0;
	SET @exists_CompteAbonne_Cond_apres = 0;
	
	-- pre
	SET @nbConducteurLocation_Avant = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	SET @exists_CompteAbonne_Cond_avant = 0;
	IF exists (SELECT 1
	           FROM CompteAbonneConducteur
	           WHERE nom_compteabonne = 'Deluze' AND prenom_compteabonne = 'Alexis' AND date_naissance_compteabonne = '1974-02-12' AND
	                 piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais')
	BEGIN
		SET @exists_CompteAbonne_Cond_avant = 1;
	END
	
	SET @exists_Cond_Loc_avant = 0;
	IF exists (SELECT 1
	           FROM ConducteurLocation
	           WHERE id_location = 1 AND piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais')
	BEGIN
		SET @exists_Cond_Loc_avant = 1;
	END
	
	-- test
	EXEC @ReturnValue = dbo.associateConducteurToLocation
		@id_location = 1,
		@piece_identite_conducteur = '123456789',
		@nationalite_conducteur = 'Francais'
	
	-- post
	SET @nbConducteurLocation_Apres = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	SET @exists_CompteAbonne_Cond_apres = 0;
	IF exists (SELECT 1
	           FROM CompteAbonneConducteur
	           WHERE nom_compteabonne = 'Deluze' AND prenom_compteabonne = 'Alexis' AND date_naissance_compteabonne = '1974-02-12' AND
	                 piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais')
	BEGIN
		SET @exists_CompteAbonne_Cond_apres = 1;
	END
	
	SET @exists_Cond_Loc_apres = 0;
	IF exists (SELECT 1
	           FROM ConducteurLocation
	           WHERE id_location = 1 AND piece_identite_conducteur = '123456789' AND nationalite_conducteur = 'Francais')
	BEGIN
		SET @exists_Cond_Loc_apres = 1;
	END
	
	-- verification
	IF ( @ReturnValue = 1 AND
	     @nbConducteurLocation_Avant+1 = @nbConducteurLocation_Apres AND 
	     @nbCompteAbonneConducteur_Avant = @nbCompteAbonneConducteur_Apres AND
	     @exists_CompteAbonne_Cond_avant = 1 AND @exists_Cond_Loc_avant = 0 AND
	     @exists_CompteAbonne_Cond_apres = 1 AND @exists_Cond_Loc_apres = 1
	   )
	BEGIN
		PRINT('------------------------------Test 6 -- OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 -- NOT OK');
	END

	-- remettre la base à son etat initial
	EXECUTE dbo.removeConducteurFromLocation 1, '123456789', 'Francais'

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - - NOT OK');
END CATCH
GO


--Test 7 : associateConducteurToLocation OK

BEGIN TRY
	DECLARE @ReturnValue int, @nbConducteurLocation_Avant int, @nbCompteAbonneConducteur_Avant int, 
			@nbConducteurLocation_Apres int, @nbCompteAbonneConducteur_Apres int, 
			@exists_Cond_Loc_avant bit, @exists_Cond_Loc_apres bit,
			@exists_CompteAbonne_Cond_avant bit, @exists_CompteAbonne_Cond_apres bit;
			
	SET @exists_Cond_Loc_apres = 0;
	SET @exists_CompteAbonne_Cond_apres = 0;
	
	-- pre
	SET @nbConducteurLocation_Avant = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Avant = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	SET @exists_CompteAbonne_Cond_avant = 0;
	IF exists (SELECT 1
	           FROM CompteAbonneConducteur
	           WHERE nom_compteabonne = 'Deluze' AND prenom_compteabonne = 'Alexis' AND date_naissance_compteabonne = '1974-02-12' AND
	                 piece_identite_conducteur = '100000001' AND nationalite_conducteur = 'Anglais')
	BEGIN
		SET @exists_CompteAbonne_Cond_avant = 1;
	END
	
	SET @exists_Cond_Loc_avant = 0;
	IF exists (SELECT 1
	           FROM ConducteurLocation
	           WHERE id_location = 1 AND piece_identite_conducteur = '100000001' AND nationalite_conducteur = 'Anglais')
	BEGIN
		SET @exists_Cond_Loc_avant = 1;
	END
	
	-- test
	EXEC @ReturnValue = dbo.associateConducteurToLocation
		@id_location = 1,
		@piece_identite_conducteur = '100000001',
		@nationalite_conducteur = 'Anglais'
	
	-- post
	SET @nbConducteurLocation_Apres = (SELECT COUNT(*) FROM ConducteurLocation );
	SET @nbCompteAbonneConducteur_Apres = (SELECT COUNT(*) FROM CompteAbonneConducteur );
	
	SET @exists_CompteAbonne_Cond_apres = 0;
	IF exists (SELECT 1
	           FROM CompteAbonneConducteur
	           WHERE nom_compteabonne = 'Deluze' AND prenom_compteabonne = 'Alexis' AND date_naissance_compteabonne = '1974-02-12' AND
	                 piece_identite_conducteur = '100000001' AND nationalite_conducteur = 'Anglais')
	BEGIN
		SET @exists_CompteAbonne_Cond_apres = 1;
	END
	
	SET @exists_Cond_Loc_apres = 0;
	IF exists (SELECT 1
	           FROM ConducteurLocation
	           WHERE id_location = 1 AND piece_identite_conducteur = '100000001' AND nationalite_conducteur = 'Anglais')
	BEGIN
		SET @exists_Cond_Loc_apres = 1;
	END
	
	-- verification
	IF ( @ReturnValue = 1 AND
	     @nbConducteurLocation_Avant+1 = @nbConducteurLocation_Apres AND 
	     @nbCompteAbonneConducteur_Avant+1 = @nbCompteAbonneConducteur_Apres AND
	     @exists_CompteAbonne_Cond_avant = 0 AND @exists_Cond_Loc_avant = 0 AND
	     @exists_CompteAbonne_Cond_apres = 1 AND @exists_Cond_Loc_apres = 1
	   )
	BEGIN
		PRINT('------------------------------Test 7 -- OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 -- NOT OK');
	END

	-- remettre la base à son etat initial
	EXECUTE dbo.removeConducteurFromCompteAbonne 'Deluze', 'Alexis', '1974-02-12', '100000001', 'Anglais';
	EXECUTE dbo.removeConducteurFromLocation 1, '100000001', 'Anglais';

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - - NOT OK');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140326_TPS_TAuto_blackListCompte.sql
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "blackListCompte"
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de blackListCompte')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
GO

--Test 1 : Les informations concernant le compte abonne sont incompletes

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.blackListCompte
		@nom = NULL,
		@prenom = NULL,
		@date_naissance = NULL
	
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - - NOT OK');
END CATCH
GO


--Test 2 : Il est deja en liste noire

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.blackListCompte
		@nom = 'Nithoo',
		@prenom = 'Ritchie',
		@date_naissance = '1990-09-08'
	
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - - NOT OK');
END CATCH
GO


--Test 3 : mettre le compte abonne ('Deluze', 'Alexis', '1974-02-12') dans la liste noire

BEGIN TRY
	DECLARE @ReturnValue int, @IsInBlackList_avant int, @IsInBlackList_apres int,
	        @actif_avant int, @actif_apres int;

	-- pre
	
	EXEC @IsInBlackList_avant = dbo.isInListeNoire 'Deluze', 'Alexis', '1974-02-12';
	SELECT @actif_avant = actif FROM CompteAbonne WHERE nom = 'Deluze' AND prenom = 'Alexis' AND date_naissance = '1974-02-12'

	-- test

	EXEC @ReturnValue = dbo.blackListCompte
		@nom = 'Deluze',
		@prenom = 'Alexis',
		@date_naissance = '1974-02-12'
		
	-- post
	
	EXEC @IsInBlackList_apres = dbo.isInListeNoire 'Deluze', 'Alexis', '1974-02-12';
	SELECT @actif_apres = actif FROM CompteAbonne WHERE nom = 'Deluze' AND prenom = 'Alexis' AND date_naissance = '1974-02-12'
	
	-- verification
	
	IF ( @ReturnValue = 1 AND
	     @actif_avant = 1 AND @actif_apres = 0 AND
	     @IsInBlackList_avant = 0 AND @IsInBlackList_apres = 1
	   )
	BEGIN
		PRINT('------------------------------Test 3 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - - NOT OK');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140326_TPS_TAuto_checkImpayeTrigger.sql
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test du trigger checkImpayeTrigger
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de checkImpayeTrigger')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
GO

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int;
	DECLARE @NbRelance_av int;
	DECLARE @NbRelance_ap int;
	
	SELECT @NbRelance_av = COUNT(*) FROM RelanceDecouvert
	WHERE   nom_compteabonne = 'TASociety'
		AND prenom_compteabonne = 'TASociety'
		AND date_naissance_compteabonne = '2014-02-24'
		AND niveau = 0
		AND a_supprimer = 'false';
	
	EXEC @ReturnValue = dbo.endEtat
		@idContratLocation = 8,
		@matricule = '0775896we',
		@date_apres = '2014-03-25T10:00:00',
		@km_apres = 15000,
		@fiche_apres = 'fichetest1',
		@degat = 'false',
		@vehicule_statut = 'Disponible';
		
	SELECT @NbRelance_ap = COUNT(*) FROM RelanceDecouvert
	WHERE   nom_compteabonne = 'TASociety'
		AND prenom_compteabonne = 'TASociety'
		AND date_naissance_compteabonne = '2014-02-24'
		AND niveau = 0
		AND a_supprimer = 'false';
	
	IF ( @ReturnValue = 7 AND
	     @NbRelance_av + 1 = @NbRelance_ap)
	BEGIN
		PRINT('------------------------------Test 1 -- OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - - NOT OK');
END CATCH
GO

--Test 2
BEGIN TRY
	DECLARE @NbRelance int;
	DECLARE @estGris bit;
	EXEC dbo.checkImpayeTriggerRec;--4
	EXEC dbo.checkImpayeTriggerRec;--5
	EXEC dbo.checkImpayeTriggerRec;--gris
		
	SELECT @NbRelance = COUNT(*) FROM RelanceDecouvert
	WHERE date = '20140226 10:00:00'
		AND nom_compteabonne = 'PIndustrie'
		AND prenom_compteabonne = 'PIndustrie'
		AND date_naissance_compteabonne = '2014-02-17'
		AND niveau = 5
		AND a_supprimer = 'true';
		
	SELECT @estGris = liste_grise FROM CompteAbonne
	WHERE   nom = 'PIndustrie'
		AND prenom = 'PIndustrie'
		AND date_naissance = '2014-02-17';
	
	IF ( @NbRelance = 1 AND @estGris = 'true')
	BEGIN
		PRINT('------------------------------Test 2 -- OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - - NOT OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 26140325_TPS_TAuto_fixFacturation
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la de l'inscription du paiement 
-- de la facture. 
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de fixFacturation')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON

/*
	dbo.fixFacturation
	@id_contrat					nvarchar(50),	-- PK
	@matricule 					nvarchar(50),	-- PK
	@date_reception				date			-- nullable
*/

--Test 1
-- cas ou la date indique precede la date de creation de la facturation
BEGIN TRY
	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 9,		
		@matricule		= '2775896wi',
		@date_reception = '2014-03-20'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
--cas ou la date indique est dans le future
BEGIN TRY
	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 9,		
		@matricule		= '2775896wi',
		@date_reception = '2019-03-25'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Erreur valeur de retour - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO



--Test 3
--cas ou la facture a deja ete regle
BEGIN TRY
	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 6,		
		@matricule		= '0775896wi',
		@date_reception = '2014-03-25'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - Erreur valeur de retour - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO



--Test 4 
--cas nominal 
BEGIN TRY
	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 9,		
		@matricule		= '2775896wi',
		@date_reception = '2014-03-25'
	IF ( @ReturnValue = 1)
	BEGIN
		IF((SELECT date_reception 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = 9
						AND matricule_vehicule = '2775896wi')) IS NULL)
			BEGIN
				PRINT('------------------------------Test 4 - La facturation n''a pas ete regle - KO')
			END
			ELSE
			BEGIN
				PRINT('------------------------------Test 4 - OK');
			END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 4 - Erreur valeur de retour - KO');	
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - Exception leve - KO');
END CATCH
GO

--Test 5
--cas ou l'argument date_reception est null
BEGIN TRY
	UPDATE Facturation
	SET date_reception = NULL
	WHERE id = (SELECT id_facturation 
				FROM Location
				WHERE id_contratLocation = 9
				AND matricule_vehicule = '2775896wi')

	DECLARE @ReturnValue int;
	--date_creation 2014-03-21
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 9,		
		@matricule		= '2775896wi',
		@date_reception = NULL
	IF ( @ReturnValue = 1)
	BEGIN
		IF((SELECT date_reception 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = 9
						AND matricule_vehicule = '2775896wi')) IS NULL)
			BEGIN
				PRINT('------------------------------Test 5 - La facturation n''a pas ete regle - KO')
			END
			ELSE
			BEGIN
				IF((SELECT date_reception 
			FROM Facturation
			WHERE id = (SELECT id_facturation 
						FROM Location
						WHERE id_contratLocation = 9
						AND matricule_vehicule = '2775896wi')) <> CAST(GETDATE() As Date))
				BEGIN
					PRINT('------------------------------Test 5 - Mauvaise date inseree - KO')
				END
				ELSE
				BEGIN		
					PRINT('------------------------------Test 5 - OK');
				END
			END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 5 - Erreur valeur de retour - KO');	
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - Exception leve - KO');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_findOtherVehiculeWithElevation
-- Date        : 10/03/2014
-- Version     : 1.0 
-- Auteur      : Neti Mohamed & Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de findOtherVehiculeWithElevation')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
SET NOCOUNT ON

BEGIN TRY

	DECLARE @ReturnValue int,
	
			@nbReservationVehicule_Avant int,
			@nbContratLocation_Avant int,
			
			@nbReservationVehicule_Apres int,
			@nbContratLocation_Apres int,
			
			@tmp_ReservationVehicule_Avant int,
			@tmp_ContratLocation_Avant int,
			
			@tmp_ReservationVehicule_Apres int,
			@tmp_ContratLocation_Apres int;
			
/*			
--Test 1 si le matricule est bien renseigne
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= NULL,
			@itMustBeDone			= NULL,
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 1 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - KO');
	END

--Test 2 s'il existe bien un vehicule pour le matricule renseigne	
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0000000zz',
			@itMustBeDone			= NULL,
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - KO');
	END
	
--Test 3 si la date de fin est bien renseigner pour une demande d'extention de location
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0775896we',
			@itMustBeDone			= 'false',
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - KO');
	END
	
--Test 4 si la date de fin est coherente : 	@date_fin < GETDATE()
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0775896we',
			@itMustBeDone			= 'false',
			@date_fin				= '2008-12-03'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 4 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - KO');
	END
	
--Test 5 si il existe bien une location en cours pour la demande d'extension de location
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0775896wx',
			@itMustBeDone			= 'false',
			@date_fin				= '2016-12-03'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 5 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - KO');
	END
	
--Test 6	
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= '0775896wr',
			@itMustBeDone			= 'false',
			@date_fin				= '2014-03-30T00:00:00'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 6 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - KO');
	END
	*/
------tout vider et inserer
DELETE FROM ReservationVehicule;
DELETE FROM Reservation;
DELETE FROM ConducteurLocation;
DELETE FROM Retard;
DELETE FROM Incident; 
DELETE FROM Infraction;
DELETE FROM Location;
DELETE FROM Facturation;
DELETE FROM Etat;
DELETE FROM ContratLocation;
DELETE FROM Vehicule;
DECLARE @id_facturation int,
		@id_contratLocation int,
		@id_etat int,
		@idAbonnementDavid int,
		@idReservation int;
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('AX-580-VT','140000','Gris','Disponible','VF3 8C4HXF 81100000','Peugeot','406','5','Essence','false');

INSERT INTO Facturation(date_creation,date_reception,montant) VALUES
		('2013-03-27','2014-03-28','15.35');

SET @id_facturation = SCOPE_IDENTITY();
INSERT INTO ContratLocation(date_debut,date_fin,date_fin_effective,extension,id_abonnement) VALUES
		('2014-03-07T09:00:00', '2014-04-01T19:00:00', null, 0, 2);
SET @id_contratLocation = SCOPE_IDENTITY();
INSERT INTO Etat(date_avant,km_avant,fiche_avant,date_apres,km_apres,fiche_apres) VALUES
		('2013-03-07T08:00:00',300,'0005','20130328 10:00:00',400,'0006');
SET @id_etat = SCOPE_IDENTITY();
INSERT INTO Location(matricule_vehicule,id_facturation,id_etat,id_contratLocation) VALUES
		('AX-580-VT',@id_facturation,@id_etat,@id_contratLocation);

SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-04-15T08:00:00', '2014-04-26T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-15T08:00:00' AND date_fin = '2014-04-26T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT'); 

SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-02T08:00:00', '2014-05-08T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-02T08:00:00' AND date_fin = '2014-05-08T17:00:00';
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT'); 
		
SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-26T08:00:00', '2014-06-01T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-26T08:00:00' AND date_fin = '2014-06-01T17:00:00'; 
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT');		
----------------------
/*	
--Test 7 si le vehicule es dispo pour la prolongation
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'false',
			@date_fin				= '2014-04-04T19:00:00'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 7 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 7 - KO');
	END
	
--Test 8 si le vehicule n'es pas dispo pour la prolongation
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'false',
			@date_fin				= '2014-04-16T19:00:00'
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 8 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 8 - KO');
	END
*/	
--Test 9 test ki remplace le cehicule endomager  pour les reservations concerné
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('AX-581-VT','140000','Gris','Disponible','VF3 8C4HXF 81100000','Peugeot','406','5','Essence','false');
INSERT INTO Vehicule (matricule,kilometrage,couleur,statut,num_serie,marque_modele,serie_modele,portieres_modele,type_carburant_modele,a_supprimer)VALUES
		('AX-582-VT','140000','Gris','Disponible','VF3 8C4HXF 81100000','Peugeot','406','5','Essence','false');

SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-04-17T08:00:00', '2014-04-22T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-17T08:00:00' AND date_fin = '2014-04-22T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-581-VT'); 
		
SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-04T08:00:00', '2014-05-27T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-04T08:00:00' AND date_fin = '2014-05-27T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-582-VT'); 

		
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'true',
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 9 - OK');
	END
	ELSE IF(@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 9 - KO');
	END
	
--Test 10 test ou le remplacement ne peut satisfaire toute les reservations
DELETE FROM ReservationVehicule;
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-15T08:00:00' AND date_fin = '2014-04-26T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT');
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-02T08:00:00' AND date_fin = '2014-05-08T17:00:00';
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT'); 
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-26T08:00:00' AND date_fin = '2014-06-01T17:00:00'; 
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-580-VT');
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-04-17T08:00:00' AND date_fin = '2014-04-22T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-581-VT'); 
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-04T08:00:00' AND date_fin = '2014-05-27T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-582-VT');		
		
SELECT @idAbonnementDavid = id FROM Abonnement WHERE nom_compteabonne = 'Lecoconier' AND date_debut = '2014-02-19'; 
INSERT INTO Reservation (date_creation, date_debut, date_fin, annule, id_abonnement) VALUES
		('2014-02-24', '2014-05-02T08:00:00', '2014-05-10T17:00:00', 0, @idAbonnementDavid);	
SELECT @idReservation = id FROM Reservation WHERE date_debut = '2014-05-02T08:00:00' AND date_fin = '2014-05-10T17:00:00'; -- 17
INSERT INTO ReservationVehicule (id_reservation,matricule_vehicule) VALUES
		(@idReservation, 'AX-581-VT'); 
		
	SET @nbReservationVehicule_Avant = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Avant = (SELECT COUNT(*) FROM ContratLocation );													   
		
	EXEC @ReturnValue = dbo.findOtherVehiculeWithElevation
			@matricule				= 'AX-580-VT',
			@itMustBeDone			= 'true',
			@date_fin				= NULL
						
	SET @nbReservationVehicule_Apres = (SELECT COUNT(*) FROM ReservationVehicule );
	SET @nbContratLocation_Apres = (SELECT COUNT(*) FROM ContratLocation );													   
	
	IF (@nbReservationVehicule_Avant = @nbReservationVehicule_Apres AND 
		@nbContratLocation_Avant = @nbContratLocation_Apres AND 
		@ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 10 - OK');
	END
	ELSE IF(@ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 10 - KO');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test NOT -- OKI');
END CATCH
GO


------------------------------------------------------------
-- Fichier     : 20140318_TPS_TAuto_fixInfraction
-- Date        : 18/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure fixInfraction qui permet de mettre regler une infraction
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de fixInfraction')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;


--Test 1
BEGIN TRY
	
	EXEC dbo.makeInfraction '0775896wt','2014-02-16T00:00:00','exces de vitesse',75,'roule a 90 km en plein aglomeration' ;	
	
	EXEC dbo.fixInfraction '0775896wt','Marshall','Michel',75,2,'2014-02-16T00:00:00';
	
	PRINT('infraction cree--- Test OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140327_TPS_TAuto_fixVehicule.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "fixVehicule"
------------------------------------------------------------

PRINT('--------------------------------------')
PRINT('test de fixVehicule')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;
GO

--Test 1 : Le matricule du vehicule n'est pas renseigne

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = NULL,
			@statut_future = 'Disponible'
	
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 1 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - - NOT OK');
END CATCH
GO

USE TAuto_IBDR;
GO


--Test 2 : Vehicule inexistant

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0999999we',
			@statut_future = 'Disponible'
	
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 2 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - - NOT OK');
END CATCH
GO


--Test 3 : Le status souhaite du vehicule n'est pas renseigne

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896we',
			@statut_future = NULL
	
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 3 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - - NOT OK');
END CATCH
GO


--Test 4 : Status inconnu

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896we',
			@statut_future = 'ecrase'
	
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 4 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - - NOT OK');
END CATCH
GO



--Test 5 : Le vehicule a deja ce status !

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896we';

	EXEC @ReturnValue = dbo.fixVehicule
		@matricule = '0775896we',
		@statut_future = 'Disponible'
		
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896we';
	
	IF ( @ReturnValue = -1 AND @Status_avant = 'Disponible' AND @Status_apres = @Status_avant)
	BEGIN
		PRINT('------------------------------Test 5 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - - NOT OK');
END CATCH
GO


--Test 6 : 'En panne' -> 'Disponible'

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	-- pre
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896wx';

	-- test
	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896wx',
			@statut_future = 'Disponible'
		
	-- post
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wx';
	
	-- verification
	IF ( @ReturnValue = 1 AND @Status_avant = 'En panne' AND @Status_apres = 'Disponible')
	BEGIN
		PRINT('------------------------------Test 6 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 -- NOT OK');
	END
	
	-- remettre la base a son etat initial
	UPDATE Vehicule
	SET statut = @Status_avant
	WHERE matricule = '0775896wx';

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - - NOT OK');
END CATCH
GO


--Test 7 : 'Perdue' -> 'Disponible'

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	-- pre
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896wu';

	-- test
	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896wu',
			@statut_future = 'Disponible'
		
	-- post
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wu';
	
	-- verification
	IF ( @ReturnValue = 1 AND @Status_avant = 'Perdue' AND @Status_apres = 'Disponible')
	BEGIN
		PRINT('------------------------------Test 7 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 -- NOT OK');
	END
	
	-- remettre la base a son etat initial
	UPDATE Vehicule
	SET statut = @Status_avant
	WHERE matricule = '0775896wu';

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - - NOT OK');
END CATCH
GO


--Test 8 : 'Disponible' -> 'En panne'

-- '0775896wi' est reserve pour les periodes suivantes :

--      - Reservation1  : 2014-04-06 -> 2014-04-10 
--      (d'autres vehicules disponibles pour ces dates : 2775896wi)

--      - Reservation2 : 2014-07-11 -> 2014-09-22 
--      (d'autres vehicules disponibles pour ces dates : 0775896wt ou 2775896wi)

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50),
	        @marque_modele nvarchar(50), @serie_modele nvarchar(50),
	        @portieres_modele tinyint, @type_carburant_modele nvarchar(50),
			@IdReservation1 int, @IdReservation2 int, 
			@Matricule_Reservation1_apres nvarchar(50), @Matricule_Reservation2_apres nvarchar(50),
			@Reservation1_date_debut datetime, @Reservation1_date_fin datetime,
			@Reservation2_date_debut datetime, @Reservation2_date_fin datetime,
			@matricule_boucle nvarchar(50), @isDispo int;

	CREATE TABLE #DispoPrReservation1(matricule nvarchar(50));
	CREATE TABLE #DispoPrReservation2(matricule nvarchar(50));

	-- pre ***********************
	
	SELECT @Status_avant = statut, @marque_modele = marque_modele, @serie_modele = serie_modele, 
	       @portieres_modele = portieres_modele, @type_carburant_modele = type_carburant_modele
	FROM Vehicule 
	WHERE matricule = '0775896wi';
	
	-- Reservation 1
	
	SET @Reservation1_date_debut = '2014-04-06T13:00:00';
	SET @Reservation1_date_fin = '2014-04-10T18:00:00';
	
	SELECT @IdReservation1 = r.id 
	FROM Reservation r
	INNER JOIN ReservationVehicule rv ON r.id = rv.id_reservation
	WHERE rv.matricule_vehicule = '0775896wi' AND 
	      r.date_debut = @Reservation1_date_debut AND r.date_fin = @Reservation1_date_fin;

	-- Reservation 2
	
	SET @Reservation2_date_debut = '2014-07-11T09:00:00';
	SET @Reservation2_date_fin = '2014-09-22T17:00:00';
	
	SELECT @IdReservation2 = r.id 
	FROM Reservation r
	INNER JOIN ReservationVehicule rv ON r.id = rv.id_reservation
	WHERE rv.matricule_vehicule = '0775896wi' AND 
	      r.date_debut = @Reservation2_date_debut AND r.date_fin = @Reservation2_date_fin;

	-- remplir les 2 tables : #DispoPrReservation1 et #DispoPrReservation2
	
	DECLARE curseur_matricule CURSOR FOR
				SELECT matricule 
				FROM Vehicule 
				WHERE marque_modele = @marque_modele AND
					  serie_modele = @serie_modele AND 
					  type_carburant_modele = @type_carburant_modele AND 
					  portieres_modele = @portieres_modele AND 
					  matricule <> '0775896wi';
									   
	OPEN curseur_matricule
	FETCH NEXT FROM curseur_matricule INTO @matricule_boucle
	
	WHILE @@FETCH_STATUS = 0
	BEGIN

		EXEC @isDispo = dbo.isDisponible1 @matricule_boucle, @Reservation1_date_debut, @Reservation1_date_fin

		IF( @isDispo = 1)
		BEGIN
			INSERT INTO #DispoPrReservation1 VALUES (@matricule_boucle);
		END

		EXEC @isDispo = dbo.isDisponible1 @matricule_boucle, @Reservation2_date_debut, @Reservation2_date_fin

		IF( @isDispo = 1)
		BEGIN
			INSERT INTO #DispoPrReservation2 VALUES (@matricule_boucle);
		END
		
		FETCH NEXT FROM curseur_matricule INTO @matricule_boucle
	END
	CLOSE curseur_matricule
	DEALLOCATE curseur_matricule
	       
	-- test ***********************

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896wi',
			@statut_future = 'En panne'

	-- post ***********************
	
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wi';
	
	-- le matricule qui est associe a la reservation 1 apres l'execution de la procedure
	SELECT @Matricule_Reservation1_apres = matricule_vehicule 
	FROM ReservationVehicule 
	WHERE id_reservation = @IdReservation1;
	
	-- le matricule qui est associe a la reservation 2 apres l'execution de la procedure
	SELECT @Matricule_Reservation2_apres = matricule_vehicule 
	FROM ReservationVehicule 
	WHERE id_reservation = @IdReservation2;
	
	
	-- verification ***********************

	IF ( @ReturnValue = 1 AND 
	     @Status_avant = 'Disponible' AND @Status_apres = 'En panne' AND
	     @Matricule_Reservation1_apres IN (SELECT matricule FROM #DispoPrReservation1) AND
	     @Matricule_Reservation2_apres IN (SELECT matricule FROM #DispoPrReservation2) AND
	     not exists (SELECT 1 FROM ReservationVehicule WHERE id_reservation = @IdReservation1 AND matricule_vehicule = '0775896wi') AND
	     not exists (SELECT 1 FROM ReservationVehicule WHERE id_reservation = @IdReservation2 AND matricule_vehicule = '0775896wi')
	   )
	BEGIN
		PRINT('------------------------------Test 8 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 8 -- NOT OK');
	END


	DROP Table #DispoPrReservation1;
	DROP Table #DispoPrReservation2;

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - - NOT OK');
END CATCH
GO


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

PRINT('--------------------------------------')
PRINT('test de makeInfraction')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

USE TAuto_IBDR;

--Test 1
BEGIN TRY
	
	EXEC dbo.makeInfraction '0775896wt','2014-02-16T00:00:00','exces de vitesse',75,'roule a 90 km en plein aglomeration' ;
	
	PRINT('infraction cree--- Test OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO

------------------------------------------------------------
-- Fichier     : 20140318_TPS_TAuto_showInfraction
-- Date        : 18/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure showInfraction qui permet d'afficher l'etat d'une infraction
------------------------------------------------------------

USE TAuto_IBDR;

PRINT('--------------------------------------')
PRINT('test de showInfraction')
PRINT('--------------------------------------')
EXEC dbo.peuplerBase

--Test 1
BEGIN TRY
	
	EXEC dbo.makeInfraction '0775896wt','2014-02-16T00:00:00','exces de vitesse',75,'roule a 90 km en plein aglomeration' ;	
	EXEC dbo.showInfraction '0775896wt','2014-02-16T00:00:00';
	
	EXEC dbo.fixInfraction '0775896wt','Marshall','Michel',75,2,'2014-02-16T00:00:00';
	EXEC dbo.showInfraction '0775896wt','2014-02-16T00:00:00';
	
	PRINT('infraction affiché --- Test OK');
END TRY
BEGIN CATCH
	PRINT('------------------------------Test  NOT -- OK');
END CATCH
GO
			
		