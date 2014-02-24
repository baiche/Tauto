------------------------------------------------------------
-- Fichier     : Procedure_Permis
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
CREATE PROCEDURE TAuto.createPermis
	@numero 				nvarchar(50),
	@valide 				bit,
	@points_estimes 		tinyint
AS
	INSERT INTO Permis (
		numero,
		valide,
		points_estimes
	)
	VALUES (
		@numero,
		@valide,
		@points_estimes
	)
	
GO
CREATE PROCEDURE TAuto.updatePermis
	@numero 				nvarchar(50),
	@valide 				bit,
	@points_estimes 		tinyint
AS
	UPDATE Permis
	SET numero = @numero, valide = @valide, points_estimes = @points_estimes
	WHERE numero = @numero
GO