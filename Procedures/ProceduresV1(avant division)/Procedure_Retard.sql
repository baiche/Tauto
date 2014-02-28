------------------------------------------------------------
-- Fichier     : Procedure_Retard
-- Date        : 24/02/2014
-- Version     : 1.0
-- Auteur      : Mourad Baiche
-- Correcteur  : 
-- Testeur     : 
-- Integrateur : 
-- Commentaire :
------------------------------------------------------------

USE TAuto_IBDR;

GO
CREATE PROCEDURE TAuto.createRetard
	@date			 		datetime,
	@id_location			int,
	@regle					bit,
	@niveau					tinyint
AS
	INSERT INTO Retard(
		date,
		id_location,
		regle,
		niveau
	)
	VALUES (
		@date,
		@id_location,
		@regle,
		@niveau
	);

GO
