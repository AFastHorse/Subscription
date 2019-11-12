﻿using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;

namespace DAL
{
    public class OrdersDAL : DBHelper
    {
        public Orders GetModel(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "select * from Orders where Id=@Id";
                return conn.QueryFirstOrDefault<Orders>(sql, new { Id = id });
            }
        }
        public bool Add(Orders model)
        {
            using (var conn = OpenConnection())
            {
                string sql = "insert into Orders(Destination,CreateTime,CreateId,OrderNo) values (@Destination,@CreateTime,@CreateId,@OrderNo)";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Edit(Orders model)
        {
            using (var conn = OpenConnection())
            {
                string sql = "update Orders set Destination=@Destination,CreateId=@CreateId where Id=@Id ";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Delete(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "delete from Orders where Id=@Id ";
                return conn.Execute(sql, new { Id = id }) > 0;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string orderNoList)
        {
            string strSql = "delete from Orders  where OrderNo in (" + orderNoList + ")  ";
            using (var conn = OpenConnection())
            {
                return conn.Execute(strSql) > 0;
            }
        }
        public List<Orders> GetList(string strWhere, int pageIndex = 0, int pageSize = 0)
        {
            using (var conn = OpenConnection())
            {
                string sqlStr = @"select * from [Orders] where 1=1 " + strWhere + " Order by CreateTime";
                if (pageSize != 0)
                {
                    sqlStr = @"select top " + pageSize + @" * from (select row_number() over(order by CreateTime) as rownumber,
                            * from Orders where 1=1 " + strWhere + @") dept where rownumber between " + ((pageIndex - 1) * pageSize + 1)
                            + " and " + pageIndex * pageSize + strWhere + " Order by CreateTime";
                }
                return conn.Query<Orders>(sqlStr).ToList();
            }
        }
        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetCount(string strWhere)
        {
            string sqlStr = @"select count(1) from Orders where 1=1 " + strWhere;
            using (var conn = OpenConnection())
            {
                return conn.ExecuteScalar<int>(sqlStr);
            }
        }
    }
}
