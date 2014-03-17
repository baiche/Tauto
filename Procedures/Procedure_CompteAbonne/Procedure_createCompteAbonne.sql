------------------------------------------------------------
-- Fichier     : Procedure_createCompteAbonne
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createCompteAbonne
GO


CREATE PROCEDURE dbo.createCompteAbonne
	@nom					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date,
	@actif					bit,
	@liste_grise			bit,
	@iban					char(25),
	@courriel				nvarchar(50),
	@telephone				nvarchar(50)
AS
	INSERT INTO CompteAbonne(
		nom,
		prenom,
		date_naissance,
		actif,
		liste_grise,
		iban,
		courriel,
		telephone
	)
	VALUES (
		@nom,
		@prenom,
		@date_naissance,
		@actif,
		@liste_grise,
		@iban,
		@courriel,
		@telephone
	);

GO
