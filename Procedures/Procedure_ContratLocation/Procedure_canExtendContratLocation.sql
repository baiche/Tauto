------------------------------------------------------------
-- Fichier     : Procedure_canExtendContratLocation
-- Date        : 08/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : indique si nous pouvons étendre la durée du 
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
	-- si il n'existe pas de contrat portant sur un des vehicules lié au contrat location 
	-- de base commencant nb_jours + 1 apres la fin du contrat location de base, on peut
	-- étendre la location, sinon on ne peut pas.
	IF 	
	(SELECT COUNT(*)
	FROM Vehicule v, Location l1,Location l2, ContratLocation cl1 , ContratLocation cl2
	WHERE cl1.id = @id_contrat_location
	AND l1.id <> l2.id
	AND cl1.id <> cl2.id
	AND cl1.id = l1.id_contratLocation
	AND l1.matricule_vehicule = v.matricule
	AND	l2.matricule_vehicule = v.matricule
	AND l2.id_contratLocation = cl2.id
	AND cl1.date_fin < cl2.date_debut
	AND DATEDIFF(DAY, cl1.date_fin, cl2.date_debut) < (@nb_jours + 1)) = 0
	RETURN 1
	ELSE
	RETURN 0
GO