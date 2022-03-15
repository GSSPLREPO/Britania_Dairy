using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Powder_MISProduct.Common
{
   public class QueryStringProcessor
    {
        /// <summary>
        /// Removes duplicate parameters from a querystring.
        /// This function is useful under the following condition:
        /// Suppose a page A wants to forward the querystring that it received to next form B.  A uses Request.QueryString.ToString() for forwarding querystring.
        /// But, the problem is if A adds its own querystring variable 'x' and when in turn is called back by B.  B also forwards querystring using
        /// Request.QueryString.ToString().  Here, querystring variable 'x' will be again appended by A even if it is present in querystring.
        /// So, to remove such duplicate querystring variables, this method can be used.
        /// </summary>
        /// <param name="queryString">The full querystring with/without '?'</param>
        /// <returns></returns>

        public static string ExcludeDuplicateParameter(string queryString)
        {
            if (queryString.Trim() == "")
                return "";


            queryString = queryString.Trim();
            if (queryString[queryString.Length - 1] == '&')
                queryString = queryString.Remove(queryString.Length - 1, 1);

            string[] strParameters = queryString.Split('&');

            Powder_MISProduct.Common.UniqueArrayList objUniquePara = new Powder_MISProduct.Common.UniqueArrayList();

            foreach (string strPara in strParameters)//this loop will leave us with only unique parameters
                objUniquePara.Add(strPara);

            StringBuilder objCleanQS = new StringBuilder("");

            foreach (string strPara in objUniquePara)//rebuild the entire querystring
                objCleanQS.Append(strPara + "&");

            objCleanQS.Remove(objCleanQS.Length - 1, 1);

            return objCleanQS.ToString();

        }
    }
}
