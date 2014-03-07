------------------------------------------------------------
-- Fichier     : Procedure_deleteListeNoire
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------
USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteListeNoire', 'P') IS NOT NULL
DROP PROCEDURE dbo.deleteListeNoire;
GO

CREATE PROCEDURE dbo.deleteListeNoire
	@date_naissance	 		date,
	@nom					nvarchar(50),
	@prenom					nvarchar(50)
AS
	BEGIN TRY
		DELETE FROM ListeNoire
		WHERE 	date_naissance = @date_naissance
		AND	nom = @nom
		AND	prenom = @prenom;
		RETURN -1
	END TRY
	BEGIN CATCH
		RETURN 1
	END CATCH
GO
