using Powder_MISProduct.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Powder_MISProduct.BL;

namespace Powder_MISProduct.WebUI
{
    public partial class UtilityConsumptionCost : System.Web.UI.Page
    {
        #region Page load event

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (IsPostBack) return;
                if (Session[ApplicationSession.Userid] != null)
                {
                    ViewState["Mode"] = "Save";
                    BindCosumptionCostGrid();
                    PanelVisibilityMode(true, false);
                    //ViewState["Id"] = 0;
                }
                else
                {
                    Response.Redirect("../Default.aspx?SessionMode=Logout", false);
                }
            }
            catch (Exception ex)
            {
                //log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                    "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
            }
        }
        #endregion

        #region BindTankReport
        public void BindCosumptionCostGrid()
        {
            try
            {
                UtilityConsumptionCostBL objectBL = new UtilityConsumptionCostBL();
                var objResult = objectBL.UtilityConsumpCostBindGrid();
                if (objResult != null)
                {
                    gvCosumptionCost.DataSource = objResult.ResultDt;
                    gvCosumptionCost.DataBind();
                    PanelVisibilityMode(true, false);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region AddNew Button
        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            try
            {
                ClearAll();
                PanelVisibilityMode(false, true);
                //divIsResignDate.Visible = false;
            }
            catch (Exception ex)
            {
                //log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }
        #endregion

        #region SaveBtn
        protected void btnSave_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    TankLabReportBO objTankLabReportBO = new TankLabReportBO();
            //    TankLabReportBL TankLabReportBL = new TankLabReportBL();

            //    objTankLabReportBO.DateTime = DateTime.ParseExact(txtDate.Text.Trim() + " " + txttime.Text.Trim(), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture).ToString(); ;
            //    //objTankLabReportBO.Time = txttime.Text.Trim();
            //    //objTankLabReportBO.SampleDate = txtSampleDate.Text.Trim() + " " + txtSampleTime.Text.Trim();
            //    //objTankLabReportBO.SampleTime = txtSampleTime.Text.Trim();
            //    objTankLabReportBO.SampleTime = DateTime.ParseExact(txtSampleDate.Text.Trim() + " " + txtSampleTime.Text.Trim(), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture).ToString(); ;
            //    objTankLabReportBO.SampleID = txtSampleID.Text.Trim();
            //    objTankLabReportBO.SiloTagNo = DropDownListTankName.SelectedValue.ToString();

            //    objTankLabReportBO.TankName = txtTankName.Text;

            //    objTankLabReportBO.Temp = txtTemp.Text.Trim();
            //    objTankLabReportBO.FAT = txtFAT.Text.Trim();
            //    objTankLabReportBO.SNF = txtSNF.Text.Trim();
            //    objTankLabReportBO.Acidity = txtAcidity.Text.Trim();
            //    objTankLabReportBO.TS = txtTS.Text.Trim();
            //    objTankLabReportBO.pH = txtpH.Text.Trim();
            //    objTankLabReportBO.Acidity = txtAcidity.Text.Trim();
            //    objTankLabReportBO.Protein = txtProtein.Text.Trim();
            //    objTankLabReportBO.tankStatus = ddTank_Status.SelectedValue.ToString();
            //    objTankLabReportBO.TDS = txtTDS.Text;
            //    objTankLabReportBO.Remarks = txtRemarks.Text;

            //    if (ViewState["Mode"].ToString() == "Save")
            //    {
            //        objTankLabReportBO.CreatedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
            //        objTankLabReportBO.CreatedDate = DateTime.UtcNow.AddHours(5.5).ToString();
            //        objTankLabReportBO.IsDeleted = 0;
            //        var objResult = TankLabReportBL.TankerLabReportInsert(objTankLabReportBO);
            //        if (objResult != null)
            //        {
            //            if (objResult.Status == ApplicationResult.CommonStatusType.Success)
            //            {
            //                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
            //                    "<script>alert('Record Saved Successfully!');</script>");
            //                ClearAll();
            //                BindCosumptionCostGrid();
            //                PanelVisibilityMode(true, false);
            //            }
            //            else
            //            {
            //                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
            //                    "<script>alert('Issue in insertion!');</script>");
            //            }

            //        }
            //    }
            //    else if (ViewState["Mode"].ToString() == "Edit")
            //    {
            //        objTankLabReportBO.Id = Convert.ToInt32(ViewState["Id"].ToString());
            //        objTankLabReportBO.IsDeleted = '0';
            //        objTankLabReportBO.LastModifiedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
            //        objTankLabReportBO.LastModifiedDate = DateTime.UtcNow.AddHours(5.5).ToString();
            //        var objResult = TankLabReportBL.TankerLabReportUpdate(objTankLabReportBO);

            //        if (objResult != null)
            //        {
            //            if (objResult.Status == ApplicationResult.CommonStatusType.Success)
            //            {
            //                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
            //                    "<script>alert('Record Updated Successfully!');</script>");
            //                ClearAll();
            //                BindCosumptionCostGrid();
            //                PanelVisibilityMode(true, false);
            //            }
            //            else
            //            {
            //                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
            //                    "<script>alert('Issue while updating this record!');</script>");
            //            }
            //        }
            //    }

            //}
            //catch (Exception ex)
            //{

            //    //log.Error("Error", ex);
            //    //ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            //    string message = string.Format("Message: {0}\\n\\n", ex.Message);
            //    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert(\"" + message + "\");", true);
            //}
        }
        #endregion 

        #region ViewList
        protected void btnViewList_Click(object sender, EventArgs e)
        {
            try
            {
                ClearAll();
                PanelVisibilityMode(true, false);
                BindCosumptionCostGrid();
            }
            catch (Exception ex)
            {
                //log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
            }
        }
        #endregion

        #region RowCommand Event for Edit and Delete
        protected void gvTankReport_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //try
            //{
            //    TankLabReportBL TankLabReportBL = new TankLabReportBL();
            //    if (e.CommandName.ToString() == "Edit1")
            //    {
            //        ViewState["Mode"] = "Edit";
            //        ViewState["Id"] = e.CommandArgument.ToString();
            //        var objResult = TankLabReportBL.TankerLabReportSelect(Convert.ToInt32(e.CommandArgument.ToString()));
            //        if (objResult != null)
            //        {
            //            if (objResult.ResultDt.Rows.Count > 0)
            //            {
            //                var Date = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_DateTime].ToString().Split(' ');

            //                //var Date = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_Date].ToString().Split(' ');
            //                var SampleDate = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_SampleTime].ToString().Split(' ');
            //                txtDate.Text = Date[0];
            //                txttime.Text = Date[1];
            //                txtSampleDate.Text = SampleDate[0];
            //                txtSampleTime.Text = SampleDate[1];

            //                txtSampleID.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_SampleID].ToString();
            //                DropDownListTankName.SelectedValue = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_SiloTagNo].ToString();
            //                txtTankName.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_TankName].ToString();
            //                txtTemp.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_Temp].ToString();
            //                txtSNF.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_SNF].ToString();
            //                txtFAT.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_Fat].ToString();
            //                txtTS.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_TS].ToString();
            //                txtpH.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_pH].ToString();
            //                txtAcidity.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_Acidity].ToString();
            //                txtProtein.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_Protein].ToString();
            //                ddTank_Status.SelectedValue = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_TankStatus].ToString();
            //                txtTDS.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_TDS].ToString();
            //                txtRemarks.Text = objResult.ResultDt.Rows[0][TankLabReportBO.TankLab_Remarks].ToString();

            //                //BindMaintenance();
            //                PanelVisibilityMode(false, true);
            //            }
            //        }
            //    }
            //    else if (e.CommandName.ToString() == "Delete1")
            //    {
            //        var objResult = TankLabReportBL.TankerLabReportDelete(Convert.ToInt32(e.CommandArgument.ToString()), Convert.ToInt32(Session[ApplicationSession.Userid]), DateTime.UtcNow.AddHours(5.5).ToString());
            //        if (objResult.Status == ApplicationResult.CommonStatusType.Success)
            //        {
            //            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Record Deleted Successfully!');</script>");
            //            PanelVisibilityMode(true, false);
            //            BindTankReport();
            //        }
            //        else
            //        {
            //            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
            //    // log.Error("Error", ex);
            //    ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            //}
        }
        #endregion //



        #region PanelVisibilityMode Method
        private void PanelVisibilityMode(bool blDivGrid, bool blDivPanel)
        {
            divGrid.Visible = blDivGrid;
            divPanel.Visible = blDivPanel;
        }
        #endregion

        #region ClearAll Method
        private void ClearAll()
        {
            Controls objcontrol = new Controls();
            objcontrol.ClearForm(Master.FindControl("ContentPlaceHolder1"));
            ViewState["Mode"] = "Save";

        }
        #endregion


    }
}