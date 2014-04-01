------------------------------------------------------------
-- Fichier     : associateConducteurToLocation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;
GO

IF OBJECT_ID ('dbo.associateConducteurToLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.associateConducteurToLocation	
GO

CREATE PROCEDURE dbo.associateConducteurToLocation
	@id_location					int, -- FK
	@piece_identite_conducteur		nvarchar(50), -- FK
	@nationalite_conducteur			nvarchar(50) -- FK
AS
	BEGIN TRANSACTION associateConducteurToLocation
	BEGIN TRY
	
		-- les informations concernant le conducteur ne sont pas renseignees
		IF(@piece_identite_conducteur IS NULL OR @nationalite_conducteur IS NULL)
		BEGIN
			PRINT('associateConducteurToLocation: ERROR Les informations concernant le conducteur sont incompletes');
			RETURN -1;
		END

		-- l'identifiant de la location n'est pas renseigne
		IF(@id_location IS NULL)
		BEGIN
			PRINT('associateConducteurToLocation: ERROR L''identifiant de la location n''est pas renseigne');
			RETURN -1;
		END

		IF not exists
			(SELECT 1
			 FROM Conducteur
			 WHERE piece_identite = @piece_identite_conducteur AND nationalite = @nationalite_conducteur
			)	
		BEGIN
			PRINT('associateConducteurToLocation: ERROR Les informations concernant le conducteur sont incorrectes');
			RETURN -1
		END
		
		IF not exists
			(SELECT 1
			 FROM Location
			 WHERE id = @id_location
			)	
		BEGIN
			PRINT('associateConducteurToLocation: ERROR L''identifiant de la location est incorrect');
			RETURN -1
		END
		
		IF exists
			(SELECT 1
			 FROM ConducteurLocation
			 WHERE id_location = @id_location AND
			       piece_identite_conducteur = @piece_identite_conducteur AND
			       nationalite_conducteur = @nationalite_conducteur
			)	
		BEGIN
			PRINT('associateConducteurToLocation: ERROR Le conducteur est deja associe a la location');
			RETURN -1
		END
		
		-- verifier que le conducteur est associe au compte abonne
		
		DECLARE @nom_compteabonne nvarchar(50), @prenom_compteabonne nvarchar(50), @date_naissance_compteabonne date;

		SELECT @nom_compteabonne = a.nom_compteabonne,@prenom_compteabonne = a.prenom_compteabonne, @date_naissance_compteabonne = a.date_naissance_compteabonne
		FROM Location l
		INNER JOIN ContratLocation cl
		ON cl.id = l.id_contratLocation
		INNER JOIN Abonnement a
		ON a.id = cl.id_abonnement
		WHERE l.id = @id_location;

		IF not exists
			(SELECT 1
			 FROM CompteAbonneConducteur
			 WHERE nom_compteabonne = @nom_compteabonne AND
			       prenom_compteabonne = @prenom_compteabonne AND
			       date_naissance_compteabonne = @date_naissance_compteabonne AND
			       piece_identite_conducteur = @piece_identite_conducteur AND
			       nationalite_conducteur = @nationalite_conducteur
			)	
		BEGIN
			EXECUTE dbo.addConducteurToCompteAbonne 
						@nom_compteabonne, @prenom_compteabonne, @date_naissance_compteabonne,
						@piece_identite_conducteur, @nationalite_conducteur;
		END
		
		EXECUTE dbo.addConducteurToLocation @id_location, @piece_identite_conducteur, @nationalite_conducteur;

		COMMIT TRANSACTION associateConducteurToLocation
		PRINT('associateConducteurToLocation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('associateConducteurToLocation: ERROR');
		ROLLBACK TRANSACTION associateConducteurToLocation
		RETURN -1;
	END CATCH
GO
