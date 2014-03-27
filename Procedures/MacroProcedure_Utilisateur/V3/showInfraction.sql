------------------------------------------------------------
-- Fichier     : showInfraction.sql
-- Date        : 15/03/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire : 
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.showInfraction', 'P') IS NOT NULL
	DROP PROCEDURE dbo.showInfraction	
GO

CREATE PROCEDURE dbo.showInfraction
	@matricule				nvarchar(50), -- FK
	@date					datetime
AS
	BEGIN TRANSACTION showInfraction
	BEGIN TRY
	
		DECLARE @id_location		INT,
				@nom_Infraction		varchar(50),
				@description		varchar(50),
				@montant			money,
				@regle				bit,
				@nom				varchar(50),
				@prenom				varchar(50),
				@date_naissance		date;
		
		
		SET @id_location = (SELECT l.id FROM Location l,Infraction i 
										WHERE l.matricule_vehicule=@matricule 
										AND  l.id=i.id_location
										AND i.date = @date);
										
		SELECT @nom_Infraction = nom, @description=description, @montant = montant, @regle = regle   FROM Infraction WHERE date = @date
																													 AND   id_location = @id_location;
										
										
		SELECT @nom=a.nom_compteabonne, @prenom=a.prenom_compteabonne, @date_naissance=a.date_naissance_compteabonne  FROM Abonnement a, ContratLocation cl, Location l
																													  WHERE l.id = @id_location
																													  AND   cl.id = l.id_contratLocation
																													  AND   a.id = cl.id_abonnement;
	
	
--affichage de l(infraction
PRINT '_________________________________________________________________________';
PRINT 'Nom infraction : ' + convert(varchar(50),@nom_Infraction);
PRINT 'Date infraction : ' + convert(varchar(10),@date);
PRINT 'Description de l''infraction : ' + convert(varchar(50),@description);
PRINT 'Montant de l''infraction : ' + convert(varchar(50),@montant);
IF(@regle = 'false')
BEGIN
PRINT 'Infraction réglé : NON';
END
ELSE
BEGIN
PRINT 'Infraction réglé : OUI';
END
PRINT 'Information de l''abonné concerné par l''infraction : ';
PRINT '		Nom : ' + convert(varchar(50),@nom);
PRINT '		Prenom : ' + convert(varchar(50),@prenom);
PRINT '		Date de naissance : ' + convert(varchar(50),@date_naissance);

PRINT '_________________________________________________________________________';

		COMMIT TRANSACTION showInfraction
		PRINT('showInfraction OK');
		RETURN 1;
	END TRY
	BEGIN CATCH
		PRINT('showInfraction: ERROR');
		ROLLBACK TRANSACTION showInfraction
		RETURN -1;
	END CATCH
GO