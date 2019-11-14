using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Orders
    {
        public int Id { get; set; }
        [DisplayName("旅游地点")]
        public string Destination { get; set; }
        public DateTime CreateTime { get; set; }
        public string OrderNo { get; set; }
        [DisplayName("业务员姓名")]
        public string UserName { get; set; }
        [DisplayName("性别")]
        public int Sex { get; set; }
        [DisplayName("业务员代码")]
        [MaxLength(10, ErrorMessage = "长度最大为10")]
        public string UserCode { get; set; }
        public decimal TotalMoney { get; set; }
        public decimal API { get; set; }
        public decimal FMX_Money { get; set; }
        public decimal FMX_Count { get; set; }
    }
    public class ViewOrders
    {
        public int Id { get; set; }
        public string Destination { get; set; }
        public string CreateTime { get; set; }
        public string OrderNo { get; set; }
        public string UserName { get; set; }
        public string Sex { get; set; }
        public string UserCode { get; set; }
        public decimal TotalMoney { get; set; }
        public decimal API { get; set; }
        public decimal FMX_Money { get; set; }
        public decimal FMX_Count { get; set; }
    }

    public class Orders_Detail
    {
        public string OrderNo { get; set; }
        public string Destination { get; set; }
        public DateTime CreateTime { get; set; }
        public string UserName { get; set; }
        public string Sex { get; set; }
        public string UserCode { get; set; }
        public decimal TotalMoney { get; set; }
        public decimal API { get; set; }
        public decimal FMX_Money { get; set; }
        public decimal FMX_Count { get; set; }

        public string ProductType { get; set; }
        public string SavingProduct { get; set; }
        public decimal SPMoney { get; set; }
        public string SPPaymentAge { get; set; }
    }
}
