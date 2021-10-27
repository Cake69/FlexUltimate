using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBLayer
{
    public class CallFunctions
    {
        MySqlConnection connection = new MySqlConnection("server=10.148.130.38;user=root;database=flex_ultimate;port=3306;password=123;SSL Mode=None");
        async Task<bool> OpenConnection()
        {
            try
            {
                await connection.OpenAsync();
                return true;
            }
            catch (MySqlException ex)
            {
                string error;
                switch (ex.Number)
                {
                    case 0:
                        error = "Server offline";
                        break;
                    case 1045:
                        error = "Incorrect login";
                        break;
                }
                return false;
            }
        }

        async Task<bool> CloseConnection()
        {
            try
            {
                await connection.CloseAsync();
                return true;
            }
            catch (MySqlException ex)
            {
                return false;
            }
        }

        async public Task<string> FlexBip(string kortData)
        {
            string query = "CALL flexBip(@kortData)";
            if (await OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@kortData", kortData);
                //await cmd.ExecuteNonQueryAsync();
                DbDataReader dataReader = await cmd.ExecuteReaderAsync();
                await CloseConnection();
                return "Det virker som det skal";
            }
            else
            {
                return "Fejl i oprettelse af databaseforbindelse";
            }
        }
    }
}
