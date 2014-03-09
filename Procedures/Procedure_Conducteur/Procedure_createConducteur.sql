------------------------------------------------------------
-- Fichier     : Procedure_createConducteur
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : ajoute un conducteur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createConducteur', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createConducteur
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
