------------------------------------------------------------
-- Fichier     : closeCatalogue.sql
-- Date        : 25/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Met la catalogue a supprimer si possible
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.closeCatalogue', 'P') IS NOT NULL
	DROP PROCEDURE dbo.closeCatalogue	
GO

CREATE PROCEDURE dbo.closeCatalogue
	@nom varchar(50)
AS
	BEGIN TRANSACTION closeCatalogue
	DECLARE @msg varchar(4000)
	BEGIN TRY 
		
		--verification de l'argument
		IF(@nom IS NULL)
		BEGIN
			PRINT('closeCatalogue: Le nom du catalogue doit etre renseigne');
			ROLLBACK TRANSACTION closeCatalogue
			RETURN -1
		END
		
		--est-ce que le catalogue existe
		IF((SELECT COUNT(*)
			FROM Catalogue
			WHERE nom = @nom) = 0)
		BEGIN
			PRINT('closeCatalogue: Le Catalogue n''existe pas');
			ROLLBACK TRANSACTION closeCatalogue
			RETURN -1
		END	
		
		--est ce que le catalogue est deja a supprimer
		IF((SELECT a_supprimer
			FROM Catalogue
			WHERE nom = @nom) <> 'false')
		BEGIN
			PRINT('closeCatalogue: Le Catalogue est deja a supprimer');
			ROLLBACK TRANSACTION closeCatalogue
			RETURN -1
		END	
		
		-- existe-il des Vehicules ce catalogue dans la table ReservationVehicule
		IF((SELECT COUNT(*)
			FROM ReservationVehicule rv,Vehicule v,CategorieModele cm,CatalogueCategorie cc
			WHERE cc.nom_catalogue=@nom AND cm.nom_categorie=cc.nom_categorie AND rv.matricule_vehicule =v.matricule AND v.marque_modele=cm.marque_modele AND v.serie_modele=cm.serie_modele AND v.portieres_modele=cm.portieres_modele AND v.type_carburant_modele=cm.type_carburant_modele ) > 0)
		BEGIN
			--TODO : remplacer le vehicule dans ces reservations
			PRINT('closeCatalogue: Il existe des vehicules dans cette categorie qui sont reserves');
			ROLLBACK TRANSACTION closeCatalogue
			RETURN -1
		END
		
		--  existe-il des Vehicules de ce catalogue dans la table Location
		IF((SELECT COUNT(*)
			FROM Location,Vehicule v,CategorieModele cm,CatalogueCategorie cc
			WHERE cc.nom_catalogue=@nom AND cm.nom_categorie=cc.nom_categorie AND matricule_vehicule =v.matricule AND v.marque_modele=cm.marque_modele AND v.serie_modele=cm.serie_modele AND v.portieres_modele=cm.portieres_modele AND v.type_carburant_modele=cm.type_carburant_modele ) > 0)
		BEGIN
			--TODO : la fonction delete doit verifier 
			PRINT('closeCatalogue: Il existe des vehicules dans ce catalogue qui sont loues');
			ROLLBACK TRANSACTION closeCatalogue
			RETURN -1
		END
		
		-- mise a supprimer du Catalogue
		UPDATE Catalogue
		SET a_supprimer = 'true'
		WHERE  nom=@nom ;
			
		COMMIT TRANSACTION closeCatalogue
		PRINT('closeCatalogue OK');
		RETURN 1 		
	END TRY
	BEGIN CATCH
		PRINT 'closeCatalogue : Exception recue'
		SET @msg = ERROR_MESSAGE()
		PRINT(@msg)
		ROLLBACK TRANSACTION closeCatalogue
		RETURN -1;
	END CATCH
GO