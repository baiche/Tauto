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

USE TAuto_IBDR;
GO

--Test 1
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


--Test 2
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


--Test 3
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


--Test 4
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


--Test 5
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


--Test 6
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


--Test 7
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
