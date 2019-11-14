using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BootstrapDemo.Common
{
    public static class NumberExtension
    {
        public static string DecimalExtension(this decimal number)
        {
            if (number < 10000)
            {
                return number.ToString();
            }
            return Math.Round(number, 2).ToString() + "万";
        }
    }
}