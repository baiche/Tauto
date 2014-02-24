------------------------------------------------------------
-- Fichier     : Procedure_Conducteur
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
CREATE PROCEDURE dbo.createConducteur
	@piece_identite 	nvarchar(50),
	@nationalite 		nvarchar(50),
	@nom 				nvarchar(50),
	@prenom 			nvarchar(50),
	@id_permis 			nvarchar(50)
AS
	INSERT INTO Conducteur (
		piece_identite,
		nationalite,
		nom,
		prenom,
		id_permis
	)
	VALUES (
		@piece_identite,
		@nationalite,
		@nom,
		@prenom,
		@id_permis
	);

GO
CREATE PROCEDURE dbo.updateConducteur
	@piece_identite 	nvarchar(50),
	@nationalite 		nvarchar(50),
	@nom 				nvarchar(50),
	@prenom 			nvarchar(50),
	@id_permis 			nvarchar(50)
AS
	UPDATE Conducteur
	SET piece_identite = @piece_identite,
		nationalite = @nationalite,
		nom = @nom,
		prenom = @prenom,
		id_permis = @id_permis
	WHERE piece_identite = @piece_identite AND nationalite = @nationalite;

GO
CREATE PROCEDURE dbo.deleteConducteur
	@piece_identite 	nvarchar(50),
	@nationalite 		nvarchar(50)
AS
	DELETE FROM Conducteur
	WHERE piece_identite = @piece_identite AND nationalite = @nationalite;
GO