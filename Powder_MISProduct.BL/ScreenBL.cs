using System;
using System.Data;
using System.Data.SqlClient;
using Powder_MISProduct.BO;
using Powder_MISProduct.Common;
using Powder_MISProduct.DataAccess;

namespace Powder_MISProduct.BL
{
  public  class ScreenBL
    {
        #region user defined variables
        public string sSql;
        public string strStoredProcName;
        public SqlParameter[] pSqlParameter = null;
        #endregion



        #region Select All Screen Details
        /// <summary>
        /// To Select All data from the Screen table
        /// Created By : Nirmal, 04-08-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Screen_SelectAll(int intType)
        {
            try
            {
                pSqlParameter = new SqlParameter[1];

                pSqlParameter[0] = new SqlParameter("@Type", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intType;

                strStoredProcName = "usp_tbl_Screen_SelectAll";

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
