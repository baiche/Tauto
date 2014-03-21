------------------------------------------------------------
-- Fichier     : Procedure_updateEtat
-- Date        : 20/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Modifie un Etat
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateEtat
GO

-- Cette procedure permet de creer modifier un etat

CREATE PROCEDURE dbo.updateEtat
	@id 				int, -- PK
	@date_apres	 		datetime,
	@km_apres 			int,
	@fiche_apres		nvarchar(50),
	@degat				bit
AS
	UPDATE Etat
	SET
		date_apres = @date_apres,
		km_apres = @km_apres,
		fiche_apres = @fiche_apres,
		degat = @degat
	WHERE id = @id
GO