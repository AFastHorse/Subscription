using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;

namespace DAL
{
    public class StaffsDAL : DBHelper
    {
        public Staffs GetModel(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "select * from Staffs where Id=@Id";
                return conn.QueryFirstOrDefault<Staffs>(sql, new { Id = id });
            }
        }
        public Staffs GetModel(string strWhere)
        {
            using (var conn = OpenConnection())
            {
                string sql = "select * from Staffs where 1=1 " + strWhere;
                return conn.QueryFirstOrDefault<Staffs>(sql);
            }
        }
        public bool Add(Staffs model)
        {
            using (var conn = OpenConnection())
            {
                string sql = "insert into Staffs(StaffName,UserName,UserPwd,DepartId,RoleId,StaffCode) values (@StaffName, @UserName, @UserPwd, @DepartId, @RoleId,@StaffCode)";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Edit(Staffs model)
        {
            using (var conn = OpenConnection())
            {
                string sql = @"update Staffs set StaffName=@StaffName,UserName=@UserName,UserPwd=@UserPwd,DepartId=@DepartId,RoleId=@RoleId,StaffCode=@StaffCode where Id=@Id ";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool ResetPwd(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = @"update Staffs set UserPwd='888888' where Id=@Id ";
                return conn.Execute(sql, new { Id = id }) > 0;
            }
        }
        public bool ChangePwd(Staffs model)
        {
            using (var conn = OpenConnection())
            {
                string sql = @"update Staffs set UserPwd=@UserPwd where Id=@Id ";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Delete(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "delete from Staffs where Id=@Id ";
                return conn.Execute(sql, new { Id = id }) > 0;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idList)
        {
            string strSql = "delete from Staffs  where Id in (" + idList + ")  ";
            using (var conn = OpenConnection())
            {
                return conn.Execute(strSql) > 0;
            }
        }
        public List<Staffs> GetList(string strWhere, int pageIndex = 0, int pageSize = 0)
        {
            using (var conn = OpenConnection())
            {
                string sqlStr = @"select * from [Staffs] where 1=1 " + strWhere + " Order by Id";
                if (pageSize != 0)
                {
                    sqlStr = @"select top " + pageSize + @" * from (select row_number() over(order by Id) as rownumber,
                            * from Staffs where 1=1 " + strWhere + @") dept where rownumber between " + ((pageIndex - 1) * pageSize + 1)
                            + " and " + pageIndex * pageSize + strWhere + " Order by Id";
                }
                return conn.Query<Staffs>(sqlStr).ToList();
            }
        }
        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetCount(string strWhere)
        {
            string sqlStr = @"select count(1) from Staffs where 1=1 " + strWhere;
            using (var conn = OpenConnection())
            {
                return conn.ExecuteScalar<int>(sqlStr);
            }
        }
    }
}
