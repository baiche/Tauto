------------------------------------------------------------
-- Fichier     : Procedure_relanceRelanceDecouvert
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Allan Mottier
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.relanceRelanceDecouvert', 'P') IS NOT NULL
	DROP PROCEDURE dbo.relanceRelanceDecouvert
GO

CREATE PROCEDURE dbo.relanceRelanceDecouvert
	@nom_compteabonne 				nvarchar(50),
	@prenom_compteabonne			nvarchar(50),
	@date_naissance_compteabonne	date
AS
	BEGIN TRANSACTION relance_relance_decouvert
		BEGIN TRY
			IF (SELECT COUNT(*) FROM RelanceDecouvert
				WHERE nom_compteabonne=@nom_compteabonne AND prenom_compteabonne=@prenom_compteabonne AND date_naissance_compteabonne=@date_naissance_compteabonne ) = 0
					EXEC dbo.createRelanceDecouvert @nom_compteabonne=@nom_compteabonne, @prenom_compteabonne=@prenom_compteabonne, @date_naissance_compteabonne=@date_naissance_compteabonne
			ELSE
				IF (SELECT niveau FROM RelanceDecouvert
					WHERE nom_compteabonne=@nom_compteabonne AND prenom_compteabonne=@prenom_compteabonne AND date_naissance_compteabonne=@date_naissance_compteabonne ) <5
						EXEC dbo.updateNiveauRelanceDecouvert @nom_compteabonne=@nom_compteabonne, @prenom_compteabonne=@prenom_compteabonne, @date_naissance_compteabonne=@date_naissance_compteabonne
					ELSE
						BEGIN
						Select * from CompteAbonne;
						EXEC dbo.backListCompteAbonne @nom_compteabonne=@nom_compteabonne, @prenom_compteabonne=@prenom_compteabonne, @date_naissance_compteabonne=@date_naissance_compteabonne;
						EXEC dbo.disableRelanceDecouvert @nom_compteabonne=@nom_compteabonne, @prenom_compteabonne=@prenom_compteabonne, @date_naissance_compteabonne=@date_naissance_compteabonne
						END
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION relance_relance_decouvert;
			RETURN -1;
		END CATCH
	COMMIT TRANSACTION relance_relance_decouvert;
	
GO