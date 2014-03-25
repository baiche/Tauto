------------------------------------------------------------
-- Fichier     : 20140323_TPS_TAuto_modifyAbonnement
-- Date        : 24/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la modification d'un abonnement
------------------------------------------------------------

USE TAuto_IBDR;

/*CREATE PROCEDURE dbo.modifyAbonnement
	@id 					int, -- PK
	@renouvellement_auto	bit
*/

--Test 1
-- cas normal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyAbonnement
		@id = 1,
		@renouvellement_auto = 'true';
		
	DECLARE @nbAbon int;
	SELECT @nbAbon = COUNT (*) FROM Abonnement WHERE
			id = 1 AND
			renouvellement_auto = 'true'

	IF ( @nbAbon = 1 AND @ReturnValue = 1 )
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
-- 14 & 15, chevauchement de deux réservations, un autre exemplaire est libre
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyAbonnement
		@id = 4,
		@renouvellement_auto = 'false';
		
	DECLARE @nbAbon int;
	SELECT @nbAbon = COUNT (*) FROM Abonnement WHERE
			id = 4 AND
			renouvellement_auto = 'false'
			
	IF ( @nbAbon = 1 AND @ReturnValue = 1 )
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 2 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 NOT - OK');
END CATCH
GO

--Test 3
--  14 & 15, chevauchement de deux réservations, aucun autre exemplaire de libre
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.modifyAbonnement
		@id = 5,
		@renouvellement_auto = NULL;
		
	DECLARE @nbAbon int;
	SELECT @nbAbon = COUNT (*) FROM Abonnement WHERE
			id = 5 AND
			renouvellement_auto = 'false'

	IF ( @nbAbon = 1 AND @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
	ELSE
	BEGIN
		PRINT('------------------------------Test 3 NOT -- OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - OK');
END CATCH
GO
