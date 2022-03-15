using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Powder_MISProduct.BO
{
   public class RoleBo
    {
        #region Role Class Properties

        public const string ROLE_TABLE = "Role";
        public const string ROLE_ROLEID = "Id";
        public const string ROLE_NAME = "Name";
        public const string ROLE_DESCRIPTION = "Description";
        public const string ROLE_ORGANISATIONID = "OrganisationId";
        public const string ROLE_ISDELETED = "IsDeleted";
        public const string ROLE_CREATEDBY = "CreatedBy";
        public const string ROLE_CREATEDDATE = "CreatedDate";
        public const string ROLE_LASTMODIFIEDBY = "LastModifiedBy";
        public const string ROLE_LASTMODIFIEDDATE = "LastModifiedDate";



        private int intId = 0;
        private string strName = string.Empty;
        private string strDescription = string.Empty;
        private int intOrganisationId = 0;
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
        public string Description
        {
            get { return strDescription; }
            set { strDescription = value; }
        }
        public int OrganisationId
        {
            get { return intOrganisationId; }
            set { intOrganisationId = value; }
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
