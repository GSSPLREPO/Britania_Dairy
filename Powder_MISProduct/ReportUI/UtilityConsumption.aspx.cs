using System;
using System.Data;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Powder_MISProduct.BL;
using log4net;
using Powder_MISProduct.Common;
using iTextSharp.text.pdf;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using System.Drawing;
using System.Text;

namespace Powder_MISProduct.ReportUI
{
    public partial class UtilityConsumption : System.Web.UI.Page
    {
        #region Load page event
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                divExport.Visible = false;
                txtFromDate.Text = DateTime.Today.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                txtToDate.Text = DateTime.Today.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
        }
        #endregion

        #region ClearAll Method
        private void ClearAll()
        {
            Controls objcontrol = new Controls();
            objcontrol.ClearForm(Master.FindControl("ContentPlaceHolder1"));
            ViewState["Mode"] = "Save";

        }
        #endregion

        #region PDFBackgroundHelper Event
        class PDFBackgroundHelper : PdfPageEventHelper
        {

            private PdfContentByte cb;
            private List<PdfTemplate> templates;

            iTextSharp.text.Font FONT = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 12, iTextSharp.text.Font.BOLD);
            int iCount = 0;

            //constructor
            public PDFBackgroundHelper()
            {
                this.templates = new List<PdfTemplate>();
            }

            public override void OnEndPage(PdfWriter writer, Document document)
            {
                try
                {
                    base.OnEndPage(writer, document);
                    cb = writer.DirectContentUnder;
                    PdfTemplate templateM = cb.CreateTemplate(500, 500);
                    templates.Add(templateM);
                    int pageN = writer.CurrentPageNumber;
                    String pageText = "Page No : " + (writer.PageNumber);
                    DateTime dtTime = DateTime.Now;
                    BaseFont bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);

                    if (this.iCount != 0)
                    {
                        ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, new Phrase("UtilityConsumption REPORT", FONT), 1190, 1665, 0);
                    }
                    iCount = iCount + 1;

