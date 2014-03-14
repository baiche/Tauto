------------------------------------------------------------
-- Fichier     : Procedure_backListCompteAbonne
-- Date        : 11/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.backListCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.backListCompteAbonne
GO

CREATE PROCEDURE dbo.backListCompteAbonne

	@nom_abonne 				nvarchar(50),
	@prenom_abonne 				nvarchar(50),
	@date_naissance_abonne 		date

AS
	BEGIN TRANSACTION backList_compte_abonne
		BEGIN TRY

			DECLARE @actif_abonne				bit;
			DECLARE @iban_abonne				char(25);
			DECLARE @courriel_abonne			nvarchar(50);
			DECLARE @telephone_abonne			nvarchar(50);
			
			SELECT @actif_abonne=actif,
				   @iban_abonne=iban,
				   @courriel_abonne=courriel,
				   @telephone_abonne=telephone
			FROM CompteAbonne 
			WHERE nom=@nom_abonne
			  AND prenom=@prenom_abonne
			  AND date_naissance=@date_naissance_abonne
			
			EXEC dbo.updateCompteAbonne 
				@nom=@nom_abonne,
				@prenom=@prenom_abonne,
				@date_naissance=@date_naissance_abonne,
				@actif=@actif_abonne,
				@liste_grise=0,
				@iban=@iban_abonne,
				@courriel=@courriel_abonne,
				@telephone=@telephone_abonne;
		
					
					
				RETURN 0;
			
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION backList_compte_abonne;
			RETURN -1;
		END CATCH
	COMMIT TRANSACTION backList_compte_abonne;
GO
