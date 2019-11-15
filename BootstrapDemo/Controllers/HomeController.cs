using BLL;
using BootstrapDemo.Common;
using BootstrapDemo.Models;
using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BootstrapDemo.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Salesman()
        {
            List<SelectListItem> list = new List<SelectListItem>();
            list.Add(new SelectListItem() { Text = "男", Value = "1" });
            list.Add(new SelectListItem() { Text = "女", Value = "0" });
            ViewData["sex"] = list;
            return View();
        }
        public ActionResult Customer()
        {
            List<SelectListItem> list = new List<SelectListItem>();
            list.Add(new SelectListItem() { Text = "男", Value = "1" });
            list.Add(new SelectListItem() { Text = "女", Value = "0" });
            ViewData["sex"] = list;
            return View();
        }
        public ActionResult SubscriptionTarget()
        {
            ViewBag.UserName = Request.QueryString["UserName"];
            ViewBag.Sex = Request.QueryString["Sex"];
            ViewBag.UserCode = Request.QueryString["UserCode"];
            List<SelectListItem> list = new List<SelectListItem>();
            list.Add(new SelectListItem() { Text = "请选择", Value = "0" });
            list.Add(new SelectListItem() { Text = "国内游", Value = "1" });
            list.Add(new SelectListItem() { Text = "吉隆坡仙本那", Value = "2" });
            list.Add(new SelectListItem() { Text = "英国伦敦", Value = "3" });
            ViewData["destination"] = list;
            return View();
        }
        [HttpPost]
        public JsonResult SubscriptionTarget(Orders model, FormCollection forms)
        {
            List<OrderDetail> list = JsonConvert.DeserializeObject<List<OrderDetail>>(forms["list"]);
            OrdersBLL bll = new OrdersBLL();
            OrderDetailBLL detailBll = new OrderDetailBLL();

            var order = new OrdersBLL().GetModelByCondition(" and UserCode='" + model.UserCode + "'");
            if (order != null)
            {
                model.Id = order.Id;
                if (bll.Update(model))
                {
                    detailBll.DeleteList("'" + order.OrderNo + "'");
                    foreach (OrderDetail item in list)
                    {
                        item.OrderNo = order.OrderNo;
                        item.CreateTime = order.CreateTime;
                    }
                    detailBll.Add(list);
                    return Json(new { success = 0, msg = "保存成功", orderNo = order.OrderNo });
                }
                return Json(new { success = 1, msg = "保存失败" });
            }
            else
            {
                model.OrderNo = System.Guid.NewGuid().ToString();
                model.CreateTime = DateTime.Now;

                foreach (OrderDetail item in list)
                {
                    item.OrderNo = model.OrderNo;
                    item.CreateTime = model.CreateTime;
                }
                if (bll.Add(model))
                {
                    if (list.Count > 0)
                    {
                        detailBll.Add(list);
                    }
                    return Json(new { success = 0, msg = "保存成功", orderNo = model.OrderNo });
                }
                return Json(new { success = 1, msg = "保存失败" });
            }
        }
        public ActionResult SubscriptionSuccess()
        {
            string orderNo = Request.QueryString["orderNo"];
            ViewBag.Destination = Request.QueryString["destination"];
            ViewBag.API = Request.QueryString["api"];
            ViewBag.Sex = Request.QueryString["sex"].ToString() == "1" ? "先生" : "女士";

            var order = new OrdersBLL().GetModel(orderNo);
            var list = new OrderDetailBLL().GetList(" and OrderNo='" + orderNo + "' and ProductType=1 ");//.GroupBy(x => x.SavingProduct);
            ViewBag.Saving_Count = list.Count();
            ViewBag.Saving_Money = list.Sum(x => x.SPMoney);

            return View(order);
        }
        public ActionResult SubmitSuccess()
        {
            string orderNo = Request.QueryString["orderNo"];
            ViewBag.Destination = Request.QueryString["destination"];
            ViewBag.API = Request.QueryString["api"];
            ViewBag.Sex = Request.QueryString["sex"].ToString() == "1" ? "先生" : "女士";

            var order = new OrdersBLL().GetModel(orderNo);
            var list = new OrderDetailBLL().GetList(" and OrderNo='" + orderNo + "' and ProductType=1 ");//.GroupBy(x => x.SavingProduct);
            ViewBag.Saving_Count = list.Count();
            ViewBag.Saving_Money = list.Sum(x => x.SPMoney);

            return View(order);
        }
        public ActionResult PartialForm(int index)
        {
            ViewBag.Index = index;
            return PartialView();
        }
    }
}