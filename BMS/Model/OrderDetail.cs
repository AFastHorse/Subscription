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
        public string SavingProductName { get; set; }
        public decimal SPMoney { get; set; }
        public int SPPaymentAge { get; set; }
        //public int SecurityProduct { get; set; }
        //public string SecurityProductName { get; set; }
        //public decimal SEPMoney { get; set; }
        //public int SEPPaymentAge { get; set; }
        public int ProductType { get; set; }
        public DateTime CreateTime { get; set; }
    }
    public class ViewOrderDetail
    {
        public int Id { get; set; }
        public string OrderNo { get; set; }
        public string SavingProduct { get; set; }
        public decimal SPMoney { get; set; }
        public string SPPaymentAge { get; set; }
        public string ProductType { get; set; }
        public string CreateTime { get; set; }
    }
}
