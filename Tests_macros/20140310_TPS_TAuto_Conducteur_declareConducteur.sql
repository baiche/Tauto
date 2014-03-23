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



			