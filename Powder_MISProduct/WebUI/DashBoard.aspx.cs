using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Powder_MISProduct.BL;
using Powder_MISProduct.Common;


namespace Powder_MISProduct.WebUI
{
    public partial class DashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //BindgvMaintainanceFive();
            //BindgvMaintainance();
            divGrid.Visible = true;
        }

        #region Bind RoutineMaintainance
        private void BindgvMaintainanceFive()
        {
            ApplicationResult objResult = new ApplicationResult();
          //  MaintainanceBL objRoutineMaintainanceBl = new MaintainanceBL();
         //   objResult = objRoutineMaintainanceBl.Maintainance_SelectAll_forTopfive();
            if (objResult != null)
            {
                gvMaintainanceFive.DataSource = objResult.ResultDt;
                gvMaintainanceFive.DataBind();
            }
        }
        #endregion


        #region Bind RoutineMaintainance
        private void BindgvMaintainance()
        {
            ApplicationResult objResult = new ApplicationResult();
         //   MaintainanceBL objRoutineMaintainanceBl = new MaintainanceBL();
        //    objResult = objRoutineMaintainanceBl.Maintainance_SelectAll_forDashboard();
            if (objResult != null)
            {
                gvMaintainance.DataSource = objResult.ResultDt;
                gvMaintainance.DataBind();
            }
        }
        #endregion
    }
}