                    float len = bf.GetWidthPoint(pageText, 9);
                    float len1 = bf.GetWidthPoint(dtTime.ToString(), 9);
                    cb.BeginText();
                    cb.SetFontAndSize(bf, 12);
                    cb.SetTextMatrix(document.LeftMargin + 300, document.PageSize.GetBottom(document.BottomMargin) - 13);
                    cb.ShowText(dtTime.ToString());
                    cb.SetTextMatrix(document.LeftMargin + 1390, document.PageSize.GetBottom(document.BottomMargin) - 13);
                    cb.ShowText(pageText);
                    cb.EndText();
                    cb.AddTemplate(templateM, document.LeftMargin + 1650 + len, document.PageSize.GetBottom(document.BottomMargin) - 13);
                }
                catch (Exception ex)
                {

                }
            }
        }
        #endregion


        #region VerifyRenderingInServerForm
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
        #endregion

        #region BindUtilityConsumption
        public void BindUtilityConsumption()
        {
            try
            {
                ApplicationResult objResult = new ApplicationResult();
                UtilityConsumptionBl objUtility = new UtilityConsumptionBl();
                DateTime dtFromDateTime = DateTime.ParseExact(txtFromDate.Text + " " + txtFromTime.Text, "dd/MM/yyyy HH:mm:ss",
                  CultureInfo.InvariantCulture);
                DateTime dtToDateTime = DateTime.ParseExact(txtToDate.Text + " " + txtToTime.Text, "dd/MM/yyyy HH:mm:ss",
                    CultureInfo.InvariantCulture);

                if (dtFromDateTime <= dtToDateTime)
                {
                    objResult = objUtility.UtilityConsumptionLogReport(dtFromDateTime, dtToDateTime);
                    if (objResult.ResultDt.Rows.Count > 0)
                    {
                        gvUtilityConsumption.DataSource = objResult.ResultDt;
                        gvUtilityConsumption.DataBind();
                        // imgWordButton.Visible = imgExcelButton.Visible = true;
                        divNo.Visible = false;
                        divExport.Visible = true;
                        gvUtilityConsumption.Visible = true;

                    }
                    else
                    {
                        // imgWordButton.Visible = imgExcelButton.Visible = false;
                        divNo.Visible = true;
                        divExport.Visible = false;
                        gvUtilityConsumption.Visible = false;
                    }

                }
                else
                {
                    gvUtilityConsumption.Visible = false;
                    ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                   "<script>alert('You cannot select From Date greater than To Date.');</script>");
                }

            }
            catch (Exception ex)
            {
                // log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                   "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
            }
        }
        #endregion

        protected void imgPDFButton_Click(object sender, EventArgs e)
        {
            try
            {
                string text = Session[ApplicationSession.OrganisationName].ToString();
                string text1 = Session[ApplicationSession.OrganisationAddress].ToString();
                string text2 = "UtilityConsumption REPORT";

                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {

                        //DateTime dtFromDateTime = Convert.ToDateTime(tempFDt); ;
                        DateTime dtfromDateTime = DateTime.ParseExact(txtFromDate.Text + " " + txtFromTime.Text, "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                        DateTime dtToDateTime = DateTime.ParseExact(txtToDate.Text + " " + txtToTime.Text, "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                        //CommonFunctions objCommonFunction = new CommonFunctions();
                        //objCommonFunction.FormatTime(txtFromTime.Text, txtToTime.Text, out outFromTime, out outToTime);
                        //string tempFDt = txtFromDate.Text + " " + outFromTime.ToString();
                        //string tempTDt = txtToDate.Text + " " + outToTime.ToString();

                        //DateTime dtFromDateTime = Convert.ToDateTime(tempFDt);
                        //DateTime dtToDateTime = Convert.ToDateTime(tempTDt);

                        StringBuilder sb = new StringBuilder();
                        sb.Append("<div align='center' style='font-size:13px;font-weight:bold;color:Black;'>");
                        sb.Append(text);
                        sb.Append("</div>");
                        sb.Append("<br/>");
                        sb.Append("<div align='center' style='font-size:11px;font-weight:bold;color:Black;'>");
                        sb.Append(text1);
                        sb.Append("</div>");
                        sb.Append("<br/>");
                        sb.Append("<div align='center' style='font-size:15px;color:Maroon;'><b>");
                        sb.Append(text2);
                        sb.Append("</b></div>");
                        sb.Append("<br/><br/><br/>");

                        string content = "<table style='display: table;width: 900px; clear:both;'> <tr> <th colspan='4' style='float: left;padding-left: 150px;'><div align='left'><strong>From DateTime : </strong>" + dtfromDateTime + " " + "</div></th>";
                        content += "<th style='float:left; padding-left:-180px;'></th>";
                        content += "<th style='float:left; padding-left:-210px;'></th>";
                        content += "<th colspan='1' align='left' style=' float: left; padding-left:-80px;'><strong> To DateTime: </strong>" +
                        dtToDateTime + " " + "</th>" +
                        "</tr></table>";
                        sb.Append(content);

                        string strDate = DateTime.UtcNow.AddHours(5.5).ToString().Replace("/", "-").Replace(" ", "-").Replace(":", "-");
                        object filename = "UtilityConsumption REPORT" + DateTime.Now.Date.ToString("dd-MM-yyyy") + ".pdf";
                        UtilityConsumptionBl objReportBL = new UtilityConsumptionBl();

                        ApplicationResult objDSResult = new ApplicationResult();
                        objDSResult = new UtilityConsumptionBl().UtilityConsumptionLogReport(dtfromDateTime, dtToDateTime);

                        ApplicationResult objResult = new ApplicationResult();
                        objResult.ResultDt = objDSResult.ResultDt;
                        gvUtilityConsumption.DataSource = objResult.ResultDt;
                        gvUtilityConsumption.DataBind();

                        if (gvUtilityConsumption.Rows.Count > 0)
                        {
                            iTextSharp.text.pdf.PdfPTable table = new PdfPTable(objResult.ResultDt.Columns.Count);
                            table.PaddingTop = 5;
                            table.SpacingBefore = 0;
                            float[] widths = new float[objResult.ResultDt.Columns.Count];
                            for (int x = 0; x < objResult.ResultDt.Columns.Count; x++)
                            {
                                string cellText = Server.HtmlDecode(gvUtilityConsumption.HeaderRow.Cells[x].Text);
                                PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
                                CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
                                CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
                                CellTwoHdr.Padding = 5;
                                CellTwoHdr.BorderWidth = 1.5f;
                                table.AddCell(CellTwoHdr);
                                int maxlength = 0;
                                var firstSpaceIndex = cellText.IndexOf(" ");
                                if (firstSpaceIndex == -1)
                                {
                                    maxlength = cellText.Length;
                                }
                                else
                                {
                                    var firstString = cellText.Substring(0, firstSpaceIndex);
                                    var secondString = cellText.Substring(firstSpaceIndex + 1);
                                    if (firstString.Length > secondString.Length)
                                    {
                                        maxlength = firstString.Length;
                                    }
                                    else
                                    {
                                        maxlength = secondString.Length;
                                    }
                                }

                                if (maxlength <= 18 && maxlength >= 15)
                                {
                                    widths[x] = 80.00F;
                                }
                                else if (maxlength <= 15 && maxlength >= 12)
                                {
                                    widths[x] = 95.00F;
                                }
                                else if (maxlength <= 12 && maxlength >= 9)
                                {
                                    widths[x] = 90.00F;
                                }
                                else if (maxlength <= 8)
                                {
                                    widths[x] = 80.00F;
                                }

                                else if (maxlength <= 30 && maxlength >= 19)
                                {
                                    widths[x] = 80.00F;

                                }
                                table.SetWidths(widths);
                            }

                            for (int i = 0; i < gvUtilityConsumption.Rows.Count; i++)
                            {
                                if (gvUtilityConsumption.Rows[i].RowType == DataControlRowType.DataRow)
                                {
                                    for (int j = 0; j < objResult.ResultDt.Columns.Count; j++)
                                    {
                                        string cellText = Server.HtmlDecode(gvUtilityConsumption.Rows[i].Cells[j].Text);

                                        DateTime dDate;
                                        double dbvalue;
                                        int intvalue;

                                        if (DateTime.TryParse(cellText, out dDate))
                                        {
                                            PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
                                            CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
                                            CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
                                            table.AddCell(CellTwoHdr);
                                        }
                                        else if (double.TryParse(cellText, out dbvalue) || Int32.TryParse(cellText, out intvalue))
                                        {
                                            PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
                                            CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
                                            CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
                                            table.AddCell(CellTwoHdr);
                                        }
                                        else
                                        {
                                            PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
                                            CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
                                            CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
                                            table.AddCell(CellTwoHdr);
                                        }
                                    }
                                    table.HeaderRows = 1;
                                }
                            }

                            var imageURL = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath());
                            var imageURL1 = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath1());

                            iTextSharp.text.Image jpg = iTextSharp.text.Image.GetInstance(imageURL);
                            iTextSharp.text.Image jpg1 = iTextSharp.text.Image.GetInstance(imageURL1);


                            jpg.Alignment = Element.ALIGN_CENTER;
                            //jpg.SetAbsolutePosition(30, 1075);
                            jpg.SetAbsolutePosition(80, 1560);

                            jpg1.Alignment = Element.ALIGN_RIGHT;
                            jpg1.SetAbsolutePosition(2050, 1530);

                            StringReader sr = new StringReader(sb.ToString());

                            Document pdfDoc = new Document(iTextSharp.text.PageSize.A1.Rotate(), -200f, -200f, 40f, 30f);

                            //   Document pdfDoc = new Document(iTextSharp.text.PageSize.A1, -40f, -40f, 20f, 30f);
                            // pdfDoc.SetPageSize(iTextSharp.text.PageSize.A3.Rotate());
                            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                            PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                            PDFBackgroundHelper pageEventHelper = new PDFBackgroundHelper();
                            writer.PageEvent = pageEventHelper;
                            pdfDoc.Open();
                            htmlparser.Parse(sr);
                            pdfDoc.Add(jpg);
                            pdfDoc.Add(jpg1);
                            pdfDoc.Add(table);

                            PdfPTable footer = new PdfPTable(2);
                            PdfPTable footer2 = new PdfPTable(2);

                            float[] cols = new float[] { 100, 300 };

                            footer.SetWidthPercentage(cols, iTextSharp.text.PageSize.A3);
                            footer2.SetWidthPercentage(cols, iTextSharp.text.PageSize.A3);
                            footer.WriteSelectedRows(0, -1, pdfDoc.LeftMargin + 95, 90, writer.DirectContent);
                            footer2.WriteSelectedRows(0, -1, pdfDoc.LeftMargin + 95, 70, writer.DirectContent);
                            //----------- /FOOTER -----------

                            pdfDoc.Close();
                            Response.ContentType = "application/pdf";
                            Response.AddHeader("content-disposition", "attachment;" + "filename=" + filename);
                            Response.Cache.SetCacheability(HttpCacheability.NoCache);
                            Response.Write(pdfDoc);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //  log.Error("PDF Export Button", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
            }
        }

        protected void imgExcelButton_Click(object sender, EventArgs e)
        {

        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            BindUtilityConsumption();
        }

        protected void gvUtilityConsumption_PreRender(object sender, EventArgs e)
        {

        }
    }
}