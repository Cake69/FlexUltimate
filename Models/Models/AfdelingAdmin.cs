using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models.Models
{
    public class AfdelingAdmin
    {
        public int afdelingId { get; set; }
        public Afdeling afdeling { get; set; }
        public int brugerId { get; set; }
        public Bruger bruger { get; set; }
    }
}
