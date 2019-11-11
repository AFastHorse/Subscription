using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using Utility.Common;

namespace BMS.Custom
{
    public class FormsPrincipal : IPrincipal
    {
        private IIdentity _identity;
        private Staffs _userData;
        private static readonly object locker = new object();

        private FormsPrincipal() { }
        private FormsPrincipal(FormsAuthenticationTicket ticket, Staffs userData)
        {
            _identity = new FormsIdentity(ticket);
            _userData = userData;
        }

        public Staffs UserData
        {
            get { return _userData; }
        }
        public IIdentity Identity
        {
            get { return _identity; }
        }

        public bool IsInRole(string role)
        {
            IPrincipal principal = _userData as IPrincipal;
            if (principal == null)
                throw new NotImplementedException();
            else
                return principal.IsInRole(role);
        }

        /// <summary>
        /// 登录成功生成Cookie
        /// </summary>
        /// <param name="loginName"></param>
        /// <param name="model"></param>
        /// <param name="expiration"></param>
        public static void SignIn(string loginName, Staffs model, int expiration)
        {
            string data = JsonConvert.SerializeObject(model);
            //定义身份验证凭据
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(2, loginName, DateTime.Now,
                                                                            DateTime.Now.AddDays(1),
                                                                            true, data);
            //将凭据加密为字符串
            string strTicket = FormsAuthentication.Encrypt(ticket);

            //定义cookie信息
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, strTicket);
            cookie.HttpOnly = true;
            cookie.Secure = FormsAuthentication.RequireSSL;
            cookie.Domain = FormsAuthentication.CookieDomain;
            cookie.Path = FormsAuthentication.FormsCookiePath;
            cookie.Expires = DateTime.Now.AddDays(expiration);

            HttpContext context = HttpContext.Current;
            //加入到响应信息中
            context.Response.Cookies.Remove(cookie.Name);
            context.Response.Cookies.Add(cookie);
        }

        /// <summary>
        /// 根据HttpContext对象设置用户标识对象
        /// </summary>
        /// <param name="context"></param>
        public static void SetUserInfo(HttpContext context)
        {
            if (context == null)
                throw new ArgumentNullException("context");

            // 1. 读登录Cookie
            HttpCookie cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (cookie == null || string.IsNullOrEmpty(cookie.Value))
                return;

            try
            {
                Staffs userData = null;
                // 2. 解密Cookie值，获取FormsAuthenticationTicket对象
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);

                if (ticket != null && string.IsNullOrEmpty(ticket.UserData) == false)
                    userData = JsonConvert.DeserializeObject<Staffs>(ticket.UserData);

                if (ticket != null && userData != null)
                {
                    context.User = new FormsPrincipal(ticket, userData);
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(typeof(FormsPrincipal), ex.Message, ex);
            }
        }
    }
}