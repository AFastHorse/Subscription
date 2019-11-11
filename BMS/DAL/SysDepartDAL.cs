using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;

namespace DAL
{
    public class SysDepartDAL : DBHelper
    {
        public SysDepart GetModel(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "select * from SysDepart where Id=@Id";
                return conn.QueryFirstOrDefault<SysDepart>(sql, new { Id = id });
            }
        }
        public SysDepart GetModel(string strWhere)
        {
            using (var conn = OpenConnection())
            {
                string sql = "select * from SysDepart where 1=1 " + strWhere;
                return conn.QueryFirstOrDefault<SysDepart>(sql);
            }
        }
        public bool Add(SysDepart model)
        {
            using (var conn = OpenConnection())
            {
                string sql = "insert into SysDepart(DepartName,ParentId,OrderNum,Remark) values (@DepartName,@ParentId,@OrderNum,@Remark)";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Edit(SysDepart model)
        {
            using (var conn = OpenConnection())
            {
                string sql = @"update SysDepart set DepartName=@DepartName,ParentId=@ParentId,OrderNum=@OrderNum,Remark=@Remark where Id=@Id ";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Delete(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "delete from SysDepart where Id=@Id ";
                return conn.Execute(sql, new { Id = id }) > 0;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idList)
        {
            string strSql = "delete from SysDepart  where Id in (" + idList + ")  ";
            using (var conn = OpenConnection())
            {
                return conn.Execute(strSql) > 0;
            }
        }
        public List<SysDepart> GetList(string strWhere, int pageIndex = 0, int pageSize = 0)
        {
            using (var conn = OpenConnection())
            {
                string sqlStr = @"select * from [SysDepart] where 1=1 " + strWhere + " Order by OrderNum";
                if (pageSize != 0)
                {
                    sqlStr = @"select top " + pageSize + @" * from (select row_number() over(order by OrderNum) as rownumber,
                            * from SysDepart where 1=1 " + strWhere + @") dept where rownumber between " + ((pageIndex - 1) * pageSize + 1)
                            + " and " + pageIndex * pageSize + strWhere + " Order by OrderNum";
                }
                return conn.Query<SysDepart>(sqlStr).ToList();
            }
        }
        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetCount(string strWhere)
        {
            string sqlStr = @"select count(1) from SysDepart where 1=1 " + strWhere;
            using (var conn = OpenConnection())
            {
                return conn.ExecuteScalar<int>(sqlStr);
            }
        }
    }
}
