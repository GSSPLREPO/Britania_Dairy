using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Powder_MISProduct.BO
{
    public class ShiftBo
    {
        #region Shift Class Properties

        public const string SHIFT_TABLE = "Shift";
        public const string SHIFT_SHIFTID = "ShiftId";
        public const string SHIFT_NAME = "Name";
        public const string SHIFT_FROMTIME = "FromTime";
        public const string SHIFT_TOTIME = "ToTime";
        public const string SHIFT_ISDELETED = "IsDeleted";
        public const string SHIFT_LASTMODIFIEDBY = "LastModifiedBy";
        public const string SHIFT_LASTMODIFIEDDATE = "LastModifiedDate";
        public const string SHIFT_CREATEDDATE = "CreatedDate";
        public const string SHIFT_CREATEDBY = "CreatedBy";



        private int intShiftId = 0;
        private string strName = string.Empty;
        private DateTime? dtFromTime = null;
        private DateTime? dtToTime = null;
        private int intIsDeleted = 0;
        private int intLastModifiedBy = 0;
        private DateTime? dtLastModifiedDate = null;
        private DateTime? dtCreatedDate = null;
        private int intCreatedBy = 0;

        #endregion

        #region ---Properties---
        public int ShiftId
        {
            get { return intShiftId; }
            set { intShiftId = value; }
        }
        public string Name
        {
            get { return strName; }
            set { strName = value; }
        }

        public DateTime FromTime
        {
            get { return (DateTime)dtFromTime; }
            set { dtFromTime = value; }
        }

        public DateTime ToTime
        {
            get { return (DateTime)dtToTime; }
            set { dtToTime = value; }
        }

        public int IsDeleted
        {
            get { return intIsDeleted; }
            set { intIsDeleted = value; }
        }
        public int LastModifiedBy
        {
            get { return intLastModifiedBy; }
            set { intLastModifiedBy = value; }
        }
        public DateTime LastModifiedDate
        {
            get { return (DateTime)dtLastModifiedDate; }
            set { dtLastModifiedDate = value; }
        }
        public DateTime CreatedDate
        {
            get { return (DateTime)dtCreatedDate; }
            set { dtCreatedDate = value; }
        }
        public int CreatedBy
        {
            get { return intCreatedBy; }
            set { intCreatedBy = value; }
        }

        #endregion
    }
}
