using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class Log
    {
        public int id { get; set; }
        public int brugerId { get; set; }
        public DateTime dato { get; set; }
        public TimeSpan start { get; set; }
        public TimeSpan slut { get; set; }
        public TimeSpan logtime { get; set; }
        public int dagstatusId { get; set; }
        public Dagstatus Dagstatus { get; set; }
    }
}
