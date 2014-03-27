------------------------------------------------------------
-- Fichier     : 4_declencheurs
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Script d'ajout des triggers de la base
------------------------------------------------------------

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

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
