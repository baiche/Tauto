------------------------------------------------------------
-- Fichier     : Suppression_Procedure_Abonnement
-- Date        : 14/03/2014
-- Version     : 1.0
-- Auteur      : de Finance Boris
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime les procedure concernant les 
--				abonnements de la base.
------------------------------------------------------------

USE TAuto_IBDR;

BEGIN TRY
	DROP PROCEDURE dbo.createAbonnement
	PRINT 'dbo.createAbonnement supprime'
END TRY
BEGIN CATCH
	PRINT 'dbo.createAbonnement n''existe pas'
END CATCH

BEGIN TRY
	DROP PROCEDURE dbo.canDeleteAbonnement
	PRINT 'dbo.canDeleteAbonnement supprime'
END TRY
BEGIN CATCH
	PRINT 'dbo.canDeleteAbonnement n''existe pas'
END CATCH

BEGIN TRY
	DROP PROCEDURE dbo.deleteAbonnement
	PRINT 'dbo.deleteAbonnement supprime'
END TRY
BEGIN CATCH
	PRINT 'dbo.deleteAbonnement n''existe pas'
END CATCH
	
BEGIN TRY	
	DROP PROCEDURE dbo.updateAbonnement
	PRINT 'dbo.updateAbonnement supprime'
END TRY
BEGIN CATCH
	PRINT 'dbo.updateAbonnement n''existe pas'
END CATCH