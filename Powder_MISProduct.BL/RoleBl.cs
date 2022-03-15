using System;
using System.Data;
using System.Data.SqlClient;
using Powder_MISProduct.BO;
using Powder_MISProduct.Common;
using Powder_MISProduct.DataAccess;

namespace Powder_MISProduct.BL
{
    public class RoleBl
    {
        #region user defined variables
        public string sSql;
        public string strStoredProcName;
        public SqlParameter[] pSqlParameter = null;
        #endregion



        #region Select All Role Details
        /// <summary>
        /// To Select All data from the Role table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Role_SelectAll()
        {
            try
            {
                sSql = "usp_tbl_Role_SelectAll";
                DataTable dtRole = new DataTable();
                dtRole = Database.ExecuteDataTable(CommandType.StoredProcedure, sSql, null);

                ApplicationResult objResults = new ApplicationResult(dtRole);
                objResults.Status = ApplicationResult.CommonStatusType.Success;
                return objResults;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion



        #region Select Role Details by Id
        /// <summary>
        /// Select all details of Role for selected RoleId from Role table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Role_Select(int intId)
        {
            try
            {
                pSqlParameter = new SqlParameter[1];

                pSqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intId;

                strStoredProcName = "usp_tbl_Role_Select";

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



        #region Delete Role Details by Id
        /// <summary>
        /// To Delete details of Role for selected RoleId from Role table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Role_Delete(int intId, int intLastModifiedBy, string strLastModifiedDate)
        {
            try
            {
                pSqlParameter = new SqlParameter[3];

                pSqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intId;

                pSqlParameter[1] = new SqlParameter("@LastModifiedBy", SqlDbType.Int);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = intLastModifiedBy;

                pSqlParameter[2] = new SqlParameter("@LastModifiedDate", SqlDbType.VarChar);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = strLastModifiedDate;

                strStoredProcName = "usp_tbl_Role_Delete";

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



        #region Insert Role Details
        /// <summary>
        /// To Insert details of Role in Role table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Role_Insert(RoleBo objRoleBo)
        {
            try
            {
                pSqlParameter = new SqlParameter[5];

                pSqlParameter[0] = new SqlParameter("@Name", SqlDbType.NVarChar);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objRoleBo.Name;

                pSqlParameter[1] = new SqlParameter("@Description", SqlDbType.NVarChar);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = objRoleBo.Description;

                pSqlParameter[2] = new SqlParameter("@OrganisationId", SqlDbType.Int);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = objRoleBo.OrganisationId;

                pSqlParameter[3] = new SqlParameter("@CreatedBy", SqlDbType.Int);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = objRoleBo.CreatedBy;

                pSqlParameter[4] = new SqlParameter("@CreatedDate", SqlDbType.VarChar);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = objRoleBo.CreatedDate;


                sSql = "usp_tbl_Role_Insert";
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
                objRoleBo = null;
            }
        }
        #endregion



        #region Update Role Details
        /// <summary>
        /// To Update details of Role in Role table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Role_Update(RoleBo objRoleBo)
        {
            try
            {
                pSqlParameter = new SqlParameter[6];


                pSqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objRoleBo.Id;

                pSqlParameter[1] = new SqlParameter("@Name", SqlDbType.NVarChar);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = objRoleBo.Name;

                pSqlParameter[2] = new SqlParameter("@Description", SqlDbType.NVarChar);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = objRoleBo.Description;

                pSqlParameter[3] = new SqlParameter("@OrganisationId", SqlDbType.Int);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = objRoleBo.OrganisationId;

                pSqlParameter[4] = new SqlParameter("@LastModifiedBy", SqlDbType.Int);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = objRoleBo.LastModifiedBy;

                pSqlParameter[5] = new SqlParameter("@LastModifiedDate", SqlDbType.VarChar);
                pSqlParameter[5].Direction = ParameterDirection.Input;
                pSqlParameter[5].Value = objRoleBo.LastModifiedDate;


                sSql = "usp_tbl_Role_Update";

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
                objRoleBo = null;
            }
        }
        #endregion

    }
}
