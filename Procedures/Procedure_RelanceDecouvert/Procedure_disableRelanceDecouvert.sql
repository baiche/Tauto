------------------------------------------------------------
-- Fichier     : Procedure_disableRelanceDecouvert
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met le champ a_supprimer d'une RelanceDecouvert a true
------------------------------------------------------------

USE TAuto_IBDR;
IF OBJECT_ID ('dbo.disableRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableRelanceDecouvert
GO

CREATE PROCEDURE dbo.disableRelanceDecouvert
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne			nvarchar(50),
	@date_naissance_compteabonne	date
AS
	UPDATE RelanceDecouvert
	SET a_supprimer = 'true'
	WHERE nom_compteabonne=@nom_compteabonne AND prenom_compteabonne=@prenom_compteabonne AND date_naissance_compteabonne=@date_naissance_compteabonne;

GO