using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Globalization;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;
using System.Data;
using System.Web.UI.WebControls;

namespace Powder_MISProduct.Common
{
   public class CommonFunctions
    {
        #region constants
        /// <summary>
        /// stores the size of a single page of grid
        /// </summary>
        public const int GRID_PAGESIZE = 10;

        //changing the culture setting in the web.config will require the changes here.
        /// <summary>
        /// date format
        /// </summary>
        // public const string DATE_PARSE_FORMAT = "dd/MM/yyyy HH:mm:ss";
        public const string DATE_PARSE_FORMAT = "dd/MM/yyyy";

        //mention the null value of a date. It is use to compare the null date. It should have the format of DATE_PARSE_FORMAT const
        /// <summary>
        /// mention the null value of a date. It is use to compare the null date. It should have the format of DATE_PARSE_FORMAT const
        /// </summary>
        public const string DATE_NULL_VALE = "01/01/0001";


        //use this format to display the date in the system
        /// <summary>
        /// use this format to display the date in the system
        /// </summary>
        public const string DATE_FORMAT = "dd/MM/yy HH:mm";

        //mention the date seperator here in the display the date
        /// <summary>
        /// mention the date seperator here in the display the date
        /// </summary>
        public const string DATE_SEPERATOR = "/"; //For Display

        //mention the date format to display in the textbox attach with the calendar control
        /// <summary>
        /// mention the date format to display in the textbox attach with the calendar control
        /// </summary>
        public const string DATE_CALENDAR_FORMAT = "dd/MM/yyyy";
        //public const string DATE_CALENDAR_FORMAT = "dd/MM/yy HH:mm";

        //Setting this parameter will derive the year (e.g. year >= 70?year+1970:year+2000)
        public const bool DERIVE_YEAR = true;

        #endregion

        #region variables

        /// <summary>
        /// a Random class for generating random numbers
        /// </summary>
        public static Random mobjRandom = new Random((int)DateTime.Now.Ticks);
        #endregion

        #region FormatDate
        /// <summary>
        /// returns a datetime object by parsing the given string according to common datetime format
        /// </summary>
        /// <param name="strDate"></param>
        /// <returns></returns>
        public DateTime FormatDate(string strDate)
        {
            return FormatDate(strDate, DATE_PARSE_FORMAT);
        }

        /// <summary>
        /// returns a datetime object by parsing the given string according to common datetime format
        /// </summary>
        /// <param name="strDate"></param>
        /// <param name="strShortDatePattern"></param>
        /// <returns></returns>
        public DateTime FormatDate(string strDate, string strShortDatePattern)
        {
            try
            {
                //DateTime dtCurrentDate = DateTime.ParseExact(strDate.Split(" ".ToCharArray())[0] ,strShortDatePattern,null);
                DateTime dtCurrentDate = DateTime.ParseExact(strDate, strShortDatePattern, null);
                //return dtCurrentDate.Date;
                return dtCurrentDate;
            }
            catch
            {
                return new DateTime(0);
            }
        }
        #endregion

        #region DisplayDate
        /// <summary>
        /// Function use to display the date
        /// </summary>
        /// <param name="strDate"></param>
        /// <returns></returns>
        public string DisplayDate(string strDate)
        {
            if (strDate != null)
                //return DisplayDate(FormatDate(strDate,CultureInfo.CurrentCulture.DateTimeFormat.ShortDatePattern));
                return DisplayDate(FormatDate(strDate, DATE_PARSE_FORMAT));
            else
                return "";
        }

        /// <summary>
        /// formats given datetime according to common date format
        /// </summary>
        /// <param name="dtDate"></param>
        /// <returns></returns>
        public string DisplayDate(DateTime dtDate)
        {
            if (dtDate != new DateTime(0))
                return dtDate.ToString(DATE_FORMAT);
            else
                return "";
        }
        #endregion

        #region Get Current Currency Culture
        /// <summary>
        /// Function use get the current currency culture from config file
        /// </summary>
        /// <returns></returns>
        public string GetCurrentCurrencyCulture()
        {
            string strCurrency;
            CultureInfo objCulture = new CultureInfo(System.Configuration.ConfigurationSettings.AppSettings["CurrentCurrencyCulture"].ToString());
            strCurrency = objCulture.NumberFormat.CurrencySymbol;

            return strCurrency;
        }
        #endregion

        #region Display Amount
        /// <summary>
        /// Function use to display the amount
        /// </summary>
        /// <param name="dcAmount"></param>
        /// <returns></returns>
        public string DisplayAmount(string dcAmount)
        {
            if (dcAmount != "")
            {
                string decAmt;
                string strCurrency = GetCurrentCurrencyCulture();
                decAmt = strCurrency + " " + Decimal.Parse(dcAmount.ToString(), System.Globalization.NumberStyles.Currency).ToString("N");
                return decAmt;
            }
            else
                return "";
        }
        #endregion

        #region Display Amount with two decimal only (without currency sign)
        /// <summary>
        /// Function use to display the amount
        /// </summary>
        /// <param name="dcAmount"></param>
        /// <returns></returns>
        public string DisplayAmount_withoutCurrency(string dcAmount)
        {
            if (dcAmount != "")
            {
                //return System.Configuration.ConfigurationSettings.AppSettings["CurrentCurrencySign"].ToString() + " " + Decimal.Parse(dcAmount.ToString(),System.Globalization.NumberStyles.Currency).ToString("N");
                string strCurrency = GetCurrentCurrencyCulture();
                //CultureInfo objCulture = new CultureInfo(System.Configuration.ConfigurationSettings.AppSettings["CurrentCurrencyCulture"].ToString());
                return strCurrency + " " + Decimal.Parse(dcAmount.ToString(), System.Globalization.NumberStyles.Currency).ToString("N");
            }
            else
                return "";
        }
        #endregion

        #region DisplayDateInCalendarTextBox
        /// <summary>
        /// Function use to Display the date in the Calendar Text box
        /// </summary>
        /// <param name="strDate"></param>
        /// <returns></returns>
        public string DisplayDateInCalendarTextBox(string strDate)
        {
            try
            {
                return DateTime.Parse(strDate).ToString(DATE_CALENDAR_FORMAT);
            }
            catch (Exception)
            {
                return "";
            }
        }
        #endregion

        #region ReturnDateToCurrentCulture
        /// <summary>
        /// Function use to read the Calendar Text box value into the DateTime object
        /// </summary>
        /// <param name="strDate"></param>
        /// <returns></returns>
        public string ReturnDateToCurrentCulture(string strDate)
        {
            strDate = strDate.Replace(DATE_SEPERATOR, "/");
            DateTime dt = FormatDate(strDate, DATE_CALENDAR_FORMAT);

            if (dt == DateTime.MinValue)
                return "";

            if (DERIVE_YEAR == true && dt != new DateTime(0))
            {
                int lintNewYear = 0;
                int lintYear = Int32.Parse(dt.Year.ToString().Substring(2, 2));
                if (lintYear >= 70)
                    lintNewYear = 1900 + lintYear;
                else
                    lintNewYear = 2000 + lintYear;
                dt = new DateTime(lintNewYear, dt.Month, dt.Day, dt.Hour, dt.Minute, dt.Second);
            }
            //return dt.ToString(CultureInfo.CurrentCulture.DateTimeFormat.ShortDatePattern);
            return dt.ToString(DATE_CALENDAR_FORMAT);
        }
        #endregion

