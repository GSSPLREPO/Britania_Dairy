using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.SessionState;


namespace Powder_MISProduct.Common
{
   public class ApplicationSession
    {
        private static HttpSessionState _mvarSession;

        public static void Init(HttpSessionState session)
        {
            _mvarSession = session;
        }

        #region Constant declaration of the session variable

        public const string Username = "UserName";
        public const string Userid = "UserId";
        public const string Roleid = "RoleID";
        public const string OrganisationName = "OrganisationName";
        public const string OrganisationAddress = "OrganisationAddress";
        public const string Logo = "";


        public static void ClearAllSessions()
        {
            _mvarSession.Remove(Username);
        }
        #endregion
    }
}
