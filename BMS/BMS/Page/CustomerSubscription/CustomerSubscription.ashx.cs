﻿using AutoMapper;
using BLL;
using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Utility.Common;

namespace BMS.Page.CustomerSubscription
{
    /// <summary>
    /// Summary description for CustomerSubscription
    /// </summary>
    public class CustomerSubscription : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string operation = context.Request["operation"];
            string result = string.Empty;
            switch (operation)
            {
                case "GetOrderDetail":
                    result = GetOrderDetail(context);
                    break;
                case "GetList":
                    result = GetList(context);
                    break;
                case "ExportData":
                    ExportData(context);
                    return;

            }
            context.Response.ContentType = "application/json";
            context.Response.Write(result);
        }

        private void ExportData(HttpContext context)
        {
            string strWhere = " and OrderType=1 ";
            string userName = context.Request["UserName"];
            if (!string.IsNullOrEmpty(userName))
            {
                strWhere += string.Format(" and UserName like '%{0}%'", userName);
            }
            OrdersBLL bll = new OrdersBLL();
            List<Models.Orders_Detail> list = bll.GetOrder_DetailList(strWhere);

            DataTable table = NPOIHelper.ToDataTable(list);//将list转化为table，转为NPOI需要的数据源格式

            //列标题名称
            string[] colTitles = { "序号", "认购时间", "姓名", "性别", "总金额", "电话", "产品名称", "保费", "交费年限" };
            //移除不需要导出的列
            string[] removeCols = { "Destination", "UserCode", "API", "FMX_Money", "FMX_Count", "ProductType" };

            NPOIHelper.InitTable(table, colTitles, removeCols);

            NPOIHelper.ExportByWeb_Other(table, "客户认购信息", DateTime.Now.ToString("yyyyMMddHHmmss") + "_客户认购信息.xls", 6);
        }

        private string GetList(HttpContext context)
        {
            int pageIndex = ObjectConvertHelper.ConvertToInt(context.Request["page"]);
            int pageSize = ObjectConvertHelper.ConvertToInt(context.Request["limit"]);
            string name = ObjectConvertHelper.ConvertToString(context.Request["txtName"]);

            string strWhere = " and OrderType=1 ";

            if (!string.IsNullOrEmpty(name))
            {
                strWhere += "  and OrderType=1 and UserName like '%" + name + "%' ";
            }
            if (context.User != null)
            {
                OrdersBLL bll = new OrdersBLL();
                List<Orders> list = bll.GetList(strWhere, pageIndex, pageSize);
                var config = new MapperConfiguration(cfg => cfg.CreateMap<Orders, ViewOrders>()
                                                            .ForMember(dest => dest.Sex, opt => opt.MapFrom((src, des) => { if (src.Sex == 1) return "男"; return "女"; }))
                                                            .ForMember(dest => dest.CreateTime, opt => opt.MapFrom((src, des) => src.CreateTime.ToString("yyyy-MM-dd HH:mm"))));

                var mapper = config.CreateMapper();
                List<ViewOrders> list2 = mapper.Map<List<Orders>, List<ViewOrders>>(list);
                int count = bll.GetCount(strWhere);
                return JsonConvert.SerializeObject(new
                {
                    code = "0",
                    msg = "",
                    count = count,
                    data = list2
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
        private string GetOrderDetail(HttpContext context)
        {
            string orderNo = ObjectConvertHelper.ConvertToString(context.Request["OrderNo"]);

            string strWhere = "";

            if (!string.IsNullOrEmpty(orderNo))
            {
                strWhere += string.Format(" and orderNo='{0}'", orderNo);
            }
            if (context.User != null)
            {
                OrderDetailBLL bll = new OrderDetailBLL();
                List<Models.OrderDetail> list = bll.GetList(strWhere);
                var config = new MapperConfiguration(cfg => cfg.CreateMap<Models.OrderDetail, ViewOrderDetail>()
                                                            .ForMember(dest => dest.SPPaymentAge, opt => opt.MapFrom((src, des) => src.SPPaymentAge.ToString() + "年"))
                                                            .ForMember(dest => dest.SavingProduct, opt => opt.MapFrom((src, des) =>
                                                            {
                                                                if (src.ProductType == 1)  //储蓄类
                                                                {
                                                                    switch (src.SavingProduct)
                                                                    {
                                                                        case 1:
                                                                            return "财富20";
                                                                        case 2:
                                                                            return "金瑞20";
                                                                        default:
                                                                            return "";

                                                                    }
                                                                }
                                                                else //保障类
                                                                {
                                                                    switch (src.SavingProduct)
                                                                    {
                                                                        case 10:
                                                                            return "成人平安福";
                                                                        case 20:
                                                                            return "少儿平安福";
                                                                        case 30:
                                                                            return "大福星";
                                                                        case 40:
                                                                            return "小福星";
                                                                        case 50:
                                                                            return "福满分";
                                                                        case 60:
                                                                            return "爱满分";
                                                                        default:
                                                                            return "";

                                                                    }
                                                                }

                                                            }))
                                                            .ForMember(dest => dest.CreateTime, opt => opt.MapFrom((src, des) => src.CreateTime.ToString("yyyy-MM-dd HH:mm"))));

                var mapper = config.CreateMapper();
                List<ViewOrderDetail> list2 = mapper.Map<List<Models.OrderDetail>, List<ViewOrderDetail>>(list);
                int count = bll.GetCount(strWhere);
                return JsonConvert.SerializeObject(new
                {
                    code = "0",
                    msg = "",
                    count = count,
                    data = list2
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}