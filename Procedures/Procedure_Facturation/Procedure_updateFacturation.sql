------------------------------------------------------------
-- Fichier     : Procedure_updateFacturation
-- Date        : 06/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.updateFacturation', 'P') IS NOT NULL
DROP PROCEDURE dbo.updateFacturation;
GO

--modifie le montant et la date recption du paiment d'une facturation lié à une location.
CREATE PROCEDURE dbo.updateFacturation
	@id_location 					int,
	@montant						money,
	@date_reception					date
	
AS
	DECLARE @id_facturation int;
	
	SET @id_facturation =(
	SELECT id_facturation
	FROM Facturation, Location
	WHERE Location.id = @id_location
	AND Facturation.id = Location.id_facturation);

	UPDATE Facturation
	SET montant = @montant,
	date_reception = @date_reception
	WHERE id = @id_facturation;
	
	CREATE TABLE #Temp1 (id int );
GO