        #region AddQryStringToLink

        /// <summary>
        /// Function returns the Qrystring added to the url.
        /// </summary>
        /// <param name="strURL">URL</param>
        /// <returns>Qrystring added to the url</returns>
        public string AddQryStringToLink(string strURL, params string[] strQryStrings)
        {
            string strQryURL = strURL;
            for (int lintIndex = 0; lintIndex < strQryStrings.Length; lintIndex++)
            {
                if (lintIndex % 2 == 0)
                {
                    if (lintIndex == 0)
                        strQryURL += "?" + strQryStrings[lintIndex];
                    else
                        strQryURL += "&" + strQryStrings[lintIndex];
                }
                else
                    strQryURL += "=" + strQryStrings[lintIndex];
            }
            return strQryURL;
        }

        #endregion

        #region transform XML using XSLT
        /// <summary>
        /// transforms given input XML by applying the given XSL stylesheet and saves output in given file
        /// </summary>
        /// <param name="xslFile"></param>
        /// <param name="inputFile"></param>
        /// <param name="outputFile"></param>
        public void TransformXML(string xslFile, string inputFile, string outputFile)
        {
            //Create a new XslTransform object.
            XslTransform xslt = new XslTransform();

            //Load the stylesheet.
            xslt.Load(xslFile);

            //Create a new XPathDocument and load the XML data to be transformed.
            XPathDocument mydata = new XPathDocument(inputFile);

            //Create an XmlTextWriter which outputs to the given file
            XmlWriter writer = new XmlTextWriter(outputFile, System.Text.Encoding.UTF8);

            //Transform the data and send the output to the given file
            xslt.Transform(mydata, null, writer, new XmlUrlResolver());

            writer.Close();

        }

        #endregion

        #region WriteToFile
        /// <summary>
        /// writes given string in the given file
        /// </summary>
        /// <param name="data"></param>
        /// <param name="filename"></param>
        public void WriteToFile(string data, string filename)
        {
            //System.IO.StreamWriter objStreamWriter = new StreamWriter(File.Create(filename), System.Text.UnicodeEncoding.Unicode);
            System.IO.StreamWriter objStreamWriter = new StreamWriter(filename, false, UTF8Encoding.UTF8);
            objStreamWriter.Write(data);
            objStreamWriter.Close();
        }

        #endregion

        #region ReadFromFile
        /// <summary>
        /// reads from given file and returns data in string
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public string ReadFromFile(string filename)
        {
            System.IO.StreamReader objStreamReader = CommonFunctions.DetectEncodingByBOMAndGetReader(filename);
            //System.IO.StreamReader objStreamReader = new StreamReader(filename);
            string strData = objStreamReader.ReadToEnd();
            objStreamReader.Close();
            return strData;

        }

        #endregion

        #region ReadFromUTF8File
        /// <summary>
        /// reads from given file and returns data in string
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public string ReadFromUTF8File(string filename)
        {
            System.IO.StreamReader objStreamReader = new StreamReader(filename, UTF8Encoding.UTF8);
            string strData = objStreamReader.ReadToEnd();
            objStreamReader.Close();
            return strData;

        }

        #endregion

        #region ReplaceNewLineWithParagraph
        /// <summary>
        /// replaces newline /r/n with paragraph <p></p>
        /// </summary>
        /// <param name="strInnerText"></param>
        /// <returns></returns>
        public string ReplaceNewLineWithParagraph(string strInnerText)
        {
            Regex regex = new Regex(@"<[^>]+>");
            if (!regex.IsMatch(strInnerText))
            {
                strInnerText = strInnerText.Replace("&nbsp;", " ");
                strInnerText = strInnerText.Replace("\r\n", "<br />");

                strInnerText = strInnerText.Replace("<p><p>", "<p>");
                strInnerText = strInnerText.Replace("</p></p>", "</p>");
                strInnerText = strInnerText.Replace("<BR>", "<br />");
                strInnerText = strInnerText.Replace("<br>", "<br />");
                if (!strInnerText.Trim().ToLower().StartsWith("<p>"))
                    strInnerText = "<p>" + strInnerText;

                if (!strInnerText.Trim().ToLower().EndsWith("</p>"))
                    strInnerText = strInnerText + "</p>";
            }
            strInnerText = strInnerText.Replace("<P>", "<p>");
            strInnerText = strInnerText.Replace("</P>", "</p>");

            return strInnerText;
        }

        #endregion

        #region	HEXA to NUMBER
        /// <summary>
        /// Convets Hexa decimal no to decimal number
        /// </summary>
        /// <param name="strHexaNumber">strHexaNumber</param>
        /// <returns>string</returns>
        public string HexaToNumber(string strHexaNumber)
        {
            strHexaNumber = strHexaNumber.ToUpper();
            if (strHexaNumber == "A" || strHexaNumber == "B" || strHexaNumber == "C" || strHexaNumber == "D" || strHexaNumber == "E" || strHexaNumber == "F")
            {
                if (strHexaNumber == "A")
                {
                    strHexaNumber = "10";
                }
                if (strHexaNumber == "B")
                {
                    strHexaNumber = "11";
                }
                if (strHexaNumber == "C")
                {
                    strHexaNumber = "12";
                }
                if (strHexaNumber == "D")
                {
                    strHexaNumber = "13";
                }
                if (strHexaNumber == "E")
                {
                    strHexaNumber = "14";
                }
                if (strHexaNumber == "F")
                {
                    strHexaNumber = "15";
                }
            }
            else
            {
                strHexaNumber = strHexaNumber;
            }
            return strHexaNumber;
        }
        #endregion

        #region GetCSVFromArray
        /// <summary>
        /// generates CSV from an integer array
        /// </summary>
        /// <param name="arr"></param>
        /// <returns></returns>
        public static string GetCSVFromArray(int[] arr)
        {
            string strCSV = "";
            for (int i = 0; i <= arr.Length - 1; i++)
                strCSV += "," + arr[i];
            if (strCSV != "")
                strCSV = strCSV.Remove(0, 1);
            return strCSV;
        }
        #endregion

        #region SelectItem in drop down string overload
        /// <summary>
        /// selects an item in a dropdownlist box
        /// </summary>
        /// <param name="control"></param>
        /// <param name="val"></param>
        public static void SelectItem(System.Web.UI.HtmlControls.HtmlSelect control, string val)
        {
            System.Web.UI.WebControls.ListItem item = control.Items.FindByValue(val);
            if (item != null)
            {
                item.Selected = true;
            }
        }
        #endregion

        #region SelectItem in drop down int overload
        /// <summary>
        /// selects an item in a dropdownlist box
        /// </summary>
        /// <param name="control"></param>
        /// <param name="val"></param>
        public static void SelectItem(System.Web.UI.HtmlControls.HtmlSelect control, int val)
        {
            System.Web.UI.WebControls.ListItem item = control.Items.FindByValue(val.ToString());
            if (item != null)
            {
                item.Selected = true;
            }
        }

