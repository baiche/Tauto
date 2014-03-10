------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_addConducteurToCompteAbonne
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'ajout de conducteur à un compte abonné
------------------------------------------------------------

USE TAuto_IBDR;

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.addConducteurToCompteAbonne 
		@nom_compteabonne = 'PIndustrie',
		@prenom_compteabonne = 'PIndustrie',
		@date_naissance_compteabonne = '2014-02-17',
		@piece_identite_conducteur = 987654321,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'PIndustrie' AND
			prenom_compteabonne = 'PIndustrie' AND
			date_naissance_compteabonne = '2014-02-17' AND
			piece_identite_conducteur = 987654321 AND
			nationalite_conducteur = 'Francais'
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
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.addConducteurToCompteAbonne 
		@nom_compteabonne = 'Lecoconier',
		@prenom_compteabonne = 'PIndustrie',
		@date_naissance_compteabonne = '2014-02-17',
		@piece_identite_conducteur = 987654321,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'Lecoconier' AND
			prenom_compteabonne = 'PIndustrie' AND
			date_naissance_compteabonne = '2014-02-17' AND
			piece_identite_conducteur = 987654321 AND
			nationalite_conducteur = 'Francais'
		) = 0)
	BEGIN
		PRINT('------------------------------Test 2 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT -- OK');
END CATCH
GO

--Test 3
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.addConducteurToCompteAbonne 
		@nom_compteabonne = 'PIndustrie',
		@prenom_compteabonne = 'David',
		@date_naissance_compteabonne = '2014-02-17',
		@piece_identite_conducteur = 987654321,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'PIndustrie' AND
			prenom_compteabonne = 'David' AND
			date_naissance_compteabonne = '2014-02-17' AND
			piece_identite_conducteur = 987654321 AND
			nationalite_conducteur = 'Francais'
		) = 0)
	BEGIN
		PRINT('------------------------------Test 3 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 NOT -- OK');
END CATCH
GO

--Test 4
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.addConducteurToCompteAbonne 
		@nom_compteabonne = 'PIndustrie',
		@prenom_compteabonne = 'PIndustrie',
		@date_naissance_compteabonne = '1990-02-02',
		@piece_identite_conducteur = 987654321,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'PIndustrie' AND
			prenom_compteabonne = 'PIndustrie' AND
			date_naissance_compteabonne = '1990-02-02' AND
			piece_identite_conducteur = 987654321 AND
			nationalite_conducteur = 'Francais'
		) = 0)
	BEGIN
		PRINT('------------------------------Test 4 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 NOT -- OK');
END CATCH
GO

--Test 5
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.addConducteurToCompteAbonne 
		@nom_compteabonne = 'PIndustrie',
		@prenom_compteabonne = 'PIndustrie',
		@date_naissance_compteabonne = '2014-02-17',
		@piece_identite_conducteur = 987622222,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'PIndustrie' AND
			prenom_compteabonne = 'PIndustrie' AND
			date_naissance_compteabonne = '2014-02-17' AND
			piece_identite_conducteur = 987622222 AND
			nationalite_conducteur = 'Francais'
		) = 0)
	BEGIN
		PRINT('------------------------------Test 5 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 NOT -- OK');
END CATCH
GO

--Test 6
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.addConducteurToCompteAbonne 
		@nom_compteabonne = 'TASociety',
		@prenom_compteabonne = 'TASociety',
		@date_naissance_compteabonne = '2014-02-24',
		@piece_identite_conducteur = 200000002,
		@nationalite_conducteur = 'Anglais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'TASociety' AND
			prenom_compteabonne = 'TASociety' AND
			date_naissance_compteabonne = '2014-02-24' AND
			piece_identite_conducteur = 200000002 AND
			nationalite_conducteur = 'Anglais'
		) = 0)
	BEGIN
		PRINT('------------------------------Test 6 OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 NOT -- OK');
END CATCH
GO