------------------------------------------------------------
-- Fichier     : declarePermis.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.declarePermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.declarePermis	
GO

CREATE PROCEDURE dbo.declarePermis
	@piece_identite 	nvarchar(50), -- PK
	@nationalite 		nvarchar(50), -- PK
	@numero				nvarchar(50), -- nullable, pas besoin de resaisir le permis s'il existe déjà en base
	@nom_typepermis		nvarchar(10),  -- PK
	@date_obtention 	date,
	@periode_probatoire tinyint, -- csq sur le nombre de points de base
	@date_expiration 	date -- nullable, null signifiant pas de limite
AS
	BEGIN TRANSACTION declarePermis
	BEGIN TRY
	
		-- les information concernant le conducteur ne sont pas renseignees
		IF(@piece_identite IS NULL OR @nationalite IS NULL)
		BEGIN
			PRINT('declareConducteur: ERROR Les informations concernant le conducteur sont incompletes');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1;
		END
		
		-- les information concernant le type de permis ne sont pas renseignees
		IF(@nom_typepermis IS NULL OR @date_obtention IS NULL)
		BEGIN
			PRINT('declareConducteur: ERROR Les informations concernant le type de permis sont incompletes');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1;
		END
		
		IF not exists
			(SELECT 1
			 FROM Conducteur
			 WHERE piece_identite = @piece_identite AND nationalite = @nationalite
			)	
		BEGIN
			PRINT('declareConducteur: ERROR Les informations concernant le conducteur sont incorrectes');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1
		END
		
		IF @nom_typepermis NOT IN ('A1', 'A2', 'B', 'C', 'D', 'E', 'F')
		BEGIN
			PRINT('declareConducteur: ERROR Le type de permis est incorrect');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1
		END
		
		IF @date_obtention > GETDATE()
		BEGIN
			PRINT('declareConducteur: ERROR La date d obtention est postéreure à la date d aujourd hui');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1
		END
		
		IF @date_expiration IS NOT NULL AND @date_expiration < GETDATE()
		BEGIN
			PRINT('declareConducteur: ERROR La date d expiration est antérieure à la date d aujourd hui');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1
		END
		
		DECLARE @numero_permis nvarchar(50);
		
		SELECT @numero_permis = id_permis 
		FROM Conducteur 
		WHERE piece_identite = @piece_identite AND nationalite = @nationalite;
		
		IF @numero_permis IS NULL
		BEGIN
			IF @numero IS NULL
			BEGIN
				PRINT('makeAbonnement: le numero de permis doit etre renseigne');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1
			END

			IF exists (SELECT 1 FROM Permis WHERE numero = @numero)	
			BEGIN
				PRINT('declareConducteur: ERROR Le numero de permis renseigne est le numero de permis d''un autre conducteur');
				ROLLBACK TRANSACTION declareConducteur
				RETURN -1
			END
		
			SET @numero_permis = @numero;
			EXECUTE dbo.createPermis @numero_permis, 1, 12;
			
			UPDATE Conducteur
			SET id_permis = @numero_permis
			WHERE piece_identite = @piece_identite AND nationalite = @nationalite;
		END
		
		IF exists 
			(SELECT 1
			 FROM SousPermis
			 WHERE nom_typepermis = @nom_typepermis AND numero_permis = @numero_permis
			)	
		BEGIN
			PRINT('declareConducteur: ERROR Le type de permis est deja enregistre');
			ROLLBACK TRANSACTION declareConducteur
			RETURN -1
		END

		EXECUTE dbo.createSousPermis @nom_typepermis, @numero_permis, @date_obtention, @date_expiration, 0;

		IF(@periode_probatoire IS NOT NULL)
		BEGIN
			UPDATE SousPermis
			SET periode_probatoire = @periode_probatoire
			WHERE nom_typepermis = @nom_typepermis
			AND numero_permis = @numero_permis;
		END
	
		COMMIT TRANSACTION declarePermis
		PRINT('declarePermis OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('declarePermis: ERROR');
		ROLLBACK TRANSACTION declarePermis
		RETURN -1;
	END CATCH
GO