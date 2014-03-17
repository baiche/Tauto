------------------------------------------------------------
-- Fichier     : associateConducteurToLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.associateConducteurToLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.associateConducteurToLocation	
GO

CREATE PROCEDURE dbo.associateConducteurToLocation
	id_location 					int, -- FK
	piece_identite_conducteur 		nvarchar(50), -- FK
	nationalite_conducteur 			nvarchar(50) -- FK
AS
	BEGIN TRANSACTION associateConducteurToLocation
	BEGIN TRY
		COMMIT TRANSACTION associateConducteurToLocation
		PRINT('associateConducteurToLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('associateConducteurToLocation: ERROR');
		ROLLBACK TRANSACTION associateConducteurToLocation
		RETURN -1;
	END CATCH
GO