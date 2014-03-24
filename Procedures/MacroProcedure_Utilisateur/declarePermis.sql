------------------------------------------------------------
-- Fichier     : modifyConducteur.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.modifyConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.modifyConducteur	
GO

CREATE PROCEDURE dbo.modifyConducteur
	@piece_identite 	nvarchar(50), -- PK
	@nationalite 		nvarchar(50), -- PK
	@numero				nvarchar(50), -- nullable, pas besoin de resaisir le permis s'il existe déjà en base
	@nom_typepermis		nvarchar(10),  -- PK
	@date_obtention 	date,
	@periode_probatoire tinyint, -- csq sur le nombre de points de base
	@date_expiration 	date, -- nullable, null signifiant pas de limite
AS
	BEGIN TRANSACTION modifyConducteur
	BEGIN TRY
		COMMIT TRANSACTION modifyConducteur
		PRINT('modifyConducteur OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('modifyConducteur: ERROR');
		ROLLBACK TRANSACTION modifyConducteur
		RETURN -1;
	END CATCH
GO