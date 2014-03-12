------------------------------------------------------------
-- Fichier     : Procedure_deleteSousPermis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime le sous permis
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteSousPermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteSousPermis
GO

CREATE PROCEDURE dbo.deleteSousPermis
	@nom_typepermis			nvarchar(50),
	@numero_permis 			nvarchar(50)
AS
	BEGIN TRY
		DELETE FROM SousPermis
		WHERE nom_typepermis = @nom_typepermis AND numero_permis = @numero_permis;
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
	--UPDATE SousPermis
	--SET actif = 'false'
	--WHERE nom_typepermis = @nom_typepermis AND numero_permis = @numero_permis;
GO