using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Powder_MISProduct.BL;
using Powder_MISProduct.BO;
using Powder_MISProduct.Common;
using log4net;

namespace Powder_MISProduct.WebUI
{
    public partial class Employee : System.Web.UI.Page
    {
        private static ILog log = LogManager.GetLogger(typeof(Employee));

        #region Page Load Event
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    ViewState["Mode"] = "Save";
                    BindEmployee();
                    ViewState["Id"] = 0;
                    ClearAll();
                    BindRole();
                    hfIsUser.Value = "0";
                    txtJoinDate.Attributes.Add("readonly", "readonly");
                    txtBirthDate.Attributes.Add("readonly", "readonly");
                    txtLastWorkingDate.Attributes.Add("readonly", "readonly");
                    txtMarriageDate.Attributes.Add("readonly", "readonly");
                    txtResignDate.Attributes.Add("readonly", "readonly");
                }
                catch (Exception ex)
                {
                    log.Error("Error", ex);
                    ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
                }
            }
        }
        #endregion



        #region BindEmployee
        public void BindEmployee()
        {
            try
            {
                EmployeeBl objEmployeeBL = new EmployeeBl();
                var objResult = objEmployeeBL.Employee_SelectAll();
                if (objResult != null)
                {
                    gvEmployee.DataSource = objResult.ResultDt;
                    gvEmployee.DataBind();
                    if (gvEmployee.Rows.Count > 0)
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

        #region BindRole
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



        #region Save Button Click event
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (hfIsUser.Value != "1")
                {
                    rfUserName.Enabled = false;
                    rfPassword.Enabled = false;
                    rfRePassword.Enabled = false;
                    cvRePassword.Enabled = false;
                }
                if (Page.IsValid)
                {
                    EmployeeBo objEmployeeBO = new EmployeeBo();
                    EmployeeBl objEmployeeBL = new EmployeeBl();

                    objEmployeeBO.Name = txtName.Text.Trim();
                    objEmployeeBO.Code = txtCode.Text.Trim();
                    objEmployeeBO.RoleId = Convert.ToInt32(ddlRole.SelectedValue);
                    objEmployeeBO.Address = txtAddress.Text.Trim();
                    objEmployeeBO.ContactNo = txtContactNo.Text.Trim();
                    objEmployeeBO.MobileNo = txtMobileNo.Text.Trim();
                    objEmployeeBO.Email = txtEmail.Text.Trim();
                    objEmployeeBO.UserName = txtUserName.Text.Trim();
                    objEmployeeBO.Password = txtPassword.Text.Trim();
                    objEmployeeBO.JoinDate = txtJoinDate.Text.Trim();
                    objEmployeeBO.BirthDate = txtBirthDate.Text.Trim();
                    objEmployeeBO.MarriageDate = txtMarriageDate.Text.Trim();
                    objEmployeeBO.AllowAccountAccess = 0;
                    if (ViewState["Mode"].ToString() == "Save")
                    {
                        objEmployeeBO.CreatedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
                        objEmployeeBO.CreatedDate = DateTime.UtcNow.AddHours(5.5).ToShortDateString();
                        var objResult = objEmployeeBL.Employee_Insert(objEmployeeBO);
                        if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Record Saved Successfully!');</script>");
                            BindEmployee();
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
                        objEmployeeBO.Id = Convert.ToInt32(ViewState["Id"].ToString());
                        objEmployeeBO.LastModifiedBy = Convert.ToInt32(Session[ApplicationSession.Userid]);
                        objEmployeeBO.LastModifiedDate = DateTime.UtcNow.AddHours(5.5).ToString();
                        var objResult = objEmployeeBL.Employee_Update(objEmployeeBO);
                        if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                        {
                            ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                                "<script>alert('Record Updated Successfully.');</script>");
                            BindEmployee();
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
            try
            {
                ClearAll();
                PanelVisibilityMode(2);
                divIsResignDate.Visible = false;
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }
        #endregion



        #region Employee GridView Events[PreRender, RowCommand]
        protected void gvEmployee_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gvEmployee.Rows.Count > 0)
                {
                    gvEmployee.UseAccessibleHeader = true;
                    gvEmployee.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
            }
            catch (Exception ex)
            {
                log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical issue. Please Contact to your administrator.');</script>");
            }
        }

        protected void gvEmployee_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                EmployeeBl objEmployeeBL = new EmployeeBl();
                if (e.CommandName.ToString() == "Edit1")
                {
                    divIsResignDate.Visible = true;
                    ViewState["Mode"] = "Edit";
                    ViewState["Id"] = e.CommandArgument.ToString();
                    var objResult = objEmployeeBL.Employee_Select(Convert.ToInt32(e.CommandArgument.ToString()));
                    if (objResult != null)
                    {
                        if (objResult.ResultDt.Rows.Count > 0)
                        {
                            txtName.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_NAME].ToString();
                            txtCode.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_CODE].ToString();
                            ddlRole.SelectedValue = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_ROLEID].ToString();
                            txtAddress.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_ADDRESS].ToString();
                            txtContactNo.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_CONTACTNO].ToString();
                            txtMobileNo.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_MOBILENO].ToString();
                            txtEmail.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_EMAIL].ToString();
                            if (objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_ISUSER].ToString() == "1")
                            {
                                txtUserName.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_USERNAME].ToString();
                                txtPassword.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_PASSWORD].ToString();
                                txtRePassword.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_PASSWORD].ToString();
                                hfIsUser.Value = "1";
                            }
                            else
                            {
                                hfIsUser.Value = "0";
                                txtUserName.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_USERNAME].ToString();
                                txtPassword.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_PASSWORD].ToString();
                                txtRePassword.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_PASSWORD].ToString();
                            }
                            txtJoinDate.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_JOINDATE].ToString();
                            txtBirthDate.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_BIRTHDATE].ToString();
                            txtMarriageDate.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_MARRIAGEDATE].ToString();
                            if (objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_ISRESIGNED].ToString() == "1")
                            {
                                hfIsResigned.Value = "1";
                                txtResignDate.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_RESIGNATIONDATE].ToString();
                                txtLastWorkingDate.Text = objResult.ResultDt.Rows[0][EmployeeBo.EMPLOYEE_LASTWORKINGDATE].ToString();
                            }
                            else
                            {
                                hfIsResigned.Value = "0";
                            }
                            BindEmployee();
                            PanelVisibilityMode(2);
                        }
                    }
                }
                else if (e.CommandName.ToString() == "Delete1")
                {
                    var objResult = objEmployeeBL.Employee_Delete(Convert.ToInt32(e.CommandArgument.ToString()), Convert.ToInt32(Session[ApplicationSession.Userid]), DateTime.UtcNow.AddHours(5.5).ToString());
                    if (objResult.Status == ApplicationResult.CommonStatusType.Success)
                    {
                        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Record Deleted Successfully');</script>");
                        PanelVisibilityMode(1);
                        BindEmployee();
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
            hfIsUser.Value = "0";
            hfIsResigned.Value = "0";
            rfUserName.Enabled = true;
            rfPassword.Enabled = true;
            rfRePassword.Enabled = true;
            cvRePassword.Enabled = true;
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