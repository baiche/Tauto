------------------------------------------------------------
-- Fichier     : 26140325_TPS_TAuto_fixFacturation
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test sur la de l'inscription du paiement 
-- de la facture. 
------------------------------------------------------------

USE TAuto_IBDR;

/*
	dbo.fixFacturation
	@id_contrat					nvarchar(50),	-- PK
	@matricule 					nvarchar(50),	-- PK
	@date_reception				date			-- nullable
*/

--Test 1
-- cas nominal
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.fixFacturation
		@id_contrat		= 3,		
		@matricule		= '0775896wr',
		@date_reception = '
	IF ( @ReturnValue = 1)
	BEGIN
		--verification de la suppression du vehicule
		IF ((SELECT COUNT(*) FROM Vehicule
			WHERE matricule = '1775896wy'
			AND	a_supprimer= 'true') = 1)
		BEGIN
			PRINT('------------------------------Test 1 - OK');
		END
		ELSE 
		BEGIN
			PRINT('------------------------------Test 1 - Erreur de suppression du vehicule - KO');
		END
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 1 - Erreur valeur de retour - KO');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 1 - Exception leve - KO');
END CATCH
GO

--Test 2
-- matricule NULL
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = NULL;
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 2 - Ne drevrais pas etre accepte - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 2 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 2 - Exception leve - KO');
END CATCH
GO

--Test 3
-- matricule inexistant
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '1435896wy';
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 3 - Ne drevrais pas etre accepte - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 3 - OK');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 3 - Exception leve - KO');
END CATCH
GO

--Test 4
--vehicule present dans une reservation (a modifier)
BEGIN TRY
	DECLARE @ReturnValue int;
	EXEC @ReturnValue = dbo.closeVehicule
		@matricule = '0775896we';
	IF ( @ReturnValue = 1)
	BEGIN
		PRINT('------------------------------Test 4 - Ne drevrais pas etre accepte - KO');
	END
	ELSE	
	BEGIN
		PRINT('------------------------------Test 4 - OK temporairement');
	END
END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4  - Exception leve - KO');
END CATCH
GO