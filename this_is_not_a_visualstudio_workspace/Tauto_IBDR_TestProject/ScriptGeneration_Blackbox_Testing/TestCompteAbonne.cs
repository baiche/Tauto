using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.SqlClient;

namespace Tauto_IBDR_TestProject.ScriptGeneration_Blackbox_Testing
{
    /** ------------------------------------------------------------
        -- Fichier     : TestCompteAbonne
        -- Date        : ?
        -- Version     : 1.0
        -- Auteur      :
        -- Correcteur  : 
        -- Testeur     :
        -- Integrateur : 
        -- Commentaire :
        -----------------------------------------------------------*/
    [TestClass]
    public class TestCompteAbonne
    {
        [TestMethod]
        public void TestMethod1()
        {
            SqlManager.executeSqlQuery(
                @"USE TAuto_IBDR;
                  INSERT INTO CompteAbonne(nom,prenom,date_naissance,actif,liste_grise,iban,courriel,telephone) VALUES
                  ('Amitousa Mankoy', 'Jean-Luc', '1990-07-18', 'true', 'false', 'LU28 0019 4006 4475 00000', 
                   'jean-luc.amitousa-mankoy@hotmail.fr', '0656470693');");
        }
    }
}
