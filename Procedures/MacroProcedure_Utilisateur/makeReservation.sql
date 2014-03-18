------------------------------------------------------------
-- Fichier     : makeReservation.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Baiche Mourad
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.makeReservation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.makeReservation	
GO

CREATE PROCEDURE dbo.makeReservation
	@id_abonnement			int, -- FK
	@marque 				nvarchar(50), -- PK
	@serie 					nvarchar(50), -- PK
	@type_carburant 		nvarchar(50), -- PK
	@portieres 				tinyint -- PK
AS
	BEGIN TRANSACTION makeReservation
	BEGIN TRY
	 DECLARE @matricule =0
	 -- verifier s'il a le droit d'emprunter
	IF (SELECT COUNT(*) FROM ListeNoire ln,Abonnement a WHERE a.nom_compteabonne=ln.nom AND a.prenom_compteabonne=ln.prenom AND a.date_naissance_compteabonne=ln.date_naissance ) !=0
	BEGIN
		PRINT('vous ne pouvez pas reserver vous etes en liste noire')
		return -1;
	END
	ELSE
	BEGIN
		
		DECLARE @ListeVoiture;
		SELECT @ListeVoiture=* FROM Vehicule v WHERE v.marque_modele=@marque AND v.serie_modele=@serie AND v.portieres_modele=@portieres AND v.type_carburant_modele=@type_carburant AND
		v.a_supprimer='false';  
		
		
		
	END
	 -- creer la reservation
	 -- 
		COMMIT TRANSACTION makeReservation
		PRINT('makeReservation OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('makeReservation: ERROR');
		ROLLBACK TRANSACTION makeReservation
		RETURN -1;
	END CATCH
GO