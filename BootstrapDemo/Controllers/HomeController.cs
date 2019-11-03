using BootstrapDemo.Common;
using BootstrapDemo.Models;
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
        public ActionResult SubscriptionTarget()
        {
            return View();
        }
        public ActionResult SubscriptionSuccess()
        {
            return View();
        }
        public ActionResult SubmitSuccess()
        {
            return View();
        }
        public ActionResult PartialForm(int index)
        {
            ViewBag.Index = index;
            return PartialView();
        }
    }
}