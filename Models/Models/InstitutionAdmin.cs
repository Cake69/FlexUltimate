using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class InstitutionAdmin
    {
        public int institutionsId { get; set; }
        public Institution Institution { get; set; }
        public int brugerId { get; set; }
        public Bruger Bruger { get; set; }
    }
}
