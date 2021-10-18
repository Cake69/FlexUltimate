using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class Team
    {
        public int id { get; set; }
        public int afdelingid { get; set; }
        public string navn { get; set; }
        public List<BrugerTeam> brugere { get; set; }
        public List<TeamAdmin> admins { get; set; }
    }
}
