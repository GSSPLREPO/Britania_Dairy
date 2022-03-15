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
    public class TransferBL
    {
        #region user defined variables
        public string sSql;
        public string strStoredProcName;
        public SqlParameter[] pSqlParameter = null;
        #endregion

        #region Transfer Log Report
        /// <summary>

        /// </summary>
        public ApplicationResult TransferLogReport(DateTime FromDatetime, DateTime ToDatetime)
        {
            try
            {
                pSqlParameter = new SqlParameter[2];

                pSqlParameter[0] = new SqlParameter("@FromDateTime", SqlDbType.DateTime);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = FromDatetime;

                pSqlParameter[1] = new SqlParameter("@ToDateTime", SqlDbType.DateTime);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = ToDatetime;



                strStoredProcName = "usp_rpt_TransferReport";

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
