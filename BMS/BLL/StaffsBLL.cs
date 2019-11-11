using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class StaffsBLL
    {
        public StaffsDAL dal;
        public StaffsBLL()
        {
            dal = new StaffsDAL();
        }
        /// <summary>
        /// 增加一条数据
        /// </summary>
        public bool Add(Staffs model)
        {
            return dal.Add(model);
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(Staffs model)
        {
            return dal.Edit(model);
        }
        public bool ResetPwd(int id)
        {
            return dal.ResetPwd(id);
        }
        public bool ChangePwd(Staffs model)
        {
            return dal.ChangePwd(model);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {
            return dal.Delete(id);
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idList)
        {
            return dal.DeleteList(idList);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Staffs GetModel(int id)
        {
            return dal.GetModel(id);
        }
        public Staffs GetModel(string strWhere)
        {
            return dal.GetModel(strWhere);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<Staffs> GetList(string strWhere, int pageIndex = 0, int pageSize = 0)
        {
            return dal.GetList(strWhere, pageIndex, pageSize);
        }

        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetCount(string strWhere)
        {
            return dal.GetCount(strWhere);
        }
    }
}
