------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_removeConducteurFromCompteAbonne
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de suppression d'un conducteur d'un compte abonné
------------------------------------------------------------

USE TAuto_IBDR;

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.removeConducteurFromCompteAbonne 
		@nom_compteabonne = 'PIndustrie',
		@prenom_compteabonne = 'PIndustrie',
		@date_naissance_compteabonne = '2014-02-17',
		@piece_identite_conducteur = 200000002,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple supprimé');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non supprimé');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'PIndustrie' AND
			prenom_compteabonne = 'PIndustrie' AND
			date_naissance_compteabonne = '2014-02-17' AND
			piece_identite_conducteur = 200000002 AND
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
	EXEC @ReturnValue = dbo.removeConducteurFromCompteAbonne 
		@nom_compteabonne = 'azERty',
		@prenom_compteabonne = 'TASociety',
		@date_naissance_compteabonne = '2014-02-24',
		@piece_identite_conducteur = 987654321,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple supprimé');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non supprimé');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'azERty' AND
			prenom_compteabonne = 'TASociety' AND
			date_naissance_compteabonne = '2014-02-24' AND
			piece_identite_conducteur = 987654321 AND
			nationalite_conducteur = 'Francais'
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
	PRINT('------------------------------Test 2 NOT -- OK');
END CATCH
GO

--Test 3
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.removeConducteurFromCompteAbonne 
		@nom_compteabonne = 'TASociety',
		@prenom_compteabonne = 'MaSociete',
		@date_naissance_compteabonne = '2014-02-24',
		@piece_identite_conducteur = 987654321,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - Tuple supprimé');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - Tuple non supprimé');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'TASociety' AND
			prenom_compteabonne = 'MaSociete' AND
			date_naissance_compteabonne = '2014-02-24' AND
			piece_identite_conducteur = 987654321 AND
			nationalite_conducteur = 'Francais'
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
	PRINT('------------------------------Test 3 NOT -- OK');
END CATCH
GO

--Test 4
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.removeConducteurFromCompteAbonne 
		@nom_compteabonne = 'TASociety',
		@prenom_compteabonne = 'TASociety',
		@date_naissance_compteabonne = '2014-07-24',
		@piece_identite_conducteur = 987654321,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - Tuple supprimé');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - Tuple non supprimé');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'TASociety' AND
			prenom_compteabonne = 'TASociety' AND
			date_naissance_compteabonne = '2014-07-24' AND
			piece_identite_conducteur = 987654321 AND
			nationalite_conducteur = 'Francais'
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
	PRINT('------------------------------Test 4 NOT -- OK');
END CATCH
GO

--Test 5
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.removeConducteurFromCompteAbonne 
		@nom_compteabonne = 'TASociety',
		@prenom_compteabonne = 'TASociety',
		@date_naissance_compteabonne = '2014-02-24',
		@piece_identite_conducteur = 987652222,
		@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 5 - Tuple supprimé');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 - Tuple non supprimé');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'TASociety' AND
			prenom_compteabonne = 'TASociety' AND
			date_naissance_compteabonne = '2014-02-24' AND
			piece_identite_conducteur = 987652222 AND
			nationalite_conducteur = 'Francais'
		) = 1)
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
	EXEC @ReturnValue = dbo.removeConducteurFromCompteAbonne 
		@nom_compteabonne = 'TASociety',
		@prenom_compteabonne = 'TASociety',
		@date_naissance_compteabonne = '2014-02-24',
		@piece_identite_conducteur = 987654321,
		@nationalite_conducteur = 'Anglais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 6 - Tuple supprimé');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 - Tuple non supprimé');
	END
	
	IF (  (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = 'TASociety' AND
			prenom_compteabonne = 'TASociety' AND
			date_naissance_compteabonne = '2014-02-24' AND
			piece_identite_conducteur = 987654321 AND
			nationalite_conducteur = 'Anglais'
		) = 1)
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