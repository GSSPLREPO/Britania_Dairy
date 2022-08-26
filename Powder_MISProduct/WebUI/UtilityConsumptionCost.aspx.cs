using Powder_MISProduct.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Powder_MISProduct.BL;
using Powder_MISProduct.BO;

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
            try
            {
                UtilityConsumptionCostBO objBO = new UtilityConsumptionCostBO();
                UtilityConsumptionCostBL objBL = new UtilityConsumptionCostBL();

                objBO.SteamCost = (txtSteam.Text != null && txtSteam.Text != "" ? (float.Parse(txtSteam.Text)) : 0);
                objBO.ChilledWaterCost = (txtChilledWater.Text != null && txtChilledWater.Text != "" ?
                                        (Convert.ToInt32(txtChilledWater.Text)) : 0);
                objBO.ElectricityCost = (txtElectricity.Text != null && txtElectricity.Text != "" ? (float.Parse(txtElectricity.Text)) : 0);
                objBO.AirCost = (txtAir.Text != null && txtAir.Text != "" ? (float.Parse(txtAir.Text)) : 0);
                objBO.SoftWaterCost = (txtSoftWater.Text != null && txtSoftWater.Text != "" ? (float.Parse(txtSoftWater.Text)) : 0);

                if (ViewState["Mode"].ToString() == "Save")
                {
                    objBO.CreatedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
                    objBO.CreatedDate = DateTime.UtcNow.AddHours(5.5);
                    objBO.IsDeleted = 0;
                    var objResult = objBL.UtilityCostInsert(objBO);
                    if (objResult != null)
                    {
                        if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Record Saved Successfully!');</script>");
                            ClearAll();
                            BindCosumptionCostGrid();
                            PanelVisibilityMode(true, false);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Issue in insertion!');</script>");
                        }

                    }
                }
                else if (ViewState["Mode"].ToString() == "Edit")
                {
                    objBO.Id = Convert.ToInt32(ViewState["Id"].ToString());
                    objBO.IsDeleted = '0';
                    objBO.LastModifiedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
                    objBO.LastModifiedDate = DateTime.UtcNow.AddHours(5.5);
                    var objResult = objBL.UtilityCostUpdate(objBO);

                    if (objResult != null)
                    {
                        if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Record Updated Successfully!');</script>");
                            ClearAll();
                            BindCosumptionCostGrid();
                            PanelVisibilityMode(true, false);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Issue while updating this record!');</script>");
                        }
                    }
                }

            }
            catch (Exception ex)
            {

                //log.Error("Error", ex);
                //ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
                string message = string.Format("Message: {0}\\n\\n", ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert(\"" + message + "\");", true);
            }
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
        protected void gvCosumptionCost_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                UtilityConsumptionCostBL objBL= new UtilityConsumptionCostBL();

                if (e.CommandName.ToString() == "Edit1")
                {
                    ViewState["Mode"] = "Edit";
                    ViewState["Id"] = e.CommandArgument.ToString();
                    var objResult = objBL.UtilityCostSelect(Convert.ToInt32(e.CommandArgument.ToString()));
                    if (objResult != null)
                    {
                        if (objResult.ResultDt.Rows.Count > 0)
                        {
                            txtSteam.Text =  objResult.ResultDt.Rows[0][UtilityConsumptionCostBO.UtilityCost_SteamCost].ToString();
                            txtChilledWater.Text = objResult.ResultDt.Rows[0][UtilityConsumptionCostBO.UtilityCost_ChilledWaterCost].ToString();
                            txtElectricity.Text = objResult.ResultDt.Rows[0][UtilityConsumptionCostBO.UtilityCost_ElectricityCost].ToString();
                            txtAir.Text = objResult.ResultDt.Rows[0][UtilityConsumptionCostBO.UtilityCost_AirCost].ToString();
                            txtSoftWater.Text = objResult.ResultDt.Rows[0][UtilityConsumptionCostBO.UtilityCost_SoftWaterCost].ToString();
                            //BindMaintenance();
                            PanelVisibilityMode(false, true);
                        }
                    }
                }
                //else if (e.CommandName.ToString() == "Delete1")
                //{
                //    var objResult = objBL.TankerLabReportDelete(Convert.ToInt32(e.CommandArgument.ToString()), Convert.ToInt32(Session[ApplicationSession.Userid]), DateTime.UtcNow.AddHours(5.5).ToString());
                //    if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                //    {
                //        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Record Deleted Successfully!');</script>");
                //        PanelVisibilityMode(true, false);
                //        BindTankReport();
                //    }
                //    else
                //    {
                //        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
                //    }
                //}
            }
            catch (Exception ex)
            {
                // log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }
        #endregion 

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