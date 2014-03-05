------------------------------------------------------------
-- Fichier     : Procedure_removeConducteurFromCompteAbonne
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

IF OBJECT_ID ('dbo.removeConducteurFromCompteAbonne', 'P') IS NOT NULL
	DROP PROCEDURE dbo.removeConducteurFromCompteAbonne

GO
CREATE PROCEDURE dbo.removeConducteurFromCompteAbonne
AS
	DECLARE	@nom_compteabonne 					nvarchar(50),
	DECLARE	@prenom_compteabonne 				nvarchar(50),
	DECLARE	@date_naissance_compteabonne 		date,
	DECLARE	@piece_identite_conducteur 			nvarchar(50),
	DECLARE	@nationalite_conducteur 			nvarchar(50)
BEGIN
	IF ( (SELECT COUNT (*) FROM CompteAbonneConducteur WHERE
		nom_compteabonne = @nom_compteabonne AND
		prenom_compteabonne = @prenom_compteabonne AND
		date_naissance_compteabonne = @date_naissance_compteabonne AND
		piece_identite_conducteur = @piece_identite_conducteur AND
		nationalite_conducteur = @nationalite_conducteur
		) = 1)
	BEGIN
		DELETE
		FROM ConducteurLocation
		WHERE
			nom_compteabonne = @nom_compteabonne AND
			prenom_compteabonne = @prenom_compteabonne AND
			date_naissance_compteabonne = @date_naissance_compteabonne AND
			piece_identite_conducteur = @piece_identite_conducteur AND
			nationalite_conducteur = @nationalite_conducteur;
		
		PRINT('Conducteur supprim� du compte abonn�');
		RETURN 1;
	END
	ELSE
	BEGIN
		PRINT('removeConducteurFromCompteAbonne: ERROR, tuple inexistant');
		RETURN -1;
	END
END
GO