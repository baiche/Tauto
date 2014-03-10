------------------------------------------------------------
-- Fichier     : Procedure_createContratLocation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un contrat de location et renvoie l'id de ce contrat
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createContratLocation

GO
CREATE PROCEDURE dbo.createContratLocation
	@date_debut 			datetime,
	@date_fin 				datetime,
	@id_abonnement 			int
AS
	BEGIN TRY
		INSERT INTO ContratLocation (
			date_debut,
			date_fin,
			extension,
			id_abonnement
		)
		VALUES (
			@date_debut,
			@date_fin,
			0,
			@id_abonnement
		);
		PRINT('createContratLocation créé' + CAST(SCOPE_IDENTITY() AS CHAR(5)) );
		RETURN SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH
		PRINT('createContratLocation: ERROR');
		RETURN -1;
	END CATCH
GO
