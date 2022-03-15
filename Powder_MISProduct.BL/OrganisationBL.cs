using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Powder_MISProduct.Common;
using Powder_MISProduct.DataAccess;
using Powder_MISProduct.BO;
using System.Data;
using System.Data.SqlClient;

namespace Powder_MISProduct.BL
{
   public class OrganisationBL
    {
        #region Declaration
        public string sSql;
        public string strStoredProcName;
        public SqlParameter[] pSqlParameter = null;
        #endregion

        #region Organisation Insert
        public ApplicationResult Organisation_Insert(BO.OrganisationBO objOrganisation)
        {
            try
            {
                pSqlParameter = new SqlParameter[8];

                pSqlParameter[0] = new SqlParameter("@Name", SqlDbType.VarChar);
                pSqlParameter[0].Direction = ParameterDirection.Input;
                pSqlParameter[0].Value = objOrganisation.Name;

                pSqlParameter[1] = new SqlParameter("@Address", SqlDbType.VarChar);
                pSqlParameter[1].Direction = ParameterDirection.Input;
                pSqlParameter[1].Value = objOrganisation.Address;

                pSqlParameter[2] = new SqlParameter("@ContactNo", SqlDbType.VarChar);
                pSqlParameter[2].Direction = ParameterDirection.Input;
                pSqlParameter[2].Value = objOrganisation.ContactNo;

                pSqlParameter[3] = new SqlParameter("@EmailId", SqlDbType.VarChar);
                pSqlParameter[3].Direction = ParameterDirection.Input;
                pSqlParameter[3].Value = objOrganisation.EmailID;

                pSqlParameter[4] = new SqlParameter("@LogoURL", SqlDbType.VarChar);
                pSqlParameter[4].Direction = ParameterDirection.Input;
                pSqlParameter[4].Value = objOrganisation.LOGOUrl;

                pSqlParameter[5] = new SqlParameter("@LoginBGImg", SqlDbType.VarChar);
                pSqlParameter[5].Direction = ParameterDirection.Input;
                pSqlParameter[5].Value = objOrganisation.LogoBGImg;

                pSqlParameter[6] = new SqlParameter("@CreatedBy", SqlDbType.Int);
                pSqlParameter[6].Direction = ParameterDirection.Input;
                pSqlParameter[6].Value = objOrganisation.CreatedBy;

                pSqlParameter[7] = new SqlParameter("@CreatedDate", SqlDbType.DateTime);
                pSqlParameter[7].Direction = ParameterDirection.Input;
                pSqlParameter[7].Value = objOrganisation.CreatedDate;


                sSql = "usp_tbl_Organisation_Insert";
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
                objOrganisation = null;
            }
        }
        #endregion

        #region organisation SelectAll
        public ApplicationResult Organisation_SelectAll()
        {
            try
            {
                pSqlParameter = null;
                strStoredProcName = "usp_tbl_Organisation_SelectAll";
                DataTable dtresult = new DataTable();
                dtresult = Database.ExecuteDataTable(CommandType.StoredProcedure, strStoredProcName, pSqlParameter);
                ApplicationResult objResult = new ApplicationResult(dtresult);
                objResult.Status = ApplicationResult.CommonStatusType.Success;
                return objResult;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        #endregion
    }
}
