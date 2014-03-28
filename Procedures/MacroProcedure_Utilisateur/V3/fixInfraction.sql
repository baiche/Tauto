------------------------------------------------------------
-- Fichier     : fixInfraction.sql
-- Date        : 27/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad & Neti Mohamed
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.fixInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.fixInfraction	
GO

CREATE PROCEDURE dbo.fixInfraction
	@matricule				nvarchar(50), -- FK
	@nom_conducteur			nvarchar(50),
	@prenom_conducteur		varchar(50),
	@somme					int,
	@nbPoint				int,
	@date					datetime
	
AS
	BEGIN TRANSACTION fixInfraction
	BEGIN TRY
	
	DECLARE		@id_location		INT,
				@nom_Infraction		varchar(50),
				@description		varchar(50),
				@montant			money,
				@regle				bit,
				@nom				varchar(50),
				@prenom				varchar(50),
				@date_naissance		date,
				@id_permis			nvarchar(50),
				@nb_point_new		int,
				@nb_point_avant		int;
				
		SET @id_location = (SELECT l.id FROM Location l,Infraction i 
										WHERE l.matricule_vehicule=@matricule 
										AND  l.id=i.id_location
										AND i.date = @date);
										
		SELECT @nom_Infraction = nom, @description=description, @montant = montant, @regle = regle   FROM Infraction WHERE date = @date
																													 AND   id_location = @id_location;
										
		IF(@somme<>@montant)
		BEGIN 
		PRINT('fixInfraction: ERROR le montant n''est pas valide');
		ROLLBACK TRANSACTION fixInfraction
		RETURN -1;
		END 
				
		UPDATE Infraction SET regle='true',montant=0 WHERE date = @date			
										   AND id_location = @id_location;
										 				
		SELECT @nom=a.nom_compteabonne, @prenom=a.prenom_compteabonne, @date_naissance=a.date_naissance_compteabonne  FROM Abonnement a, ContratLocation cl, Location l
																													  WHERE l.id = @id_location
																													  AND   cl.id = l.id_contratLocation
																													  AND   a.id = cl.id_abonnement;
		
		SET @id_permis = (SELECT id_permis FROM Conducteur c, ConducteurLocation cl   WHERE nom = @nom_conducteur
																					   AND	 prenom = @prenom_conducteur
																					   AND   cl.id_location = @id_location
																					   AND   cl.piece_identite_conducteur = c.piece_identite
																					   AND   cl.nationalite_conducteur = c.nationalite);
		
		SET @nb_point_avant = (SELECT points_estimes FROM Permis WHERE numero = @id_permis);
		SET @nb_point_new = @nb_point_avant - @nbPoint;
													    					
		UPDATE Permis SET points_estimes=@nb_point_new WHERE numero = @id_permis;
		SET @nb_point_avant = (SELECT points_estimes FROM Permis WHERE numero = @id_permis);


		COMMIT TRANSACTION fixInfraction
		PRINT('fixInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('fixInfraction: ERROR');
		ROLLBACK TRANSACTION fixInfraction
		RETURN -1;
	END CATCH
GO