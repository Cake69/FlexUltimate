using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class Institution
    {
        public int id { get; set; }
        public string navn { get; set; }
        public List<InstitutionAdmin> admins { get; set; }
    }
}
