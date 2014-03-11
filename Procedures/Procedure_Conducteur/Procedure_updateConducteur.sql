------------------------------------------------------------
-- Fichier     : Procedure_updateConducteur
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modification d'un conducteur
------------------------------------------------------------

USE TAuto_IBDR;


IF OBJECT_ID ('dbo.updateConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateConducteur
GO

CREATE PROCEDURE dbo.updateConducteur
	@piece_identite 	nvarchar(50),
	@nationalite 		nvarchar(50),
	@nom 				nvarchar(50),
	@prenom 			nvarchar(50),
	@id_permis 			nvarchar(50)
AS
	UPDATE Conducteur
	SET nom = @nom,
		prenom = @prenom
	WHERE piece_identite = @piece_identite AND nationalite = @nationalite;

GO
