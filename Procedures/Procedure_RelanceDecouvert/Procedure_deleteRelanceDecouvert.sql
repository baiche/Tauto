------------------------------------------------------------
-- Fichier     : Procedure_deleteRelanceDecouvert
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.deleteRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteRelanceDecouvert
GO

CREATE PROCEDURE dbo.deleteRelanceDecouvert
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne			nvarchar(50),
	@date_naissance_compteabonne	date,
	@date							datetime
AS
	IF(	SELECT COUNT(*)
		FROM RelanceDecouvert
		WHERE   nom_compteabonne=@nom_compteabonne
			AND prenom_compteabonne = @prenom_compteabonne
			AND date_naissance_compteabonne = @date_naissance_compteabonne
			AND date = @date
			AND a_supprimer = 'true') = 1
	BEGIN
		DELETE FROM RelanceDecouvert
		WHERE   nom_compteabonne=@nom_compteabonne
			AND prenom_compteabonne = @prenom_compteabonne
			AND date_naissance_compteabonne = @date_naissance_compteabonne
			AND date = @date;
	END
GO