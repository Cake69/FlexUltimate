using Models.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBLayer
{
    public class Brugere
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

        async public Task<List<Bruger>> GetAllBrugere()
        {
            string query = "SELECT * FROM flex_ultimate.brugere";
            List<Bruger> list = new List<Bruger>();
            if (await OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                DbDataReader dataReader = await cmd.ExecuteReaderAsync();

                while (dataReader.Read())
                {
                    Bruger bruger = new Bruger();

                    bruger.id = Convert.ToInt32(dataReader["id"]);
                    bruger.brugerNavn = (string)dataReader["brugerNavn"];
                    bruger.institutionsid = Convert.ToInt32(dataReader["institutionsid"]);
                    bruger.kortnummer = (string)dataReader["kortnummer"];
                    bruger.navn = (string)dataReader["navn"];
                    bruger.oprettet = (DateTime)dataReader["oprettet"];

                    list.Add(bruger);
                }
                await CloseConnection();
                return list;
            }
            else
            {
                return list;
            }
        }

        async public Task<Bruger> GetOneBruger(int id)
        {
            string query = "SELECT * FROM flex_ultimate.brugere WHERE id = @id";
            Bruger bruger = new Bruger();
            if (await OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@id", id);
                //MySqlDataReader dataReader = cmd.ExecuteReader();
                DbDataReader dataReader = await cmd.ExecuteReaderAsync();

                while (await dataReader.ReadAsync())
                {
                    bruger.id = Convert.ToInt32(dataReader["id"]);
                    bruger.brugerNavn = (string)dataReader["brugerNavn"];
                    bruger.institutionsid = Convert.ToInt32(dataReader["institutionsid"]);
                    bruger.kortnummer = (string)dataReader["kortnummer"];
                    bruger.navn = (string)dataReader["navn"];
                    bruger.oprettet = (DateTime)dataReader["oprettet"];
                }
                await CloseConnection();
                return bruger;
            }
            else
            {
                return bruger;
            }
        }

    }
}
