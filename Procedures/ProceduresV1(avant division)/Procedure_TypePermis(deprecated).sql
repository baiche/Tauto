------------------------------------------------------------
-- Fichier     : Procedure_TypePermis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE TAuto.createTypePermis
	@nom	 				nvarchar(50)
AS
	INSERT INTO TypePermis(
		nom
	)
	VALUES (
		@nom
	);

GO
CREATE PROCEDURE TAuto.updateTypePermis
	@nom 					nvarchar(50)
AS
	UPDATE TypePermis
	SET nom = @nom
	WHERE 	nom = @nom;

GO
CREATE PROCEDURE TAuto.deleteTypePermis
	@nom 					nvarchar(50)
AS
	DELETE FROM TypePermis
	WHERE 	nom = @nom;
GO
