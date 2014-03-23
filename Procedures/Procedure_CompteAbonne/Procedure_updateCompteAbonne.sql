------------------------------------------------------------
-- Fichier     : Procedure_updateCompteAbonne
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mohamed Neti
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateCompteAbonne
GO

CREATE PROCEDURE dbo.updateCompteAbonne
	@nom					nvarchar(50), -- PK
	@prenom 				nvarchar(50), -- PK
	@date_naissance 		date, -- PK
	@actif					bit, -- nullable
	@liste_grise			bit, -- nullable
	@iban					char(25), -- nullable
	@courriel				nvarchar(50), -- nullable
	@telephone				nvarchar(50) -- nullable
AS
	IF (@nom IS NULL OR @prenom IS NULL OR @date_naissance IS NULL)
		RAISERROR('Null dans la clef primaire', 10, -1);
	
	UPDATE CompteAbonne
		SET nom = @nom, prenom = @prenom, date_naissance=@date_naissance
		WHERE nom = @nom AND prenom = @prenom AND date_naissance=@date_naissance;
	
	IF ( @actif IS NOT NULL)
		UPDATE CompteAbonne
		SET actif = @actif
		WHERE nom = @nom AND prenom = @prenom AND date_naissance=@date_naissance;
		
	IF ( @liste_grise IS NOT NULL)
		UPDATE CompteAbonne
		SET liste_grise = @liste_grise
		WHERE nom = @nom AND prenom = @prenom AND date_naissance=@date_naissance;
		
	IF ( @iban IS NOT NULL)
		UPDATE CompteAbonne
		SET iban = @iban
		WHERE nom = @nom AND prenom = @prenom AND date_naissance=@date_naissance;
		
	IF ( @courriel IS NOT NULL)
		UPDATE CompteAbonne
		SET courriel = @courriel
		WHERE nom = @nom AND prenom = @prenom AND date_naissance=@date_naissance;
	
	IF ( @telephone IS NOT NULL)
		UPDATE CompteAbonne
		SET telephone = @telephone
		WHERE nom = @nom AND prenom = @prenom AND date_naissance=@date_naissance;

GO