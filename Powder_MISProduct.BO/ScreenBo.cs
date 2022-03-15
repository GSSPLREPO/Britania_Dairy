using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Powder_MISProduct.BO
{
   public class ScreenBo
    {
        #region Screen Class Properties

        public const string SCREEN_TABLE = "Screen";
        public const string SCREEN_ID = "Id";
        public const string SCREEN_SCREENNAME = "ScreenName";
        public const string SCREEN_DISPLAYNAME = "DisplayName";
        public const string SCREEN_ISDELETED = "IsDeleted";



        private int intId = 0;
        private string strScreenName = string.Empty;
        private string strDisplayName = string.Empty;
        private int intIsDeleted = 0;

        #endregion

        #region ---Properties---
        public int Id
        {
            get { return intId; }
            set { intId = value; }
        }
        public string ScreenName
        {
            get { return strScreenName; }
            set { strScreenName = value; }
        }
        public string DisplayName
        {
            get { return strDisplayName; }
            set { strDisplayName = value; }
        }
        public int IsDeleted
        {
            get { return intIsDeleted; }
            set { intIsDeleted = value; }
        }

        #endregion
    }
}
