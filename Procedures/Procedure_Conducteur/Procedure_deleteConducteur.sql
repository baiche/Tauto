------------------------------------------------------------
-- Fichier     : Procedure_deleteConducteur
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Suppression d'un conducteur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteConducteur
GO
CREATE PROCEDURE dbo.deleteConducteur
	@piece_identite 	nvarchar(50),
	@nationalite 		nvarchar(50)
AS
	DELETE FROM Conducteur
	WHERE piece_identite = @piece_identite AND nationalite = @nationalite;
GO
