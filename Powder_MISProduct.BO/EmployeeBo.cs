using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Powder_MISProduct.BO
{
    public class EmployeeBo
    {
        #region Employee Class Properties

        public const string EMPLOYEE_TABLE = "Employee";
        public const string EMPLOYEE_ID = "Id";
        public const string EMPLOYEE_NAME = "Name";
        public const string EMPLOYEE_CODE = "Code";
        public const string EMPLOYEE_BRANCHID = "BranchId";
        public const string EMPLOYEE_ORGANISATIONID = "OrganisationId";
        public const string EMPLOYEE_ROLEID = "RoleId";
        public const string EMPLOYEE_DEPARTMENTID = "DepartmentId";
        public const string EMPLOYEE_DESIGNATIONID = "DesignationId";
        public const string EMPLOYEE_REPORTINGTOID = "ReportingToId";
        public const string EMPLOYEE_ADDRESS = "Address";
        public const string EMPLOYEE_CONTACTNO = "ContactNo";
        public const string EMPLOYEE_MOBILENO = "MobileNo";
        public const string EMPLOYEE_EMAIL = "Email";
        public const string EMPLOYEE_ISUSER = "IsUser";
        public const string EMPLOYEE_USERNAME = "UserName";
        public const string EMPLOYEE_PASSWORD = "Password";
        public const string EMPLOYEE_JOINDATE = "JoinDate";
        public const string EMPLOYEE_BIRTHDATE = "BirthDate";
        public const string EMPLOYEE_MARRIAGEDATE = "MarriageDate";
        public const string EMPLOYEE_ALLOWACCOUNTACCESS = "AllowAccountAccess";
        public const string EMPLOYEE_ISRESIGNED = "IsResigned";
        public const string EMPLOYEE_RESIGNATIONDATE = "ResignationDate";
        public const string EMPLOYEE_LASTWORKINGDATE = "LastWorkingDate";
        public const string EMPLOYEE_ISDELETED = "IsDeleted";
        public const string EMPLOYEE_CREATEDBY = "CreatedBy";
        public const string EMPLOYEE_CREATEDDATE = "CreatedDate";
        public const string EMPLOYEE_LASTMODIFIEDBY = "LastModifiedBy";
        public const string EMPLOYEE_LASTMODIFIEDDATE = "LastModifiedDate";



        private int intId = 0;
        private string strName = string.Empty;
        private string strCode = string.Empty;
        private int intBranchId = 0;
        private int intOrganisationId = 0;
        private int intRoleId = 0;
        private int intDepartmentId = 0;
        private int intDesignationId = 0;
        private int intReportingToId = 0;
        private string strAddress = string.Empty;
        private string strContactNo = string.Empty;
        private string strMobileNo = string.Empty;
        private string strEmail = string.Empty;
        private int intIsUser = 0;
        private string strUserName = string.Empty;
        private string strPassword = string.Empty;
        private string strJoinDate = string.Empty;
        private string strBirthDate = string.Empty;
        private string strMarriageDate = string.Empty;
        private int intAllowAccountAccess = 0;
        private int intIsResigned = 0;
        private string strResignationDate = string.Empty;
        private string strLastWorkingDate = string.Empty;
        private int intIsDeleted = 0;
        private int intCreatedBy = 0;
        private string strCreatedDate = string.Empty;
        private int intLastModifiedBy = 0;
        private string strLastModifiedDate = string.Empty;

        #endregion

        #region ---Properties---
        public int Id
        {
            get { return intId; }
            set { intId = value; }
        }
        public string Name
        {
            get { return strName; }
            set { strName = value; }
        }
        public string Code
        {
            get { return strCode; }
            set { strCode = value; }
        }
        public int BranchId
        {
            get { return intBranchId; }
            set { intBranchId = value; }
        }
        public int OrganisationId
        {
            get { return intOrganisationId; }
            set { intOrganisationId = value; }
        }
        public int RoleId
        {
            get { return intRoleId; }
            set { intRoleId = value; }
        }
        public int DepartmentId
        {
            get { return intDepartmentId; }
            set { intDepartmentId = value; }
        }
        public int DesignationId
        {
            get { return intDesignationId; }
            set { intDesignationId = value; }
        }
        public int ReportingToId
        {
            get { return intReportingToId; }
            set { intReportingToId = value; }
        }
        public string Address
        {
            get { return strAddress; }
            set { strAddress = value; }
        }
        public string ContactNo
        {
            get { return strContactNo; }
            set { strContactNo = value; }
        }
        public string MobileNo
        {
            get { return strMobileNo; }
            set { strMobileNo = value; }
        }
        public string Email
        {
            get { return strEmail; }
            set { strEmail = value; }
        }
        public int IsUser
        {
            get { return intIsUser; }
            set { intIsUser = value; }
        }
        public string UserName
        {
            get { return strUserName; }
            set { strUserName = value; }
        }
        public string Password
        {
            get { return strPassword; }
            set { strPassword = value; }
        }
        public string JoinDate
        {
            get { return strJoinDate; }
            set { strJoinDate = value; }
        }
        public string BirthDate
        {
            get { return strBirthDate; }
            set { strBirthDate = value; }
        }
        public string MarriageDate
        {
            get { return strMarriageDate; }
            set { strMarriageDate = value; }
        }
        public int AllowAccountAccess
        {
            get { return intAllowAccountAccess; }
            set { intAllowAccountAccess = value; }
        }
        public int IsResigned
        {
            get { return intIsResigned; }
            set { intIsResigned = value; }
        }
        public string ResignationDate
        {
            get { return strResignationDate; }
            set { strResignationDate = value; }
        }
        public string LastWorkingDate
        {
            get { return strLastWorkingDate; }
            set { strLastWorkingDate = value; }
        }
        public int IsDeleted
        {
            get { return intIsDeleted; }
            set { intIsDeleted = value; }
        }
        public int CreatedBy
        {
            get { return intCreatedBy; }
            set { intCreatedBy = value; }
        }
        public string CreatedDate
        {
            get { return strCreatedDate; }
            set { strCreatedDate = value; }
        }
        public int LastModifiedBy
        {
            get { return intLastModifiedBy; }
            set { intLastModifiedBy = value; }
        }
        public string LastModifiedDate
        {
            get { return strLastModifiedDate; }
            set { strLastModifiedDate = value; }
        }

        #endregion
    }
}
