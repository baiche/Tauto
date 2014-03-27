------------------------------------------------------------
-- Fichier     : ProcedureAnnexe.sql
-- Date        : 12/03/2014
-- Version     : 1.0
-- Auteur      : Seyyid Ouir
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : procedure "videTables" : Vider toutes les tables
------------------------------------------------------------


USE TAuto_IBDR;
GO

PRINT('Procédure Annexe')
PRINT('================');

IF EXISTS (SELECT name FROM  sysobjects WHERE name = 'videTables' AND type = 'P')
BEGIN
    DROP PROCEDURE dbo.videTables
	PRINT('Procédure dbo.videTables supprimée');
END
GO

CREATE PROCEDURE dbo.videTables
AS
BEGIN
	PRINT('Vider toutes les tables - Debut');
	PRINT('===============================');
	
	SET NOCOUNT  ON  

	DELETE FROM ReservationVehicule
	DELETE FROM CatalogueCategorie
	DELETE FROM CategorieModele
	DELETE FROM ConducteurLocation
	DELETE FROM CompteAbonneConducteur
	DELETE FROM Catalogue
	DELETE FROM Categorie
	DELETE FROM SousPermis
	DELETE FROM Conducteur
	DELETE FROM Permis
	DELETE FROM Reservation
	DELETE FROM Infraction
	DELETE FROM Incident
	DELETE FROM Retard
	DELETE FROM Location
	DELETE FROM Vehicule
	DELETE FROM Modele
	DELETE FROM ContratLocation
	DELETE FROM Abonnement
	DELETE FROM TypeAbonnement
	DELETE FROM RelanceDecouvert
	DELETE FROM Particulier
	DELETE FROM Entreprise
	DELETE FROM CompteAbonne
	DELETE FROM Facturation
	DELETE FROM Etat
	DELETE FROM ListeNoire
	
	SET NOCOUNT OFF  
	
	PRINT('Vider toutes les tables - Fin');
	PRINT('=============================');
END
GO

PRINT('Procédure dbo.videTables créée.')
GO
