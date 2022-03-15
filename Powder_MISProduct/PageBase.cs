using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Powder_MISProduct.Common;
namespace Powder_MISProduct
{
    public class PageBase : System.Web.UI.Page
    {
        #region OnInit
        protected override void OnInit(EventArgs e)
        {
            if (Session[ApplicationSession.Username] == null)
            {
                Response.Redirect("../Default.aspx");

            }

            base.OnInit(e);
        }
        #endregion



        #region PagePreRender
        /// <summary>
        /// Pre Render event for evey page calling pagebase
        /// </summary>
        /// <param name="e"></param>
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            #region Stop Back space
            string strDisAbleBackButton;
            strDisAbleBackButton = "<script language='javascript'>\n window.history.forward(1);\n\n</script>";
            Page.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "clientScript", strDisAbleBackButton);
            #endregion
        }
        #endregion

    }
}