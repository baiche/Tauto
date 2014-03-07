------------------------------------------------------------
-- Fichier     : Procedure_updateListeNoire
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateListeNoire', 'P') IS NOT NULL
DROP PROCEDURE dbo.updateListeNoire;
GO

CREATE PROCEDURE dbo.updateListeNoire
	@date_naissance	 		date,
	@nom					nvarchar(50),
	@prenom					nvarchar(50)
AS
	BEGIN TRY
		UPDATE ListeNoire
		SET date_naissance = @date_naissance,
			nom = @nom,
			prenom = @prenom
		WHERE 	date_naissance = @date_naissance
		AND		nom = @nom
		AND		prenom = @prenom;
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
GO
