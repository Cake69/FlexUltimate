using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class TeamsTid
    {
        public int id { get; set; }
        public int teamId { get; set; }
        public Team Team { get; set; }
        public string dag { get; set; }
        public TimeSpan tid { get; set; }
        public int status { get; set; }
        public DateTime fra { get; set; }
        public DateTime til { get; set; }
    }
}
