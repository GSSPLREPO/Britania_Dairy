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
    public partial class CPLLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region VerifyRenderingInServerForm
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
        #endregion

        #region BindGrid
        public void CPLLogReport()
        {
            try
            {
                ApplicationResult objResult = new ApplicationResult();
                CPLBL objCPLStorage = new CPLBL();
                DateTime dtFromDateTime = DateTime.ParseExact(txtFromDate.Text + " " + txtFromTime.Text, "dd/MM/yyyy HH:mm:ss",
                  CultureInfo.InvariantCulture);
                DateTime dtToDateTime = DateTime.ParseExact(txtToDate.Text + " " + txtToTime.Text, "dd/MM/yyyy HH:mm:ss",
                    CultureInfo.InvariantCulture);
                objResult = objCPLStorage.CPLLogReport(dtFromDateTime, dtToDateTime);
                if (objResult.ResultDt.Rows.Count > 0)
                {
                    gvCPL.DataSource = objResult.ResultDt;
                    gvCPL.DataBind();
                    // imgWordButton.Visible = imgExcelButton.Visible = true;
                    divNo.Visible = false;
                }
                else
                {
                    // imgWordButton.Visible = imgExcelButton.Visible = false;
                    divNo.Visible = true;
                    // ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                    //"<script>alert('No Record Found.');</script>");
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
                string text2 = "CPLLog REPORT";

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
                        object filename = "CPLLogReport" + DateTime.Now.Date.ToString("dd-MM-yyyy") + ".pdf";
                        CPLBL objReportBL = new CPLBL();

                        ApplicationResult objDSResult = new ApplicationResult();
                        objDSResult = new CPLBL().CPLLogReport(dtfromDateTime, dtToDateTime);

                        ApplicationResult objResult = new ApplicationResult();
                        objResult.ResultDt = objDSResult.ResultDt;
                        gvCPL.DataSource = objResult.ResultDt;
                        gvCPL.DataBind();

                        if (gvCPL.Rows.Count > 0)
                        {
                            iTextSharp.text.pdf.PdfPTable table = new PdfPTable(objResult.ResultDt.Columns.Count);
                            table.PaddingTop = 5;
                            table.SpacingBefore = 0;
                            float[] widths = new float[objResult.ResultDt.Columns.Count];
                            for (int x = 0; x < objResult.ResultDt.Columns.Count; x++)
                            {
                                string cellText = Server.HtmlDecode(gvCPL.HeaderRow.Cells[x].Text);
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

                            for (int i = 0; i < gvCPL.Rows.Count; i++)
                            {
                                if (gvCPL.Rows[i].RowType == DataControlRowType.DataRow)
                                {
                                    for (int j = 0; j < objResult.ResultDt.Columns.Count; j++)
                                    {
                                        string cellText = Server.HtmlDecode(gvCPL.Rows[i].Cells[j].Text);

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
            try
            {
                string text = Session[ApplicationSession.OrganisationName].ToString();
                string text1 = Session[ApplicationSession.OrganisationAddress].ToString();
                string text2 = "CPL Log REPORT";
                string filename = "CPL Log REPORT" + DateTime.Now.Date.ToString("dd-MM-yyyy") + ".xls";
                Response.AddHeader("content-disposition", "attachment;filename=" + filename);
                //Response.AddHeader("content-disposition", "attachment;filename=WeighbridgeSummaryReport.xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.ms-excel";
                StringWriter sw = new StringWriter();
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                gvCPL.AllowPaging = false;
                gvCPL.RenderControl(hw);
                string strTitle = text;
                string Date = DateTime.UtcNow.AddHours(5.5).ToString();
                string strSubTitle = text2 + "</br>";
                //string strPath = Request.Url.GetLeftPart(UriPartial.Authority) + "/images/Logo1.gif";
                string strPath = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath());
                string strPath1 = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath1());

                string content = "<div align='left' style='font-family:verdana;font-size:16px'><img width='100' height='100' src='" + strPath + "'/></div><div align='center' style='font-family:verdana;font-size:16px;style='text-align:center'><img width='100' height='100' src='" + strPath1 + "'/></div><div align='center' style='font-family:verdana;font-size:16px'><span style='font-size:16px;font-weight:bold;color:Black;'>" + Session[ApplicationSession.OrganisationName] +
                       "</span><br/><span style='font-size:13px;font-weight:bold;color:Black;'>" + Session[ApplicationSession.OrganisationAddress] + "</span><br/>" +
                          "<span align='center' style='font-family:verdana;font-size:13px'><strong>" + strSubTitle + "</strong></span><br/>" +
                          "<div align='center' style='font-family:verdana;font-size:12px'><strong>From Date :</strong>" +
                      DateTime.ParseExact(txtFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture) +
                       "&nbsp;&nbsp;&nbsp;&nbsp;<strong> To Date :</strong>" +
                       DateTime.ParseExact(txtToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture) +
                       "</div><br/> "
                       + sw.ToString() + "<br/></div>";
                Response.Output.Write(content);
                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                // log.Error("Button EXCEL", ex);
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Oops! There is some technical issue. Please Contact to your administrator.');", true);
            }

        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            CPLLogReport();
        }

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
                        ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, new Phrase("RWST Storage REPORT", FONT), 1190, 1665, 0);
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
        protected void gvCPL_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    GridViewRow headerRow1 = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                    GridViewRow headerRow2 = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);


                    TableHeaderCell headerTableCell = new TableHeaderCell();

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 2;
                    headerTableCell.Text = "SrNo";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 2;
                    headerTableCell.Text = "Date";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 2;
                    headerTableCell.Text = "Time";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    //headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "PasteurizerStatus";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                   // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Source";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Destination";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Pasteurizer Flow";
                    headerRow1.Controls.Add(headerTableCell);


                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Batch Totalizer";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Transfered Quantity";
                    headerRow1.Controls.Add(headerTableCell);


                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Heating FDV Status";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Chilling FDV Status";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Heating";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Cooling";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "HotWater Inlet";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Regeneration Efficiency";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    // headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Remarks";
                    headerRow1.Controls.Add(headerTableCell);

                    TableHeaderCell headerCell1;
                    TableHeaderCell headerCell2;
                    TableHeaderCell headerCell3;
                    TableHeaderCell headerCell4;
                    TableHeaderCell headerCell5;
                    TableHeaderCell headerCell6;
                    TableHeaderCell headerCell7;
                    TableHeaderCell headerCell8;
                    TableHeaderCell headerCell9;
                    TableHeaderCell headerCell10;
                    TableHeaderCell headerCell11;
                    TableHeaderCell headerCell12;
                    TableHeaderCell headerCell13;
                    TableHeaderCell headerCell14;
                    TableHeaderCell headerCell15;
                    TableHeaderCell headerCell16;
                    TableHeaderCell headerCell17;
                    TableHeaderCell headerCell18;
                    TableHeaderCell headerCell19;
                    TableHeaderCell headerCell20;
                    TableHeaderCell headerCell21;
                    TableHeaderCell headerCell22;
                    TableHeaderCell headerCell23;
                    TableHeaderCell headerCell24;
                    TableHeaderCell headerCell25;
                    TableHeaderCell headerCell26;
                    TableHeaderCell headerCell27;
                    TableHeaderCell headerCell28;





                    headerCell1 = new TableHeaderCell();
                    headerCell2 = new TableHeaderCell();
                    headerCell3 = new TableHeaderCell();
                    headerCell4 = new TableHeaderCell();
                    headerCell5 = new TableHeaderCell();

                    headerCell6 = new TableHeaderCell();
                    headerCell7 = new TableHeaderCell();
                    headerCell8 = new TableHeaderCell();
                    headerCell9 = new TableHeaderCell();
                    headerCell10 = new TableHeaderCell();

                    headerCell11 = new TableHeaderCell();
                    headerCell12 = new TableHeaderCell();
                    //headerCell13 = new TableHeaderCell();
                    //headerCell14 = new TableHeaderCell();
                    //headerCell15 = new TableHeaderCell();

                    //headerCell16 = new TableHeaderCell();
                    //headerCell17 = new TableHeaderCell();
                    //headerCell18 = new TableHeaderCell();
                    //headerCell19 = new TableHeaderCell();
                    //headerCell20 = new TableHeaderCell();

                    //headerCell21 = new TableHeaderCell();
                    //headerCell22 = new TableHeaderCell();
                    //headerCell23 = new TableHeaderCell();
                    //headerCell24 = new TableHeaderCell();
                    //headerCell25 = new TableHeaderCell();
                    //headerCell26 = new TableHeaderCell();
                    //headerCell27 = new TableHeaderCell();
                    //headerCell28 = new TableHeaderCell();



                    //headerCell1.Text = "Types of Whey";
                    //headerCell2.Text = "Tank Status";
                    //headerCell3.Text = "Qty (Ltrs)";
                    //headerCell4.Text = "Temp (°C)";
                    //headerCell5.Text = "Ageing timer(hr)";
                    //headerCell6.Text = "Dirty Time(hr)";



                    //headerCell7.Text = "Types of Whey";
                    //headerCell8.Text = "Tank Status";
                    //headerCell9.Text = "Qty (Ltrs)";
                    //headerCell10.Text = "Temp (°C)";
                    //headerCell11.Text = "Ageing timer(hr)";
                    //headerCell12.Text = "Dirty Time(hr)";


                    //headerCell15.Text = "Qty (Ltrs)";
                    //headerCell16.Text = "Temp (°C)";
                    //headerCell17.Text = "Inoculation Time(min)";
                    //headerCell18.Text = "Curd Breaking Time(min)";
                    //headerCell19.Text = "Ageing Time(hr)";
                    //headerCell20.Text = "CIP Time(hr)";
                    //headerCell21.Text = "QC Released Time";

                    //headerCell22.Text = "Qty (Ltrs)";
                    //headerCell23.Text = "Temp (°C)";
                    //headerCell24.Text = "Inoculation Time(min)";
                    //headerCell25.Text = "Curd Breaking Time(min)";
                    //headerCell26.Text = "Ageing Time(hr)";
                    //headerCell27.Text = "CIP Time(hr)";
                    //headerCell28.Text = "QC Released Time";








                    headerRow2.Controls.Add(headerCell1);
                    headerRow2.Controls.Add(headerCell2);
                    headerRow2.Controls.Add(headerCell3);
                    headerRow2.Controls.Add(headerCell4);
                    headerRow2.Controls.Add(headerCell5);

                    headerRow2.Controls.Add(headerCell6);
                    headerRow2.Controls.Add(headerCell7);
                    headerRow2.Controls.Add(headerCell8);
                    headerRow2.Controls.Add(headerCell9);
                    headerRow2.Controls.Add(headerCell10);

                    headerRow2.Controls.Add(headerCell11);
                    headerRow2.Controls.Add(headerCell12);
                    //headerRow2.Controls.Add(headerCell13);
                    //headerRow2.Controls.Add(headerCell14);
                    //headerRow2.Controls.Add(headerCell15);

                    //headerRow2.Controls.Add(headerCell16);
                    //headerRow2.Controls.Add(headerCell17);
                    //headerRow2.Controls.Add(headerCell18);
                    //headerRow2.Controls.Add(headerCell19);
                    //headerRow2.Controls.Add(headerCell20);

                    //headerRow2.Controls.Add(headerCell21);
                    //headerRow2.Controls.Add(headerCell22);
                    //headerRow2.Controls.Add(headerCell23);
                    //headerRow2.Controls.Add(headerCell24);
                    //headerRow2.Controls.Add(headerCell25);
                    //headerRow2.Controls.Add(headerCell26);
                    //headerRow2.Controls.Add(headerCell27);
                    //headerRow2.Controls.Add(headerCell28);


                    gvCPL.Controls[0].Controls.AddAt(0, headerRow2);
                    gvCPL.Controls[0].Controls.AddAt(0, headerRow1);
                }
            }

        }

        protected void gvCPL_PreRender(object sender, EventArgs e)
        {

        }
    }
}