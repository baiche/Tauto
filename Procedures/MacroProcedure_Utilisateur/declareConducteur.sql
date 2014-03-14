------------------------------------------------------------
-- Fichier     : declareConducteur.sql
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.declareConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.declareConducteur	
GO

CREATE PROCEDURE dbo.declareConducteur
	@nom 				nvarchar(50),
	@prenom 			nvarchar(50),
	@date_naissance 	date,
	@piece_identite 	nvarchar(50),
	@nationalite 		nvarchar(50),
	@numero_permi		nvarchar(50), 	-- nullable
	@nom_typepermis 	nvarchar(10), 	-- nullable
	@date_obtention 	date,			-- nullable
	@date_expiration 	date,			-- nullable
	@periode_probatoire tinyint 		-- nullable
AS
	BEGIN TRANSACTION declareConducteur
	BEGIN TRY
		COMMIT TRANSACTION declareConducteur
		PRINT('declareConducteur OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('declareConducteur: ERROR');
		ROLLBACK TRANSACTION declareConducteur
		RETURN -1;
	END CATCH
GO