using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Orders
    {
        public int Id { get; set; }
        public string Destination { get; set; }
        public DateTime CreateTime { get; set; }
        public int CreateId { get; set; }
        public string OrderNo { get; set; }
    }
}
