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
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date, -- PK
	@piece_identite 	nvarchar(50), -- PK
	@nationalite 		nvarchar(50), -- PK
	@numero_permis		nvarchar(50), 	-- nullable
	@nom_typepermis 	nvarchar(10), 	-- nullable
	@date_obtention 	date,			-- nullable, si null ne pas prendre en compte la suite des arguments
	@periode_probatoire tinyint, -- nullable, csq sur le nombre de points de base
	@date_expiration 	date, -- nullable, null signifiant pas de limite
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