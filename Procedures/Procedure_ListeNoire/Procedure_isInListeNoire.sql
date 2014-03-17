------------------------------------------------------------
-- Fichier     : Procedure_isInListeNoire
-- Date        : 16/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : modifie une personne dans la liste noire
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.isInListeNoire', 'P') IS NOT NULL
	DROP PROCEDURE dbo.isInListeNoire;
GO

CREATE PROCEDURE dbo.isInListeNoire
	@nom							nvarchar(50),
	@prenom							nvarchar(50),
	@date_naissance			 		date
AS
	BEGIN TRY
		DECLARE @present			INT	
		
		SET @present = 
		(SELECT COUNT(*) FROM ListeNoire
		WHERE nom = @nom
		AND prenom = @prenom
		AND date_naissance = @date_naissance)
		
		IF (@present = 0)
			RETURN 0
		ELSE
			RETURN 1
	END TRY
	BEGIN CATCH
	RAISERROR('Erreur dans la fonction dbo.isInListeNoire',10,1)
	END CATCH
GO
