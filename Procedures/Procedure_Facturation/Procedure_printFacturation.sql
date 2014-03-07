------------------------------------------------------------
-- Fichier     : Procedure_updateFacturation
-- Date        : 06/03/2014
-- Version     : 1.0
-- Auteur      : Boris de Finance
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

IF OBJECT_ID ('dbo.printFacturation', 'P') IS NOT NULL
DROP PROCEDURE dbo.printFacturation;
GO

--affiche la partie d'une facture concernant 1 location.
CREATE PROCEDURE dbo.printFacturation
	@id_location 					int
AS
DECLARE @matricule  nvarchar(50);
DECLARE @id_facture int;
DECLARE @montant money;
DECLARE @tva money;
SET @matricule =(SELECT matricule_vehicule FROM Location WHERE Location.id = @id_location);
SET @id_facture = (SELECT id_facturation FROM Location WHERE Location.id = @id_location);
SET @montant = (SELECT montant FROM Facturation WHERE Facturation.id = @id_facture);
SET @tva = @montant - (@montant / 1.196) ;

PRINT '_________________________________________________________________________';
PRINT 'FACTURE numero : ' + convert(varchar(10),@id_facture);
PRINT 'Location du vehicule ' + @matricule +' montant : ' + convert(varchar(10),@montant) + 'euros dont TVA : ' + convert(varchar(10),@tva) + ' euros' ;
PRINT '_________________________________________________________________________';


GO
