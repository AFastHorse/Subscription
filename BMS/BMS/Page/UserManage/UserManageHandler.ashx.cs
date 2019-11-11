using BLL;
using BMS.Custom;
using Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Utility.Common;

namespace BMS.Page.UserManage
{
    /// <summary>
    /// UserManageHandler 的摘要说明
    /// </summary>
    public class UserManageHandler : IHttpHandler
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
                case "UpdateUserMsg":
                    result = UpdateUserMsg(context);
                    break;
                case "ChangePwd":
                    result = ChangePwd(context);
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
                case "ResetPwd":
                    result = ResetPwd(context);
                    break;               
            }
            context.Response.ContentType = "application/json";
            context.Response.Write(result);
        }

        private string ResetPwd(HttpContext context)
        {
            int id = ObjectConvertHelper.ConvertToInt(context.Request["id"]);
            StaffsBLL bll = new StaffsBLL();
            if (bll.ResetPwd(id))
            {
                return JsonConvert.SerializeObject(new
                {
                    success = 0,
                    msg = "操作成功"
                });
            }
            return JsonConvert.SerializeObject(new
            {
                success = 1,
                msg = "操作失败"
            });

        }

        private string BatchDelete(HttpContext context)
        {
            string ids = context.Request["ids"];
            string names = context.Request["names"];
            if (!string.IsNullOrEmpty(ids))
            {
                StaffsBLL bll = new StaffsBLL();
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
            StaffsBLL bll = new StaffsBLL();
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
            Staffs model = JsonConvert.DeserializeObject<Staffs>(data);
            StaffsBLL bll = new StaffsBLL();
            int success = 1;
            string msg = "";

            if (model.Id == 0)
            {
                if (bll.GetCount(" and UserName='" + model.UserName + "' ") > 0)
                {
                    msg = "账号已存在！";
                }
                else
                {
                    model.UserPwd = "888888";
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
            int pageIndex = ObjectConvertHelper.ConvertToInt(context.Request["page"]);
            int pageSize = ObjectConvertHelper.ConvertToInt(context.Request["limit"]);
            string name = ObjectConvertHelper.ConvertToString(context.Request["txtName"]);

            string strWhere = "";
            if (!string.IsNullOrEmpty(name))
            {
                strWhere += " and (UserName like '%" + name + "%' or StaffName like '%" + name + "%' )";
            }

            StaffsBLL bll = new StaffsBLL();
            List<Staffs> list = bll.GetList(strWhere, pageIndex, pageSize);

            int count = bll.GetCount(strWhere);

            var iso = new IsoDateTimeConverter();
            iso.DateTimeFormat = "yyyy-MM-dd";
            return JsonConvert.SerializeObject(new
            {
                code = "0",
                msg = "",
                count = count,
                data = list
            }, iso);

        }

        private string ChangePwd(HttpContext context)
        {
            string oldPwd = context.Request["oldPwd"];
            string newPwd = context.Request["newPwd"];
            if (context.User != null)
            {
                Staffs model = ((FormsPrincipal)context.User).UserData;

                StaffsBLL bll = new StaffsBLL();
                model = bll.GetModel(model.Id);
                if (model.UserPwd != oldPwd)
                {
                    return JsonConvert.SerializeObject(new
                    {
                        success = 1,
                        msg = "原始密码不正确"
                    });
                }
                else
                {
                    model.UserPwd = newPwd;
                    if (bll.ChangePwd(model))
                    {
                        return JsonConvert.SerializeObject(new
                        {
                            success = 0,
                            msg = "修改成功"
                        });
                    }
                    else
                    {
                        return JsonConvert.SerializeObject(new
                        {
                            success = 2,
                            msg = "修改失败"
                        });
                    }
                }
            }
            else
            {
                return JsonConvert.SerializeObject(new
                {
                    success = 3,
                    msg = "用户未登录"
                });
            }
        }

        private string UpdateUserMsg(HttpContext context)
        {
            string realName = context.Request["realName"];

            Staffs model = new Staffs();
            if (context.User != null)
            {
                StaffsBLL bll = new StaffsBLL();
                model = ((FormsPrincipal)context.User).UserData;
                model = bll.GetModel(model.Id);

                model.StaffName = realName;

                if (bll.Update(model))
                {
                    return JsonConvert.SerializeObject(new
                    {
                        success = 0,
                        msg = "修改成功"
                    });
                }
                else
                {
                    return JsonConvert.SerializeObject(new
                    {
                        success = 1,
                        msg = "修改失败"
                    });
                }
            }
            else
            {
                return JsonConvert.SerializeObject(new
                {
                    success = 2,
                    msg = "用户未登录"
                });
            }

        }

        private string GetModel(HttpContext context)
        {
            int id = ObjectConvertHelper.ConvertToInt(context.Request["id"]);
            StaffsBLL bll = new StaffsBLL();
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