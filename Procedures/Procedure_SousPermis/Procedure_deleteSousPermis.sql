------------------------------------------------------------
-- Fichier     : Procedure_deleteSousPermis
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

-- Désactive le sous permis (pas de supression)

CREATE PROCEDURE dbo.deleteSousPermis
	@nom_typepermis			nvarchar(50),
	@numero_permis 			nvarchar(50),
AS
	UPDATE SousPermis
	SET actif = 'false'
	WHERE nom_typepermis = @nom_typepermis AND numero_permis = @numero_permis;
GO