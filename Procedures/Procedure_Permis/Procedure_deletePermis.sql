------------------------------------------------------------
-- Fichier     : Procedure_deletePermis
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Suppression d'un permis
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deletePermis', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deletePermis
GO


CREATE PROCEDURE dbo.deletePermis
	@numero 				nvarchar(50)
AS
	BEGIN TRY
		DELETE FROM Permis
		WHERE numero = @numero;
		RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.deletePermis',10,1)
	END CATCH
GO