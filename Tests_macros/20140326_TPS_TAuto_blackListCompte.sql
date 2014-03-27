------------------------------------------------------------
-- Fichier     : 20140326_TPS_TAuto_blackListCompte.sql
-- Date        : 26/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "blackListCompte"
------------------------------------------------------------

USE TAuto_IBDR;
GO

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.blackListCompte
		@nom = NULL,
		@prenom = NULL,
		@date_naissance = NULL
	
	IF ( @ReturnValue = -1)
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


--Test 2
BEGIN TRY
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = dbo.blackListCompte
		@nom = 'Nithoo',
		@prenom = 'Ritchie',
		@date_naissance = '1990-09-08'
	
	IF ( @ReturnValue = -1)
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


--Test 3
BEGIN TRY
	DECLARE @ReturnValue int, @IsInBlackList_avant int, @IsInBlackList_apres int,
	        @actif_avant int, @actif_apres int;

	-- pre
	
	EXEC @IsInBlackList_avant = dbo.isInListeNoire 'Deluze', 'Alexis', '1974-02-12';
	SELECT @actif_avant = actif FROM CompteAbonne WHERE nom = 'Deluze' AND prenom = 'Alexis' AND date_naissance = '1974-02-12'

	-- test

	EXEC @ReturnValue = dbo.blackListCompte
		@nom = 'Deluze',
		@prenom = 'Alexis',
		@date_naissance = '1974-02-12'
		
	-- post
	
	EXEC @IsInBlackList_apres = dbo.isInListeNoire 'Deluze', 'Alexis', '1974-02-12';
	SELECT @actif_apres = actif FROM CompteAbonne WHERE nom = 'Deluze' AND prenom = 'Alexis' AND date_naissance = '1974-02-12'
	
	-- verification
	
	IF ( @ReturnValue = 1 AND
	     @actif_avant = 1 AND @actif_apres = 0 AND
	     @IsInBlackList_avant = 0 AND @IsInBlackList_apres = 1
	   )
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


