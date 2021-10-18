using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class SuperAdmin
    {
        public int id { get; set; }
        public int brugerId { get; set; }
        public Bruger Bruger { get; set; }
    }
}
