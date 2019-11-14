using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace BootstrapDemo.Models
{
    public enum EnumSavingProducts
    {
        [Description("财富20")]
        CaiFu20 = 1,
        [Description("金瑞20")]
        JinRui20 = 2
    }
    public enum EnumPaymentAge
    {
        [Description("3年")]
        ThreeYears = 3,
        [Description("5年")]
        FiveYears = 5,
        [Description("10年")]
        TenYears = 10
    }
    public enum EnumSecurityProducts
    {
        [Description("成人平安福")]
        CRPAF = 10,
        [Description("少儿平安福")]
        SEPAF = 20,
        [Description("大福星")]
        DFX = 30,
        [Description("小福星")]
        XFX = 40,
        [Description("福满分")]
        FMF = 50,
        [Description("爱满分")]
        AMF = 60
    }
}