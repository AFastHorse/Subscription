using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace BootstrapDemo.Models
{
    public class SavingProduct
    {
        public int Id { get; set; }
        public int SavingType { get; set; }
        public int PaymentYearType { get; set; }
    }
    public class SecurityProduct
    {
        public int Id { get; set; }
        public int SecurityType { get; set; }
        public int PaymentYearType { get; set; }
    }
    public class SubscriptionTarget
    {
        [DisplayName("储蓄类")]
        public List<SavingProduct> SavingProducts { get; set; }
        [DisplayName("保障类")]
        public List<SecurityProduct> SecurityProducts { get; set; }
        [DisplayName("金瑞直通车目的地")]
        public string Destination { get; set; }
        [DisplayName("备注")]
        public string Remark { get; set; }
    }
}