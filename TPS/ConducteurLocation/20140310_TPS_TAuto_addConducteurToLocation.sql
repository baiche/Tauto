------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_addConducteurToLocation
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure d'ajout de conducteur à une location
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
		PRINT('------------------------------Test 1 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non inséré');
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