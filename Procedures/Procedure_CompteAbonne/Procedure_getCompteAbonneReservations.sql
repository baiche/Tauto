------------------------------------------------------------
-- Fichier     : Procedure_getCompteAbonneReservations
-- Date        : 11/03/2014
-- Version     : 1.0
-- Auteur      : Jean-Luc Amitousa Mankoy
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE dbo.getCompteAbonneReservations

	@nom_abonne 				nvarchar(50),
	@prenom_abonne 				nvarchar(50),
	@date_naissance_abonne 		date

AS
		RETURN 
		(
		SELECT r 
		FROM Reservation r, CompteAbonne ca
		WHERE ca.nom=@nom_abonne
		  AND ca.prenom=@prenom_abonne
		  AND ca.date_naissance=@date_naissance_abonne
		);
GO
