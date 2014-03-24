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
