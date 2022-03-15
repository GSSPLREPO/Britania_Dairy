using System;
using System.Data;
using System.Data.SqlClient;
using Powder_MISProduct.BO;
using Powder_MISProduct.Common;
using Powder_MISProduct.DataAccess;

namespace Powder_MISProduct.BL
{
  public  class ShiftBl
    {
        #region user defined variables
        public string sSql;
        public string strStoredProcName;
        public SqlParameter[] pSqlParameter = null;
        #endregion



        #region Select All Shift Details
        /// <summary>
        /// To Select All data from the Shift table
        /// Created By : Vishal, 9/24/2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Shift_SelectAll()
        {
            try
            {
                sSql = "usp_tbl_Shift_SelectAll";
                DataTable dtShift = new DataTable();
                dtShift = Database.ExecuteDataTable(CommandType.StoredProcedure, sSql);

                ApplicationResult objResults = new ApplicationResult(dtShift);
                objResults.Status = ApplicationResult.CommonStatusType.Success;
                return objResults;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion



        #region Select Shift Details by ShiftId
        /// <summary>
        /// Select all details of Shift for selected ShiftId from Shift table
        /// Created By : Chintan, 06-10-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Shift_Select(int intShiftId)
        {
            try
            {
                pSqlParameter = new SqlParameter[1];

                pSqlParameter[0] = new SqlParameter("@ShiftId", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intShiftId;

                strStoredProcName = "usp_tbl_Shift_Select";

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



        #region Delete Shift Details by ShiftId
        /// <summary>
        /// To Delete details of Shift for selected ShiftId from Shift table
        /// Created By : Chintan, 06-10-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Shift_Delete(int intShiftId, int intLastModifiedBy, string strLastModifiedDate)
        {
            try
            {
                pSqlParameter = new SqlParameter[3];

                pSqlParameter[0] = new SqlParameter("@ShiftId", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intShiftId;

                pSqlParameter[1] = new SqlParameter("@LastModifiedBy", SqlDbType.Int);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = intLastModifiedBy;

                pSqlParameter[2] = new SqlParameter("@LastModifiedDate", SqlDbType.VarChar);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = strLastModifiedDate;

                strStoredProcName = "usp_tbl_Shift_Delete";

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



        #region Insert Shift Details
        /// <summary>
        /// To Insert details of Shift in Shift table
        /// Created By : Chintan, 06-10-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Shift_Insert(ShiftBo objShiftBo, string strFromTime, string strToTime)
        {
            try
            {
                pSqlParameter = new SqlParameter[6];


                pSqlParameter[0] = new SqlParameter("@Name", SqlDbType.NVarChar);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objShiftBo.Name;

                pSqlParameter[1] = new SqlParameter("@FromTime", SqlDbType.VarChar);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = strFromTime;

                pSqlParameter[2] = new SqlParameter("@ToTime", SqlDbType.VarChar);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = strToTime;

                pSqlParameter[3] = new SqlParameter("@IsDeleted", SqlDbType.Int);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = objShiftBo.IsDeleted;

                pSqlParameter[4] = new SqlParameter("@CreatedDate", SqlDbType.DateTime);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = objShiftBo.CreatedDate;

                pSqlParameter[5] = new SqlParameter("@CreatedBy", SqlDbType.Int);
                pSqlParameter[5].Direction = ParameterDirection.Input;
                pSqlParameter[5].Value = objShiftBo.CreatedBy;


                sSql = "usp_tbl_Shift_Insert";
                //int iResult = Database.ExecuteNonQuery(CommandType.StoredProcedure, sSql, pSqlParameter);

                //if (iResult > 0)
                //{
                //    ApplicationResult objResults = new ApplicationResult();
                //    objResults.Status = ApplicationResult.CommonStatusType.Success;
                //    return objResults;
                //}
                //else
                //{
                //    ApplicationResult objResults = new ApplicationResult();
                //    objResults.Status = ApplicationResult.CommonStatusType.Failure;
                //    return objResults;
                //}
                DataTable dtResult = new DataTable();
                dtResult = Database.ExecuteDataTable(CommandType.StoredProcedure, sSql, pSqlParameter);
                ApplicationResult objResults = new ApplicationResult(dtResult);
                objResults.Status = ApplicationResult.CommonStatusType.Success;
                return objResults;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objShiftBo = null;
            }
        }
        #endregion



        #region Update Shift Details
        /// <summary>
        /// To Update details of Shift in Shift table
        /// Created By : Chintan, 06-10-2015
        /// Modified By :
        /// </summary>
        public ApplicationResult Shift_Update(ShiftBo objShiftBo, string strFromTime, string strToTime)
        {
            try
            {
                pSqlParameter = new SqlParameter[6];


                pSqlParameter[0] = new SqlParameter("@ShiftId", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objShiftBo.ShiftId;

                pSqlParameter[1] = new SqlParameter("@Name", SqlDbType.NVarChar);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = objShiftBo.Name;

                pSqlParameter[2] = new SqlParameter("@FromTime", SqlDbType.VarChar);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = strFromTime;

                pSqlParameter[3] = new SqlParameter("@ToTime", SqlDbType.VarChar);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = strToTime;

                pSqlParameter[4] = new SqlParameter("@LastModifiedBy", SqlDbType.Int);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = objShiftBo.LastModifiedBy;

                pSqlParameter[5] = new SqlParameter("@LastModifiedDate", SqlDbType.DateTime);
                pSqlParameter[5].Direction = ParameterDirection.Input;
                pSqlParameter[5].Value = objShiftBo.LastModifiedDate;

                sSql = "usp_tbl_Shift_Update";

                DataTable dtResult = new DataTable();
                dtResult = Database.ExecuteDataTable(CommandType.StoredProcedure, sSql, pSqlParameter);
                ApplicationResult objResults = new ApplicationResult(dtResult);
                objResults.Status = ApplicationResult.CommonStatusType.Success;
                return objResults;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                objShiftBo = null;
            }
        }
        #endregion

    }

}
