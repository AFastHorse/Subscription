using BMS.Custom;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMS.Pages
{
    public partial class Main : System.Web.UI.Page
    {
        public string UserName = "未登录";
        public bool IsLogin = false;
        public string CurrentAccountSet = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpContext context = HttpContext.Current;
                if (context.User.Identity.IsAuthenticated && context.User is FormsPrincipal)
                {
                    Staffs model = ((FormsPrincipal)context.User).UserData;
                    UserName = model.StaffName;
                    IsLogin = true;
                }
                else
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }
    }
}