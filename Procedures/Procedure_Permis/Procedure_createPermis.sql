------------------------------------------------------------
-- Fichier     : Procedure_createPermis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Ajout d'un permis
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createPermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createPermis
GO


CREATE PROCEDURE dbo.createPermis
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
	);
	
GO
