using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class Bruger
    {
        public int id { get; set; }
        public string navn { get; set; }
        public string brugerNavn { get; set; }
        public string kortnummer { get; set; }
        public int institutionsid { get; set; }
        public DateTime oprettet { get; set; }
        public List<Dagstatus> dagstatuses { get; set; }
        public List<AfdelingAdmin> afdAdmin { get; set; }
        public List<TeamAdmin> teamAdmin { get; set; }
        public List<InstitutionAdmin> instAdmin { get; set; }
        public List<SuperAdmin> SuperAdmin { get; set; }
        public List<BrugerTeam> BrugerTeams { get; set; }
    }
}
