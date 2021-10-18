using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class Status
    {
        public int id { get; set; }
        public string navn { get; set; }
        public bool fri { get; set; }
        public bool absent { get; set; }
    }
}
