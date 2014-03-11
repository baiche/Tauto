------------------------------------------------------------
-- Fichier     : Procedure_disableCompteAbonne
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
CREATE PROCEDURE dbo.disableCompteAbonne

	@nom 					nvarchar(50),
	@prenom 				nvarchar(50),
	@date_naissance 		date
	
	
	--------------------------------------------------------------------------
	------------------------- RESUME DE LA PROCEDURE -------------------------
	--------------------------------------------------------------------------
	--------------------------------------------------------------------------
	-- PARTIE.A: Verification de la coherence 
	---- DESCRIPTION: Dans cette partie, nous allons verifier que la base est 
	----------------- dans un etat valide pour effectuer cette operation.
	---- ETAPE.A.01: Aucune location en cours (les locations conservees dans 
	---------------- l'historique ne sont pas concernees). 
	--------------------------------------------------------------------------
	--------------------------------------------------------------------------
	-- PARTIE.B: Realisation effective de l'operation 
	---- ETAPE.B.01: Desactivation dans CompteAbonne
	---- ETAPE.B.02: Desactivation dans Particulier ou Entreprise
	---- ETAPE.B.03: Desactivation dans RelanceDecouvert
	---- ETAPE.B.04: Desactivation dans CompteAbonneConduteur
	---- ETAPE.B.05: Desactivation dans Abonnement
	--------------------------------------------------------------------------

AS
	BEGIN TRANSACTION disable_compte_abonne
		BEGIN TRY

			------------------------------------------------------------------
			------------------------------------------------------------------
			------------- PARTIE.A: Verification de la coherence -------------
			------------------------------------------------------------------
			------------------------------------------------------------------
			
			
			
			------------------------------------------------------------------
			-- ETAPE.A.01: Aucune location en cours (les locations conservees 
			-------------- dans l'historique ne sont pas concernees). 
			------------------------------------------------------------------
			
			DECLARE @nbCurrentLocation int;
			
			SELECT @nbCurrentLocation=COUNT(l.id) 
			FROM Location l, Etat e
			WHERE l.id_etat = e.id
			  AND e.km_apres = NULL; -- Puisque l'etat apres n'a pas ete 
									 -- initialise, la location est en
									 -- cours.
									  
			IF(@nbCurrentLocation > 0)
				RAISERROR (
						N'Des locations sont toujours en cours, impossible de desactiver le compte', 
						10,
						-1); 
			
			
			
			
			
			
			------------------------------------------------------------------
			------------------------------------------------------------------
			--------- PARTIE.B: Realisation effective de l'operation ---------
			------------------------------------------------------------------
			------------------------------------------------------------------
			
			
			
			----------------------------------------------
			-- ETAPE.B.01: Desactivation dans CompteAbonne
			----------------------------------------------
			
			UPDATE CompteAbonne 
			SET actif=0 
			WHERE nom=@nom
			  AND prenom=@prenom
			  AND date_naissance=@date_naissance;
			
			
			
			-----------------------------------------------------------
			-- ETAPE.B.02: Desactivation dans Particulier ou Entreprise
			-----------------------------------------------------------
			
			-- ????????????????????????????????????????????????????????
			
			
			
			--------------------------------------------------
			-- ETAPE.B.03: Desactivation dans RelanceDecouvert
			--------------------------------------------------
			
			-- ????????????????????????????????????????????????????????
			
			
			
			-------------------------------------------------------
			-- ETAPE.B.04: Desactivation dans CompteAbonneConduteur
			-------------------------------------------------------
			
			-- ????????????????????????????????????????????????????????
			
			
			
			-------------------------------------------
			-- ETAPE.B.05: Desactivation dans Abonnement
			--------------------------------------------

			-- ????????????????????????????????????????????????????????
			
				
				
			RETURN 0;
			
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION disable_compte_abonne;
			RETURN -1;
		END CATCH
	COMMIT TRANSACTION disable_compte_abonne;
GO
