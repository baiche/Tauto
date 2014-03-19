------------------------------------------------------------
-- Fichier     : Procedure_greyListCompteAbonne
-- Date        : 11/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.greyListCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.greyListCompteAbonne
GO

CREATE PROCEDURE dbo.greyListCompteAbonne
	@nom_abonne 				nvarchar(50),
	@prenom_abonne 				nvarchar(50),
	@date_naissance_abonne 		date
AS
	UPDATE CompteAbonne 
	SET liste_grise = 'true' 
	WHERE nom = @nom_abonne
	AND prenom = @prenom_abonne 
	AND date_naissance = @date_naissance_abonne;
GO
