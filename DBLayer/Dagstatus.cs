using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBLayer
{
    public class Dagstatus
    {
        MySqlConnection connection;
        public Dagstatus()
        {
            connection = new MySqlConnection("server=127.0.0.1;user=root;database=flex_ultimate;port=3306;password=123;SSL Mode=None");
        }
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

        async public Task<List<Models.Models.Dagstatus>> GetAllLogs()
        {
            string query = "SELECT * FROM flex_ultimate.log";
            List<Models.Models.Dagstatus> list = new List<Models.Models.Dagstatus>();
            if (await OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                DbDataReader dataReader = await cmd.ExecuteReaderAsync();

                while (dataReader.Read())
                {
                    Models.Models.Dagstatus dagstatus = new Models.Models.Dagstatus();

                    dagstatus.id = Convert.ToInt32(dataReader["id"]);
                    dagstatus.adminTid = (TimeSpan)dataReader["admintid"];
                    dagstatus.brugerId = Convert.ToInt32(dataReader["brugerid"]);
                    dagstatus.dato = (DateTime)dataReader["dato"];
                    dagstatus.statusId = Convert.ToInt32(dataReader["statusid"]);

                    list.Add(dagstatus);
                }
                await CloseConnection();
                return list;
            }
            else
            {
                return list;
            }
        }

        async public Task<Models.Models.Dagstatus> GetOneLog(int id)
        {
            string query = "SELECT * FROM flex_ultimate.log WHERE id = @id";
            Models.Models.Dagstatus dagstatus = new Models.Models.Dagstatus();
            if (await OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@id", id);
                //MySqlDataReader dataReader = cmd.ExecuteReader();
                DbDataReader dataReader = await cmd.ExecuteReaderAsync();

                while (await dataReader.ReadAsync())
                {
                    dagstatus.id = Convert.ToInt32(dataReader["id"]);
                    dagstatus.adminTid = (TimeSpan)dataReader["admintid"];
                    dagstatus.brugerId = Convert.ToInt32(dataReader["brugerid"]);
                    dagstatus.dato = (DateTime)dataReader["dato"];
                    dagstatus.statusId = Convert.ToInt32(dataReader["statusid"]);
                }
                await CloseConnection();
                return dagstatus;
            }
            else
            {
                return dagstatus;
            }
        }
    }
}
