------------------------------------------------------------
-- Fichier     : Procedure_disableCompteAbonne
-- Date        : 11/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.disableCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.disableCompteAbonne
GO


CREATE PROCEDURE dbo.disableCompteAbonne
	@nom 					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date
AS
	UPDATE CompteAbonne 
	SET a_supprimer = 'true' 
	WHERE nom = @nom AND prenom = @prenom AND date_naissance = @date_naissance;
GO
