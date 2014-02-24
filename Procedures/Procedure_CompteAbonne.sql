------------------------------------------------------------
-- Fichier     : Procedure_CompteAbonne
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE TAuto.createCompteAbonne
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
	)

GO
CREATE PROCEDURE TAuto.updateCompteAbonne
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
	WHERE 	nom = @nom,
			prenom = @prenom,
			date_naissance = @date_naissance

GO
CREATE PROCEDURE TAuto.deleteCompteAbonne
	@nom					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date,
AS
	DELETE FROM CompteAbonne
	WHERE 	nom = @nom,
			prenom = @prenom,
			date_naissance = @date_naissance
GO
