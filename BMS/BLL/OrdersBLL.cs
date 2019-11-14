using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class OrdersBLL
    {
        public OrdersDAL dal;
        public OrdersBLL()
        {
            dal = new OrdersDAL();
        }
        /// <summary>
        /// 增加一条数据
        /// </summary>
        public bool Add(Orders model)
        {
            return dal.Add(model);
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(Orders model)
        {
            return dal.Edit(model);
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
        public bool DeleteList(string orderNoList)
        {
            return dal.DeleteList(orderNoList);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Orders GetModel(int id)
        {
            return dal.GetModel(id);
        }
        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Orders GetModel(string orderNo)
        {
            return dal.GetModel(orderNo);
        }
        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Orders GetModelByCondition(string strWhere)
        {
            return dal.GetModelByCondition(strWhere);
        }

        public List<Orders_Detail> GetOrder_DetailList(string strWhere, int pageIndex = 0, int pageSize = 0)
        {
            return dal.GetOrder_DetailList(strWhere, pageIndex, pageSize);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<Orders> GetList(string strWhere, int pageIndex = 0, int pageSize = 0)
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
