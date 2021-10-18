using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class Afdeling
    {
        public int id { get; set; }
        public int institutionsId { get; set; }
        public string navn { get; set; }
        public List<AfdelingAdmin> admins { get; set; }
    }
}
