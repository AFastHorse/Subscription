using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class SysDepart
    {
        public int Id { get; set; } = 0;
        public string DepartName { get; set; } = string.Empty;
        public int ParentId { get; set; } = 0;
        public string ParentName { get; set; } = string.Empty;
        public int OrderNum { get; set; } = 0;
        public string Remark { get; set; } = string.Empty;
    }
}
