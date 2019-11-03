using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BootstrapDemo.Models
{
    public class Salesman
    {
        public int Id { get; set; }
        [DisplayName("业务员名称")]
        public string Name { get; set; }
        [DisplayName("性别")]
        public int Sex { get; set; }
        [DisplayName("业务员编号")]
        [MaxLength(10, ErrorMessage = "长度最大为10")]
        public string PersonCode { get; set; }
    }
}