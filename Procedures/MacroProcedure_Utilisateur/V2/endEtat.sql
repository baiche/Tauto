------------------------------------------------------------
-- Fichier     : endEtat.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met fin à un état non terminé
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.endEtat', 'P') IS NOT NULL
	DROP PROCEDURE dbo.endEtat	
GO

CREATE PROCEDURE dbo.endEtat
	@idContratLocation	int, -- FK
	@matricule			nvarchar(50), -- FK
	@date_apres	 		datetime, -- nullable
	@km_apres 			int,
	@fiche_apres		nvarchar(50),
	@degat 				bit, -- nullable, mettre faux si rien n'est indiqué
	@vehicule_statut	nvarchar(50) -- nullable, met dispo par défaut
AS
	BEGIN TRANSACTION endEtat
	BEGIN TRY
		DECLARE @id_Loc int, @idEtat int, @date_av datetime, @date_ap datetime, @km_ap int, @fiche_ap nvarchar(50), @diffDay int, @prix money, @idFac int, @nbIntePenal int, @sumInfra int;
		
		SELECT @id_Loc = id, @idEtat = id_etat FROM Location WHERE matricule_vehicule = @matricule AND id_contratLocation = @idContratLocation;
				
		IF @id_Loc IS NULL
		BEGIN
			RAISERROR('Location pas trouvee', 10, -1);
			RETURN -1;
		END
			
		IF @idEtat IS NULL
		BEGIN
			RAISERROR('Etat inexistant', 10, -1);
			RETURN -1;
		END		
		
		SELECT @date_ap = date_apres, @km_ap = km_apres, @fiche_ap = fiche_apres, @date_av = date_avant FROM Etat WHERE id = @idEtat;
		
		IF @date_ap IS NOT NULL OR @km_ap IS NOT NULL OR @fiche_ap NOT LIKE ''
		BEGIN
			RAISERROR('Etat deja termine', 10, -1);
			RETURN -1;
		END
			
		IF @km_apres < (SELECT km_avant FROM Etat WHERE id = @idEtat)
		BEGIN
			RAISERROR('Kilometrage moins eleve que prevu', 10, -1);
			RETURN -1;
		END
		
		IF @degat IS NULL
			SET @degat = 'false';
			
		IF @date_apres IS NULL
			SET @date_apres = GETDATE();
			
		IF @vehicule_statut IS NULL
			SET @vehicule_statut = 'Disponible';
			
		IF @vehicule_statut IN ('En panne', 'Perdue')
			EXEC dbo.findOtherVehicule
				@matricule = @matricule,
				@itMustBeDone = 'true',
				@date_fin = NULL;
		
		EXEC dbo.updateEtat
			@id = @idEtat,
			@date_apres = @date_apres,
			@km_apres = @km_apres,
			@fiche_apres = @fiche_apres,
			@degat = @degat;
			
		EXEC dbo.setKilometrageVehicule
			@matricule = @matricule,
			@kilometrage = @km_apres;
		
		EXEC dbo.setStatutVehicule
			@matricule = @matricule,
			@statut = @vehicule_statut;
			
		SELECT @diffDay = DATEDIFF(day, @date_av, @date_apres);
		SET @prix = @diffDay * (SELECT prix FROM TypeAbonnement WHERE nom = 
			(SELECT nom_typeabonnement FROM Abonnement WHERE id =
				(SELECT id_abonnement FROM ContratLocation WHERE id = @idContratLocation)))

		SET @sumInfra = 0;
		SELECT @sumInfra = SUM(montant) FROM Infraction WHERE id_location = @id_Loc AND regle = 'false';
		SELECT @nbIntePenal = COUNT(*) FROM Incident WHERE id_location = @id_Loc AND penalisable = 'true';
		
		IF @sumInfra IS NULL
			SET @sumInfra = 0;
		
		SET @prix += (50.0*@nbIntePenal) + @sumInfra;
		
		EXEC @idFac = dbo.createFacturation
			@montant = @prix;
		
		UPDATE Location
		SET id_facturation = @idFac
		WHERE id = @id_Loc;
			
		COMMIT TRANSACTION endEtat
		PRINT('endEtat OK');
		RETURN @idEtat;
	END TRY
	BEGIN CATCH
		PRINT('endEtat: ERROR');
		ROLLBACK TRANSACTION endEtat
		RETURN -1;
	END CATCH
GO