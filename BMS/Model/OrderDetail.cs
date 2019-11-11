using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class OrderDetail
    {
        public int Id { get; set; }
        public string OrderNo { get; set; }
        public int SavingProduct { get; set; }
        public decimal SPMoney { get; set; }
        public int SPPaymentAget { get; set; }
        public int SecurityProduct { get; set; }
        public decimal SEPMoney { get; set; }
        public int SEPPaymentAge { get; set; }
        public DateTime CreateTime { get; set; }
    }
}
