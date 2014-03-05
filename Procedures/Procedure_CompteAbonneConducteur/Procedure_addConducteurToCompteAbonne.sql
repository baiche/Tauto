------------------------------------------------------------
-- Fichier     : Procedure_addConducteurToCompteAbonne
-- Date        : 05/03/2014
-- Version     : 1.0
-- Auteur      : David Lecoconnier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : Crée une jointure seulement si le tuple n'existe pas.
--				 Renvoie 1 en cas de succès, -1 autrement
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.addConducteurToCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.addConducteurToCompteAbonne

GO
CREATE PROCEDURE dbo.addConducteurToCompteAbonne
AS
	DECLARE	@nom_compteabonne 					nvarchar(50),
	DECLARE	@prenom_compteabonne 				nvarchar(50),
	DECLARE	@date_naissance_compteabonne 		date,
	DECLARE	@piece_identite_conducteur 			nvarchar(50),
	DECLARE	@nationalite_conducteur 			nvarchar(50)
BEGIN
	TRY
	BEGIN
		IF ( (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = @nom_compteabonne AND
			prenom_compteabonne = @prenom_compteabonne AND
			date_naissance_compteabonne = @date_naissance_compteabonne AND
			piece_identite_conducteur = @piece_identite_conducteur AND
			nationalite_conducteur = @nationalite_conducteur
			) = 0)
		BEGIN
			INSERT INTO CompteAbonneConducteur (
				nom_compteabonne,
				prenom_compteabonne,
				date_naissance_compteabonne,
				piece_identite_conducteur,
				nationalite_conducteur
			)
			VALUES (
				@nom_compteabonne,
				@prenom_compteabonne,
				@date_naissance_compteabonne,
				@piece_identite_conducteur,
				@nationalite_conducteur
			);
			PRINT('Conducteur ajouté au compte abonné');
			RETURN 1;
		END
		ELSE
		BEGIN
			PRINT('addConducteurToCompteAbonne: ERROR, tuple existant');
			RETURN -1;
		END
	END
	CATCH
	BEGIN
		PRINT('addConducteurToCompteAbonne: ERROR, clef primaire');
		RETURN -1;
	END
END
GO