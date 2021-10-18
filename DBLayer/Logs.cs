using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.Models;
using MySql.Data.MySqlClient;
using Microsoft.EntityFrameworkCore;

namespace DBLayer
{
    public class Logs
    {
        MySqlConnection connection;
        public Logs()
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
        async public Task<List<Log>> GetAllLogs()
        {
            string query = "SELECT * FROM flex_ultimate.log";
            List<Log> list = new List<Log>();
            if (await OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                MySqlDataReader dataReader = cmd.ExecuteReader();

                while (dataReader.Read())
                {
                    Log log = new Log();

                    log.id = Convert.ToInt32(dataReader["id"]);
                    log.brugerId = Convert.ToInt32(dataReader["brugerid"]);
                    log.dato = (DateTime)dataReader["dato"];
                    log.start = (TimeSpan)dataReader["start"];
                    log.slut = (TimeSpan)dataReader["slut"];
                    log.logtime = (TimeSpan)dataReader["logtime"];

                    list.Add(log);
                }
                await CloseConnection();
                return list;
            }
            else
            {
                return list;
            }
        }

        async public Task<Log> GetOneLog(int id)
        {
            string query = "SELECT * FROM flex_ultimate.log WHERE id = @id";
            Log log = new Log();
            if (await OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@id", id);
                MySqlDataReader dataReader = cmd.ExecuteReader();

                while (dataReader.Read())
                {
                    log.id = Convert.ToInt32(dataReader["id"]);
                    log.brugerId = Convert.ToInt32(dataReader["brugerid"]);
                    log.dato = (DateTime)dataReader["dato"];
                    log.start = (TimeSpan)dataReader["start"];
                    log.slut = (TimeSpan)dataReader["slut"];
                    log.logtime = (TimeSpan)dataReader["logtime"];
                }
                await CloseConnection();
                return log;
            }
            else
            {
                return log;
            }
        }
    }
}
