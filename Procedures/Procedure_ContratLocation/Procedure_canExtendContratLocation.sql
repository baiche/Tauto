------------------------------------------------------------
-- Fichier     : Procedure_canExtendContratLocation
-- Date        : 08/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : indique si nous pouvons �tendre la dur�e du 
--				 contratLocation pour n jours.
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.canExtendContratLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.canExtendContratLocation;
GO

CREATE PROCEDURE dbo.canExtendContratLocation
	@id_contrat_location	int,
	@nb_jours				int
AS
	-- si il n'existe pas de contrat portant sur un des vehicules li� au contrat location 
	-- de base commencant nb_jours + 1 apres la fin du contrat location de base, on peut
	-- �tendre la location, sinon on ne peut pas.
	IF 	
	(SELECT COUNT(*)
	FROM Vehicule v, Location l1, ContratLocation cl1 , ReservationVehicule rv, Reservation r
	WHERE cl1.id = @id_contrat_location
	AND cl1.id = l1.id_contratLocation
	AND l1.matricule_vehicule = v.matricule
	AND v.matricule =  rv.matricule_vehicule
	AND rv.id_reservation = r.id
	AND r.annule = 'false'
	AND cl1.date_fin < r.date_debut
	AND DATEDIFF(DAY, cl1.date_fin, r.date_debut) < (@nb_jours + 1)) = 0
	RETURN 1
	ELSE
	RETURN 0
GO