        /// <summary>
        /// selects an item in a dropdownlist box
        /// </summary>
        /// <param name="control"></param>
        /// <param name="val"></param>
        public static void SelectItem(System.Web.UI.WebControls.DropDownList control, string val)
        {
            System.Web.UI.WebControls.ListItem item = control.Items.FindByValue(val);
            if (item != null)
            {
                item.Selected = true;
            }
        }

        /// <summary>
        /// selects an item in a dropdownlist box
        /// </summary>
        /// <param name="control"></param>
        /// <param name="val"></param>
        public static void SelectItem(System.Web.UI.WebControls.DropDownList control, int val)
        {
            System.Web.UI.WebControls.ListItem item = control.Items.FindByValue(val.ToString());
            if (item != null)
            {
                item.Selected = true;
            }
        }
        #endregion

        #region RemoveItem in dropdown
        /// <summary>
        /// removes an item from dropdownlistbox
        /// </summary>
        /// <param name="control"></param>
        /// <param name="val"></param>
        public static void RemoveItem(System.Web.UI.HtmlControls.HtmlSelect control, string val)
        {
            System.Web.UI.WebControls.ListItem item = control.Items.FindByValue(val);
            if (item != null)
            {
                control.Items.Remove(item);
            }
        }
        #endregion

        #region RemoveItem in dropdown int overload
        /// <summary>
        /// removes an item from dropdownlistbox
        /// </summary>
        /// <param name="control"></param>
        /// <param name="val"></param>
        public static void RemoveItem(System.Web.UI.HtmlControls.HtmlSelect control, int val)
        {
            System.Web.UI.WebControls.ListItem item = control.Items.FindByValue(val.ToString());
            if (item != null)
            {
                control.Items.Remove(item);
            }
        }
        #endregion

        #region RemoveItem in dropdown int overload	asp.net controls
        /// <summary>
        /// removes an item from dropdownlistbox
        /// </summary>
        /// <param name="control"></param>
        /// <param name="val"></param>
        public static void RemoveItem(System.Web.UI.WebControls.DropDownList control, int val)
        {
            System.Web.UI.WebControls.ListItem item = control.Items.FindByValue(val.ToString());
            if (item != null)
            {
                control.Items.Remove(item);
            }
        }
        #endregion

        #region ConvertColumnToCSV
        /// <summary>
        /// converts a DB column to CSV
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="columnName"></param>
        /// <returns></returns>
        public static string ConvertColumnToCSV(DataTable dt, string columnName)
        {
            string strCSV = "";
            foreach (DataRow dr in dt.Rows)
                strCSV += "," + dr[columnName].ToString();
            if (strCSV != "")
                strCSV = strCSV.Remove(0, 1);
            return strCSV;

        }
        #endregion

        #region WriteJsFunction
        /// <summary>
        /// writes the given JS function on the given page
        /// </summary>
        /// <param name="targetPage"></param>
        /// <param name="JSFunction"></param>
        public static void WriteJsFunction(Page targetPage, string JSFunction)
        {
            string strKey = "js" + CommonFunctions.mobjRandom.Next();
            string strJS = "<script language='javascript'>" + JSFunction + "</script>";
            targetPage.RegisterStartupScript(strKey, strJS);
        }
        #endregion

        #region Method for setting selection in a datagrid according to array list
        /// <summary>
        /// Maintains multi page selections in a data grid
        /// The method maintains the given session variable in its own way and the variable should not be changed from outside
        /// The method also sets the state of checkbox
        /// </summary>
        /// <param name="grd">Datagrid for which multi page selection is to be maintained</param>
        /// <param name="indexOfKeyCell">index of cell which contains primary key</param>
        /// <param name="nameOfCheckboxControl">name of checkbox control</param>
        /// <param name="nameOfCheckboxControl">name of session variable in which the method should store selections</param>
        public static void SetGridSelection(DataGrid grd, int indexOfKeyCell, string nameOfCheckboxControl, string sessionVarName)
        {
            UniqueArrayList objSelections;

            //if you are starting from scratch, create a new UniqueArrayList and store it
            if (System.Web.HttpContext.Current.Session[sessionVarName] == null)
            {
                //System.Web.HttpContext.Current.Session[sessionVarName] = new UniqueArrayList();
                return;//don't do anything if there is no selection
            }

            objSelections = (UniqueArrayList)System.Web.HttpContext.Current.Session[sessionVarName];

            //set all previous selections
            foreach (DataGridItem itm in grd.Items)
            {
                string strID = itm.Cells[indexOfKeyCell].Text;
                CheckBox chk = (CheckBox)itm.FindControl(nameOfCheckboxControl);

                if (objSelections.Contains(strID))//has user selected this item previously?
                    chk.Checked = true;
                else
                    chk.Checked = false;
            }

        }
        #endregion

        #region Method for setting selection in a datagrid according to array list - overload for uniqueArrayList
        /// <summary>
        /// Maintains multi page selections in a data grid
        /// The method maintains the given session variable in its own way and the variable should not be changed from outside
        /// The method also sets the state of checkbox
        /// </summary>
        /// <param name="grd">Datagrid for which multi page selection is to be maintained</param>
        /// <param name="indexOfKeyCell">index of cell which contains primary key</param>
        /// <param name="nameOfCheckboxControl">name of checkbox control</param>
        /// <param name="nameOfCheckboxControl">name of session variable in which the method should store selections</param>
        public static void SetGridSelection(DataGrid grd, int indexOfKeyCell, string nameOfCheckboxControl, UniqueArrayList container)
        {
            if (container == null)
                return;//don't do anything if there is no selection

            UniqueArrayList objSelections;

            objSelections = container;

            //set all previous selections
            foreach (DataGridItem itm in grd.Items)
            {
                string strID = itm.Cells[indexOfKeyCell].Text;
                CheckBox chk = (CheckBox)itm.FindControl(nameOfCheckboxControl);

                if (objSelections.Contains(strID))//has user selected this item previously?
                    chk.Checked = true;
                else
                    chk.Checked = false;
            }

        }
        #endregion

        #region Method for maintaining multi page selection in a datagrid
        /// <summary>
        /// Maintains multi page selections in a data grid
        /// The method maintains the given session variable in its own way and the variable should not be changed from outside
        /// The method also sets the state of checkbox
        /// </summary>
        /// <param name="grd">Datagrid for which multi page selection is to be maintained</param>
        /// <param name="indexOfKeyCell">index of cell which contains primary key</param>
        /// <param name="nameOfCheckboxControl">name of checkbox control</param>
        /// <param name="nameOfCheckboxControl">name of session variable in which the method should store selections</param>
        public static void MaintainMultiPageGridSelection(DataGrid grd, int indexOfKeyCell, string nameOfCheckboxControl, string sessionVarName)
        {
            UniqueArrayList objSelections;

            //if you are starting from scratch, create a new UniqueArrayList and store it
            if (System.Web.HttpContext.Current.Session[sessionVarName] == null)
            {
                System.Web.HttpContext.Current.Session[sessionVarName] = new UniqueArrayList();
                //return;
            }

            objSelections = (UniqueArrayList)System.Web.HttpContext.Current.Session[sessionVarName];

            //set all previous selections
            foreach (DataGridItem itm in grd.Items)
            {
                string strID = itm.Cells[indexOfKeyCell].Text;
                CheckBox chk = (CheckBox)itm.FindControl(nameOfCheckboxControl);

                if (chk.Checked)//if user has just selected the item, add it to the selections else remove it
                    objSelections.Add(strID);
                else
                    objSelections.Remove(strID);

                if (objSelections.Contains(strID))//has user selected this item previously?
                    chk.Checked = true;
            }

            System.Web.HttpContext.Current.Session[sessionVarName] = objSelections;

        }
        #endregion

