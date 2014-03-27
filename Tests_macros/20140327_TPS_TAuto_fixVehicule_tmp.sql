------------------------------------------------------------
-- Fichier     : 20140327_TPS_TAuto_fixVehicule_tmp.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "fixVehicule_tmp"
------------------------------------------------------------

USE TAuto_IBDR;
GO

--Test 1 : @matricule = NULL

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule_tmp
		@matricule = NULL
	
	IF ( @ReturnValue = -1 )
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

USE TAuto_IBDR;
GO


--Test 2 : Le matricule du vehicule n'est pas renseigne

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule_tmp
		@matricule = '0999999we'
	
	IF ( @ReturnValue = -1 )
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


--Test 3 : Le status du vehicule n'est pas 'En panne' !

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896we';

	EXEC @ReturnValue = dbo.fixVehicule_tmp
		@matricule = '0775896we'
		
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896we';
	
	IF ( @ReturnValue = -1 AND @Status_avant <> 'En panne' AND @Status_apres = @Status_avant)
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


--Test 4 : OK

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	-- pre
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896wx';

	-- test
	EXEC @ReturnValue = dbo.fixVehicule_tmp
			@matricule = '0775896wx'
		
	-- post
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wx';
	
	-- verification
	IF ( @ReturnValue = 1 AND @Status_avant = 'En panne' AND @Status_apres = 'Disponible')
	BEGIN
		PRINT('------------------------------Test 4 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 -- NOT OK');
	END
	
	-- remettre la base a son etat initial
	UPDATE Vehicule
	SET statut = @Status_avant
	WHERE matricule = '0775896wx';

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - - NOT OK');
END CATCH
GO

