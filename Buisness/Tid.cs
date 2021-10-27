using DBLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Buisness
{
    public class Tid
    {
        public async Task<string> CallFlexBip(string kortData)
        {
            if (kortData.Length > 32)
            {
                return "For langt input";
            }
            else
            {
                CallFunctions call = new CallFunctions();
                return await call.FlexBip(kortData);
            }
        }
    }
}
