using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace BootstrapDemo.Common
{
    public class EnumExtension
    {
        public static string GetEnumDescription(FieldInfo fi)
        {
            object[] attrs = fi.GetCustomAttributes(typeof(DescriptionAttribute), false);
            if (attrs != null && attrs.Length > 0)
            {
                return ((DescriptionAttribute)attrs[0]).Description;
            }
            else
            {
                return fi.GetValue(null).ToString();
            }
        }
        public static IList<SelectListItem> ToSelectList(Type enumType)
        {
            IList<SelectListItem> listItem = new List<SelectListItem>();
            if (enumType.IsEnum)
            {
                FieldInfo[] fields = enumType.GetFields();
                if (fields.Length > 1)
                {
                    for (int i = 1; i < fields.Length; i++)
                    {
                        listItem.Add(new SelectListItem
                        {
                            Value = fields[i].GetValue(null).ToString(),
                            Text = GetEnumDescription(fields[i])
                        });
                    }
                }
            }
            else
            {
                throw new ArgumentException("请传入正确的枚举！");
            }
            return listItem;
        }
    }
}