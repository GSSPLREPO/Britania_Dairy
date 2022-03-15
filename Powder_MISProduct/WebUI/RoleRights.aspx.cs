using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Powder_MISProduct.BL;
using Powder_MISProduct.BO;
using Powder_MISProduct.Common;
using System.Data;
using log4net;

namespace Powder_MISProduct.WebUI
{
    public partial class RoleRights : System.Web.UI.Page
    {
        private static ILog log = LogManager.GetLogger(typeof(RoleRights));

        #region Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    BindRole();
                    BindRoleRights();
                    PanelVisibilityMode(1);
                }
                catch (Exception ex)
                {
                    log.Error("Error", ex);
                    ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
                }
            }
        }
        #endregion



        #region Bind Role
        public void BindRole()
        {
            try
            {
                RoleBl objRoleBl = new RoleBl();
                Controls objControls = new Controls();
                var objResult = objRoleBl.Role_SelectAll();
                if (objResult != null)
                {
                    if (objResult.ResultDt.Rows.Count > 0)
                    {
                        objControls.BindDropDown_ListBox(objResult.ResultDt, ddlRole, "Name", "Id");
                    }
                    ddlRole.Items.Insert(0, new ListItem("--Select--", "-1"));
                }
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }
        #endregion

        #region Bind RoleRights
        public void BindRoleRights()
        {
            try
            {
                ScreenBL objScreenBl = new ScreenBL();
                var objResult = objScreenBl.Screen_SelectAll(1);
                if (objResult != null)
                {
                    gvRoleRightsWeb.DataSource = objResult.ResultDt;
                    gvRoleRightsWeb.DataBind();
                    if (gvRoleRightsWeb.Rows.Count > 1)
                    {
                        PanelVisibilityMode(2);
                    }
                    else
                    {
                        PanelVisibilityMode(1);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region GridView PreRender Event
        protected void gvSupplierList_OnPreRender(object sender, EventArgs e)
        {
            try
            {
                if (gvRoleRightsWeb.Rows.Count > 0)
                {
                    gvRoleRightsWeb.UseAccessibleHeader = true;
                    gvRoleRightsWeb.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }
        #endregion

        #region WebSave Button Click Event
        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            try
            {
                RoleRightsBl objRoleRightsBl = new RoleRightsBl();
                RoleRightsBo objRoleRightsBo = new RoleRightsBo();
                CheckBox chk;

                var objResult = objRoleRightsBl.RoleRights_Delete(Convert.ToInt32(ddlRole.SelectedValue), 1);

                for (int i = 0; i < gvRoleRightsWeb.Rows.Count; i++)
                {
                    chk = (CheckBox)gvRoleRightsWeb.Rows[i].Cells[2].FindControl("chkSelectWeb");
                    if (chk.Checked == true)
                    {
                        objRoleRightsBo.RoleId = Convert.ToInt32(ddlRole.SelectedValue);
                        objRoleRightsBo.ScreenId = Convert.ToInt32(gvRoleRightsWeb.Rows[i].Cells[0].Text);

                        objResult = objRoleRightsBl.RoleRights_Insert(objRoleRightsBo);
                    }
                }
                if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                {
                    ClearAll();
                    BindRoleRights();
                    ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Roles Applied Successfully');</script>");
                }
            }
            catch (Exception ex)
            {
                log.Error("error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }
        #endregion



        #region DropDown Role Selected Index change event
        protected void ddlRole_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                RoleRightsBl objRoleRightsBl = new RoleRightsBl();
                DataTable dt = new DataTable();
                DataTable dtRoleRight = new DataTable();
                dt.Rows.Clear();
                gvRoleRightsWeb.DataSource = dt;
                gvRoleRightsWeb.DataBind();
                BindRoleRights();

                var objResult = objRoleRightsBl.RoleRights_Select(Convert.ToInt32(ddlRole.SelectedValue), 1);
                dtRoleRight = objResult.ResultDt;
                if (dtRoleRight.Rows.Count > 0)
                {
                    int j = 0;
                    foreach (GridViewRow rowItem in gvRoleRightsWeb.Rows)
                    {
                        for (int i = 0; i < dtRoleRight.Rows.Count; i++)
                        {
                            if (gvRoleRightsWeb.Rows[j].Cells[0].Text.ToString() == dtRoleRight.Rows[i]["ScreenId"].ToString())
                            {
                                CheckBox chk = (CheckBox)gvRoleRightsWeb.Rows[j].FindControl("chkSelectWeb");
                                chk.Checked = true;
                            }
                        }
                        j++;
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error("error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }
        #endregion



        #region PanelVisibilityMode Method
        private void PanelVisibilityMode(int intmode)
        {
            if (intmode == 1)
            {
                divGrid.Visible = true;
            }
            else if (intmode == 2)
            {
                divGrid.Visible = true;
            }
        }
        #endregion

        #region ClearAll
        private void ClearAll()
        {
            Controls objcontrol = new Controls();
            objcontrol.ClearForm(Master.FindControl("ContentPlaceHolder1"));
            ViewState["Mode"] = "Save";
        }
        #endregion

    }
}