------------------------------------------------------------
-- Fichier     : Example
-- Date        : 15/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE dbo.getIBAN_Courriel
	@nom 				nvarchar(50),
	@prenom				nvarchar(50),
	@date_naissance		date
AS
	SELECT iban, courriel
	FROM CompteAbonne
	WHERE nom = @nom AND prenom = @prenom AND date_naissance = @date_naissance;
GO	

--EXECUTE dbo.getIBAN_Courriel @nom = N'', @prenom = N'', @date_naissance = N'';

--http://technet.microsoft.com/fr-fr/library/ms345415.aspx