------------------------------------------------------------
-- Fichier     : makeReservation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : David Lecoconnier
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Renvoie l'id de la réservation, -1 en cas d'erreur
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeReservation	
GO

CREATE PROCEDURE dbo.makeReservation
	@id_abonnement			int, -- FK
	@date_debut				dateTime,
	@date_fin				dateTime,
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint -- PK
AS
	
	BEGIN TRANSACTION makeReservation
	BEGIN TRY
		DECLARE @ReturnValue int;
		DECLARE @return INT ;
		DECLARE @matricule VARCHAR(50);
		DECLARE @matricule_disponible VARCHAR(50);
		SET @matricule_disponible = '0';
			
		 -- verifier s'il a le droit d'emprunter
		IF (SELECT COUNT(*) FROM ListeNoire ln,Abonnement a WHERE a.nom_compteabonne=ln.nom AND a.prenom_compteabonne=ln.prenom AND a.date_naissance_compteabonne=ln.date_naissance ) !=0
		BEGIN
			PRINT('vous ne pouvez pas reserver vous etes en liste noire')
			return -1;
		END
		ELSE
			
		BEGIN

		-- verifier si on a un vehicule disponible
			DECLARE ListeVoiture CURSOR LOCAL  
			FOR SELECT matricule 
			FROM Vehicule  
			WHERE marque_modele=@marque AND serie_modele=@serie AND portieres_modele=@portieres AND type_carburant_modele=@type_carburant AND a_supprimer='false';  
			
			
			OPEN ListeVoiture
			FETCH NEXT FROM ListeVoiture INTO @matricule;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
			
				IF (SELECT v.statut FROM Vehicule v WHERE v.matricule=@matricule)='Disponible'
				BEGIN
					
					SET @matricule_disponible=@matricule;
				
					BREAK;
				END
			
			FETCH NEXT FROM ListeVoiture INTO @matricule 
			END 
			
			CLOSE ListeVoiture;
			
			IF @matricule_disponible ='0'
			BEGIN
				PRINT('Aucun vehicule disponible')
				return -1;
			END 
			ELSE 
			BEGIN
			 
			-- creer la reservation
			-- 
			EXEC @return=dbo.isDisponible1 @matricule_disponible,@date_debut,@date_fin ;
			
			IF (@return =1 ) 
			BEGIN 
				
				EXEC @ReturnValue = dbo.createReservation
					@date_debut, @date_fin, @id_abonnement;
				EXEC dbo.addVehiculeToReservation
					@ReturnValue, @matricule_disponible ;
			END
			END 
		END
	 
		COMMIT TRANSACTION makeReservation
		PRINT('makeReservation OK');
		RETURN @ReturnValue;
	END TRY
	BEGIN CATCH
		PRINT('makeReservation: ERROR');
		ROLLBACK TRANSACTION makeReservation
		RETURN -1;
	END CATCH
GO