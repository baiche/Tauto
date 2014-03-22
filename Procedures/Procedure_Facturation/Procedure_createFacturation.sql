------------------------------------------------------------
-- Fichier     : Procedure_createFacturation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : ajoute une facture a la location
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createFacturation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createFacturation;
GO

--crée une nouvelle facturation lié à la location avec le montant non encore calculé et le paiement 
CREATE PROCEDURE dbo.createFacturation
	@montant		money
AS
	INSERT INTO Facturation(
		montant
	) VALUES (
		@montant
	);
	RETURN SCOPE_IDENTITY();
	
GO
