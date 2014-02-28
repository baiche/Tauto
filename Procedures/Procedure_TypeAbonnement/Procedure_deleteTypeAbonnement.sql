------------------------------------------------------------
-- Fichier     : Procedure_deleteTypeAbonnement
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

-- Désactive le type d'abonnement (pas de supression)

CREATE PROCEDURE dbo.deleteTypeAbonnement
	@nom					nvarchar(50),
AS
	UPDATE TypeAbonnement
	SET actif = 'false'
	WHERE nom = @nom;
GO