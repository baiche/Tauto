------------------------------------------------------------
-- Fichier     : 20140327_TPS_TAuto_fixVehicule.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "fixVehicule"
------------------------------------------------------------

USE TAuto_IBDR;
GO

--Test 1 : Le matricule du vehicule n'est pas renseigne

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = NULL,
			@statut_future = 'Disponible'
	
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


--Test 2 : Vehicule inexistant

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0999999we',
			@statut_future = 'Disponible'
	
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


--Test 3 : Le status souhaite du vehicule n'est pas renseigne

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896we',
			@statut_future = NULL
	
	IF ( @ReturnValue = -1 )
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


--Test 4 : Status inconnu

BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896we',
			@statut_future = 'ecrase'
	
	IF ( @ReturnValue = -1 )
	BEGIN
		PRINT('------------------------------Test 4 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 4 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 4 - - NOT OK');
END CATCH
GO



--Test 5 : Le vehicule a deja ce status !

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896we';

	EXEC @ReturnValue = dbo.fixVehicule
		@matricule = '0775896we',
		@statut_future = 'Disponible'
		
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896we';
	
	IF ( @ReturnValue = -1 AND @Status_avant = 'Disponible' AND @Status_apres = @Status_avant)
	BEGIN
		PRINT('------------------------------Test 5 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 5 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 5 - - NOT OK');
END CATCH
GO


--Test 6 : 'En panne' -> 'Disponible'

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	-- pre
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896wx';

	-- test
	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896wx',
			@statut_future = 'Disponible'
		
	-- post
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wx';
	
	-- verification
	IF ( @ReturnValue = 1 AND @Status_avant = 'En panne' AND @Status_apres = 'Disponible')
	BEGIN
		PRINT('------------------------------Test 6 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 -- NOT OK');
	END
	
	-- remettre la base a son etat initial
	UPDATE Vehicule
	SET statut = @Status_avant
	WHERE matricule = '0775896wx';

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - - NOT OK');
END CATCH
GO


--Test 7 : 'Perdue' -> 'Disponible'

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	-- pre
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896wu';

	-- test
	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896wu',
			@statut_future = 'Disponible'
		
	-- post
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wu';
	
	-- verification
	IF ( @ReturnValue = 1 AND @Status_avant = 'Perdue' AND @Status_apres = 'Disponible')
	BEGIN
		PRINT('------------------------------Test 7 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 -- NOT OK');
	END
	
	-- remettre la base a son etat initial
	UPDATE Vehicule
	SET statut = @Status_avant
	WHERE matricule = '0775896wu';

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - - NOT OK');
END CATCH
GO


--Test 8 : 'Disponible' -> 'En panne'

BEGIN TRY
	DECLARE @ReturnValue int, @Status_avant nvarchar(50), @Status_apres nvarchar(50);
	
	-- pre
	SELECT @Status_avant = statut FROM Vehicule WHERE matricule = '0775896wi';

	-- test
	EXEC @ReturnValue = dbo.fixVehicule
			@matricule = '0775896wi',
			@statut_future = 'En panne'
		
	-- post
	SELECT @Status_apres = statut FROM Vehicule WHERE matricule = '0775896wi';
	
	-- verification
	IF ( @ReturnValue = 1 AND @Status_avant = 'Disponible' AND @Status_apres = 'En panne')
	BEGIN
		PRINT('------------------------------Test 8 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 8 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 8 - - NOT OK');
END CATCH
GO


