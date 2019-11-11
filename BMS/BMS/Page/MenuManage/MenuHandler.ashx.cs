using BLL;
using BMS.Custom;
using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using Utility.Common;

namespace BMS.Page.MenuMange
{
    /// <summary>
    /// MenuHandler 的摘要说明
    /// </summary>
    public class MenuHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string operation = context.Request["operation"];
            string result = string.Empty;
            switch (operation)
            {
                case "GetModel":
                    result = GetModel(context);
                    break;
                case "GetList":
                    result = GetList(context);
                    break;
                case "Add":
                    result = AddData(context);
                    break;
                case "Delete":
                    result = DeleteData(context);
                    break;
                case "BatchDelete":
                    result = BatchDelete(context);
                    break;
                case "GetMenuListForMain":
                    result = GetMenuListForMain(context);
                    break;
            }
            context.Response.ContentType = "application/json";
            context.Response.Write(result);
        }

        private string BatchDelete(HttpContext context)
        {
            string ids = context.Request["ids"];
            string names = context.Request["names"];
            if (!string.IsNullOrEmpty(ids))
            {
                SysMenuBLL bll = new SysMenuBLL();
                if (bll.DeleteList(ids))
                {
                    return JsonConvert.SerializeObject(new
                    {
                        success = 0,
                        msg = "删除成功"
                    });
                }
                else
                {
                    return JsonConvert.SerializeObject(new
                    {
                        success = 1,
                        msg = "删除失败"
                    });
                }
            }
            return JsonConvert.SerializeObject(new
            {
                success = 1,
                msg = "Id不存在"
            });
        }

        private string DeleteData(HttpContext context)
        {
            int id = ObjectConvertHelper.ConvertToInt(context.Request["id"]);
            string name = context.Request["name"];

            SysMenuBLL bll = new SysMenuBLL();
            if (bll.Delete(id))
            {
                return JsonConvert.SerializeObject(new
                {
                    success = 0,
                    msg = "删除成功"
                });
            }
            else
            {
                return JsonConvert.SerializeObject(new
                {
                    success = 1,
                    msg = "删除失败"
                });
            }
        }

        private string AddData(HttpContext context)
        {
            string data = context.Request["model"];
            SysMenu model = JsonConvert.DeserializeObject<SysMenu>(data);
            SysMenuBLL bll = new SysMenuBLL();
            int success = 1;
            string msg = "";

            if (model.Id == 0)
            {
                if (bll.Add(model))
                {
                    success = 0;
                    msg = "添加成功";
                }
                else
                {
                    msg = "添加失败";
                }
            }
            else
            {
                if (bll.Update(model))
                {
                    success = 0;
                    msg = "Success";
                }
                else
                {
                    msg = "修改失败";
                }
            }
            return JsonConvert.SerializeObject(new
            {
                success = success,
                msg = msg
            });
        }
        private string GetMenuListForMain(HttpContext context)
        {
            if (context.User != null)
            {
                SysMenuBLL bll = new SysMenuBLL();
                List<SysMenu> list = bll.GetList("");
                return JsonConvert.SerializeObject(list);
            }

            return JsonConvert.SerializeObject(new { });
        }
        private string GetList(HttpContext context)
        {
            int pageIndex = ObjectConvertHelper.ConvertToInt(context.Request["page"]);
            int pageSize = ObjectConvertHelper.ConvertToInt(context.Request["limit"]);
            string name = ObjectConvertHelper.ConvertToString(context.Request["txtName"]);

            string strWhere = "";

            if (!string.IsNullOrEmpty(name))
            {
                strWhere += " and Name like '%" + name + "%' ";
            }
            if (context.User != null)
            {
                SysMenuBLL bll = new SysMenuBLL();
                List<SysMenu> list = bll.GetList(strWhere, pageIndex, pageSize);
                int count = bll.GetCount(strWhere);
                return JsonConvert.SerializeObject(new
                {
                    code = "0",
                    msg = "",
                    count = count,
                    data = list
                });
            }
            else
            {
                return JsonConvert.SerializeObject(new
                {
                    code = "0",
                    msg = "",
                    count = 0,
                    data = ""
                });
            }
        }
        private string GetModel(HttpContext context)
        {
            int id = ObjectConvertHelper.ConvertToInt(context.Request["id"]);
            SysMenuBLL bll = new SysMenuBLL();
            var model = bll.GetModel(id);
            return JsonConvert.SerializeObject(model);
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