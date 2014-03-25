------------------------------------------------------------
-- Fichier     : closeVehicule.sql
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : Boris de Finance
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met le vehicule a supprimer si possible
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeVehicule', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeVehicule	
GO

CREATE PROCEDURE dbo.closeVehicule
	@matricule varchar(50)
AS
	BEGIN TRANSACTION closeVehicule	
	DECLARE @msg varchar(4000)
	BEGIN TRY 
		
		--verification de l'argument
		IF(@matricule IS NULL)
		BEGIN
			PRINT('closeVehicule: Le matricule doit etre renseigne');
			ROLLBACK TRANSACTION closeVehicule
			RETURN -1
		END
		
		--est-ce que le vehicule existe
		IF((SELECT COUNT(*)
			FROM Vehicule
			WHERE matricule = @matricule) <> 1)
		BEGIN
			PRINT('closeVehicule: Le vehicule n''existe pas');
			ROLLBACK TRANSACTION closeVehicule
			RETURN -1
		END	
		
		--est ce que le vehicule est deja a supprimer
		IF((SELECT a_supprimer
			FROM Vehicule
			WHERE matricule = @matricule) <> 'false')
		BEGIN
			PRINT('closeVehicule: Le vehicule est deja a supprimer');
			ROLLBACK TRANSACTION closeVehicule
			RETURN -1
		END	
		
		-- le vehicule est-il present dans la table ReservationVehicule
		IF((SELECT COUNT(*)
			FROM ReservationVehicule
			WHERE matricule_vehicule = @matricule) > 0)
		BEGIN
			--TODO : remplacer le vehicule dans ces reservations
			PRINT('closeVehicule: Le vehicule est reserve');
			ROLLBACK TRANSACTION closeVehicule
			RETURN -1
		END
		
		-- le vehicule est-il present dans la table Location
		/*IF((SELECT COUNT(*)
			FROM Location
			WHERE matricule_vehicule = @matricule) > 0)
		BEGIN
			--TODO : la fonction delete doit verifier 
			PRINT('closeVehicule: Le vehicule est loué');
			ROLLBACK TRANSACTION closeVehicule
			RETURN -1
		END
		*/
		-- mise a supprimer du vehicule
		UPDATE Vehicule
		SET a_supprimer = 'true'
		WHERE matricule = @matricule
			
		COMMIT TRANSACTION closeVehicule
		PRINT('closeVehicule OK');
		RETURN 1 		
	END TRY
	BEGIN CATCH
		PRINT 'closeVehicule : Exception recue'
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION closeVehicule
		RETURN -1;
	END CATCH
GO