        #region Method for maintaining multi page selection in a datagrid - overload for unique array list
        /// <summary>
        /// Maintains multi page selections in a data grid
        /// The method maintains the given session variable in its own way and the variable should not be changed from outside
        /// The method also sets the state of checkbox
        /// </summary>
        /// <param name="grd">Datagrid for which multi page selection is to be maintained</param>
        /// <param name="indexOfKeyCell">index of cell which contains primary key</param>
        /// <param name="nameOfCheckboxControl">name of checkbox control</param>
        /// <param name="nameOfCheckboxControl">name of session variable in which the method should store selections</param>
        public static void MaintainMultiPageGridSelection(DataGrid grd, int indexOfKeyCell, string nameOfCheckboxControl, ref UniqueArrayList container)
        {
            UniqueArrayList objSelections;

            //if you are starting from scratch, create a new UniqueArrayList and store it
            if (container == null)
            {
                container = new UniqueArrayList();
                //return;
            }

            objSelections = container;

            //set all previous selections
            foreach (DataGridItem itm in grd.Items)
            {
                string strID = itm.Cells[indexOfKeyCell].Text;
                CheckBox chk = (CheckBox)itm.FindControl(nameOfCheckboxControl);

                if (chk.Checked)//if user has just selected the item, add it to the selections else remove it
                    objSelections.Add(strID);
                else
                    objSelections.Remove(strID);

                if (objSelections.Contains(strID))//has user selected this item previously?
                    chk.Checked = true;
            }

            container = objSelections;

        }
        #endregion

        #region Method for maintaining multi page selection in a datagrid - overload for unique array list - reverse
        /// <summary>
        /// Maintains multi page selections in a data grid
        /// The method maintains the given session variable in its own way and the variable should not be changed from outside
        /// The method also sets the state of checkbox - checked items are removed from list
        /// </summary>
        /// <param name="grd">Datagrid for which multi page selection is to be maintained</param>
        /// <param name="indexOfKeyCell">index of cell which contains primary key</param>
        /// <param name="nameOfCheckboxControl">name of checkbox control</param>
        /// <param name="nameOfCheckboxControl">name of session variable in which the method should store selections</param>
        public static void MaintainMultiPageGridSelection(DataGrid grd, int indexOfKeyCell, string nameOfCheckboxControl, ref UniqueArrayList container, bool reverse)
        {
            UniqueArrayList objSelections;

            //if you are starting from scratch, create a new UniqueArrayList and store it
            if (container == null)
            {
                container = new UniqueArrayList();
                //return;
            }

            objSelections = container;

            //set all previous selections
            foreach (DataGridItem itm in grd.Items)
            {
                string strID = itm.Cells[indexOfKeyCell].Text;
                CheckBox chk = (CheckBox)itm.FindControl(nameOfCheckboxControl);

                if (!chk.Checked)//if user has just selected the item, add it to the selections else remove it
                    objSelections.Add(strID);
                else
                    objSelections.Remove(strID);

                if (objSelections.Contains(strID))//has user selected this item previously?
                    chk.Checked = true;
            }

            container = objSelections;

        }
        #endregion

        #region Method for maintaining multi page selection in a datagrid overload for single item
        /// <summary>
        /// Maintains multi page selections in a data grid
        /// The method maintains the given session variable in its own way and the variable should not be changed from outside
        /// </summary>
        /// <param name="grd">Datagrid for which multi page selection is to be maintained</param>
        /// <param name="indexOfKeyCell">index of cell which contains primary key</param>
        /// <param name="nameOfCheckboxControl">name of checkbox control</param>
        /// <param name="nameOfCheckboxControl">name of session variable in which the method should store selections</param>
        public static void MaintainMultiPageGridSelection(DataGridItem itm, int indexOfKeyCell, string nameOfCheckboxControl, string sessionVarName)
        {
            UniqueArrayList objSelections;

            //if you are starting from scratch, create a new UniqueArrayList and store it
            if (System.Web.HttpContext.Current.Session[sessionVarName] == null)
            {
                System.Web.HttpContext.Current.Session[sessionVarName] = new UniqueArrayList();
                //return;
            }

            objSelections = (UniqueArrayList)System.Web.HttpContext.Current.Session[sessionVarName];

            string strID = itm.Cells[indexOfKeyCell].Text;
            CheckBox chk = (CheckBox)itm.FindControl(nameOfCheckboxControl);

            if (chk.Checked)//if user has just selected the item, add it to the selections
                objSelections.Add(strID);

            if (objSelections.Contains(strID))//has user selected this item previously?
                chk.Checked = true;

            System.Web.HttpContext.Current.Session[sessionVarName] = objSelections;

        }
        #endregion

        #region generates a time stamp in the format "yyyymmddhhmmss"
        /// <summary>
        /// generates a datetime stamp
        /// </summary>
        /// <returns></returns>
        public static string GenerateTimeStamp()
        {
            DateTime dtTodaysDateTime;

            dtTodaysDateTime = DateTime.Now;

            string strDateString = Convert.ToString(dtTodaysDateTime.Year).PadLeft(4, '0');
            strDateString += Convert.ToString(dtTodaysDateTime.Month).PadLeft(2, '0');
            strDateString += Convert.ToString(dtTodaysDateTime.Day).PadLeft(2, '0');
            strDateString += Convert.ToString(dtTodaysDateTime.Hour).PadLeft(2, '0');
            strDateString += Convert.ToString(dtTodaysDateTime.Minute).PadLeft(2, '0');
            strDateString += Convert.ToString(dtTodaysDateTime.Second).PadLeft(2, '0');

            return strDateString;

        }

        #endregion

        #region generates a unique file name using time stamp and the given extension in the format filename + "_" + timestamp + "." + extension
        /// <summary>
        /// generates a unique file name using time stamp and the given extension in the format filename + "_" + timestamp + "." + extension
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="extension"></param>
        /// <returns></returns>
        public static string GenerateUniqueFileName(string filename, string extension)
        {
            return filename + "_" + CommonFunctions.GenerateTimeStamp() + "." + extension;
        }
        #endregion

        #region set grid page index to first page on the basis of row count and page size
        /// <summary>
        /// check if grid page index should be set to first page on the basis of row count and page size
        /// </summary>
        /// <param name="pageSize"></param>
        /// <param name="rowCount"></param>
        /// <param name="currentPage"></param>
        /// <returns></returns>
        public static bool SetPageIndexToFirstPage(int pageSize, int rowCount, int currentPage)
        {
            if (currentPage > (int)rowCount / pageSize)
                return true;
            else
                return false;

        }
        #endregion

        #region get filename from full path
        public static string RetrieveFileNameFromFullPath(string filenameWithPath)
        {
            FileInfo objFile = new FileInfo(filenameWithPath);
            return objFile.Name;
        }
        #endregion

