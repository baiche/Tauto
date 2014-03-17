------------------------------------------------------------
-- Fichier     : Procedure_removeConducteurFromCompteAbonne
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

IF OBJECT_ID ('dbo.removeConducteurFromCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeConducteurFromCompteAbonne
GO

CREATE PROCEDURE dbo.removeConducteurFromCompteAbonne
	@nom_compteabonne 					nvarchar(50),
	@prenom_compteabonne 				nvarchar(50),
	@date_naissance_compteabonne 		date,
	@piece_identite_conducteur 			nvarchar(50),
	@nationalite_conducteur 			nvarchar(50)
AS
	/*BEGIN TRANSACTION removeConducteurFromCompteAbonne
	BEGIN TRY
		IF ( (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
			nom_compteabonne = @nom_compteabonne AND
			prenom_compteabonne = @prenom_compteabonne AND
			date_naissance_compteabonne = @date_naissance_compteabonne AND
			piece_identite_conducteur = @piece_identite_conducteur AND
			nationalite_conducteur = @nationalite_conducteur
			) = 1)
		BEGIN*/
			DELETE
			FROM CompteAbonneConducteur
			WHERE
				nom_compteabonne = @nom_compteabonne AND
				prenom_compteabonne = @prenom_compteabonne AND
				date_naissance_compteabonne = @date_naissance_compteabonne AND
				piece_identite_conducteur = @piece_identite_conducteur AND
				nationalite_conducteur = @nationalite_conducteur;
			
			--RAISERROR('Suppression de la jointure CompteAbonneConducteur impossible', 10, 1);
			/*PRINT('Conducteur supprimé du compte abonné');
			COMMIT TRANSACTION removeConducteurFromCompteAbonne*/
			RETURN 1;
		/*END
		ELSE
		BEGIN
			PRINT('removeConducteurFromCompteAbonne: ERROR, tuple inexistant');
			ROLLBACK TRANSACTION removeConducteurFromCompteAbonne
			RETURN -1;
		END
	END TRY
	BEGIN CATCH
		PRINT('removeConducteurFromCompteAbonne: ERROR, clef primaire');
		ROLLBACK TRANSACTION removeConducteurFromCompteAbonne
		RETURN -1;
	END CATCH*/
GO