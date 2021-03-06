------------------------------------------------------------
-- Fichier     : Procedure_createAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : Mohamed Neti
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un abonnement et renvoie l'id de cet abonnement, ou une erreur
------------------------------------------------------------


USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createAbonnement', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createAbonnement

GO
CREATE PROCEDURE dbo.createAbonnement
	@date_debut 					date,
	@duree 							int,
	@renouvellement_auto 			bit,
	@nom_typeabonnement 			nvarchar(50),
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne 			nvarchar(50),
	@date_naissance_compteabonne 	date
AS
	INSERT INTO Abonnement(
		date_debut,
		duree,
		renouvellement_auto,
		nom_typeabonnement,
		nom_compteabonne,
		prenom_compteabonne,
		date_naissance_compteabonne
	)
	VALUES (
		@date_debut,
		@duree,
		@renouvellement_auto,
		@nom_typeabonnement,
		@nom_compteabonne,
		@prenom_compteabonne,
		@date_naissance_compteabonne
	);
	RETURN SCOPE_IDENTITY();
GO