        #region detect encoding of file
        public static System.Text.Encoding DetectEncoding(string filename)
        {
            /*
            When you don't read a file using the encoding in which it was written, you may incur character loss (in rare cases)
			
            Constructor for StreamReader which takes a file name,
            and a boolean "detectEncodingFromByteOrderMarks" does not detect file encoding reliably.
            (At present we are using this though)
			
            It doesn't seem to work. Files are being
            labelled as "UTF-8", which is not always true (in rare cases)
			
            On way to detect encoding is read first three bytes of a file (Byte Order Mark - BOM ) and manually detect
            encoding.
			
            There *is* no way of determining it reliably. Something that starts
            with "abc" could be in UTF-8, ASCII, UCS-2 without any BOM, Cp1252,
            etc...

            If you know that all your files are going to be *either* UCS-2 with a
            BOM or UTF-8, that makes things a lot simpler - but you'll still
            basically have to look at the first few bytes.

            You need to read actually the file to detect the ecoding from Byte Order mark and thus detect the codepage/encoding

            */

            StreamReader objSR = new StreamReader(filename, true);
            objSR.ReadToEnd(); // read the file and know the codepage
            System.Text.Encoding objEncoding = objSR.CurrentEncoding;
            objSR.Close();
            return objEncoding;
        }
        #endregion

        #region detect codepage of file
        public static int DetectCodepage(string filename)
        {
            /*
            When you don't read a file using the encoding in which it was written, you may incur character loss (in rare cases)
			
            Constructor for StreamReader which takes a file name,
            and a boolean "detectEncodingFromByteOrderMarks" does not detect file encoding reliably.
            (At present we are using this though)
			
            It doesn't seem to work. Files are being
            labelled as "UTF-8", which is not always true (in rare cases)
			
            On way to detect encoding is read first three bytes of a file (Byte Order Mark - BOM ) and manually detect
            encoding.
			
            There *is* no way of determining it reliably. Something that starts
            with "abc" could be in UTF-8, ASCII, UCS-2 without any BOM, Cp1252,
            etc...

            If you know that all your files are going to be *either* UCS-2 with a
            BOM or UTF-8, that makes things a lot simpler - but you'll still
            basically have to look at the first few bytes.

            You need to read actually the file to detect the ecoding from Byte Order mark and thus detect the codepage/encoding

            */

            StreamReader objSR = new StreamReader(filename, true);
            objSR.ReadToEnd(); // read the file and know the codepage
            int iCodepage = objSR.CurrentEncoding.CodePage;
            objSR.Close();
            return iCodepage;
        }
        #endregion

        #region detect encoding and return streamreader on the basis of BOM
        /// <summary>
        /// The method returns a proper streamreader on the basis of BOM of a file
        /// At present it only supports unicode(bid endian, little endian, UTF8) and windows operating system (windows-1252) file encodings
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static System.IO.StreamReader DetectEncodingByBOMAndGetReader(string filename)
        {
            System.IO.FileStream objFile = new System.IO.FileStream(filename, FileMode.Open, FileAccess.Read);
            byte[] btPreamble = new byte[3];//for first three bytes which is BOM
            objFile.Read(btPreamble, 0, btPreamble.Length);//read BOM
            objFile.Close();

            StreamReader objReader;

            if (btPreamble[0] == 0xFE && btPreamble[1] == 0xFF)//Unicode little endian
                objReader = new StreamReader(filename, true);
            else if (btPreamble[0] == 0xFF && btPreamble[1] == 0xFE)//unicode big endian
                objReader = new StreamReader(filename, true);
            else if (btPreamble[0] == 0xEF && btPreamble[1] == 0xBB && btPreamble[2] == 0xBF)//UTF-8
                objReader = new StreamReader(filename, UTF8Encoding.UTF8);
            else
                objReader = new StreamReader(filename, System.Text.Encoding.GetEncoding("windows-1252"));//all other encodings are interpreted as Windows operating system encoding

            return objReader;

        }
        #endregion

        #region detect encoding and return proper encoding on the basis of BOM
        /// <summary>
        /// The method returns a proper streamreader on the basis of BOM of a file
        /// At present it only supports unicode(bid endian, little endian, UTF8) and windows operating system (windows-1252) file encodings
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static System.Text.Encoding GetEncodingByBOM(string filename)
        {
            System.IO.FileStream objFile = new System.IO.FileStream(filename, FileMode.Open, FileAccess.Read);
            byte[] btPreamble = new byte[3];//for first three bytes which is BOM
            objFile.Read(btPreamble, 0, btPreamble.Length);//read BOM
            objFile.Close();

            Encoding objProperEncoding;

            if (btPreamble[0] == 0xFE && btPreamble[1] == 0xFF)//Unicode little endian
                objProperEncoding = Encoding.Unicode;
            else if (btPreamble[0] == 0xFF && btPreamble[1] == 0xFE)//unicode big endian
                objProperEncoding = Encoding.Unicode;
            else if (btPreamble[0] == 0xEF && btPreamble[1] == 0xBB && btPreamble[2] == 0xBF)//UTF-8
                objProperEncoding = Encoding.Unicode;
            else
                objProperEncoding = System.Text.Encoding.GetEncoding("windows-1252");//all other encodings are interpreted as Windows operating system encoding

            return objProperEncoding;

        }
        #endregion

        #region get unicode streamwriter
        public static StreamWriter GetStreamWriter(string filename)
        {
            return new StreamWriter(filename, false, UTF8Encoding.UTF8);
        }
        #endregion

        #region get unicode streamreader
        public static StreamReader GetStreamReader(string filename)
        {
            return new StreamReader(filename, UTF8Encoding.UTF8);
        }
        #endregion

        #region get CSV of client IDs of controls in a datagrid
        public static string GetClientIDCSVOfGridColumn(DataGrid grid, string controlName)
        {
            string strCSVClientID = "";
            foreach (DataGridItem itm in grid.Items)
                if (itm.ItemType == ListItemType.Item || itm.ItemType == ListItemType.AlternatingItem)
                    strCSVClientID += itm.FindControl(controlName).ClientID + ",";

            if (strCSVClientID != "")
                strCSVClientID = strCSVClientID.Remove(strCSVClientID.Length - 1, 1);//remove last comma
            return strCSVClientID;

        }
        #endregion

        #region get CSV of client IDs of controls in a datagrid
        public static string GetIDCSVOfPKColumn(DataGrid grid, int indexPKCell)
        {
            string strCSVClientID = "";
            foreach (DataGridItem itm in grid.Items)
                if (itm.ItemType == ListItemType.Item || itm.ItemType == ListItemType.AlternatingItem)
                    strCSVClientID += itm.Cells[indexPKCell].Text + ",";

            if (strCSVClientID != "")
                strCSVClientID = strCSVClientID.Remove(strCSVClientID.Length - 1, 1);//remove last comma
            return strCSVClientID;

        }
        #endregion

        #region GetFileSize
        public static long GetFileSize(string strFileName)
        {
            long lSize = 0;
            if (File.Exists(strFileName))
            {
                FileInfo objFileInfo = new FileInfo(strFileName);
                lSize = objFileInfo.Length;
            }
            return lSize;
        }

        #endregion

