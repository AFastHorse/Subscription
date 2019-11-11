using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utility.Common
{
    public enum OperLogEnum
    {
        [Description("新增")]
        Add = 1,
        [Description("编辑")]
        Edit = 2,
        [Description("删除")]
        Delete = 3
    }
}
