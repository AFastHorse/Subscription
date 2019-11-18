using Models;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Utility.Common
{
    public class NPOIHelper
    {
        /// <summary>
        /// DataTable导出到Excel的MemoryStream
        /// </summary>
        /// <param name="dtSource">源DataTable</param>
        /// <param name="strHeaderText">表头文本</param>
        public static MemoryStream Export(DataTable dtSource, string strHeaderText)
        {
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = (HSSFSheet)workbook.CreateSheet(strHeaderText);

            HSSFCellStyle dateStyle = (HSSFCellStyle)workbook.CreateCellStyle();
            dateStyle.Alignment = HorizontalAlignment.Right;

            HSSFCellStyle stringStyle = (HSSFCellStyle)workbook.CreateCellStyle();
            stringStyle.Alignment = HorizontalAlignment.Right;

            //取得列宽
            int[] arrColWidth = new int[dtSource.Columns.Count];
            foreach (DataColumn item in dtSource.Columns)
            {
                arrColWidth[item.Ordinal] = Encoding.GetEncoding(936).GetBytes(item.ColumnName.ToString()).Length;
            }
            for (int i = 0; i < dtSource.Rows.Count; i++)
            {
                for (int j = 0; j < dtSource.Columns.Count; j++)
                {
                    int intTemp = Encoding.GetEncoding(936).GetBytes(dtSource.Rows[i][j].ToString()).Length;
                    if (intTemp > arrColWidth[j])
                    {
                        arrColWidth[j] = intTemp;
                    }
                }
            }

            #region 表头及样式
            {
                HSSFRow headerRow = (HSSFRow)sheet.CreateRow(0);
                headerRow.HeightInPoints = 25;
                headerRow.CreateCell(0).SetCellValue(strHeaderText);

                HSSFCellStyle headStyle = (HSSFCellStyle)workbook.CreateCellStyle();
                headStyle.Alignment = HorizontalAlignment.Center;
                HSSFFont font = (HSSFFont)workbook.CreateFont();
                font.FontHeightInPoints = 20;
                font.Boldweight = 700;
                headStyle.SetFont(font);
                headerRow.GetCell(0).CellStyle = headStyle;
                sheet.AddMergedRegion(new Region(0, 0, 0, dtSource.Columns.Count - 1));
            }
            #endregion


            #region 列头及样式
            {
                HSSFRow headerRow = (HSSFRow)sheet.CreateRow(1);
                headerRow.HeightInPoints = 20;
                HSSFCellStyle headStyle = (HSSFCellStyle)workbook.CreateCellStyle();
                headStyle.Alignment = HorizontalAlignment.Center;
                HSSFFont font = (HSSFFont)workbook.CreateFont();
                font.FontHeightInPoints = 10;
                font.Boldweight = 700;
                headStyle.SetFont(font);
                foreach (DataColumn column in dtSource.Columns)
                {
                    headerRow.CreateCell(column.Ordinal).SetCellValue(column.ColumnName);
                    headerRow.GetCell(column.Ordinal).CellStyle = headStyle;

                    //设置列宽
                    sheet.SetColumnWidth(column.Ordinal, (arrColWidth[column.Ordinal] + 1) * 256);
                }
            }
            #endregion

            int rowIndex = 2;
            foreach (DataRow row in dtSource.Rows)
            {
                #region 填充内容
                HSSFRow dataRow = (HSSFRow)sheet.CreateRow(rowIndex);
                dataRow.HeightInPoints = 20;
                foreach (DataColumn column in dtSource.Columns)
                {
                    HSSFCell newCell = (HSSFCell)dataRow.CreateCell(column.Ordinal);

                    HSSFFont font = (HSSFFont)workbook.CreateFont();
                    font.FontHeightInPoints = 10;
                    stringStyle.SetFont(font);
                    dateStyle.SetFont(font);

                    newCell.CellStyle = stringStyle;

                    string drValue = row[column].ToString();

                    switch (column.DataType.ToString())
                    {
                        case "System.String"://字符串类型
                            newCell.SetCellValue(drValue);
                            break;
                        case "System.DateTime"://日期类型
                            if (!string.IsNullOrEmpty(drValue))
                            {
                                DateTime dateV;
                                DateTime.TryParse(drValue, out dateV);
                                newCell.SetCellValue(dateV.ToString("yyyy-MM-dd"));
                            }
                            else
                            {
                                newCell.SetCellValue("");
                            }


                            newCell.CellStyle = dateStyle;//格式化显示
                            break;
                        case "System.Boolean"://布尔型
                            bool boolV = false;
                            bool.TryParse(drValue, out boolV);
                            newCell.SetCellValue(boolV);
                            break;
                        case "System.Int16"://整型
                        case "System.Int32":
                        case "System.Int64":
                        case "System.Byte":
                            int intV = 0;
                            int.TryParse(drValue, out intV);
                            newCell.SetCellValue(intV);
                            break;
                        case "System.Decimal"://浮点型
                        case "System.Double":
                            double doubV = 0;
                            double.TryParse(drValue, out doubV);
                            newCell.SetCellValue(doubV);
                            break;
                        case "System.DBNull"://空值处理
                            newCell.SetCellValue("");
                            break;
                        default:
                            newCell.SetCellValue("");
                            break;
                    }

                }
                #endregion

                rowIndex++;
            }
            using (MemoryStream ms = new MemoryStream())
            {
                workbook.Write(ms);
                ms.Flush();
                ms.Position = 0;

                workbook = null;
                return ms;
            }
        }
        public static MemoryStream Export_Other(DataTable dtSource, string strHeaderText, int limit)
        {
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = (HSSFSheet)workbook.CreateSheet(strHeaderText);

            HSSFCellStyle dateStyle = (HSSFCellStyle)workbook.CreateCellStyle();
            dateStyle.Alignment = HorizontalAlignment.Right;

            //取得列宽
            int[] arrColWidth = new int[dtSource.Columns.Count];
            foreach (DataColumn item in dtSource.Columns)
            {
                arrColWidth[item.Ordinal] = Encoding.GetEncoding(936).GetBytes(item.ColumnName.ToString()).Length;
            }
            for (int i = 0; i < dtSource.Rows.Count; i++)
            {
                for (int j = 1; j < dtSource.Columns.Count; j++)
                {
                    int intTemp = Encoding.GetEncoding(936).GetBytes(dtSource.Rows[i][j].ToString()).Length;
                    if (intTemp > arrColWidth[j])
                    {
                        arrColWidth[j] = intTemp;
                    }
                }
            }

            #region 表头及样式
            {
                HSSFRow headerRow = (HSSFRow)sheet.CreateRow(0);
                headerRow.HeightInPoints = 25;
                headerRow.CreateCell(0).SetCellValue(strHeaderText);

                HSSFCellStyle headStyle = (HSSFCellStyle)workbook.CreateCellStyle();
                headStyle.Alignment = HorizontalAlignment.Center;
                HSSFFont font = (HSSFFont)workbook.CreateFont();
                font.FontHeightInPoints = 20;
                font.Boldweight = 700;
                headStyle.SetFont(font);
                headerRow.GetCell(0).CellStyle = headStyle;
                sheet.AddMergedRegion(new Region(0, 0, 0, dtSource.Columns.Count - 1));
            }
            #endregion


            #region 列头及样式
            {
                HSSFRow headerRow = (HSSFRow)sheet.CreateRow(1);
                headerRow.HeightInPoints = 20;
                HSSFCellStyle headStyle = (HSSFCellStyle)workbook.CreateCellStyle();
                headStyle.Alignment = HorizontalAlignment.Center;
                HSSFFont font = (HSSFFont)workbook.CreateFont();
                font.FontHeightInPoints = 10;
                font.Boldweight = 700;
                headStyle.SetFont(font);
                foreach (DataColumn column in dtSource.Columns)
                {
                    headerRow.CreateCell(column.Ordinal).SetCellValue(column.ColumnName);
                    headerRow.GetCell(column.Ordinal).CellStyle = headStyle;

                    //设置列宽
                    sheet.SetColumnWidth(column.Ordinal, (arrColWidth[column.Ordinal] + 1) * 256);
                }
            }
            #endregion

            int rowIndex = 2;
            int num = 1;
            for (int i = 0; i < dtSource.Rows.Count; i++)
            {
                #region 填充内容
                HSSFRow dataRow = (HSSFRow)sheet.CreateRow(rowIndex);
                dataRow.HeightInPoints = 20;
                DataRow[] rows = dtSource.Select(" 序号='" + dtSource.Rows[i]["序号"] + "'");
                dtSource.Rows[i]["序号"] = num++;
                for (int j = 0; j < dtSource.Columns.Count; j++)
                {
                    if (j < limit)
                    {
                        SetCellValue(rows[0], dtSource.Columns[j], dataRow, workbook, sheet, dateStyle, true, rows.Length, rowIndex, j);
                    }
                    else
                    {
                        SetCellValue(rows[0], dtSource.Columns[j], dataRow, workbook, sheet, dateStyle, false);
                    }
                }
                for (int m = 1; m < rows.Length; m++)
                {
                    rowIndex++;
                    dataRow = (HSSFRow)sheet.CreateRow(rowIndex);
                    dataRow.HeightInPoints = 20;
                    DataRow row = dtSource.Rows[m];
                    for (int n = limit; n < dtSource.Columns.Count; n++)
                    {
                        SetCellValue(rows[m], dtSource.Columns[n], dataRow, workbook, sheet, dateStyle, false);
                    }
                }
                i += rows.Length - 1;
                #endregion

                rowIndex++;
            }
            using (MemoryStream ms = new MemoryStream())
            {
                workbook.Write(ms);
                ms.Flush();
                ms.Position = 0;

                workbook = null;
                return ms;
            }
        }
        public static void SetCellValue(DataRow row, DataColumn column, HSSFRow dataRow, HSSFWorkbook workbook, HSSFSheet sheet, HSSFCellStyle dateStyle,
            bool isRegion, int regionCount = 0, int rowIndex = 0, int colIndex = 0)
        {
            HSSFCell newCell = (HSSFCell)dataRow.CreateCell(column.Ordinal);
            if (isRegion)
            {
                sheet.AddMergedRegion(new Region(rowIndex, colIndex, rowIndex + regionCount - 1, colIndex));
                dateStyle.VerticalAlignment = VerticalAlignment.Center;
                dateStyle.Alignment = HorizontalAlignment.Center;
            }


            HSSFFont font = (HSSFFont)workbook.CreateFont();
            font.FontHeightInPoints = 10;
            dateStyle.SetFont(font);

            newCell.CellStyle = dateStyle;

            string drValue = row[column].ToString();

            switch (column.DataType.ToString())
            {
                case "System.String"://字符串类型
                    newCell.SetCellValue(drValue);
                    break;
                case "System.DateTime"://日期类型
                    if (!string.IsNullOrEmpty(drValue))
                    {
                        DateTime dateV;
                        DateTime.TryParse(drValue, out dateV);
                        newCell.SetCellValue(dateV.ToString("yyyy-MM-dd"));
                    }
                    else
                    {
                        newCell.SetCellValue("");
                    }
                    newCell.CellStyle = dateStyle;//格式化显示
                    break;
                case "System.Boolean"://布尔型
                    bool boolV = false;
                    bool.TryParse(drValue, out boolV);
                    newCell.SetCellValue(boolV);
                    break;
                case "System.Int16"://整型
                case "System.Int32":
                case "System.Int64":
                case "System.Byte":
                    int intV = 0;
                    int.TryParse(drValue, out intV);
                    newCell.SetCellValue(intV);
                    break;
                case "System.Decimal"://浮点型
                case "System.Double":
                    double doubV = 0;
                    double.TryParse(drValue, out doubV);
                    newCell.SetCellValue(doubV);
                    break;
                case "System.DBNull"://空值处理
                    newCell.SetCellValue("");
                    break;
                default:
                    newCell.SetCellValue("");
                    break;
            }
        }

        /// <summary>
        /// 用于Web导出
        /// </summary>
        /// <param name="dtSource">源DataTable</param>
        /// <param name="strHeaderText">表头文本</param>
        /// <param name="strFileName">文件名</param>
        public static void ExportByWeb(DataTable dtSource, string strHeaderText, string strFileName)
        {
            HttpContext curContext = HttpContext.Current;

            // 设置编码和附件格式
            curContext.Response.ContentType = "application/vnd.ms-excel";
            curContext.Response.ContentEncoding = Encoding.UTF8;
            curContext.Response.Charset = "";
            curContext.Response.AppendHeader("Content-Disposition",
                "attachment;filename=" + HttpUtility.UrlEncode(strFileName, Encoding.UTF8));

            curContext.Response.BinaryWrite(Export(dtSource, strHeaderText).GetBuffer());
            curContext.Response.End();
        }
        public static void ExportByWeb_Other(DataTable dtSource, string strHeaderText, string strFileName, int limit)
        {
            HttpContext curContext = HttpContext.Current;

            // 设置编码和附件格式
            curContext.Response.ContentType = "application/vnd.ms-excel";
            curContext.Response.ContentEncoding = Encoding.UTF8;
            curContext.Response.Charset = "";
            curContext.Response.AppendHeader("Content-Disposition",
                "attachment;filename=" + HttpUtility.UrlEncode(strFileName, Encoding.UTF8));

            curContext.Response.BinaryWrite(Export_Other(dtSource, strHeaderText, limit).GetBuffer());
            curContext.Response.End();
        }

        public static DataTable ToDataTable<T>(IEnumerable<T> collection)
        {
            var props = typeof(T).GetProperties();
            var dt = new DataTable();
            dt.Columns.AddRange(props.Select(p =>
            {
                Type columnType = p.PropertyType;
                if (p.PropertyType.IsGenericType && p.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>))
                {
                    columnType = p.PropertyType.GetGenericArguments()[0];
                }
                return new DataColumn(p.Name, columnType);
            }).ToArray());

            if (collection.Count() > 0)
            {
                for (int i = 0; i < collection.Count(); i++)
                {
                    ArrayList tempList = new ArrayList();
                    foreach (PropertyInfo pi in props)
                    {
                        object obj = pi.GetValue(collection.ElementAt(i), null);
                        tempList.Add(obj);
                    }
                    object[] array = tempList.ToArray();
                    dt.LoadDataRow(array, true);
                }
            }
            return dt;
        }
        public static void InitTable(DataTable table, string[] colTitles, string[] removeCols)
        {
            for (int i = 0; i < removeCols.Length; i++)
            {
                table.Columns.Remove(removeCols[i]);
            }

            for (int i = 0; i < table.Columns.Count; i++)
            {
                table.Columns[i].ColumnName = colTitles[i];
            }
        }
    }
}
