------------------------------------------------------------
-- Fichier     : extendReservation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : 
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.extendReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.extendReservation	
GO

CREATE PROCEDURE dbo.extendReservation
	@id_reservation			int, -- FK
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint -- PK
AS
	BEGIN TRANSACTION extendReservation
	BEGIN TRY
		COMMIT TRANSACTION extendReservation
		PRINT('extendReservation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('extendReservation: ERROR');
		ROLLBACK TRANSACTION extendReservation
		RETURN -1;
	END CATCH
GO