using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Staffs
    {
        public int Id { get; set; } = 0;
        public string StaffName { get; set; } = string.Empty;
        public string UserName { get; set; } = string.Empty;
        public string UserPwd { get; set; } = string.Empty;
        public int DepartId { get; set; } = 0;
        public int RoleId { get; set; } = 0;
        public string StaffCode { get; set; }
    }
}
