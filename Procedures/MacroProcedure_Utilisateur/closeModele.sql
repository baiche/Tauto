------------------------------------------------------------
-- Fichier     : closeModele.sql
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met le Modele a supprimer si possible
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeModele', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeModele	
GO

CREATE PROCEDURE dbo.closeModele
	@marque varchar(50),
	@serie varchar(50),
	@type_carburant varchar(50),
	@portiere int
AS
	BEGIN TRANSACTION closeModele
	DECLARE @msg varchar(4000)
	BEGIN TRY 
		
		--verification de l'argument
		IF(@marque IS NULL)
		BEGIN
			PRINT('closeModele: La marque doit etre renseigne');
			ROLLBACK TRANSACTION closeModele
			RETURN -1
		END
		
		--est-ce que le Modele existe
		IF((SELECT COUNT(*)
			FROM Modele
			WHERE marque = @marque AND serie=@serie AND type_carburant=@type_carburant AND portieres=@portiere) = 0)
		BEGIN
			PRINT('closeModele: Le Modele n''existe pas');
			ROLLBACK TRANSACTION closeModele
			RETURN -1
		END	
		
		--est ce que le Modele est deja a supprimer
		IF((SELECT a_supprimer
			FROM Modele
			WHERE marque = @marque AND serie=@serie AND type_carburant=@type_carburant AND portieres=@portiere) <> 'false')
		BEGIN
			PRINT('closeModele: Le Modele est deja a supprimer');
			ROLLBACK TRANSACTION closeModele
			RETURN -1
		END	
		
		-- existe-il des Vehicules de ce modele dans la table ReservationVehicule
		IF((SELECT COUNT(*)
			FROM ReservationVehicule rv,Vehicule v
			WHERE rv.matricule_vehicule =v.matricule AND v.marque_modele=@marque AND v.serie_modele=@serie AND v.portieres_modele=@portiere AND v.type_carburant_modele=@type_carburant ) > 0)
		BEGIN
			--TODO : remplacer le vehicule dans ces reservations
			PRINT('closeModele: Il existe des vehicules de ce modele qui sont reserves');
			ROLLBACK TRANSACTION closeModele
			RETURN -1
		END
		
		--  existe-il des Vehicules de ce modele dans la table Location
		IF((SELECT COUNT(*)
			FROM Location,Vehicule v
			WHERE matricule_vehicule =v.matricule AND v.marque_modele=@marque AND v.serie_modele=@serie AND v.portieres_modele=@portiere AND v.type_carburant_modele=@type_carburant ) > 0)
		BEGIN
			--TODO : la fonction delete doit verifier 
			PRINT('closeModele: Le vehicule est loué');
			ROLLBACK TRANSACTION closeModele
			RETURN -1
		END
		
		-- mise a supprimer du vehicule
		UPDATE Modele
		SET a_supprimer = 'true'
		WHERE  marque = @marque AND serie=@serie AND type_carburant=@type_carburant AND portieres=@portiere;
			
		COMMIT TRANSACTION closeModele
		PRINT('closeModele OK');
		RETURN 1 		
	END TRY
	BEGIN CATCH
		PRINT 'closeModele : Exception recue'
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION closeModele
		RETURN -1;
	END CATCH
GO