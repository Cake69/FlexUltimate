using DBLayer;
using Microsoft.EntityFrameworkCore;
using System;
using System.Threading.Tasks;

namespace Test
{
    class Program
    {
        static async Task Main(string[] args)
        {
            Logs logs = new Logs();
            // var some = logs.GetOneLog(2).Result;

            DatabaseContext db = new DatabaseContext();

            try
            {
                var some = await db.log.ToListAsync();
                /*
                int max = 0;
                foreach (var v in some)
                {
                    if (v.brugerNavn.Length > max)
                    {
                        max = v.brugerNavn.Length;
                    }
                }
                foreach (var v in some)
                {
                    Console.WriteLine("{0,-" + max + "} | {1}", v.brugerNavn, v.navn);
                }
                Console.WriteLine(some.Count);
                */
                
            }
            catch (Exception e)
            {
                Console.WriteLine("Nope");
            }
            Console.WriteLine("Hello World!");
        }
    }
}
