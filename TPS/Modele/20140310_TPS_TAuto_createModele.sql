------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_addConducteurToLocation
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la proc�dure d'ajout de conducteur � une location
------------------------------------------------------------

USE TAuto_IBDR;

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.addConducteurToLocation 
			@id_location = 6,
			@piece_identite_conducteur = 987654321,
			@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 1 - Tuple ins�r�');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non ins�r�');
	END
	
	IF (  (SELECT COUNT (*) FROM ConducteurLocation WHERE
			id_location = 6 AND
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
	EXEC @ReturnValue = dbo.addConducteurToLocation 
			@id_location = 10,
			@piece_identite_conducteur = 987654321,
			@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple ins�r�');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non ins�r�');
	END
	
	IF (  (SELECT COUNT (*) FROM ConducteurLocation WHERE
			id_location = 10 AND
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
	EXEC @ReturnValue = dbo.addConducteurToLocation 
			@id_location = 6,
			@piece_identite_conducteur = 987622222,
			@nationalite_conducteur = 'Francais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - Tuple ins�r�');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - Tuple non ins�r�');
	END
	
	IF (  (SELECT COUNT (*) FROM ConducteurLocation WHERE
			id_location = 6 AND
			piece_identite_conducteur = 987622222 AND
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
	EXEC @ReturnValue = dbo.addConducteurToLocation 
			@id_location = 6,
			@piece_identite_conducteur = 987654321,
			@nationalite_conducteur = 'Anglais'
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - Tuple ins�r�');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - Tuple non ins�r�');
	END
	
	IF (  (SELECT COUNT (*) FROM ConducteurLocation WHERE
			id_location = 6 AND
			piece_identite_conducteur = 987654321 AND
			nationalite_conducteur = 'Anglais'
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