using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Powder_MISProduct.BL;
using Powder_MISProduct.BO;
using Powder_MISProduct.Common;
using log4net;

namespace Powder_MISProduct.WebUI
{
    public partial class Shift : System.Web.UI.Page
    {
        private static ILog log = LogManager.GetLogger(typeof(Shift));

        #region Page Load Event
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (IsPostBack) return;
                if (Session[ApplicationSession.Userid] != null)
                {
                    ViewState["Mode"] = "Save";
                    PanelVisibilityMode(true, false);
                    BindgvShift();
                }
                else
                {
                    Response.Redirect("../Default.aspx?SessionMode=Logout", false);
                }
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                    "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
            }
        }
        #endregion



        #region Bind Reception
        private void BindgvShift()
        {
            ApplicationResult objResult = new ApplicationResult();
            ShiftBl objReceptionBl = new ShiftBl();
            objResult = objReceptionBl.Shift_SelectAll();
            if (objResult != null)
            {
                gvShift.DataSource = objResult.ResultDt;
                gvShift.DataBind();
                PanelVisibilityMode(true, false);
            }
        }
        #endregion



        #region Buttton btnSave Click Event
        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            try
            {
                ShiftBo objShiftBo = new ShiftBo();
                ShiftBl objShiftBl = new ShiftBl();
                string strFromTime = string.Empty;
                string strToTime = string.Empty;
                objShiftBo.Name = txtName.Text.Trim();
                strFromTime = txtFromTime.Text;
                strToTime = txtToTime.Text;
                if (ViewState["Mode"].ToString() == "Save")
                {
                    objShiftBo.CreatedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
                    objShiftBo.CreatedDate = DateTime.UtcNow.AddHours(5.5);
                    var objResult = objShiftBl.Shift_Insert(objShiftBo, strFromTime, strToTime);
                    if (objResult != null)
                    {
                        if (objResult.ResultDt.Rows.Count > 0)
                        {
                            int intStatus = Convert.ToInt32(objResult.ResultDt.Rows[0]["Status"].ToString());
                            if (intStatus == 0)
                            {
                                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('" + txtName.Text + " is already exist.');</script>");
                            }
                            else
                            {
                                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Record Saved Successfully.');</script>");
                                ClearAll();
                                BindgvShift();
                                PanelVisibilityMode(true, false);
                            }
                        }
                    }
                }
                else if (ViewState["Mode"].ToString() == "Edit")
                {
                    objShiftBo.LastModifiedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
                    objShiftBo.LastModifiedDate = DateTime.UtcNow.AddHours(5.5);
                    objShiftBo.ShiftId = Convert.ToInt32(ViewState["ID"].ToString());
                    var objResult = objShiftBl.Shift_Update(objShiftBo, strFromTime, strToTime);
                    if (objResult != null)
                    {
                        if (objResult.ResultDt.Rows.Count > 0)
                        {
                            int intStatus = Convert.ToInt32(objResult.ResultDt.Rows[0]["Status"].ToString());
                            if (intStatus == 0)
                            {
                                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('" + txtName.Text + " is already exist.');</script>");
                            }
                            else
                            {
                                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Record Updated Successfully.');</script>");
                                ClearAll();
                                BindgvShift();
                                PanelVisibilityMode(true, false);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
            }
        }
        #endregion

        #region Button btnAddNew Click Event
        protected void btnAddNew_OnClick(object sender, EventArgs e)
        {
            ClearAll();
            PanelVisibilityMode(false, true);
        }
        #endregion

        #region Button btnViewList Click Event
        protected void btnViewList_OnClick(object sender, EventArgs e)
        {
            try
            {
                ClearAll();
                PanelVisibilityMode(true, false);
                BindgvShift();
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
            }
        }
        #endregion



        #region gvShift Pre Render Event
        protected void gvShift_OnPreRender(object sender, EventArgs e)
        {
            try
            {
                if (gvShift.Rows.Count <= 0) return;
                gvShift.UseAccessibleHeader = true;
                gvShift.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
            }
        }
        #endregion

        #region gvShift Row Command Event
        protected void gvShift_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                ShiftBl objShiftBL = new ShiftBl();
                if (e.CommandName == "Edit1")
                {
                    ViewState["Mode"] = "Edit";
                    ViewState["ID"] = e.CommandArgument.ToString();
                    var objResult = objShiftBL.Shift_Select(Convert.ToInt32(ViewState["ID"].ToString()));
                    if (objResult != null)
                    {
                        if (objResult.ResultDt.Rows.Count > 0)
                        {
                            txtName.Text = objResult.ResultDt.Rows[0][ShiftBo.SHIFT_NAME].ToString();
                            txtFromTime.Text = objResult.ResultDt.Rows[0][ShiftBo.SHIFT_FROMTIME].ToString();
                            txtToTime.Text = objResult.ResultDt.Rows[0][ShiftBo.SHIFT_TOTIME].ToString();
                            PanelVisibilityMode(false, true);
                        }
                    }
                }
                else if (e.CommandName == "Delete1")
                {
                    var objResult = objShiftBL.Shift_Delete(Convert.ToInt32(e.CommandArgument.ToString()), Convert.ToInt32(Session[ApplicationSession.Userid].ToString()), System.DateTime.UtcNow.AddHours(5.5).ToString());
                    if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                    {
                        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Record Deleted Successfully.');</script>");
                        PanelVisibilityMode(true, false);
                        BindgvShift();
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('You can not delete this Reception because it is in used.');</script>");
                    }
                }

            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
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