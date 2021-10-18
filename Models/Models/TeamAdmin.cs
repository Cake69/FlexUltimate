using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class TeamAdmin
    {
        public int teamId { get; set; }
        public Team Team { get; set; }
        public int brugerId { get; set; }
        public Bruger Bruger { get; set; }
    }
}
