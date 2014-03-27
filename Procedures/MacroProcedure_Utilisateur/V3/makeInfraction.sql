------------------------------------------------------------
-- Fichier     : makeInfraction.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeInfraction	
GO

CREATE PROCEDURE dbo.makeInfraction
	@matricule				nvarchar(50), -- FK
	@date					datetime,
	@nom 					nvarchar(50),
	@montant 				money,
	@description 			nvarchar(50)
AS
	BEGIN TRANSACTION makeInfraction
	BEGIN TRY
	
		DECLARE @id_location INT;
		SET @id_location = (SELECT l.id FROM Location l,ContratLocation cl 
										WHERE l.matricule_vehicule=@matricule 
										AND  l.id_contratLocation=cl.id 
										AND cl.date_debut<=@date
										AND cl.date_fin >= @date);
		
		EXEC createInfraction @date,@id_location,@nom,@montant,@description,'false' ;
		
		COMMIT TRANSACTION makeInfraction
		PRINT('makeInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeInfraction: ERROR');
		ROLLBACK TRANSACTION makeInfraction
		RETURN -1;
	END CATCH
GO