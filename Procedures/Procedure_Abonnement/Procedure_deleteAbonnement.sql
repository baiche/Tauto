------------------------------------------------------------
-- Fichier     : Procedure_deleteAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteAbonnement
GO

GO
CREATE PROCEDURE dbo.deleteAbonnement
	@id 							int
AS
	DELETE FROM Abonnement
	WHERE id = @id
GO