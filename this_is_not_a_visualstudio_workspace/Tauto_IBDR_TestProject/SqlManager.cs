using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tauto_IBDR_TestProject
{
    class SqlManager
    {
        private static readonly string hostname = "localhost";
        private static readonly string id = "TAuto_IBDR_user";
        private static readonly string password = "tauto_UBDR_password2014";
        private static readonly string connectionString =
            "Server=" + hostname + ";Integrated security=SSPI;user id=" + id +
            ";password=" + password + ";database=master;MultipleActiveResultSets=True;";
        private static readonly SqlConnection sqlConnection = new SqlConnection(connectionString);



        public static void executeSqlQuery(String strSqlQuery)
        {
            SqlCommand sqlCommand = new SqlCommand(strSqlQuery, sqlConnection);

            sqlConnection.Open();
            sqlCommand.ExecuteNonQuery();
            sqlConnection.Close();
        }
    }
}
