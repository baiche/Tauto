------------------------------------------------------------
-- Fichier     : fixInfraction.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.fixInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.fixInfraction	
GO

CREATE PROCEDURE dbo.fixInfraction
	@matricule				nvarchar(50), -- FK
	@date					datetime
AS
	BEGIN TRANSACTION fixInfraction
	BEGIN TRY
	
		DECLARE @id_location INT;
		SET @id_location = (SELECT l.id FROM Location l,Infraction i 
										WHERE l.matricule_vehicule=@matricule 
										AND  l.id=i.id_location
										AND i.date = @date);	
										
		UPDATE Infraction SET regle='true' WHERE date = @date			
										   AND id_location = @id_location;			

		COMMIT TRANSACTION fixInfraction
		PRINT('fixInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('fixInfraction: ERROR');
		ROLLBACK TRANSACTION fixInfraction
		RETURN -1;
	END CATCH
GO