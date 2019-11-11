using BLL;
using BMS.Custom;
using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using Utility.Common;

namespace BMS
{
    /// <summary>
    /// LoginHandler 的摘要说明
    /// </summary>
    public class LoginHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            string action = context.Request["action"];
            switch (action)
            {
                case "Login":
                    LoginOper(context);
                    break;
                case "LogOut":
                    LogOut(context);
                    break;
            }
        }
        private void LogOut(HttpContext context)
        {
            FormsAuthentication.SignOut();
            context.Request.Cookies.Clear();
            context.Response.ContentType = "application/json";
            context.Response.Write(JsonConvert.SerializeObject(new
            {
                success = 0,
                result = "已退出登录"
            }));
            context.Response.End();
        }

        private void LoginOper(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            string userName = context.Request["userName"].ToString();
            string password = context.Request["password"].ToString();
            string strWhere = " and StaffName='" + userName + "' ";

            StaffsBLL bll = new StaffsBLL();
            Staffs model = bll.GetModel(strWhere);
            if (model != null)
            {
                if (model.UserPwd == password)
                {
                    FormsPrincipal.SignIn(model.UserName, model, 30);
                    LogHelper.Info(this.GetType(), model.UserName + "登录");

                    context.Response.Write(JsonConvert.SerializeObject(new
                    {
                        success = 0,
                        result = "登录成功！"
                    }));
                }
                else
                {
                    context.Response.Write(JsonConvert.SerializeObject(new
                    {
                        success = 1,
                        result = "密码输入不正确！"
                    }));
                }
            }
            else
            {
                context.Response.Write(JsonConvert.SerializeObject(new
                {
                    success = 2,
                    result = "用户不存在！"
                }));
            }
            context.Response.End();
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}