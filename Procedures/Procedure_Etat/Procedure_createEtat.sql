------------------------------------------------------------
-- Fichier     : Procedure_createEtat
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un Etat et renvoie l'id de cet Etat, ou une erreur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createEtat
GO

-- Cette procedure permet de creer un nouvel etat

CREATE PROCEDURE dbo.createEtat
	@date_avant	 		datetime,
	@km_avant 			int,
	@fiche_avant		nvarchar(50)
AS
	INSERT INTO Etat(
		date_avant,
		km_avant,
		fiche_avant
	)
	VALUES (
		@date_avant,
		@km_avant,
		@fiche_avant
	);
	RETURN SCOPE_IDENTITY();
GO