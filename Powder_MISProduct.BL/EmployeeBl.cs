using System;
using System.Data;
using System.Data.SqlClient;
using Powder_MISProduct.BO;
using Powder_MISProduct.Common;
using Powder_MISProduct.DataAccess;

namespace Powder_MISProduct.BL
{
    public class EmployeeBl
    {
        #region user defined variables
        public string sSql;
        public string strStoredProcName;
        public SqlParameter[] pSqlParameter = null;
        #endregion



        #region Select All Employee Details
        /// <summary>
        /// To Select All data from the Employee table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Employee_SelectAll()
        {
            try
            {
                sSql = "usp_tbl_Employee_SelectAll";
                DataTable dtEmployee = new DataTable();
                dtEmployee = Database.ExecuteDataTable(CommandType.StoredProcedure, sSql, null);

                ApplicationResult objResults = new ApplicationResult(dtEmployee);
                objResults.Status = ApplicationResult.CommonStatusType.Success;
                return objResults;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region Select All Employee Details for ReportingId
        /// <summary>
        /// To Select All data from the Employee table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Employee_SelectAll_ReportingTo(int intReportingToId)
        {
            try
            {
                pSqlParameter = new SqlParameter[1];

                pSqlParameter[0] = new SqlParameter("@ReportingToId", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intReportingToId;

                sSql = "usp_tbl_Employee_SelectAll_ForReportingTo";
                DataTable dtEmployee = new DataTable();
                dtEmployee = Database.ExecuteDataTable(CommandType.StoredProcedure, sSql, pSqlParameter);

                ApplicationResult objResults = new ApplicationResult(dtEmployee);
                objResults.Status = ApplicationResult.CommonStatusType.Success;
                return objResults;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion



        #region Select Employee Details by 
        /// <summary>
        /// Select all details of Employee for selected  from Employee table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Employee_Select(int intId)
        {
            try
            {
                pSqlParameter = new SqlParameter[1];

                pSqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intId;

                strStoredProcName = "usp_tbl_Employee_Select";

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

        #region Select Employee For Login
        /// <summary>
        /// Select all details of Employee for selected  from Employee table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Employee_Select_ForLogin(string strUserName, string strPassword)
        {
            try
            {
                pSqlParameter = new SqlParameter[2];

                pSqlParameter[0] = new SqlParameter("@UserName", SqlDbType.VarChar);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = strUserName;

                pSqlParameter[1] = new SqlParameter("@Password", SqlDbType.VarChar);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = strPassword;

                strStoredProcName = "usp_tbl_Employee_Select_ForLogin";

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



        #region Delete Employee Details by 
        /// <summary>
        /// To Delete details of Employee for selected  from Employee table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Employee_Delete(int intId, int intLastModifiedBy, string strLastModifiedDate)
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

                strStoredProcName = "usp_tbl_Employee_Delete";

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



        #region Insert Employee Details
        /// <summary>
        /// To Insert details of Employee in Employee table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Employee_Insert(EmployeeBo objEmployeeBo)
        {
            try
            {
                pSqlParameter = new SqlParameter[24];



                pSqlParameter[0] = new SqlParameter("@Name", SqlDbType.NVarChar);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objEmployeeBo.Name;

                pSqlParameter[1] = new SqlParameter("@Code", SqlDbType.NVarChar);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = objEmployeeBo.Code;

                pSqlParameter[2] = new SqlParameter("@BranchId", SqlDbType.Int);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = objEmployeeBo.BranchId;

                pSqlParameter[3] = new SqlParameter("@OrganisationId", SqlDbType.Int);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = objEmployeeBo.OrganisationId;

                pSqlParameter[4] = new SqlParameter("@RoleId", SqlDbType.Int);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = objEmployeeBo.RoleId;

                pSqlParameter[5] = new SqlParameter("@DepartmentId", SqlDbType.Int);
                pSqlParameter[5].Direction = ParameterDirection.Input;
                pSqlParameter[5].Value = objEmployeeBo.DepartmentId;

                pSqlParameter[6] = new SqlParameter("@DesignationId", SqlDbType.Int);
                pSqlParameter[6].Direction = ParameterDirection.Input;
                pSqlParameter[6].Value = objEmployeeBo.DesignationId;

                pSqlParameter[7] = new SqlParameter("@ReportingToId", SqlDbType.Int);
                pSqlParameter[7].Direction = ParameterDirection.Input;
                pSqlParameter[7].Value = objEmployeeBo.ReportingToId;

                pSqlParameter[8] = new SqlParameter("@Address", SqlDbType.NVarChar);
                pSqlParameter[8].Direction = ParameterDirection.Input;
                pSqlParameter[8].Value = objEmployeeBo.Address;

                pSqlParameter[9] = new SqlParameter("@ContactNo", SqlDbType.VarChar);
                pSqlParameter[9].Direction = ParameterDirection.Input;
                pSqlParameter[9].Value = objEmployeeBo.ContactNo;

                pSqlParameter[10] = new SqlParameter("@MobileNo", SqlDbType.VarChar);
                pSqlParameter[10].Direction = ParameterDirection.Input;
                pSqlParameter[10].Value = objEmployeeBo.MobileNo;

                pSqlParameter[11] = new SqlParameter("@Email", SqlDbType.VarChar);
                pSqlParameter[11].Direction = ParameterDirection.Input;
                pSqlParameter[11].Value = objEmployeeBo.Email;

                pSqlParameter[12] = new SqlParameter("@IsUser", SqlDbType.Int);
                pSqlParameter[12].Direction = ParameterDirection.Input;
                pSqlParameter[12].Value = objEmployeeBo.IsUser;

                pSqlParameter[13] = new SqlParameter("@UserName", SqlDbType.NVarChar);
                pSqlParameter[13].Direction = ParameterDirection.Input;
                pSqlParameter[13].Value = objEmployeeBo.UserName;

                pSqlParameter[14] = new SqlParameter("@Password", SqlDbType.NVarChar);
                pSqlParameter[14].Direction = ParameterDirection.Input;
                pSqlParameter[14].Value = objEmployeeBo.Password;

                pSqlParameter[15] = new SqlParameter("@JoinDate", SqlDbType.VarChar);
                pSqlParameter[15].Direction = ParameterDirection.Input;
                pSqlParameter[15].Value = objEmployeeBo.JoinDate;

                pSqlParameter[16] = new SqlParameter("@BirthDate", SqlDbType.VarChar);
                pSqlParameter[16].Direction = ParameterDirection.Input;
                pSqlParameter[16].Value = objEmployeeBo.BirthDate;

                pSqlParameter[17] = new SqlParameter("@MarriageDate", SqlDbType.VarChar);
                pSqlParameter[17].Direction = ParameterDirection.Input;
                pSqlParameter[17].Value = objEmployeeBo.MarriageDate;

                pSqlParameter[18] = new SqlParameter("@AllowAccountAccess", SqlDbType.Int);
                pSqlParameter[18].Direction = ParameterDirection.Input;
                pSqlParameter[18].Value = objEmployeeBo.AllowAccountAccess;

                pSqlParameter[19] = new SqlParameter("@IsResigned", SqlDbType.Int);
                pSqlParameter[19].Direction = ParameterDirection.Input;
                pSqlParameter[19].Value = objEmployeeBo.IsResigned;

                pSqlParameter[20] = new SqlParameter("@ResignationDate", SqlDbType.VarChar);
                pSqlParameter[20].Direction = ParameterDirection.Input;
                pSqlParameter[20].Value = objEmployeeBo.ResignationDate;

                pSqlParameter[21] = new SqlParameter("@LastWorkingDate", SqlDbType.VarChar);
                pSqlParameter[21].Direction = ParameterDirection.Input;
                pSqlParameter[21].Value = objEmployeeBo.LastWorkingDate;

                pSqlParameter[22] = new SqlParameter("@CreatedBy", SqlDbType.Int);
                pSqlParameter[22].Direction = ParameterDirection.Input;
                pSqlParameter[22].Value = objEmployeeBo.CreatedBy;

                pSqlParameter[23] = new SqlParameter("@CreatedDate", SqlDbType.VarChar);
                pSqlParameter[23].Direction = ParameterDirection.Input;
                pSqlParameter[23].Value = objEmployeeBo.CreatedDate;


                sSql = "usp_tbl_Employee_Insert";
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
                objEmployeeBo = null;
            }
        }
        #endregion



        #region Update Employee Details
        /// <summary>
        /// To Update details of Employee in Employee table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Employee_Update(EmployeeBo objEmployeeBo)
        {
            try
            {
                pSqlParameter = new SqlParameter[25];


                pSqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objEmployeeBo.Id;

                pSqlParameter[1] = new SqlParameter("@Name", SqlDbType.NVarChar);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = objEmployeeBo.Name;

                pSqlParameter[2] = new SqlParameter("@Code", SqlDbType.NVarChar);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = objEmployeeBo.Code;

                pSqlParameter[3] = new SqlParameter("@BranchId", SqlDbType.Int);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = objEmployeeBo.BranchId;

                pSqlParameter[4] = new SqlParameter("@OrganisationId", SqlDbType.Int);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = objEmployeeBo.OrganisationId;

                pSqlParameter[5] = new SqlParameter("@RoleId", SqlDbType.Int);
                pSqlParameter[5].Direction = ParameterDirection.Input;
                pSqlParameter[5].Value = objEmployeeBo.RoleId;

                pSqlParameter[6] = new SqlParameter("@DepartmentId", SqlDbType.Int);
                pSqlParameter[6].Direction = ParameterDirection.Input;
                pSqlParameter[6].Value = objEmployeeBo.DepartmentId;

                pSqlParameter[7] = new SqlParameter("@DesignationId", SqlDbType.Int);
                pSqlParameter[7].Direction = ParameterDirection.Input;
                pSqlParameter[7].Value = objEmployeeBo.DesignationId;

                pSqlParameter[8] = new SqlParameter("@ReportingToId", SqlDbType.Int);
                pSqlParameter[8].Direction = ParameterDirection.Input;
                pSqlParameter[8].Value = objEmployeeBo.ReportingToId;

                pSqlParameter[9] = new SqlParameter("@Address", SqlDbType.NVarChar);
                pSqlParameter[9].Direction = ParameterDirection.Input;
                pSqlParameter[9].Value = objEmployeeBo.Address;

                pSqlParameter[10] = new SqlParameter("@ContactNo", SqlDbType.VarChar);
                pSqlParameter[10].Direction = ParameterDirection.Input;
                pSqlParameter[10].Value = objEmployeeBo.ContactNo;

                pSqlParameter[11] = new SqlParameter("@MobileNo", SqlDbType.VarChar);
                pSqlParameter[11].Direction = ParameterDirection.Input;
                pSqlParameter[11].Value = objEmployeeBo.MobileNo;

                pSqlParameter[12] = new SqlParameter("@Email", SqlDbType.VarChar);
                pSqlParameter[12].Direction = ParameterDirection.Input;
                pSqlParameter[12].Value = objEmployeeBo.Email;

                pSqlParameter[13] = new SqlParameter("@IsUser", SqlDbType.Int);
                pSqlParameter[13].Direction = ParameterDirection.Input;
                pSqlParameter[13].Value = objEmployeeBo.IsUser;

                pSqlParameter[14] = new SqlParameter("@UserName", SqlDbType.NVarChar);
                pSqlParameter[14].Direction = ParameterDirection.Input;
                pSqlParameter[14].Value = objEmployeeBo.UserName;

                pSqlParameter[15] = new SqlParameter("@Password", SqlDbType.NVarChar);
                pSqlParameter[15].Direction = ParameterDirection.Input;
                pSqlParameter[15].Value = objEmployeeBo.Password;

                pSqlParameter[16] = new SqlParameter("@JoinDate", SqlDbType.VarChar);
                pSqlParameter[16].Direction = ParameterDirection.Input;
                pSqlParameter[16].Value = objEmployeeBo.JoinDate;

                pSqlParameter[17] = new SqlParameter("@BirthDate", SqlDbType.VarChar);
                pSqlParameter[17].Direction = ParameterDirection.Input;
                pSqlParameter[17].Value = objEmployeeBo.BirthDate;

                pSqlParameter[18] = new SqlParameter("@MarriageDate", SqlDbType.VarChar);
                pSqlParameter[18].Direction = ParameterDirection.Input;
                pSqlParameter[18].Value = objEmployeeBo.MarriageDate;

                pSqlParameter[19] = new SqlParameter("@AllowAccountAccess", SqlDbType.Int);
                pSqlParameter[19].Direction = ParameterDirection.Input;
                pSqlParameter[19].Value = objEmployeeBo.AllowAccountAccess;

                pSqlParameter[20] = new SqlParameter("@IsResigned", SqlDbType.Int);
                pSqlParameter[20].Direction = ParameterDirection.Input;
                pSqlParameter[20].Value = objEmployeeBo.IsResigned;

                pSqlParameter[21] = new SqlParameter("@ResignationDate", SqlDbType.VarChar);
                pSqlParameter[21].Direction = ParameterDirection.Input;
                pSqlParameter[21].Value = objEmployeeBo.ResignationDate;

                pSqlParameter[22] = new SqlParameter("@LastWorkingDate", SqlDbType.VarChar);
                pSqlParameter[22].Direction = ParameterDirection.Input;
                pSqlParameter[22].Value = objEmployeeBo.LastWorkingDate;

                pSqlParameter[23] = new SqlParameter("@LastModifiedBy", SqlDbType.Int);
                pSqlParameter[23].Direction = ParameterDirection.Input;
                pSqlParameter[23].Value = objEmployeeBo.LastModifiedBy;

                pSqlParameter[24] = new SqlParameter("@LastModifiedDate", SqlDbType.VarChar);
                pSqlParameter[24].Direction = ParameterDirection.Input;
                pSqlParameter[24].Value = objEmployeeBo.LastModifiedDate;


                sSql = "usp_tbl_Employee_Update";

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
                objEmployeeBo = null;
            }
        }
        #endregion

        #region Update Employee For Change Password
        /// <summary>
        /// To Update details of Employee in Employee table
        /// Created By : Nirmal, 27-04-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Employee_Update_ForChangePassword(int intUserId, string strOldPassword, string strPassword, string strLastModifiedDate)
        {
            try
            {
                pSqlParameter = new SqlParameter[5];


                pSqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intUserId;

                pSqlParameter[1] = new SqlParameter("@OldPassword", SqlDbType.NVarChar);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = strOldPassword;

                pSqlParameter[2] = new SqlParameter("@Password", SqlDbType.NVarChar);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = strPassword;

                pSqlParameter[3] = new SqlParameter("@LastModifiedBy", SqlDbType.Int);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = intUserId;

                pSqlParameter[4] = new SqlParameter("@LastModifiedDate", SqlDbType.VarChar);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = strLastModifiedDate;


                sSql = "usp_tbl_Employee_Update_ForChangePassword";

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
        }
        #endregion

    }
}
