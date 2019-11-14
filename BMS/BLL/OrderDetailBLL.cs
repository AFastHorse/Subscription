using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class OrderDetailBLL
    {
        public OrderDetailDAL dal;
        public OrderDetailBLL()
        {
            dal = new OrderDetailDAL();
        }
        /// <summary>
        /// 增加一条数据
        /// </summary>
        public bool Add(OrderDetail model)
        {
            return dal.Add(model);
        }
        /// <summary>
        /// 增加多条数据
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public bool Add(List<OrderDetail> list)
        {
            return dal.Add(list);
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(OrderDetail model)
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
        public OrderDetail GetModel(int id)
        {
            return dal.GetModel(id);
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<OrderDetail> GetList(string strWhere, int pageIndex = 0, int pageSize = 0)
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
