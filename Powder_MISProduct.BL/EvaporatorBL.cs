using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using Powder_MISProduct.Common;
using Powder_MISProduct.DataAccess;

namespace Powder_MISProduct.BL
{
    public class EvaporatorBL
    {
        #region user defined variables
        public string sSql;
        public string strStoredProcName;
        public SqlParameter[] pSqlParameter = null;
        #endregion

        #region Evaporator Log Report
        /// <summary>

        /// </summary>
        public ApplicationResult EvaporatorReport(DateTime FromDatetime, DateTime ToDatetime)
        {
            try
            {
                pSqlParameter = new SqlParameter[2];

                pSqlParameter[0] = new SqlParameter("@FromDate", SqlDbType.DateTime);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = FromDatetime;

                pSqlParameter[1] = new SqlParameter("@ToDate", SqlDbType.DateTime);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = ToDatetime;



                strStoredProcName = "usp_rpt_tbl_Evaporatorlog";

                DataTable dtResult = new DataTable();
                dtResult = Database.ExecuteDataTable(CommandType.StoredProcedure, strStoredProcName, pSqlParameter);
                ApplicationResult objResults = new ApplicationResult(dtResult);
                objResults.Status = ApplicationResult.CommonStatusType.Success;
                return objResults;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region DryerData Log Report
        /// <summary>

        /// </summary>
        public ApplicationResult DryerReport(DateTime FromDatetime, DateTime ToDatetime)
        {
            try
            {
                pSqlParameter = new SqlParameter[2];

                pSqlParameter[0] = new SqlParameter("@FromDate", SqlDbType.DateTime);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = FromDatetime;

                pSqlParameter[1] = new SqlParameter("@ToDate", SqlDbType.DateTime);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = ToDatetime;



                strStoredProcName = "usp_rpt_DryerDatalog_Report";

                DataTable dtResult = new DataTable();
                dtResult = Database.ExecuteDataTable(CommandType.StoredProcedure, strStoredProcName, pSqlParameter);
                ApplicationResult objResults = new ApplicationResult(dtResult);
                objResults.Status = ApplicationResult.CommonStatusType.Success;
                return objResults;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion
    }
}
