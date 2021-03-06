------------------------------------------------------------
-- Fichier     : Procedure_addConducteurToLocation
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Cr�e une jointure seulement si le tuple n'existe pas.
--				 Renvoie 1 en cas de succ�s, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addConducteurToLocation', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addConducteurToLocation
GO

CREATE PROCEDURE dbo.addConducteurToLocation
	@id_contratLocation 						int,
	@piece_identite_conducteur 			nvarchar(50),
	@nationalite_conducteur 			nvarchar(50)
AS
	DECLARE @id_location int;
	SELECT @id_location=id FROM Location WHERE id_contratLocation = @id_contratLocation;
	/*BEGIN TRY
		IF ( (SELECT COUNT (*) FROM ConducteurLocation WHERE
			@id_location = id_location AND
			@piece_identite_conducteur = piece_identite_conducteur AND
			@nationalite_conducteur = nationalite_conducteur
		) = 0)
		BEGIN*/
			INSERT INTO ConducteurLocation (
				id_location,
				piece_identite_conducteur,
				nationalite_conducteur
			)
			VALUES (
				@id_location,
				@piece_identite_conducteur,
				@nationalite_conducteur
			);
			--RAISERROR('Creation de la jointure ConducteurLocation impossible', 10, 1);
			--PRINT('Conducteur ajout� � la location');
			RETURN 1;
		/*END
		ELSE
		BEGIN
			PRINT('addConducteurToLocation: ERROR, tuple existant');
			RETURN -1;
		END*/
	/*END TRY
	BEGIN CATCH
		PRINT('addConducteurToLocation: ERROR, clef primaire');
		RETURN -1;
	END CATCH*/
GO