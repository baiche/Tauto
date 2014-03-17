------------------------------------------------------------
-- Fichier     : Procedure_createContratLocation
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée un contrat de location et renvoie l'id de ce contrat, -1 en cas d'erreur
--				 Vérifie que le contrat puisse être créé pendant la période de validité de l'abonnement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.createContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.createContratLocation
GO

CREATE PROCEDURE dbo.createContratLocation
	@date_debut 			datetime,
	@date_fin 				datetime,
	@id_abonnement 			int
AS
	/*BEGIN TRY
		DECLARE @ABONNEMENT_T TABLE(
			date_debut 					datetime,
			duree						int,
			renouvellement_auto			bit
		)
		DECLARE @date_debut_curseur datetime, @duree_curseur int, @renouvellement_auto_curseur bit;
		
		INSERT INTO @ABONNEMENT_T(date_debut, duree, renouvellement_auto)
			(SELECT date_debut, duree, renouvellement_auto
			FROM Abonnement 
			WHERE id = @id_abonnement);
		
		IF ( (SELECT COUNT(*) FROM @ABONNEMENT_T) = 0 )
		BEGIN
			Print('createContratLocation: aucun abonnement correspondant');
			RETURN -1;
		END
		
		DECLARE abonne_cursor CURSOR
			FOR SELECT * FROM @ABONNEMENT_T
			
		OPEN abonne_cursor
		FETCH NEXT FROM abonne_cursor
			INTO @date_debut_curseur, @duree_curseur, @renouvellement_auto_curseur;
		CLOSE abonne_cursor;
		DEALLOCATE abonne_cursor;
		
		IF ( @date_debut_curseur > @date_debut )
		BEGIN
			Print('createContratLocation: Date de début inférieur à celle de l''abonnement');
			RETURN -1;
		END
		
		IF ( DATEADD(day, @duree_curseur, @date_debut_curseur) < @date_fin AND @renouvellement_auto_curseur = 'false')
		BEGIN
			Print('createContratLocation: Date de fin supérieure à celle de l''abonnement');
			RETURN -1;
		END*/
		
		INSERT INTO ContratLocation (
			date_debut,
			date_fin,
			extension,
			id_abonnement
		)
		VALUES (
			@date_debut,
			@date_fin,
			0,
			@id_abonnement
		);
		--PRINT('createContratLocation créé ' + CAST(SCOPE_IDENTITY() AS CHAR(5)) );
		RETURN SCOPE_IDENTITY();
	/*END TRY
	BEGIN CATCH
		PRINT('createContratLocation: ERROR');
		RETURN -1;
	END CATCH*/
GO
