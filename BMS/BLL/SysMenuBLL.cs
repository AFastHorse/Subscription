using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SysMenuBLL
    {
        public SysMenuDAL dal;
        public SysMenuBLL()
        {
            dal = new SysMenuDAL();
        }
        /// <summary>
        /// 增加一条数据
        /// </summary>
        public bool Add(SysMenu model)
        {
            return dal.Add(model);
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(SysMenu model)
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
        public bool DeleteList(string idList)
        {
            return dal.DeleteList(idList);
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public SysMenu GetModel(int id)
        {
            return dal.GetModel(id);
        }       
       
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<SysMenu> GetList(string strWhere, int pageIndex = 0, int pageSize = 0)
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
