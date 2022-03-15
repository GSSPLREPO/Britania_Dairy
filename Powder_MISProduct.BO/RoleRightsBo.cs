using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Powder_MISProduct.BO
{
   public class RoleRightsBo
    {
        #region RoleRights Class Properties

        public const string ROLERIGHTS_TABLE = "RoleRights";
        public const string ROLERIGHTS_ROLERIGHTSID = "RoleRightsId";
        public const string ROLERIGHTS_ROLEID = "RoleId";
        public const string ROLERIGHTS_SCREENID = "ScreenId";



        private int intRoleRightsId = 0;
        private int intRoleId = 0;
        private int intScreenId = 0;

        #endregion

        #region ---Properties---
        public int RoleRightsId
        {
            get { return intRoleRightsId; }
            set { intRoleRightsId = value; }
        }
        public int RoleId
        {
            get { return intRoleId; }
            set { intRoleId = value; }
        }
        public int ScreenId
        {
            get { return intScreenId; }
            set { intScreenId = value; }
        }

        #endregion
    }
}
