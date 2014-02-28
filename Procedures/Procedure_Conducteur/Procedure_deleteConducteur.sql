------------------------------------------------------------
-- Fichier     : Procedure_deleteConducteur
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE dbo.deleteConducteur
	@piece_identite 	nvarchar(50),
	@nationalite 		nvarchar(50)
AS
	DELETE FROM Conducteur
	WHERE piece_identite = @piece_identite AND nationalite = @nationalite;
GO
