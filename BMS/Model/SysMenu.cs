using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class SysMenu
    {
        public int Id { get; set; } = 0;
        public string Name { get; set; } = string.Empty;
        public string Url { get; set; } = string.Empty;
        public string Remark { get; set; } = string.Empty;
        public int OrderNum { get; set; }
    }
}
