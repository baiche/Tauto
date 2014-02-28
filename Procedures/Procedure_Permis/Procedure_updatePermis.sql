------------------------------------------------------------
-- Fichier     : Procedure_updatePermis
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
CREATE PROCEDURE dbo.updatePermis
	@numero 				nvarchar(50),
	@valide 				bit,
	@points_estimes 		tinyint
AS
	UPDATE Permis
	SET valide = @valide, points_estimes = @points_estimes
	WHERE numero = @numero;
GO