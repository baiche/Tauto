------------------------------------------------------------
-- Fichier     : 20140310_TPS_TAuto_createContratLocation
-- Date        : 10/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure de création de contrat de location
------------------------------------------------------------

USE TAuto_IBDR;

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.createContratLocation 
			@date_debut = '2014-02-21T00:00:00',
			@date_fin = '2014-02-25T00:00:00',
			@id_abonnement = 11
			
	IF ( @ReturnValue = (SELECT COUNT(*) FROM ContratLocation) )
	BEGIN
		PRINT('------------------------------Test 1 - Tuple inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 1 - Tuple non inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			date_debut = '2014-02-21T00:00:00' AND
			date_fin = '2014-02-25T00:00:00' AND
			id_abonnement = 11
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
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.createContratLocation 
			@date_debut = '2014-02-21T00:00:00',
			@date_fin = '2014-02-25T00:00:00',
			@id_abonnement = 25
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 2 - Tuple non inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 - Tuple inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			date_debut = '2014-02-21T00:00:00' AND
			date_fin = '2014-02-25T00:00:00' AND
			id_abonnement = 25
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
	PRINT('------------------------------Test 2 NOT - - OK');
END CATCH
GO

--Test 3
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.createContratLocation 
			@date_debut = '2014-02-25T00:00:00',
			@date_fin = '2014-03-26T00:00:00',
			@id_abonnement = 11
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 3 - Tuple non inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 - Tuple inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			date_debut = '2014-02-25T00:00:00' AND
			date_fin = '2014-03-26T00:00:00' AND
			id_abonnement = 11
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
	PRINT('------------------------------Test 3 NOT - - OK');
END CATCH
GO

--Test 4
BEGIN TRY
	DECLARE @ReturnValue int
	EXEC @ReturnValue = dbo.createContratLocation 
			@date_debut = '2014-02-17T00:00:00',
			@date_fin = '2014-02-25T00:00:00',
			@id_abonnement = 11
	IF ( @ReturnValue = -1)
	BEGIN
		PRINT('------------------------------Test 4 - Tuple non inséré');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 - Tuple inséré');
	END
	
	IF (  (SELECT COUNT (*) FROM ContratLocation WHERE
			date_debut = '2014-02-17T00:00:00' AND
			date_fin = '2014-02-25T00:00:00' AND
			id_abonnement = 11
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
	PRINT('------------------------------Test 4 NOT - - OK');
END CATCH
GO