
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
