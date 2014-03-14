------------------------------------------------------------
-- Fichier     : Procedure_createEtat
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createEtat
GO

-- Cette procedure permet de creer un nouvel etat

CREATE PROCEDURE dbo.createEtat
	@id_location 		int,
	@km 				int,
	@degat 				bit,
	@fiche 				nvarchar(50)
AS
	INSERT INTO Etat(
		date_creation,
		id_location,
		km,
		degat,
		fiche
	)
	VALUES (
		DEFAULT,
		@id_location,
		@km,
		@degat,
		@fiche
	);
	
GO