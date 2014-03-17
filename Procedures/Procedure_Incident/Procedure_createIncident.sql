------------------------------------------------------------
-- Fichier     : Procedure_createIncident
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createIncident', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createIncident
GO

CREATE PROCEDURE dbo.createIncident 
	@date_creation datetime,
	@id_location int,
	@description_incident nvarchar(50),
	@isPenalisable bit
	
	AS
	INSERT INTO Incident(
	date, 	
	id_location, 		
	description,
	penalisable 
	)
	
	VALUES (
	@date_creation ,
	@id_location,
	@description_incident,
	@isPenalisable
	)
GO
