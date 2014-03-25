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



			