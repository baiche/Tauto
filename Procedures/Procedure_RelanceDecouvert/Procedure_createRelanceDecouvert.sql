------------------------------------------------------------
-- Fichier     : Procedure_createRelanceDecouvert
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée une nouvelle RelanceDecouvert à la date actuelle et au niveau 0.
------------------------------------------------------------

USE TAuto_IBDR;
IF OBJECT_ID ('dbo.createRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createRelanceDecouvert
GO

CREATE PROCEDURE dbo.createRelanceDecouvert
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne			nvarchar(50),
	@date_naissance_compteabonne	date
AS
	INSERT INTO RelanceDecouvert(
		nom_compteabonne,
		prenom_compteabonne,
		date_naissance_compteabonne
	)
	VALUES (
		@nom_compteabonne,
		@prenom_compteabonne,
		@date_naissance_compteabonne
	);
	
GO
