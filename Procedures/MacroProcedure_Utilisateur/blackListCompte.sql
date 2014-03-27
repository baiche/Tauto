------------------------------------------------------------
-- Fichier     : blackListCompte.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.blackListCompte', 'P') IS NOT NULL
	DROP PROCEDURE dbo.blackListCompte	
GO

CREATE PROCEDURE dbo.blackListCompte
	@nom 				nvarchar(50), -- PK
	@prenom 			nvarchar(50), -- PK
	@date_naissance 	date -- PK
AS
	BEGIN TRANSACTION blackListCompte
	BEGIN TRY
	
		IF(@nom IS NULL OR @prenom IS NULL OR @date_naissance IS NULL)
		BEGIN
			PRINT('declareConducteur: ERROR Les informations concernant le compte abonne sont incompletes');
			ROLLBACK TRANSACTION blackListCompte
			RETURN -1;
		END
		
		DECLARE @IsInBlackList int;

		EXEC @IsInBlackList = dbo.isInListeNoire @nom, @prenom, @date_naissance;
		
		IF(@IsInBlackList = 1)
		BEGIN
			PRINT('declareConducteur: ERROR Il est deja en liste noire');
			ROLLBACK TRANSACTION blackListCompte
			RETURN -1;
		END
		
		-- ajouter dans la liste noire
		EXECUTE dbo.createListeNoire @date_naissance, @nom, @prenom;

		-- desactiver le compte
		UPDATE CompteAbonne
		SET actif = 0
		WHERE nom = @nom AND prenom = @prenom AND date_naissance = @date_naissance;
		
		-- a_supprimer pour RelanceDecouvert
		UPDATE RelanceDecouvert
		SET a_supprimer = 1
		WHERE nom_compteabonne = @nom AND prenom_compteabonne = @prenom AND date_naissance_compteabonne = @date_naissance;
		
		CREATE TABLE #Temp(id_reservation int);
		INSERT INTO #Temp(id_reservation)
			SELECT r.id 
			FROM Reservation r
			INNER JOIN Abonnement a
			ON a.id = r.id_abonnement
			WHERE a.nom_compteabonne = @nom AND a.prenom_compteabonne = @prenom AND a.date_naissance_compteabonne = @date_naissance
		
		-- annuler les reservation
		UPDATE Reservation SET annule = 1, a_supprimer = 1 WHERE id in (select id_reservation from #Temp);

		-- liberer les voitures reservees
		DELETE FROM ReservationVehicule WHERE id_reservation in (select id_reservation from #Temp);
		
		DROP Table #Temp;
		
		COMMIT TRANSACTION blackListCompte
		PRINT('blackListCompte OK');
		RETURN 1;
		
	END TRY
	BEGIN CATCH
		PRINT('blackListCompte: ERROR');
		ROLLBACK TRANSACTION blackListCompte
		RETURN -1;
	END CATCH
GO
