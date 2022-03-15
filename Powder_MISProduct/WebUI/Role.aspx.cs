using System;
using System.Web.UI;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Powder_MISProduct.BL;
using Powder_MISProduct.BO;
using Powder_MISProduct.Common;
using log4net;

namespace Powder_MISProduct.WebUI
{
    public partial class Role : System.Web.UI.Page
    {
        private static ILog log = LogManager.GetLogger(typeof(Role));

        #region Page Load Event
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    ViewState["Mode"] = "Save";
                    ViewState["Id"] = 0;
                    BindRole();
                }
                catch (Exception ex)
                {
                    log.Error("Error", ex);
                    ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
                }
            }
        }
        #endregion



        #region BindRole
        public void BindRole()
        {
            try
            {
                RoleBl objRoleBL = new RoleBl();
                var objResult = objRoleBL.Role_SelectAll();
                if (objResult != null)
                {
                    gvRole.DataSource = objResult.ResultDt;
                    gvRole.DataBind();
                    if (gvRole.Rows.Count > 0)
                    {
                        PanelVisibilityMode(1);
                    }
                    else
                    {
                        PanelVisibilityMode(2);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion



        #region Save Button Click event
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    RoleBo objRoleBO = new RoleBo();
                    RoleBl objRoleBL = new RoleBl();
                    objRoleBO.Name = txtName.Text.Trim();
                    objRoleBO.Description = txtDescription.Text.Trim();

                    if (ViewState["Mode"].ToString() == "Save")
                    {
                        objRoleBO.CreatedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
                        objRoleBO.CreatedDate = DateTime.UtcNow.AddHours(5.5).ToShortDateString();
                        var objResult = objRoleBL.Role_Insert(objRoleBO);
                        if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Record Saved Successfully!');</script>");
                            BindRole();
                            ClearAll();
                            PanelVisibilityMode(1);
                            ViewState["Mode"] = "Save";
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Record already exist.');</script>");
                        }
                    }
                    else if (ViewState["Mode"].ToString() == "Edit")
                    {
                        objRoleBO.Id = Convert.ToInt32(ViewState["Id"].ToString());
                        objRoleBO.LastModifiedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
                        objRoleBO.LastModifiedDate = DateTime.UtcNow.AddHours(5.5).ToString();
                        var objResult = objRoleBL.Role_Update(objRoleBO);
                        if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Record Updated Successfully.');</script>");
                            BindRole();
                            ClearAll();
                            PanelVisibilityMode(1);
                            ViewState["Mode"] = "Save";
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Record already exist.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }
        #endregion

        #region ViewList Button Click Event
        protected void btnViewList_Click(object sender, EventArgs e)
        {
            ClearAll();
            PanelVisibilityMode(1);
        }
        #endregion

        #region AddNew Button Click Event
        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            ClearAll();
            PanelVisibilityMode(2);
        }
        #endregion



        #region GridView Events[PreRender, RowCommand]
        protected void gvRole_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gvRole.Rows.Count > 0)
                {
                    gvRole.UseAccessibleHeader = true;
                    gvRole.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }

        protected void gvRole_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                RoleBl objRoleBL = new RoleBl();
                if (e.CommandName.ToString() == "Edit1")
                {
                    ViewState["Mode"] = "Edit";
                    ViewState["Id"] = e.CommandArgument.ToString();
                    var objResult = objRoleBL.Role_Select(Convert.ToInt32(e.CommandArgument.ToString()));
                    if (objResult != null)
                    {
                        if (objResult.ResultDt.Rows.Count > 0)
                        {
                            txtName.Text = objResult.ResultDt.Rows[0][RoleBo.ROLE_NAME].ToString();
                            txtDescription.Text = objResult.ResultDt.Rows[0][RoleBo.ROLE_DESCRIPTION].ToString();

                            BindRole();
                            PanelVisibilityMode(2);
                        }
                    }
                }
                else if (e.CommandName.ToString() == "Delete1")
                {
                    var objResult = objRoleBL.Role_Delete(Convert.ToInt32(e.CommandArgument.ToString()), Convert.ToInt32(Session[ApplicationSession.Userid]), DateTime.UtcNow.AddHours(5.5).ToString());
                    if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                    {
                        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Record Deleted Successfully');</script>");
                        PanelVisibilityMode(1);
                        BindRole();
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
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

        #region PanelVisibilityMode Method
        private void PanelVisibilityMode(int intmode)
        {
            if (intmode == 1)
            {
                divGrid.Visible = true;
                divPanel.Visible = false;
            }
            else if (intmode == 2)
            {
                divGrid.Visible = false;
                divPanel.Visible = true;
            }
        }
        #endregion
    }
}