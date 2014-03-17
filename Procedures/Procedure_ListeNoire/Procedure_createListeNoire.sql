------------------------------------------------------------
-- Fichier     : Procedure_createListeNoire
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Ajoute une personne a la liste noire 
-- (attention elle ne supprime pas la personne des comptes 
-- abonnés).
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createListeNoire', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createListeNoire;
GO

CREATE PROCEDURE dbo.createListeNoire
	@date_naissance	 		date,
	@nom					nvarchar(50),
	@prenom					nvarchar(50)
AS
	BEGIN TRY
		INSERT INTO ListeNoire(
			date_naissance,
			nom,
			prenom
		)
		VALUES (
			@date_naissance,
			@nom,
			@prenom
		);
		RETURN 1
	END TRY
	BEGIN CATCH
		RAISERROR('Erreur dans la fonction dbo.createListeNoire',10,1)
	END CATCH
GO
