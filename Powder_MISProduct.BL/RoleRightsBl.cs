using System;
using System.Data;
using System.Data.SqlClient;
using Powder_MISProduct.BO;
using Powder_MISProduct.Common;
using Powder_MISProduct.DataAccess;

namespace Powder_MISProduct.BL
{
   public class RoleRightsBl
    {
        #region user defined variables
        public string sSql;
        public string strStoredProcName;
        public SqlParameter[] pSqlParameter = null;
        #endregion



        #region Select All RoleRights Details
        /// <summary>
        /// To Select All data from the RoleRights table
        /// Created By : Nirmal, 04-08-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult RoleRights_SelectAll()
        {
            try
            {
                sSql = "usp_tbl_RoleRights_SelectAll";
                DataTable dtRoleRights = new DataTable();
                dtRoleRights = Database.ExecuteDataTable(CommandType.StoredProcedure, sSql, null);

                ApplicationResult objResults = new ApplicationResult(dtRoleRights);
                objResults.Status = ApplicationResult.CommonStatusType.Success;
                return objResults;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region Select All RoleRights Details For Authorization
        /// <summary>
        /// To Select All data from the RoleRights table
        /// Created By : Nirmal, 04-08-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult RoleRights_SelectAll_ForAuthorization(int intRoleId)
        {
            try
            {
                pSqlParameter = new SqlParameter[1];

                pSqlParameter[0] = new SqlParameter("@RoleId", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intRoleId;

                strStoredProcName = "usp_tbl_RoleRights_SelectAll_ForAuthorization";

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


        #region Select RoleRights Details by RoleRightsId
        /// <summary>
        /// Select all details of RoleRights for selected RoleRightsId from RoleRights table
        /// Created By : Nirmal, 04-08-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult RoleRights_Select(int intRoleId, int intType)
        {
            try
            {
                pSqlParameter = new SqlParameter[2];

                pSqlParameter[0] = new SqlParameter("@RoleId", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intRoleId;

                pSqlParameter[1] = new SqlParameter("@Type", SqlDbType.Int);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = intType;

                strStoredProcName = "usp_tbl_RoleRights_Select";

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


        #region Delete RoleRights Details by RoleRightsId
        /// <summary>
        /// To Delete details of RoleRights for selected RoleRightsId from RoleRights table
        /// Created By : Nirmal, 04-08-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult RoleRights_Delete(int intRoleId, int intType)
        {
            try
            {
                pSqlParameter = new SqlParameter[2];

                pSqlParameter[0] = new SqlParameter("@RoleId", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intRoleId;

                pSqlParameter[1] = new SqlParameter("@Type", SqlDbType.Int);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = intType;

                strStoredProcName = "usp_tbl_RoleRights_Delete";

                int iResult = Database.ExecuteNonQuery(CommandType.StoredProcedure, strStoredProcName, pSqlParameter);

                if (iResult > 0)
                {
                    ApplicationResult objResults = new ApplicationResult();
                    objResults.Status = ApplicationResult.CommonStatusType.Success;
                    return objResults;
                }
                else
                {
                    ApplicationResult objResults = new ApplicationResult();
                    objResults.Status = ApplicationResult.CommonStatusType.Failure;
                    return objResults;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion



        #region Insert RoleRights Details
        /// <summary>
        /// To Insert details of RoleRights in RoleRights table
        /// Created By : Nirmal, 04-08-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult RoleRights_Insert(RoleRightsBo objRoleRightsBo)
        {
            try
            {
                pSqlParameter = new SqlParameter[2];


                pSqlParameter[0] = new SqlParameter("@RoleId", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objRoleRightsBo.RoleId;

                pSqlParameter[1] = new SqlParameter("@ScreenId", SqlDbType.Int);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = objRoleRightsBo.ScreenId;


                sSql = "usp_tbl_RoleRights_Insert";
                int iResult = Database.ExecuteNonQuery(CommandType.StoredProcedure, sSql, pSqlParameter);

                if (iResult > 0)
                {
                    ApplicationResult objResults = new ApplicationResult();
                    objResults.Status = ApplicationResult.CommonStatusType.Success;
                    return objResults;
                }
                else
                {
                    ApplicationResult objResults = new ApplicationResult();
                    objResults.Status = ApplicationResult.CommonStatusType.Failure;
                    return objResults;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objRoleRightsBo = null;
            }
        }
        #endregion


    }
}
