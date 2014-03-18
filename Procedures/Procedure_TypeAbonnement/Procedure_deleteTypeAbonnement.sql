------------------------------------------------------------
-- Fichier     : Procedure_deleteTypeAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime un typeAbonnement. Renvoie 1 en cas de succès, erreur autrement.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteTypeAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteTypeAbonnement
GO

CREATE PROCEDURE dbo.deleteTypeAbonnement
	@nom					nvarchar(50)
AS
	DELETE FROM TypeAbonnement
		WHERE nom=@nom;
		
	RETURN 1;
GO