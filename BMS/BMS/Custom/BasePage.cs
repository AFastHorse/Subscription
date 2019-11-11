using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BMS.Custom
{
    public class BasePage : System.Web.UI.Page
    {
        public BasePage()
        {
            var user = HttpContext.Current.User;
            if (user is FormsPrincipal)
            {
                if (((FormsPrincipal)user).UserData.RoleId != 1)
                {
                    HttpContext.Current.Response.Redirect("/Login.aspx");
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect("/Login.aspx");
            }
        }
    }
}