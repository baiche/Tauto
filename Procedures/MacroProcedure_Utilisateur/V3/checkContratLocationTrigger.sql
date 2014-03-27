------------------------------------------------------------
-- Fichier     : checkContratLocationTrigger.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Vérifie que tous les véhcules du contrat de location sont de retour.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.checkContratLocationTrigger') IS NOT NULL
	DROP PROCEDURE dbo.checkContratLocationTrigger	
GO

CREATE PROCEDURE dbo.checkContratLocationTrigger
AS
	DECLARE @date_recep date;
	DECLARE @idFac int;
	DECLARE @idLoc int;
	DECLARE @idConLoc int;
	DECLARE @niveau int;
	DECLARE @courriel nvarchar(50);
	
	DECLARE @LocRetard_T TABLE(
		id_location int,
		id_contratLoc int
	);
	
	INSERT INTO @LocRetard_T(id_location, id_contratLoc)
		(SELECT l.id, l.id_contratLocation FROM Location l WHERE		
			EXISTS (SELECT * FROM ContratLocation cl WHERE
							cl.date_fin_effective IS NULL
						AND DATEADD(day, cl.extension, cl.date_fin) > GETDATE()
						AND l.id_contratLocation = cl.id)
			AND NOT EXISTS (SELECT * FROM Retard r WHERE r.id_location = l.id));
			
	DECLARE Loc_cursor CURSOR
		FOR SELECT * FROM @LocRetard_T;
	OPEN Loc_cursor;
	
	FETCH NEXT FROM Loc_cursor
		INTO @idLoc, @idConLoc;
		
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @courriel = ca.courriel FROM CompteAbonne ca, Abonnement a, ContratLocation cl WHERE
				ca.nom = a.nom_compteabonne
			AND ca.prenom = a.prenom_compteabonne
			AND ca.date_naissance = a.date_naissance_compteabonne
			AND cl.id_abonnement = a.id
			AND cl.id = @idConLoc;
		INSERT INTO Retard(id_location)
			VALUES(@idLoc);
		PRINT('Retard: message #1 envoye a ');
		PRINT @courriel;
		PRINT (', location ');
		PRINT @idLoc;
		PRINT('\n');
			
		FETCH NEXT FROM Loc_cursor
			INTO @idLoc, @idConLoc;
	END
	
	CLOSE Loc_cursor;
	DEALLOCATE Loc_cursor;

GO

IF OBJECT_ID ('dbo.checkContratLocationTriggerRec', 'P') IS NOT NULL
	DROP PROCEDURE dbo.checkContratLocationTriggerRec	
GO

CREATE PROCEDURE dbo.checkContratLocationTriggerRec
AS
	DECLARE @date_recep date;
	DECLARE @idFac int;
	DECLARE @idLoc int;
	DECLARE @idConLoc int;
	DECLARE @niveau int;
	DECLARE @courriel nvarchar(50);
	
	DECLARE @Retard_T TABLE(
		courriel nvarchar(50),
		niveau int,
		id_location int
	);
	
	INSERT INTO @Retard_T(courriel, niveau, id_location)
		(SELECT ca.courriel, r.niveau, r.id_location FROM CompteAbonne ca, Abonnement a, ContratLocation cl, Location l, Retard r WHERE
				ca.nom = a.nom_compteabonne
			AND ca.prenom = a.prenom_compteabonne
			AND ca.date_naissance = a.date_naissance_compteabonne
			AND cl.id_abonnement = a.id
			AND cl.id = l.id_contratLocation
			AND r.id_location = l.id);
			
	DECLARE Retard_cursor CURSOR
		FOR SELECT * FROM @Retard_T;
	OPEN Retard_cursor;
	
	FETCH NEXT FROM Retard_cursor
		INTO @courriel, @niveau, @idLoc;
		
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @niveau = niveau FROM Retard WHERE id_location = @idLoc;
		SET @niveau += 1;
		IF @niveau < 6
		BEGIN
			UPDATE Retard
			SET niveau = @niveau
			WHERE id_location = @idLoc;
			
			PRINT('Retard: message #');
			PRINT @niveau;
			PRINT(' envoye a ');
			PRINT @courriel;
		END
		ELSE
		BEGIN
			PRINT('Niveau 6 atteint, que fait-on ?');
		END
		PRINT('\n');
		FETCH NEXT FROM Retard_cursor
			INTO @courriel, @niveau, @idLoc;
	END
	
	CLOSE Retard_cursor;
	DEALLOCATE Retard_cursor;
GO