------------------------------------------------------------
-- Fichier     : 20140325_TPS_TAuto_declarePermis.sql
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Test de la procédure "declarePermis"
------------------------------------------------------------

USE TAuto_IBDR;
GO

--Test 1
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = NULL,
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2013-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
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
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = NULL,
		@date_obtention = '2013-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
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
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '999999999',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2013-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
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


--Test 4
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'M',
		@date_obtention = '2013-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
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


--Test 5
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2015-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
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


--Test 6
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2010-03-01',
		@periode_probatoire = NULL,
		@date_expiration = '2013-03-01'
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 6 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 6 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 6 - - NOT OK');
END CATCH
GO


--Test 7
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '300000003',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2010-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 7 -- OK'+char(13));
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 7 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 7 - - NOT OK');
END CATCH
GO


--Test 8
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'B',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 8 -- OK');
		DELETE FROM SousPermis WHERE nom_typepermis = 'E' AND numero_permis = '0000000001';
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


--Test 9
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	IF ( @ReturnValue = 1 AND
	     @nbSousPermis_Avant+1 = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres )
	BEGIN
		PRINT('------------------------------Test 9 -- OK');
		DELETE FROM SousPermis WHERE nom_typepermis = 'E' AND numero_permis = '0000000001';
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 9 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 9 - - NOT OK');
END CATCH
GO


--Test 10
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int, @date_expiration_apres date;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = '2018-03-01'
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	SELECT @date_expiration_apres = date_expiration 
	FROM SousPermis 
	WHERE nom_typepermis = 'E' AND numero_permis = '0000000001'
	
	IF ( @ReturnValue = 1 AND
	     @nbSousPermis_Avant+1 = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres AND
	     @date_expiration_apres = '2018-03-01')
	BEGIN
		PRINT('------------------------------Test 10 -- OK');
		DELETE FROM SousPermis WHERE nom_typepermis = 'E' AND numero_permis = '0000000001';
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 10 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 10 - - NOT OK');
END CATCH
GO


--Test 11
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int, @periode_probatoire_apres int;
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '123456789',
		@nationalite = 'Francais',
		@numero = NULL,
		@nom_typepermis = 'E',
		@date_obtention = '2012-03-01',
		@periode_probatoire = 2,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	SELECT @periode_probatoire_apres = periode_probatoire 
	FROM SousPermis 
	WHERE nom_typepermis = 'E' AND numero_permis = '0000000001'
	
	IF ( @ReturnValue = 1 AND
	     @nbSousPermis_Avant+1 = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres AND
	     @periode_probatoire_apres = 2 )
	BEGIN
		PRINT('------------------------------Test 11 -- OK');
		DELETE FROM SousPermis WHERE nom_typepermis = 'E' AND numero_permis = '0000000001';
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 11 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 11 - - NOT OK');
END CATCH
GO


--Test 12
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int,
			@id_permis_conducteur_avant nvarchar(50), @id_permis_conducteur_apres nvarchar(50);
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	SELECT @id_permis_conducteur_avant = id_permis 
	FROM Conducteur 
	WHERE  piece_identite = '300000003' AND nationalite = 'Francais';
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '300000003',
		@nationalite = 'Francais',
		@numero = '0000000004',
		@nom_typepermis = 'B',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	SELECT @id_permis_conducteur_apres = id_permis 
	FROM Conducteur 
	WHERE  piece_identite = '300000003' AND nationalite = 'Francais';
	
	IF ( @ReturnValue = -1 AND
	     @nbSousPermis_Avant = @nbSousPermis_Apres AND 
	     @nbPermis_Avant = @nbPermis_Apres AND
	     @id_permis_conducteur_avant IS NULL AND
	     @id_permis_conducteur_apres IS NULL)
	BEGIN
		PRINT('------------------------------Test 12 -- OK');
	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 12 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 12 - - NOT OK');
END CATCH
GO


--Test 13
BEGIN TRY
	DECLARE @ReturnValue int, @nbSousPermis_Avant int, @nbPermis_Avant int, 
			@nbSousPermis_Apres int, @nbPermis_Apres int,
			@id_permis_conducteur_avant nvarchar(50), @id_permis_conducteur_apres nvarchar(50);
	
	SET @nbSousPermis_Avant = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Avant = (SELECT COUNT(*) FROM Permis );
	
	SELECT @id_permis_conducteur_avant = id_permis 
	FROM Conducteur 
	WHERE  piece_identite = '300000003' AND nationalite = 'Francais';
	
	EXEC @ReturnValue = dbo.declarePermis
		@piece_identite = '300000003',
		@nationalite = 'Francais',
		@numero = '0000000005',
		@nom_typepermis = 'B',
		@date_obtention = '2012-03-01',
		@periode_probatoire = NULL,
		@date_expiration = NULL
		
	SET @nbSousPermis_Apres = (SELECT COUNT(*) FROM SousPermis );
	SET @nbPermis_Apres = (SELECT COUNT(*) FROM Permis );
	
	SELECT @id_permis_conducteur_apres = id_permis 
	FROM Conducteur 
	WHERE  piece_identite = '300000003' AND nationalite = 'Francais';
	
	IF ( @ReturnValue = 1 AND
	     @nbSousPermis_Avant+1 = @nbSousPermis_Apres AND 
	     @nbPermis_Avant+1 = @nbPermis_Apres AND
	     @id_permis_conducteur_avant IS NULL AND
	     @id_permis_conducteur_apres = '0000000005')
	BEGIN
		PRINT('------------------------------Test 13 -- OK');
		UPDATE Conducteur
		SET id_permis = NULL
		WHERE piece_identite = '300000003' AND nationalite = 'Francais';
		DELETE FROM SousPermis WHERE nom_typepermis = 'B' AND numero_permis = '0000000005';
		DELETE FROM Permis WHERE numero = '0000000005';

	END
	
	ELSE
	BEGIN
		PRINT('------------------------------Test 13 -- NOT OK');
	END

END TRY
BEGIN CATCH
	PRINT('------------------------------Test 13 - - NOT OK');
END CATCH
GO
