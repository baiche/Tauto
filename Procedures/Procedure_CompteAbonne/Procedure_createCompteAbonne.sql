------------------------------------------------------------
-- Fichier     : Procedure_createCompteAbonne
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : David Lecoconneir
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createParticulier', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createParticulier
GO


CREATE PROCEDURE dbo.createParticulier
	@nom					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date,
	@iban					char(25),
	@courriel				nvarchar(50),
	@telephone				nvarchar(50)
AS
	INSERT INTO CompteAbonne(
		nom,
		prenom,
		date_naissance,
		iban,
		courriel,
		telephone
	)
	VALUES (
		@nom,
		@prenom,
		@date_naissance,
		@iban,
		@courriel,
		@telephone
	);
	INSERT INTO Particulier(
		nom,
		prenom,
		date_naissance
	)
	VALUES (
		@nom,
		@prenom,
		@date_naissance
	);
GO


IF OBJECT_ID ('dbo.createEntreprise', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createEntreprise
GO

CREATE PROCEDURE dbo.createEntreprise
	@nom					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date,
	@iban					char(25),
	@courriel				nvarchar(50),
	@telephone				nvarchar(50),
	@siret 					char(14),
	@nom_entreprise			nvarchar(50)
AS
	INSERT INTO CompteAbonne(
		nom,
		prenom,
		date_naissance,
		iban,
		courriel,
		telephone
	)
	VALUES (
		@nom,
		@prenom,
		@date_naissance,
		@iban,
		@courriel,
		@telephone
	);
	INSERT INTO Entreprise (
		siret,
		nom,
		nom_compte,
		prenom_compte,
		date_naissance_compte
	VALUES (
		@siret,
		@nom_entreprise,
		@nom,
		@prenom,
		@date_naissance
	);
GO
