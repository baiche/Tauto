------------------------------------------------------------
-- Fichier     : Procedure_removeConducteurFromLocation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime une jointure seulement si le tuple existe.
--				 Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.removeConducteurFromLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeConducteurFromLocation

GO
CREATE PROCEDURE dbo.removeConducteurFromLocation
AS
	DECLARE	@id_location 						int,
	DECLARE	@piece_identite_conducteur 			nvarchar(50),
	DECLARE	@nationalite_conducteur 			nvarchar(50)
BEGIN
	IF ( (SELECT COUNT (*) FROM ConducteurLocation WHERE
		id_location = @id_location AND
		piece_identite_conducteur = @piece_identite_conducteur AND
		nationalite_conducteur = @nationalite_conducteur
	) = 1)
	BEGIN
		DELETE
		FROM ConducteurLocation
		WHERE
			id_location = @id_location AND
			piece_identite_conducteur = @piece_identite_conducteur AND
			nationalite_conducteur = @nationalite_conducteur;
		
		PRINT('Conducteur supprimé de la location');
		RETURN 1;
	END
	ELSE
	BEGIN
		PRINT('removeConducteurFromLocation: ERROR, tuple inexistant');
		RETURN -1;
	END
END
GO