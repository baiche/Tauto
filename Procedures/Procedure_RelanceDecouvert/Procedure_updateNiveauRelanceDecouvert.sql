------------------------------------------------------------
-- Fichier     : Procedure_updateNiveauRelanceDecouvert
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Augmente le niveau d'une RelanceDecouvert et remet la date à jour.
------------------------------------------------------------

USE TAuto_IBDR;
IF OBJECT_ID ('dbo.updateNiveauRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateNiveauRelanceDecouvert
GO

CREATE PROCEDURE dbo.updateNiveauRelanceDecouvert
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne			nvarchar(50),
	@date_naissance_compteabonne	date
AS
	UPDATE RelanceDecouvert
	SET niveau = niveau+1
	WHERE nom_compteabonne=@nom_compteabonne AND prenom_compteabonne=@prenom_compteabonne AND date_naissance_compteabonne=@date_naissance_compteabonne;

GO