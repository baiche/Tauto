------------------------------------------------------------
-- Fichier     : checkImpayeTrigger.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.checkImpayeTrigger') IS NOT NULL
	DROP TRIGGER dbo.checkImpayeTrigger	
GO

CREATE TRIGGER dbo.checkImpayeTrigger
ON Location
AFTER UPDATE
AS
	DECLARE @date_recep date;
	DECLARE @date_crea date;
	DECLARE @idFac int;
	DECLARE @idConLoc int;
	DECLARE @courriel nvarchar(50);
	DECLARE @nom nvarchar(50);
	DECLARE @prenom nvarchar(50);
	DECLARE @date_naissance date;
	DECLARE @date_ datetime;
	
	SELECT @idConLoc = id_contratLocation, @idFac = id_facturation
	FROM inserted;
	
	IF @idFac IS NULL
		RETURN;
	
	SELECT @date_recep = date_reception, @date_crea = date_creation
	FROM Facturation
	WHERE @idFac = id;
	
	--SELECT @idConLoc = id_contratLocation FROM Location WHERE id_facturation = @idFac;
	
	SELECT @courriel = ca.courriel, @prenom = ca.prenom, @nom = ca.nom, @date_naissance = ca.date_naissance
	FROM CompteAbonne ca, Abonnement a, ContratLocation cl
	WHERE	ca.nom = a.nom_compteabonne
		AND ca.prenom = a.prenom_compteabonne
		AND ca.date_naissance = a.date_naissance_compteabonne
		AND cl.id_abonnement = a.id
		AND cl.id = @idConLoc;
	
	IF @date_recep IS NULL
	BEGIN
		IF NOT EXISTS (SELECT * FROM RelanceDecouvert WHERE nom_compteabonne = @nom AND prenom_compteabonne = @prenom AND date_naissance_compteabonne = @date_naissance AND date = GETDATE())
		BEGIN
			EXEC dbo.createRelanceDecouvert
				@nom, @prenom, @date_naissance;
			PRINT 'Relance #0 cree - ' + @courriel;
		END
	END
	ELSE
	BEGIN
		SELECT @date_ = date
		FROM RelanceDecouvert
		WHERE  nom_compteabonne = @nom
			AND prenom_compteabonne = @prenom
			AND date_naissance_compteabonne = @date_naissance
			AND DATEDIFF(day, date, @date_crea) = 0;
		EXEC dbo.disableRelanceDecouvert
			@nom, @prenom, @date_naissance, @date_;
	END
GO


IF OBJECT_ID ('dbo.checkImpayeTriggerRec') IS NOT NULL
	DROP PROCEDURE dbo.checkImpayeTriggerRec	
GO

CREATE PROCEDURE dbo.checkImpayeTriggerRec
AS
	DECLARE @idFac int;
	DECLARE @niveau int;
	DECLARE @courriel nvarchar(50);
	DECLARE @nom nvarchar(50);
	DECLARE @prenom nvarchar(50);
	DECLARE @date_naissance date;
	DECLARE @date_ datetime;
	DECLARE @a_supprimer bit;
			
	DECLARE Impaye_cursor CURSOR
		FOR SELECT * FROM RelanceDecouvert;
	OPEN Impaye_cursor;
	FETCH NEXT FROM Impaye_cursor
		INTO @date_, @nom, @prenom, @date_naissance, @niveau, @a_supprimer; 
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @a_supprimer = 'false'
		BEGIN
			IF @niveau < 5
			BEGIN
				SELECT @courriel = courriel FROM CompteAbonne WHERE nom = @nom AND prenom = @prenom AND date_naissance = @date_naissance;
				EXEC dbo.updateNiveauRelanceDecouvert
					@nom, @prenom, @date_naissance, @date_;
				PRINT 'Niveau de relance incremente pour ' + @nom + N' ' + @prenom;
				PRINT 'Message envoye a l''adresse ' + @courriel + ', niveau ' + CAST(@niveau AS nvarchar(2));
			END
			ELSE
			BEGIN
				PRINT N'Niveau 5 atteint, ' + @nom + N' ' + @prenom + N' mis en liste grise';
				EXEC dbo.greyListCompteAbonne
					@nom, @prenom, @date_naissance;
				EXEC dbo.disableRelanceDecouvert
					@nom, @prenom, @date_naissance, @date_;
			END
		END
		PRINT '';
		FETCH NEXT FROM Impaye_cursor
			INTO @date_, @nom, @prenom, @date_naissance, @niveau, @a_supprimer; 
	END
	
	CLOSE Impaye_cursor;
	DEALLOCATE Impaye_cursor;
GO