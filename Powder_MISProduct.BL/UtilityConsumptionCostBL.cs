﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Powder_MISProduct.Common;
using Powder_MISProduct.DataAccess;
using Powder_MISProduct.BO;

namespace Powder_MISProduct.BL
{
    public class UtilityConsumptionCostBL
    {
        #region user defined variables
        public string sSql;
        public string strStoredProcName;
        public SqlParameter[] pSqlParameter = null;
        #endregion

        #region Utility consumption cost grid binding
        public ApplicationResult UtilityConsumpCostBindGrid()
        {
            try
            {
                strStoredProcName = "usp_tbl_UtilityCost_SelectAll";

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

        #region Select  utility cost report Details
        public ApplicationResult UtilityCostSelect(int intId)
        {
            try
            {
                pSqlParameter = new SqlParameter[1];

                pSqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = intId;

                strStoredProcName = "usp_tbl_UtilityCost_Select";

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



        #region Insert Utility cost Details

        public ApplicationResult UtilityCostInsert(UtilityConsumptionCostBO objBO)
        {
            try
            {
                pSqlParameter = new SqlParameter[7];

                pSqlParameter[0] = new SqlParameter("@SteamCost", SqlDbType.Float);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objBO.SteamCost;

                pSqlParameter[1] = new SqlParameter("@ElectricityCost", SqlDbType.Float);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = objBO.ElectricityCost;

                pSqlParameter[2] = new SqlParameter("@AirCost", SqlDbType.Float);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = objBO.AirCost;

                pSqlParameter[3] = new SqlParameter("@SoftWaterCost", SqlDbType.Float);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = objBO.SoftWaterCost;

                pSqlParameter[4] = new SqlParameter("@ChilledWaterCost", SqlDbType.Float);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = objBO.ChilledWaterCost;

                pSqlParameter[5] = new SqlParameter("@CreatedBy", SqlDbType.Int);
                pSqlParameter[5].Direction = ParameterDirection.Input;
                pSqlParameter[5].Value = objBO.CreatedBy;

                pSqlParameter[6] = new SqlParameter("@CreatedDate", SqlDbType.DateTime);
                pSqlParameter[6].Direction = ParameterDirection.Input;
                pSqlParameter[6].Value = objBO.CreatedDate;

                sSql = "usp_tbl_UtilityCost_Insert";
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
                objBO = null;
            }
        }
        #endregion

        #region Update Utility Cost Details

        public ApplicationResult UtilityCostUpdate(UtilityConsumptionCostBO objBO)
        {
            try
            {
                pSqlParameter = new SqlParameter[8];

                pSqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objBO.Id;

                pSqlParameter[1] = new SqlParameter("@SteamCost", SqlDbType.Float);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = objBO.SteamCost;

                pSqlParameter[2] = new SqlParameter("@ElectricityCost", SqlDbType.Float);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = objBO.ElectricityCost;

                pSqlParameter[3] = new SqlParameter("@AirCost", SqlDbType.Float);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = objBO.AirCost;

                pSqlParameter[4] = new SqlParameter("@SoftWaterCost", SqlDbType.Float);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = objBO.SoftWaterCost;

                pSqlParameter[5] = new SqlParameter("@ChilledWaterCost", SqlDbType.Float);
                pSqlParameter[5].Direction = ParameterDirection.Input;
                pSqlParameter[5].Value = objBO.ChilledWaterCost;

                pSqlParameter[6] = new SqlParameter("@LastModifiedBy", SqlDbType.Int);
                pSqlParameter[6].Direction = ParameterDirection.Input;
                pSqlParameter[6].Value = objBO.LastModifiedBy;

                pSqlParameter[7] = new SqlParameter("@LastModifiedDate", SqlDbType.DateTime);
                pSqlParameter[7].Direction = ParameterDirection.Input;
                pSqlParameter[7].Value = objBO.LastModifiedDate;


                sSql = "usp_tbl_UtilityCost_Update";
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
                objBO = null;
            }
        }
        #endregion

    }
}
