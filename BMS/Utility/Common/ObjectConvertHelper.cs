using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utility.Common
{
    public class ObjectConvertHelper
    {
        public static int ConvertToInt(object obj)
        {
            int result = 0;
            if (obj != null)
            {
                int.TryParse(obj.ToString(), out result);
            }
            return result;
        }
        public static string ConvertToString(object obj)
        {
            if (obj != null)
            {
                return obj.ToString();
            }
            return string.Empty;
        }
    }
}
