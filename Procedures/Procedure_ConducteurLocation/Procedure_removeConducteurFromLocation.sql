------------------------------------------------------------
-- Fichier     : Procedure_removeConducteurFromLocation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Supprime une jointure seulement si le tuple existe.
--				 Renvoie 1 en cas de succ�s, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.removeConducteurFromLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeConducteurFromLocation
GO

CREATE PROCEDURE dbo.removeConducteurFromLocation
	@id_location 						int,
	@piece_identite_conducteur 			nvarchar(50),
	@nationalite_conducteur 			nvarchar(50)
AS
	/*BEGIN TRY
		IF ( (SELECT COUNT (*) FROM ConducteurLocation WHERE
			id_location = @id_location AND
			piece_identite_conducteur = @piece_identite_conducteur AND
			nationalite_conducteur = @nationalite_conducteur
		) = 1)
		BEGIN*/
			DELETE
			FROM ConducteurLocation
			WHERE
				id_location = @id_location AND
				piece_identite_conducteur = @piece_identite_conducteur AND
				nationalite_conducteur = @nationalite_conducteur;
			
			--RAISERROR('Suppression de la jointure ConducteurLocation impossible', 10, 1);
			--PRINT('Conducteur supprim� de la location');
			--COMMIT TRANSACTION removeConducteurFromLocation
			RETURN 1;
		/*END
		ELSE
		BEGIN
			PRINT('removeConducteurFromLocation: ERROR, tuple inexistant');
			ROLLBACK TRANSACTION removeConducteurFromLocation
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('removeConducteurFromLocation: ERROR, clef primaire');
		ROLLBACK TRANSACTION removeConducteurFromLocation
		RETURN -1;
	END CATCH*/
GO