using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;

namespace DAL
{
    public class SysMenuDAL : DBHelper
    {
        public SysMenu GetModel(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "select * from SysMenu where Id=@Id";
                return conn.QueryFirstOrDefault<SysMenu>(sql, new { Id = id });
            }
        }
        public bool Add(SysMenu model)
        {
            using (var conn = OpenConnection())
            {
                string sql = "insert into SysMenu(Name,Url,Remark,OrderNum) values (@Name,@Url,@Remark,@OrderNum)";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Edit(SysMenu model)
        {
            using (var conn = OpenConnection())
            {
                string sql = "update SysMenu set Name=@Name,Url=@Url,Remark=@Remark,OrderNum=@OrderNum where Id=@Id ";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Delete(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "delete from SysMenu where Id=@Id ";
                return conn.Execute(sql, new { Id = id }) > 0;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idList)
        {
            string strSql = "delete from SysMenu  where Id in (" + idList + ")  ";
            using (var conn = OpenConnection())
            {
                return conn.Execute(strSql) > 0;
            }
        }
        public List<SysMenu> GetList(string strWhere, int pageIndex = 0, int pageSize = 0)
        {
            using (var conn = OpenConnection())
            {
                string sqlStr = @"select * from [SysMenu] where 1=1 " + strWhere + " Order by OrderNum";
                if (pageSize != 0)
                {
                    sqlStr = @"select top " + pageSize + @" * from (select row_number() over(order by OrderNum) as rownumber,
                            * from SysMenu where 1=1 " + strWhere + @") dept where rownumber between " + ((pageIndex - 1) * pageSize + 1)
                            + " and " + pageIndex * pageSize + strWhere + " Order by OrderNum";
                }
                return conn.Query<SysMenu>(sqlStr).ToList();
            }
        }
        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetCount(string strWhere)
        {
            string sqlStr = @"select count(1) from SysMenu where 1=1 " + strWhere;
            using (var conn = OpenConnection())
            {
                return conn.ExecuteScalar<int>(sqlStr);
            }
        }
    }
}
