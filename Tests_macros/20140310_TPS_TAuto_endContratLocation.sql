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
