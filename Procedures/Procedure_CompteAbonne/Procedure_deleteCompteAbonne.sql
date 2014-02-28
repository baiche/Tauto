------------------------------------------------------------
-- Fichier     : Procedure_deleteCompteAbonne
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
CREATE PROCEDURE dbo.deleteCompteAbonne
	@nom					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date
AS
	DELETE FROM CompteAbonne
	WHERE 	nom = @nom,
			prenom = @prenom,
			date_naissance = @date_naissance;
GO