------------------------------------------------------------
-- Fichier     : closeCategorie.sql
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met la categorie a supprimer si possible
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeCategorie', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeCategorie	
GO

CREATE PROCEDURE dbo.closeCategorie
	@nom varchar(50)
AS
	BEGIN TRANSACTION closeCategorie
	DECLARE @msg varchar(4000)
	BEGIN TRY 
		
		--verification de l'argument
		IF(@nom IS NULL)
		BEGIN
			PRINT('closeCategorie: Le nom de la categorie doit etre renseigne');
			ROLLBACK TRANSACTION closeCategorie
			RETURN -1
		END
		
		--est-ce que la categorie existe
		IF((SELECT COUNT(*)
			FROM Categorie
			WHERE nom = @nom) = 0)
		BEGIN
			PRINT('closeCategorie: La categorie n''existe pas');
			ROLLBACK TRANSACTION closeCategorie
			RETURN -1
		END	
		
		--est ce que la categorie est deja a supprimer
		IF((SELECT a_supprimer
			FROM Categorie
			WHERE nom = @nom) <> 'false')
		BEGIN
			PRINT('closeCategorie: La Categorie est deja a supprimer');
			ROLLBACK TRANSACTION closeCategorie
			RETURN -1
		END	
		
		-- existe-il des Vehicules de ce modele dans la table ReservationVehicule
		IF((SELECT COUNT(*)
			FROM ReservationVehicule rv,Vehicule v,CategorieModele cm
			WHERE cm.nom_categorie=@nom AND rv.matricule_vehicule =v.matricule AND v.marque_modele=cm.marque_modele AND v.serie_modele=cm.serie_modele AND v.portieres_modele=cm.portieres_modele AND v.type_carburant_modele=cm.type_carburant_modele ) > 0)
		BEGIN
			--TODO : remplacer le vehicule dans ces reservations
			PRINT('closeCategorie: Il existe des vehicules dans cette categorie qui sont reserves');
			ROLLBACK TRANSACTION closeCategorie
			RETURN -1
		END
		
		--  existe-il des Vehicules de cette categorie dans la table Location
		IF((SELECT COUNT(*)
			FROM Location,Vehicule v,CategorieModele cm
			WHERE cm.nom_categorie=@nom AND matricule_vehicule =v.matricule AND v.marque_modele=cm.marque_modele AND v.serie_modele=cm.serie_modele AND v.portieres_modele=cm.portieres_modele AND v.type_carburant_modele=cm.type_carburant_modele ) > 0)
		BEGIN
			--TODO : la fonction delete doit verifier 
			PRINT('closeCategorie: Il existe des vehicules dans cette categorie qui sont loues');
			ROLLBACK TRANSACTION closeCategorie
			RETURN -1
		END
		
		-- mise a supprimer du vehicule
		UPDATE Categorie
		SET a_supprimer = 'true'
		WHERE  nom=@nom ;
			
		COMMIT TRANSACTION closeCategorie
		PRINT('closeCategorie OK');
		RETURN 1 		
	END TRY
	BEGIN CATCH
		PRINT 'closeCategorie : Exception recue'
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION closeCategorie
		RETURN -1;
	END CATCH
GO