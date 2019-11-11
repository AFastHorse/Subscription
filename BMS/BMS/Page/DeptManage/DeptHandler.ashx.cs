using BLL;
using BMS.Custom;
using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Utility.Common;

namespace BMS.Page.DeptManage
{
    /// <summary>
    /// DeptHandler 的摘要说明
    /// </summary>
    public class DeptHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string operation = context.Request["operation"];
            string result = string.Empty;
            switch (operation)
            {
                case "GetList":
                    result = GetList(context);
                    break;
                case "Add":
                    result = AddData(context);
                    break;
                case "Delete":
                    result = DeleteData(context);
                    break;
                case "GetModel":
                    result = GetModel(context);
                    break;
                case "GetMaxCode":
                    result = GetMaxCode(context);
                    break;
            }
            context.Response.ContentType = "application/json";
            context.Response.Write(result);
        }

        private string GetMaxCode(HttpContext context)
        {
            SysDepartBLL bll = new SysDepartBLL();
            int parentId = ObjectConvertHelper.ConvertToInt(context.Request["parentId"]);
            SysDepart model = bll.GetModel(parentId);

            if (model == null)
            {
                model = new SysDepart();
                model.DepartName = "无上级部门";
                model.Id = parentId;
            }
            return JsonConvert.SerializeObject(model);
        }

        private string GetModel(HttpContext context)
        {
            SysDepartBLL bll = new SysDepartBLL();
            int id = ObjectConvertHelper.ConvertToInt(context.Request["id"]);

            SysDepart model = bll.GetModel(id);
            if (model.ParentId == 0)
            {
                model.ParentName = "无上级部门";
            }
            return JsonConvert.SerializeObject(model);
        }

        private string DeleteData(HttpContext context)
        {
            int id = ObjectConvertHelper.ConvertToInt(context.Request["id"]);
            string name = context.Request["name"];

            SysDepartBLL bll = new SysDepartBLL();
            var dept = bll.GetModel(id);
            StaffsBLL userBll = new StaffsBLL();
            if (bll.GetCount(" and ParentId=" + id) > 1)
            {
                return JsonConvert.SerializeObject(new
                {
                    success = 1,
                    msg = "该部门下面子级部门，不能删除！"
                });
            }
            if (userBll.GetCount(" and DepartId='" + id + "' ") > 0)
            {
                return JsonConvert.SerializeObject(new
                {
                    success = 1,
                    msg = "该部门下面有用户，不能删除！"
                });
            }
            if (bll.Delete(id))
            {
                return JsonConvert.SerializeObject(new
                {
                    success = 0,
                    msg = "Success"
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
            SysDepart model = JsonConvert.DeserializeObject<SysDepart>(data);
            SysDepartBLL bll = new SysDepartBLL();
            int success = 1;
            string msg = "";

            if (model.Id == 0)
            {
                if (bll.Add(model))
                {
                    success = 0;
                    msg = "Success";
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

        private string GetList(HttpContext context)
        {
            string type = context.Request["type"];
            SysDepartBLL bll = new SysDepartBLL();
            List<SysDepart> list = bll.GetList("");
            if (type != "GetDropList")
            {
                list.Add(new SysDepart
                {
                    Id = 0,
                    ParentId = -1,
                    DepartName = "根部门"
                });
            }
            return JsonConvert.SerializeObject(new
            {
                code = "0",
                msg = "",
                count = list.Count(),
                data = list
            });

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