        # region function for styles
        /// <summary>
        /// converts cmyk color to rgb colors
        /// </summary>
        /// <param name="C"></param>
        /// <param name="M"></param>
        /// <param name="Y"></param>
        /// <param name="K"></param>
        /// <param name="R"></param>
        /// <param name="G"></param>
        /// <param name="B"></param>
        public static void CMYKToRGB(int C, int M, int Y, int K, out int R, out int G, out int B)
        {
            ///////////////////////////////////////////////////////////////////////////////
            //
            // The algorithms for these routines were taken from:
            //     http://www.neuro.sfc.keio.ac.jp/~aly/polygon/info/color-space-faq.html
            //
            // RGB --> CMYK                              CMYK --> RGB
            // ---------------------------------------   --------------------------------------------
            // Black   = minimum(1-Red,1-Green,1-Blue)   Red   = 1-minimum(1,Cyan*(1-Black)+Black)
            // Cyan    = (1-Red-Black)/(1-Black)         Green = 1-minimum(1,Magenta*(1-Black)+Black)
            // Magenta = (1-Green-Black)/(1-Black)       Blue  = 1-minimum(1,Yellow*(1-Black)+Black)
            // Yellow  = (1-Blue-Black)/(1-Black)
            //
            ///////////////////////////////////////////////////////////////////////////////
            double dC, dM, dY, dK, dR, dG, dB;
            dC = C / 100.0;
            dM = M / 100.0;
            dY = Y / 100.0;
            dK = K / 100.0;
            dR = 1 - Minimum(1, dC * (1 - dK) + dK);
            dG = 1 - Minimum(1, dM * (1 - dK) + dK);
            dB = 1 - Minimum(1, dY * (1 - dK) + dK);
            //this values are in range [0,1], so map to [0,255]
            dR *= 255;
            dG *= 255;
            dB *= 255;

            R = Convert.ToInt32(Math.Round(dR + 0.5));
            G = Convert.ToInt32(Math.Round(dG + 0.5));
            B = Convert.ToInt32(Math.Round(dB + 0.5));

        }

        /// <summary>
        /// returns the minimum of given two numbers
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        private static double Minimum(double a, double b)
        {
            return (a <= b) ? a : b;
        }

        /// <summary>
        /// returns hexadecimal equivalent(used to specify color in style) of rgb color
        /// for example: if input is 50,100,200 then output is #3264C8
        /// </summary>
        /// <param name="R"></param>
        /// <param name="G"></param>
        /// <param name="B"></param>
        /// <returns></returns>
        public static string GetHEXEquivalentOfRGB(int R, int G, int B)
        {
            return "#" + GetTwoDigitHexOfDecimal(R) + GetTwoDigitHexOfDecimal(G) + GetTwoDigitHexOfDecimal(B);
        }

        /// <summary>
        /// return hexadecimal equivalent of a decimal number
        /// for example if input is 200 then output is C8
        /// </summary>
        /// <param name="iNo"></param>
        /// <returns></returns>
        private static string GetTwoDigitHexOfDecimal(int iNo)
        {
            if (iNo > 255)
                return "FF";
            int dig1 = iNo & 15; //bitwise and
            string strDig1, strDig2;
            int dig2 = (iNo & 240) >> 4;
            strDig1 = dig1.ToString();
            if (dig1 > 9)
            {
                strDig1 = GetHexAlphabet(dig1).ToString();
            }
            strDig2 = dig2.ToString();
            if (dig2 > 9)
            {
                strDig2 = GetHexAlphabet(dig2).ToString();
            }
            return strDig2 + strDig1;
        }

        /// <summary>
        /// returns the hex alphabet for numbers 10 to 15
        /// </summary>
        /// <param name="iNo"></param>
        /// <returns></returns>
        private static string GetHexAlphabet(int iNo)
        {
            switch (iNo)
            {
                case 10:
                    return "A";
                case 11:
                    return "B";
                case 12:
                    return "C";
                case 13:
                    return "D";
                case 14:
                    return "E";
                case 15:
                    return "F";
                default:
                    return Convert.ToString(iNo);
            }
        }

        /// <summary>
        /// returns RGB values of a Hex Color
        /// For example if input is #3264C8 then output is  50,100,200 
        /// </summary>
        /// <param name="strHexValue"></param>
        /// <param name="R"></param>
        /// <param name="G"></param>
        /// <param name="B"></param>
        public void GetRGBValuesFromHex(string strHexValue, out int R, out int G, out int B)
        {
            string hashRed, hashGreen, hashBlue;
            strHexValue = strHexValue.Replace("#", "");
            hashRed = strHexValue.Substring(0, 2);
            hashGreen = strHexValue.Substring(2, 2);
            hashBlue = strHexValue.Substring(4, 2);

            R = Int32.Parse(HexaToNumber(hashRed.Substring(0, 1))) * 16 + Int32.Parse(HexaToNumber(hashRed.Substring(1, 1)));
            G = Int32.Parse(HexaToNumber(hashGreen.Substring(0, 1))) * 16 + Int32.Parse(HexaToNumber(hashGreen.Substring(1, 1)));
            B = Int32.Parse(HexaToNumber(hashBlue.Substring(0, 1))) * 16 + Int32.Parse(HexaToNumber(hashBlue.Substring(1, 1)));
        }
        # endregion

        #region adds serial no column to a datatable
        public static DataTable AddSerialNoColumn(DataTable dt, string columnName)
        {
            if (!dt.Columns.Contains(columnName))
                dt.Columns.Add(columnName);
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
                dt.Rows[i][columnName] = i + 1;
            dt.AcceptChanges();
            return dt;
        }
        #endregion

        #region converts a filename column to physical filename column with full path
        public static void ConvertFilenameToPhysicalFilenameWithPath(DataTable sourceTable, string filenameColumn, string virtualDirectory)
        {
            foreach (DataRow dr in sourceTable.Rows)
                dr[filenameColumn] = System.Web.HttpContext.Current.Server.MapPath(virtualDirectory) + dr[filenameColumn].ToString();
        }
        #endregion

        #region Replace BackSlash with ForwardSlash.
        public static string ReplaceBackSlashWithForwardSlash(string data)
        {
            StringBuilder objBuilder = new StringBuilder(data);
            objBuilder.Replace((char)92, (char)47);//back slash = 92, forward slash = 47
            return objBuilder.ToString();
        }
        #endregion

