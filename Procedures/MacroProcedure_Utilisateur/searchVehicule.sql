------------------------------------------------------------
-- Fichier     : searchVehicule.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Alexis Deluze
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Retourne une table de Vehicules en fonction
--               de plusieurs paramètres de recherche.
------------------------------------------------------------

USE TAuto_IBDR;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
IF OBJECT_ID(N'[dbo].[searchVehicule]', 'TF') IS NOT NULL 
    DROP FUNCTION [dbo].[searchVehicule]
GO
  
  
CREATE FUNCTION [dbo].[searchVehicule] (
	@nom_categorie			nvarchar(50),
	@marque 				nvarchar(50),
	@serie 					nvarchar(50),
	@type_carburant 		nvarchar(50),
	@portieres 				tinyint,
	@prix_max 				money,
	@prix_min 				money,
	@date_debut 			date,
	@date_fin 				date,
	@couleur				nvarchar(50)
)
RETURNS @returnTable TABLE (
	matricule 				nvarchar(50) 	PRIMARY KEY,
	kilometrage 			int,
	couleur 				nvarchar(50),
	statut 					nvarchar(50),
	num_serie				nvarchar(50),				
	marque_modele 			nvarchar(50),
	serie_modele 			nvarchar(50),
	portieres_modele 		tinyint,
	date_entree				date,
	type_carburant_modele	nvarchar(50),
	a_supprimer 			bit
)
AS
BEGIN
	INSERT @returnTable
		SELECT * 
		FROM Vehicule v
		WHERE (@marque IS NULL OR v.marque_modele = @marque)
			AND (@serie IS NULL OR v.serie_modele = @serie)
			AND (@type_carburant IS NULL OR v.type_carburant_modele = @type_carburant)
			AND (@portieres IS NULL OR v.portieres_modele = @portieres)
			AND (@couleur IS NULL OR v.couleur = @couleur)
			AND (v.a_supprimer = 'false')
			AND (v.statut <> 'Perdue')
	
	DECLARE @matricule_courant nvarchar(50)
	DECLARE @statut_courant nvarchar(50)
	DECLARE @isDispo INT;
	DECLARE Curseur_vehicule CURSOR LOCAL FOR
		SELECT matricule,statut FROM @returnTable
	OPEN Curseur_vehicule
		FETCH NEXT FROM Curseur_vehicule 
			INTO @matricule_courant, @statut_courant					
		WHILE @@FETCH_STATUS=0
		BEGIN
			IF @statut_courant = 'Perdue'
			BEGIN
				DELETE FROM @returnTable where matricule = @matricule_courant;
			END
			
			IF @statut_courant = 'En panne'
			BEGIN
				DELETE FROM @returnTable where matricule = @matricule_courant;
			END
			
			IF @statut_courant = 'Louee'
			BEGIN
				DECLARE @DateFinLocation datetime;
				SELECT @DateFinLocation = cl.date_fin 
				FROM Location l
				INNER JOIN ContratLocation cl
				ON l.id_contratLocation = cl.id
				WHERE l.matricule_vehicule = @matricule_courant AND cl.date_fin >= @date_debut;
				
				IF (@DateFinLocation IS NOT NULL)	
				BEGIN
					DELETE FROM @returnTable where matricule = @matricule_courant;
				END
			END
		
			IF EXISTS
				(SELECT 1
				FROM ReservationVehicule rv
				INNER JOIN Reservation r
				ON rv.id_reservation = r.id
				WHERE 
					rv.matricule_vehicule = @matricule_courant
					AND (r.date_debut BETWEEN @date_debut AND @date_fin
					OR r.date_fin BETWEEN @date_debut AND @date_fin
					OR (r.date_debut <= @date_debut AND r.date_fin >= @date_fin))
				)
			BEGIN
				DELETE FROM @returnTable where matricule = @matricule_courant;
			END
			
			FETCH NEXT FROM Curseur_vehicule
			INTO	@matricule_courant,
					@statut_courant
		END
		CLOSE Curseur_vehicule
    RETURN
END