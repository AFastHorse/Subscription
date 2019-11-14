using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Models;

namespace DAL
{
    public class OrderDetailDAL : DBHelper
    {
        public OrderDetail GetModel(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "select * from OrderDetail where Id=@Id";
                return conn.QueryFirstOrDefault<OrderDetail>(sql, new { Id = id });
            }
        }
        public bool Add(OrderDetail model)
        {
            using (var conn = OpenConnection())
            {
                string sql = @"insert into OrderDetail(OrderNo,SavingProduct,SPMoney,SPPaymentAge,ProductType,CreateTime)
                    values (@OrderNo,@SavingProduct,@SPMoney,@SPPaymentAge,@ProductType，@CreateTime)";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Add(List<OrderDetail> list)
        {
            using (var conn = OpenConnection())
            {
                string sql = @"insert into OrderDetail(OrderNo,SavingProduct,SPMoney,SPPaymentAge,ProductType,CreateTime)
                    values (@OrderNo,@SavingProduct,@SPMoney,@SPPaymentAge,@ProductType,@CreateTime)";
                return conn.Execute(sql, list) > 0;
            }
        }
        public bool Edit(OrderDetail model)
        {
            using (var conn = OpenConnection())
            {
                string sql = @"update OrderDetail set SavingProduct=@SavingProduct,SPMoney=@SPMoney,SPPaymentAge=@SPPaymentAge,CreateTime=@CreateTime where Id=@Id ";
                return conn.Execute(sql, model) > 0;
            }
        }
        public bool Delete(int id)
        {
            using (var conn = OpenConnection())
            {
                string sql = "delete from OrderDetail where Id=@Id ";
                return conn.Execute(sql, new { Id = id }) > 0;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string orderNoList)
        {
            string strSql = "delete from OrderDetail  where OrderNo in (" + orderNoList + ")  ";
            using (var conn = OpenConnection())
            {
                return conn.Execute(strSql) > 0;
            }
        }
        public List<OrderDetail> GetList(string strWhere, int pageIndex = 0, int pageSize = 0)
        {
            using (var conn = OpenConnection())
            {
                string sqlStr = @"select * from [OrderDetail] where 1=1 " + strWhere + " Order by CreateTime";
                if (pageSize != 0)
                {
                    sqlStr = @"select top " + pageSize + @" * from (select row_number() over(order by CreateTime) as rownumber,
                            * from OrderDetail where 1=1 " + strWhere + @") dept where rownumber between " + ((pageIndex - 1) * pageSize + 1)
                            + " and " + pageIndex * pageSize + strWhere + " Order by CreateTime";
                }
                return conn.Query<OrderDetail>(sqlStr).ToList();
            }
        }
        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetCount(string strWhere)
        {
            string sqlStr = @"select count(1) from OrderDetail where 1=1 " + strWhere;
            using (var conn = OpenConnection())
            {
                return conn.ExecuteScalar<int>(sqlStr);
            }
        }
    }
}
