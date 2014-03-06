------------------------------------------------------------
-- Fichier     : Procedure_createFacturation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createFacturation', 'P') IS NOT NULL
DROP PROCEDURE dbo.createFacturation;
GO

--crée une nouvelle facturation lié à la location avec le montant non encore calculé et le paiement 
CREATE PROCEDURE dbo.createFacturation
	@id_location 					int
AS
	CREATE TABLE #Temp1 (id int );

	INSERT INTO Facturation(
		date_reception
	)
	OUTPUT inserted.id INTO #Temp1(id)
	VALUES (
		null
	);
	
	UPDATE Location
	SET id_facturation = (SELECT id FROM #Temp1)
	WHERE id = @id_location
GO
