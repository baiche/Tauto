------------------------------------------------------------
-- Fichier     : Procedure_printContratLocation
-- Date        : 07/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Affiche la facture d'un contrat_location
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.printContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.printContratLocation
GO

CREATE PROCEDURE dbo.printContratLocation
	@id_contrat_location	int
AS
	BEGIN TRY
		CREATE TABLE #Temp(id_location int);
		INSERT INTO #Temp(id_location)
		SELECT id FROM Location WHERE Location.id_contratLocation = @id_contrat_location
		DECLARE @nb_location int
		DECLARE @id_location int
		SET @nb_location = (SELECT COUNT(*) FROM #Temp)
		PRINT 'contrat_location numero : ' + CONVERT(varchar(10), @id_contrat_location) + ' nombre de véhicules loué(s) : ' + CONVERT(varchar(10), @nb_location)
		DECLARE Curseur_location CURSOR LOCAL FOR SELECT id_location FROM dbo.#Temp; 
		OPEN  Curseur_location
		FETCH NEXT FROM Curseur_location INTO @id_location
		WHILE	@@FETCH_STATUS=0
		BEGIN	
			EXEC dbo.printFacturation @id_location;
			FETCH NEXT FROM Curseur_location INTO @id_location
		END
		CLOSE Curseur_Location
	END TRY
	BEGIN CATCH
	END CATCH	
GO