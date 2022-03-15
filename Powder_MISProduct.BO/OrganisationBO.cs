using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Powder_MISProduct.BO
{
  public  class OrganisationBO
    {
        #region LabReport Class Properties

        public const string ORGANISATION_TABLE = "Organisation";
        public const string ORGANISATION_ID = "Id";
        public const string ORGANISATION_NAME = "Name";
        public const string ORGANISATION_ADDRESS = "Address";
        public const string ORGANISATION_CONTACTNO = "ContactNo";
        public const string ORGANISATION_EMAILID = "EmailId";
        public const string ORGANISATION_LOGOURL = "LogoURL";
        public const string ORGANISATION_LOGOBGIMG = "LogoBGImg";
        public const string ORGANISATION_CREATEDBY = "CreatedBy";
        public const string ORGANISATION_CREATEDDATE = "CreatedDate";
        public const string ORGANISATION_LASTMODIFIEDBY = "LastModifiedBy";
        public const string ORGANISATION_LASTMODIFIEDDATE = "LastModifiedDate";



        private int intId = 0;
        private string strName = string.Empty;
        private string strAddress = string.Empty;
        private string strContactNo = string.Empty;
        private string strEmailId = string.Empty;
        private string strLogoUrl = string.Empty;
        private string strLogoBgImg = string.Empty;
        private int intCreatedBy = 0;
        private DateTime dtCreatedDate;
        private int intLastModifiedBy = 0;
        private DateTime dtLastModifiedDate;

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
        public string EmailID
        {
            get { return strEmailId; }
            set { strEmailId = value; }
        }

        public string LOGOUrl
        {
            get { return strLogoUrl; }
            set { strLogoUrl = value; }
        }
        public string LogoBGImg
        {
            get { return strLogoBgImg; }
            set { strLogoBgImg = value; }
        }

        public int CreatedBy
        {
            get { return intCreatedBy; }
            set { intCreatedBy = value; }
        }
        public DateTime CreatedDate
        {
            get { return dtCreatedDate; }
            set { dtCreatedDate = value; }
        }
        public int LastModifiedBy
        {
            get { return intLastModifiedBy; }
            set { intLastModifiedBy = value; }
        }
        public DateTime LastModifiedDate
        {
            get { return dtLastModifiedDate; }
            set { dtLastModifiedDate = value; }
        }

        #endregion
    }
}
