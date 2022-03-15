using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI;
using Powder_MISProduct.BL;
using Powder_MISProduct.Common;
using log4net;
using System.Web.UI.WebControls;
using System.Drawing;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
//using Word = Microsoft.Office.Interop.Word;
using System.Data;
using System.Text;
//using Dairy_MIS.BL;
namespace Powder_MISProduct.Common
{
    public class CommonClass
    {
        #region Declare
        private static ILog log = LogManager.GetLogger(typeof(CommonFunctions));
        #endregion
        string strLogoPath = "";

        public object ClientScript { get; private set; }

        #region Bind Logo Session 
        public string SetLogoPath()
        {
            try
            {
                ApplicationResult objResult = new ApplicationResult();
                DataTable objOrgdt = new DataTable();
                OrganisationBL objOrganisationBl = new OrganisationBL();

                objResult = objOrganisationBl.Organisation_SelectAll();
                if (objResult.ResultDt != null)
                {
                    strLogoPath = objResult.ResultDt.Rows[0]["LogoURL"].ToString();
                    string[] strLogoPatharr = strLogoPath.Split('.');
                    strLogoPath = strLogoPatharr[2].ToString() + "." + strLogoPatharr[3].ToString();
                }
                return strLogoPath;
            }
            catch (Exception ex)
            {

                log.Error("BindLogo  Method", ex);
                throw ex;
            }
        }
        #endregion

        public string SetLogoPath1()
        {
            try
            {
                ApplicationResult objResult = new ApplicationResult();
                DataTable objOrgdt = new DataTable();
                OrganisationBL objOrganisationBl = new OrganisationBL();

                objResult = objOrganisationBl.Organisation_SelectAll();
                if (objResult.ResultDt != null)
                {
                    strLogoPath = objResult.ResultDt.Rows[0]["LoginBGImg"].ToString();
                    string[] strLogoPatharr = strLogoPath.Split('.');
                    strLogoPath = strLogoPatharr[2].ToString() + "." + strLogoPatharr[3].ToString();
                }
                return strLogoPath;
            }
            catch (Exception ex)
            {

                log.Error("BindLogo  Method", ex);
                throw ex;
            }
        }

    }
}