------------------------------------------------------------
-- Fichier     : Procedure_updatePermis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Alexis Deluze
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modification d'un permis
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updatePermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updatePermis
GO


CREATE PROCEDURE dbo.updatePermis
	@numero 				nvarchar(50),
	@valide 				bit,
	@points_estimes 		tinyint
AS
	BEGIN TRY
		UPDATE Permis
		SET valide = @valide, points_estimes = @points_estimes
		WHERE numero = @numero;
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.deletePermis',10,1)
	END CATCH
GO