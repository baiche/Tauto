------------------------------------------------------------
-- Fichier     : Procedure_updateListeNoire
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : modifie une personne dans la liste noire
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateListeNoire', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateListeNoire;
GO

CREATE PROCEDURE dbo.updateListeNoire
	@date_naissance_avant	 		date,
	@nom_avant						nvarchar(50),
	@prenom_avant					nvarchar(50),
	@date_naissance_apres			date,
	@nom_apres						nvarchar(50),
	@prenom_apres					nvarchar(50)
AS
	BEGIN TRY
		UPDATE ListeNoire
		SET date_naissance = @date_naissance_apres,
			nom = @nom_apres,
			prenom = @prenom_apres
		WHERE 	date_naissance = @date_naissance_avant
		AND		nom = @nom_avant
		AND		prenom = @prenom_avant;
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
GO
