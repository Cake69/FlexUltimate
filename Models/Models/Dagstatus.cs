using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class Dagstatus
    {
        public int id { get; set; }
        public int brugerId { get; set; }
        public Bruger Bruger { get; set; }
        public DateTime dato { get; set; }
        public int statusId { get; set; }
        public Status Status { get; set; }
        public TimeSpan adminTid { get; set; }
        public List<Log> Logs { get; set; }
    }
}
