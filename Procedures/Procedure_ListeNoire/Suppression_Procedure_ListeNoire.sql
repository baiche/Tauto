------------------------------------------------------------
-- Fichier     : Suppression_Procedure_ListeNoire
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedures concernant les
--				listes noires
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createListeNoire', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createListeNoire;
GO

IF OBJECT_ID ('dbo.deleteListeNoire', 'P') IS NOT NULL
	DROP PROCEDURE dbo.deleteListeNoire;
GO

IF OBJECT_ID ('dbo.updateListeNoire', 'P') IS NOT NULL
	DROP PROCEDURE dbo.updateListeNoire;
GO