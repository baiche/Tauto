------------------------------------------------------------
-- Fichier     : Procedure_updateCompteAbonne
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateCompteAbonne
GO

CREATE PROCEDURE dbo.updateCompteAbonne
	@nom					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date,
	@actif					bit,
	@liste_grise			bit,
	@iban					char(25),
	@courriel				nvarchar(50),
	@telephone				nvarchar(50)
AS
	UPDATE CompteAbonne
	SET nom = @nom,
		prenom = @prenom,
		date_naissance = @date_naissance,
		actif = @actif,
		liste_grise = @liste_grise,
		iban = @iban,
		courriel = @courriel,
		telephone = @telephone		
	WHERE 	nom = @nom
	AND		prenom = @prenom
	AND		date_naissance = @date_naissance;

GO