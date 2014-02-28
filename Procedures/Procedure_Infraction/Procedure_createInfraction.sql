------------------------------------------------------------
-- Fichier     : Procedure_createInfraction
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE dbo.createInfraction 
	@date_creation datetime,
	@id_location int,
	@nom nvarchar(50),
	@montant_infraction money,
	@description_infraction nvarchar(50),
	@regle bit
	
	AS
	INSERT INTO Infraction(
	date, 	
	id_location, 
	nom,
	montant,
	description,
	regle 
	)
	
	VALUES (
	@date_creation ,
	@id_location,
	@nom,
	@montant_infraction,
	@description_infraction,
	@regle
	)
	
GO