        #region ConvertAmountInWords
        public string ConvertInWords(int Digits)
        {
            int amount, num, digiCount = 0, tenCrores = 0, unitCrores = 0, tenLacs = 0, unitLacs = 0, tenThousands = 0,
            unitThousands = 0, hundreds = 0, tens = 0, units = 0;
            string words, strTenCrores = "", strUnitCrores = "", strCrores = "", strTenLacs = "", strUnitLacs = "", strLacs = "",
            strTenThousands = "", strUnitThousands = "", strThousands = "", strHundreds = "", strTens = "", strUnits = "",
            strTensnUnits = "";

            amount = Digits;

            num = amount;

            #region Digicount
            while (num > 0)
            {
                num /= 10;
                digiCount++;
            }
            #endregion
            num = amount;
            #region assign digits to place value

            //Assign Ten Crores & Crores digits

            #region assignCrores
            if (digiCount > 7)
            {
                tenCrores = num / 10000000;
                unitCrores = tenCrores % 10;
                tenCrores /= 10;
                num = num - ((tenCrores * 10 + unitCrores) * 10000000);
                digiCount -= 2;
            }
            #endregion

            //Assign Ten Lacs and Lacs digits

            #region assignLacs

            if (digiCount > 5)
            {
                tenLacs = num / 100000;
                unitLacs = tenLacs % 10;
                tenLacs /= 10;
                num = num - ((tenLacs * 10 + unitLacs) * 100000);
                digiCount -= 2;
            }

            #endregion

            //Assign Ten Thousands and Thousands digits

            #region assignThousands

            if (digiCount > 3)
            {
                tenThousands = num / 1000;
                unitThousands = tenThousands % 10;
                tenThousands /= 10;
                num = num - ((tenThousands * 10 + unitThousands) * 1000);
                digiCount -= 2;
            }

            #endregion

            //Assign Hundreds, Tens and Units

            #region assignHundredsTensUnits

            if (digiCount >= 2)
            {
                hundreds = num / 100;
                num = num - (hundreds * 100);
                digiCount--;
            }

            if (digiCount >= 1)
            {
                tens = num / 10;
                num = num - (tens * 10);
                digiCount--;
            }

            if (digiCount >= 0)
            {
                units = num;
            }

            #endregion

            //Create string for Crores

            #endregion
            #region allocate strings for digits

            #region string for Crores

            if (tenCrores != 1) //If the digit for Ten Crores place is NOT zero, follow this condition
            {
                switch (tenCrores)
                {
                    case 0:
                        {
                            strTenCrores = "";
                            break;
                        }
                    case 2:
                        {
                            strTenCrores = "Twenty";
                            break;
                        }
                    case 3:
                        {
                            strTenCrores = "Thirty";
                            break;
                        }
                    case 4:
                        {
                            strTenCrores = "Forty";
                            break;
                        }
                    case 5:
                        {
                            strTenCrores = "Fifty";
                            break;
                        }
                    case 6:
                        {
                            strTenCrores = "Sixty";
                            break;
                        }
                    case 7:
                        {
                            strTenCrores = "Seventy";
                            break;
                        }
                    case 8:
                        {
                            strTenCrores = "Eighty";
                            break;
                        }
                    case 9:
                        {
                            strTenCrores = "Ninety";
                            break;
                        }
                }

                switch (unitCrores)
                {
                    case 0:
                        {
                            strUnitCrores = "";
                            break;
                        }
                    case 1:
                        {
                            strUnitCrores = "One";
                            break;
                        }
                    case 2:
                        {
                            strUnitCrores = "Two";
                            break;
                        }
                    case 3:
                        {
                            strUnitCrores = "Three";
                            break;
                        }
                    case 4:
                        {
                            strUnitCrores = "Four";
                            break;
                        }
                    case 5:
                        {
                            strUnitCrores = "Five";
                            break;
                        }
                    case 6:
                        {
                            strUnitCrores = "Six";
                            break;
                        }
                    case 7:
                        {
                            strUnitCrores = "Seven";
                            break;
                        }
                    case 8:
                        {
                            strUnitCrores = "Eight";
                            break;
                        }
                    case 9:
                        {
                            strUnitCrores = "Nine";
                            break;
                        }
                }

                if ((tenCrores == 0) & (unitCrores == 0))
                {
                    strCrores = "";
                }
                else
                {
                    strCrores = strTenCrores + " " + strUnitCrores + " " + "Crores"; //string defined for Crores
                }
            }
            else //If Ten Crores digit's place value is 1, execute this
            {
                switch (unitCrores)
                {
                    case 0:
                        {
                            strCrores = "Ten Crores";
                            break;
                        }
                    case 1:
                        {
                            strCrores = "Eleven Crores";
                            break;
                        }
                    case 2:
                        {
                            strCrores = "Twelve Crores";
                            break;
                        }
                    case 3:
                        {
                            strCrores = "Thirteen Crores";
                            break;
                        }
                    case 4:
                        {
                            strCrores = "Fourteen Crores";
                            break;
                        }
                    case 5:
                        {
                            strCrores = "Fifteen Crores";
                            break;
                        }
                    case 6:
                        {
                            strCrores = "Sixteen Crores";
                            break;
                        }
                    case 7:
                        {
                            strCrores = "Seventeen Crores";
                            break;
                        }
                    case 8:
                        {
                            strCrores = "Eighteen Crores";
                            break;
                        }
                    case 9:
                        {
                            strCrores = "Nineteen Crores";
                            break;
                        }
                }
            }
            #endregion

            //Create string for Lacs

            #region string for Lacs

            if (tenLacs != 1)
            {
                switch (tenLacs)
                {
                    case 0:
                        {
                            strTenLacs = "";
                            break;
                        }
                    case 2:
                        {
                            strTenLacs = "Twenty";
                            break;
                        }
                    case 3:
                        {
                            strTenLacs = "Thirty";
                            break;
                        }
                    case 4:
                        {
                            strTenLacs = "Forty";
                            break;
                        }
                    case 5:
                        {
                            strTenLacs = "Fifty";
                            break;
                        }
                    case 6:
                        {
                            strTenLacs = "Sixty";
                            break;
                        }
                    case 7:
                        {
                            strTenLacs = "Seventy";
                            break;
                        }
                    case 8:
                        {
                            strTenLacs = "Eighty";
                            break;
                        }
                    case 9:
                        {
                            strTenLacs = "Ninety";
                            break;
                        }
                }

                switch (unitLacs)
                {
                    case 1:
                        {
                            strUnitLacs = "One";
                            break;
                        }
                    case 2:
                        {
                            strUnitLacs = "Two";
                            break;
                        }
                    case 3:
                        {
                            strUnitLacs = "Three";
                            break;
                        }
                    case 4:
                        {
                            strUnitLacs = "Four";
                            break;
                        }
                    case 5:
                        {
                            strUnitLacs = "Five";
                            break;
                        }
                    case 6:
                        {
                            strUnitLacs = "Six";
                            break;
                        }
                    case 7:
                        {
                            strUnitLacs = "Seven";
                            break;
                        }
                    case 8:
                        {
                            strUnitLacs = "Eight";
                            break;
                        }
                    case 9:
                        {
                            strUnitLacs = "Nine";
                            break;
                        }
                }

                if ((tenLacs == 0) & (unitLacs == 0))
                {
                    strLacs = "";
                }
                else
                {
                    strLacs = strTenLacs + " " + strUnitLacs + " " + "Lacs";
                }
            }
            else
            {
                switch (unitLacs)
                {
                    case 0:
                        {
                            strLacs = "Ten Lacs";
                            break;
                        }
                    case 1:
                        {
                            strLacs = "Eleven Lacs";
                            break;
                        }
                    case 2:
                        {
                            strLacs = "Twelve Lacs";
                            break;
                        }
                    case 3:
                        {
                            strLacs = "Thirteen Lacs";
                            break;
                        }
                    case 4:
                        {
                            strLacs = "Fourteen Lacs";
                            break;
                        }
                    case 5:
                        {
                            strLacs = "Fifteen Lacs";
                            break;
                        }
                    case 6:
                        {
                            strLacs = "Sixteen Lacs";
                            break;
                        }
                    case 7:
                        {
                            strLacs = "Seventeen Lacs";
                            break;
                        }
                    case 8:
                        {
                            strLacs = "Eighteen Lacs";
                            break;
                        }
                    case 9:
                        {
                            strLacs = "Nineteen Lacs";
                            break;
                        }
                }
            }

            #endregion

            //Create string for Thousands

            #region string for Thousands

            if (tenThousands != 1)
            {
                switch (tenThousands)
                {
                    case 0:
                        {
                            strTenThousands = "";
                            break;
                        }
                    case 2:
                        {
                            strTenThousands = "Twenty";
                            break;
                        }
                    case 3:
                        {
                            strTenThousands = "Thirty";
                            break;
                        }
                    case 4:
                        {
                            strTenThousands = "Forty";
                            break;
                        }
                    case 5:
                        {
                            strTenThousands = "Fifty";
                            break;
                        }
                    case 6:
                        {
                            strTenThousands = "Sixty";
                            break;
                        }
                    case 7:
                        {
                            strTenThousands = "Seventy";
                            break;
                        }
                    case 8:
                        {
                            strTenThousands = "Eighty";
                            break;
                        }
                    case 9:
                        {
                            strTenThousands = "Ninety";
                            break;
                        }
                }

                switch (unitThousands)
                {
                    case 1:
                        {
                            strUnitThousands = "One";
                            break;
                        }
                    case 2:
                        {
                            strUnitThousands = "Two";
                            break;
                        }
                    case 3:
                        {
                            strUnitThousands = "Three";
                            break;
                        }
                    case 4:
                        {
                            strUnitThousands = "Four";
                            break;
                        }
                    case 5:
                        {
                            strUnitThousands = "Five";
                            break;
                        }
                    case 6:
                        {
                            strUnitThousands = "Six";
                            break;
                        }
                    case 7:
                        {
                            strUnitThousands = "Seven";
                            break;
                        }
                    case 8:
                        {
                            strUnitThousands = "Eight";
                            break;
                        }
                    case 9:
                        {
                            strUnitThousands = "Nine";
                            break;
                        }
                }
                if ((tenThousands == 0) & (unitThousands == 0))
                {
                    strThousands = "";
                }
                else
                {
                    strThousands = strTenThousands + " " + strUnitThousands + " " + "Thousand";
                }
            }
            else
            {
                switch (unitThousands)
                {
                    case 0:
                        {
                            strThousands = "Ten Thousand";
                            break;
                        }
                    case 1:
                        {
                            strThousands = "Eleven Thousand";
                            break;
                        }
                    case 2:
                        {
                            strThousands = "Twelve Thousand";
                            break;
                        }
                    case 3:
                        {
                            strThousands = "Thirteen Thousand";
                            break;
                        }
                    case 4:
                        {
                            strThousands = "Fourteen Thousand";
                            break;
                        }
                    case 5:
                        {
                            strThousands = "Fifteen Thousand";
                            break;
                        }
                    case 6:
                        {
                            strThousands = "Sixteen Thousand";
                            break;
                        }
                    case 7:
                        {
                            strThousands = "Seventeen Thousand";
                            break;
                        }
                    case 8:
                        {
                            strThousands = "Eighteen Thousand";
                            break;
                        }
                    case 9:
                        {
                            strThousands = "Nineteen Thousand";
                            break;
                        }
                }
            }
            #endregion

            //Create string for Hundreds

            #region string for Hundreds

            switch (hundreds)
            {
                case 0:
                    {
                        strHundreds = "";
                        break;
                    }
                case 1:
                    {
                        strHundreds = "One Hundred";
                        break;
                    }
                case 2:
                    {
                        strHundreds = "Two Hundred";
                        break;
                    }
                case 3:
                    {
                        strHundreds = "Three Hundred";
                        break;
                    }
                case 4:
                    {
                        strHundreds = "Four Hundred";
                        break;
                    }
                case 5:
                    {
                        strHundreds = "Five Hundred";
                        break;
                    }
                case 6:
                    {
                        strHundreds = "Six Hundred";
                        break;
                    }
                case 7:
                    {
                        strHundreds = "Seven Hundred";
                        break;
                    }
                case 8:
                    {
                        strHundreds = "Eight Hundred";
                        break;
                    }
                case 9:
                    {
                        strHundreds = "Nine Hundred";
                        break;
                    }
            }
            #endregion

            //Create string for Tens and Units

            #region string for Tens and Units

            if (tens != 1)
            {
                switch (tens)
                {
                    case 0:
                        {
                            strTens = "";
                            break;
                        }
                    case 2:
                        {
                            strTens = "Twenty";
                            break;
                        }
                    case 3:
                        {
                            strTens = "Thirty";
                            break;
                        }
                    case 4:
                        {
                            strTens = "Forty";
                            break;
                        }
                    case 5:
                        {
                            strTens = "Fifty";
                            break;
                        }
                    case 6:
                        {
                            strTens = "Sixty";
                            break;
                        }
                    case 7:
                        {
                            strTens = "Seventy";
                            break;
                        }
                    case 8:
                        {
                            strTens = "Eighty";
                            break;
                        }
                    case 9:
                        {
                            strTens = "Ninety";
                            break;
                        }
                }

                switch (units)
                {
                    case 1:
                        {
                            strUnits = "One";
                            break;
                        }
                    case 2:
                        {
                            strUnits = "Two";
                            break;
                        }
                    case 3:
                        {
                            strUnits = "Three";
                            break;
                        }
                    case 4:
                        {
                            strUnits = "Four";
                            break;
                        }
                    case 5:
                        {
                            strUnits = "Five";
                            break;
                        }
                    case 6:
                        {
                            strUnits = "Six";
                            break;
                        }
                    case 7:
                        {
                            strUnits = "Seven";
                            break;
                        }
                    case 8:
                        {
                            strUnits = "Eight";
                            break;
                        }
                    case 9:
                        {
                            strUnits = "Nine";
                            break;
                        }
                }
                if (amount == 0)
                {
                    strTensnUnits = "Zero";
                }
                else
                {
                    strTensnUnits = strTens + " " + strUnits;
                }
            }
            else
            {
                switch (units)
                {
                    case 0:
                        {
                            strTensnUnits = "Ten";
                            break;
                        }
                    case 1:
                        {
                            strTensnUnits = "Eleven";
                            break;
                        }
                    case 2:
                        {
                            strTensnUnits = "Twelve";
                            break;
                        }
                    case 3:
                        {
                            strTensnUnits = "Thirteen";
                            break;
                        }
                    case 4:
                        {
                            strTensnUnits = "Fourteen";
                            break;
                        }
                    case 5:
                        {
                            strTensnUnits = "Fifteen";
                            break;
                        }
                    case 6:
                        {
                            strTensnUnits = "Sixteen";
                            break;
                        }
                    case 7:
                        {
                            strTensnUnits = "Seventeen";
                            break;
                        }
                    case 8:
                        {
                            strTensnUnits = "Eighteen";
                            break;
                        }
                    case 9:
                        {
                            strTensnUnits = "Nineteen";
                            break;
                        }
                }
            }
            #endregion

            #endregion

            words = "Rupees " + strCrores + " " + strLacs + " " + strThousands + " " + strHundreds + " " + strTensnUnits + " Only";

            return words;
        }
        #endregion
    }
}
