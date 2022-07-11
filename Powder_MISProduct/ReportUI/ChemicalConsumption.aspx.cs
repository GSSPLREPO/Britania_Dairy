﻿using System;
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
using Font = iTextSharp.text.Font;

namespace Powder_MISProduct.ReportUI
{
    public partial class ChemicalConsumption : System.Web.UI.Page
    {
        #region Page Load
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

        #region VerifyRenderingInServerForm
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
        #endregion

        #region BindGrid
        public void ChemicalConsumptionLog()
        {
            try
            {
                ApplicationResult objResult = new ApplicationResult();
                ChemicalConsumptionBL objChemicalConsumption = new ChemicalConsumptionBL();
                DateTime dtFromDateTime = DateTime.ParseExact(txtFromDate.Text, "dd/MM/yyyy",
                  CultureInfo.InvariantCulture);
                DateTime dtToDateTime = DateTime.ParseExact(txtToDate.Text, "dd/MM/yyyy",
                    CultureInfo.InvariantCulture);

                if (dtFromDateTime <= dtToDateTime)
                {
                    objResult = objChemicalConsumption.ChemicalConsumption(dtFromDateTime, dtToDateTime);
                    if (objResult.ResultDt.Rows.Count > 0)
                    {
                        gvChemicalConsumption.DataSource = objResult.ResultDt;
                        gvChemicalConsumption.DataBind();
                        // imgWordButton.Visible = imgExcelButton.Visible = true;
                        divExport.Visible = true;
                        divNo.Visible = false;
                        gvChemicalConsumption.Visible = true;

                    }
                    else
                    {
                        // imgWordButton.Visible = imgExcelButton.Visible = false;
                        divExport.Visible = false;
                        divNo.Visible = true;
                        gvChemicalConsumption.Visible = false;
                        // ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                        //"<script>alert('No Record Found.');</script>");
                    }
                }
                else
                {
                    gvChemicalConsumption.Visible = false;
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

        #region Grid view row created event
        protected void gvChemicalConsumption_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    GridViewRow headerRow1 = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                    GridViewRow headerRow2 = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);


                    TableHeaderCell headerTableCell = new TableHeaderCell();

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    headerTableCell.Text = "Sr. No.";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    headerTableCell.Text = "Date";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    headerTableCell.Text = "Time";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    //headerTableCell.ColumnSpan = 7;
                    headerTableCell.Text = "Shift";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    //headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Lye (Ltr.)";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    //headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Acid (Ltr.)";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    //headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Lye Consumption";
                    headerRow1.Controls.Add(headerTableCell);

                    headerTableCell = new TableHeaderCell();
                    headerTableCell.RowSpan = 1;
                    //headerTableCell.ColumnSpan = 6;
                    headerTableCell.Text = "Acid Consumption";
                    headerRow1.Controls.Add(headerTableCell);

                    gvChemicalConsumption.Controls[0].Controls.AddAt(0, headerRow1);
                }
            }

        }
        #endregion
        protected void btnGo_Click(object sender, EventArgs e)
        {
            ChemicalConsumptionLog();
        }

        #region PDF export.

        protected void imgPDFButton_Click(object sender, EventArgs e)
        {
            try
            {
                string text = Session[ApplicationSession.OrganisationName].ToString();
                string text1 = Session[ApplicationSession.OrganisationAddress].ToString();
                string text2 = "Chemical Consumption Report";

                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        DateTime dtfromDateTime = DateTime.ParseExact(txtFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        DateTime dtToDateTime = DateTime.ParseExact(txtToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

                        System.Text.StringBuilder sb = new StringBuilder();
                        sb.Append("<div align='center' style='font-size:16px;font-weight:bold;color:Black;'>");
                        sb.Append(text);
                        sb.Append("</div>");
                        sb.Append("<br/>");
                        sb.Append("<div align='center' style='font-size:13px;font-weight:bold;color:Black;'>");
                        sb.Append(text1);
                        sb.Append("</div>");
                        sb.Append("<br/>");
                        sb.Append("<div align='center' style='font-size:26px;color:Maroon;'><b>");
                        sb.Append(text2);
                        sb.Append("</b></div>");
                        sb.Append("<br/>");

                        string content = "<table style='display: table;width: 900px; clear:both;'> <tr> <th colspan='7'"
                            + "style='float: left;padding-left: 275px;'><div align='left'><strong>From Date : </strong>" +
                            dtfromDateTime + "</div></th>";

                        content += "<th style='float:left; padding-left:-180px;'></th>";

                        content += "<th style='float:left; padding-left:-210px;'></th>";

                        content += "<th colspan='1' align='left' style=' float: left; padding-left:-200px;'><strong> To DateTime: </strong>" +
                        dtToDateTime + "</th>" +
                        "</tr></table>";
                        sb.Append(content);
                        sb.Append("<br/>");

                        PdfPTable pdfPTable = new PdfPTable(gvChemicalConsumption.HeaderRow.Cells.Count);
                        iTextSharp.text.Font fontHeader = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 18, iTextSharp.text.Font.BOLD);
                        Font header = new Font(Font.FontFamily.TIMES_ROMAN, 15f, Font.BOLD, BaseColor.BLACK);



                        PdfPCell headerCel20 = new PdfPCell(new Phrase("Sr. No."));
                        headerCel20.Rowspan = 1;
                        headerCel20.Colspan = 1;
                        headerCel20.Padding = 5;
                        headerCel20.BorderWidth = 1.5f;
                        headerCel20.HorizontalAlignment = Element.ALIGN_CENTER;
                        headerCel20.VerticalAlignment = Element.ALIGN_MIDDLE;
                        pdfPTable.AddCell(headerCel20);

                        PdfPCell headerCell = new PdfPCell(new Phrase("Date"));
                        headerCell.Rowspan = 1;
                        headerCell.Colspan = 1;
                        headerCell.Padding = 5;
                        headerCell.BorderWidth = 1.5f;
                        headerCell.HorizontalAlignment = Element.ALIGN_CENTER;
                        headerCell.VerticalAlignment = Element.ALIGN_MIDDLE;
                        pdfPTable.AddCell(headerCell);

                        PdfPCell headerCell1 = new PdfPCell(new Phrase("Time"));
                        headerCell1.Rowspan = 1;
                        headerCell1.Colspan = 1;
                        headerCell1.Padding = 5;
                        headerCell1.BorderWidth = 1.5f;
                        headerCell1.HorizontalAlignment = Element.ALIGN_CENTER;
                        headerCell1.VerticalAlignment = Element.ALIGN_MIDDLE;
                        pdfPTable.AddCell(headerCell1);

                        PdfPCell headerCell2 = new PdfPCell(new Phrase("Shift"));
                        headerCell2.Rowspan = 1;
                        headerCell2.Colspan = 1;
                        headerCell2.Padding = 5;
                        headerCell2.BorderWidth = 1.5f;
                        headerCell2.HorizontalAlignment = Element.ALIGN_CENTER;
                        headerCell2.VerticalAlignment = Element.ALIGN_MIDDLE;
                        pdfPTable.AddCell(headerCell2);

                        PdfPCell headerCell3 = new PdfPCell(new Phrase("Lye (Ltr.)"));
                        headerCell3.Rowspan = 1;
                        headerCell3.Colspan = 1;
                        headerCell3.Padding = 5;
                        headerCell3.BorderWidth = 1.5f;
                        headerCell3.HorizontalAlignment = Element.ALIGN_CENTER;
                        headerCell3.VerticalAlignment = Element.ALIGN_MIDDLE;
                        pdfPTable.AddCell(headerCell3);

                        PdfPCell headerCell4 = new PdfPCell(new Phrase("Acid (Ltr.)"));
                        headerCell4.Rowspan = 1;
                        headerCell4.Colspan = 1;
                        headerCell4.Padding = 5;
                        headerCell4.BorderWidth = 1.5f;
                        headerCell4.HorizontalAlignment = Element.ALIGN_CENTER;
                        headerCell4.VerticalAlignment = Element.ALIGN_MIDDLE;
                        pdfPTable.AddCell(headerCell4);
                        
                        PdfPCell headerCell5 = new PdfPCell(new Phrase("Lye Consumption"));
                        headerCell5.Rowspan = 1;
                        headerCell5.Colspan = 1;
                        headerCell5.Padding = 5;
                        headerCell5.BorderWidth = 1.5f;
                        headerCell5.HorizontalAlignment = Element.ALIGN_CENTER;
                        headerCell5.VerticalAlignment = Element.ALIGN_MIDDLE;
                        pdfPTable.AddCell(headerCell5);

                        PdfPCell headerCell6 = new PdfPCell(new Phrase("Acid Consumption"));
                        headerCell6.Rowspan = 1;
                        headerCell6.Colspan = 1;
                        headerCell6.Padding = 5;
                        headerCell6.BorderWidth = 1.5f;
                        headerCell6.HorizontalAlignment = Element.ALIGN_CENTER;
                        headerCell6.VerticalAlignment = Element.ALIGN_MIDDLE;
                        pdfPTable.AddCell(headerCell6);

                        //float[] widthsTAS = { 90f,90f, 90f, 90f, 90f, 90f, 90f, 90f, 90f,90f

                        //};
                        //pdfPTable.SetWidths(widthsTAS);
                        
                        foreach (GridViewRow gridViewRow in gvChemicalConsumption.Rows)
                        {
                            foreach (TableCell tableCell in gridViewRow.Cells)
                            {
                                string cellText = Server.HtmlDecode(tableCell.Text);
                                iTextSharp.text.Font fontH1 = new iTextSharp.text.Font(iTextSharp.text.Font.NORMAL, 23);

                                DateTime dDate;
                                double dbvalue;
                                int intvalue;

                                if (DateTime.TryParse(cellText, out dDate))
                                {
                                    PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
                                    CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
                                    CellTwoHdr.Padding = 5;
                                    pdfPTable.AddCell(CellTwoHdr);
                                }
                                else if (double.TryParse(cellText, out dbvalue) || Int32.TryParse(cellText, out intvalue))
                                {
                                    PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
                                    CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
                                    CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
                                    CellTwoHdr.Padding = 5;
                                    pdfPTable.AddCell(CellTwoHdr);
                                }
                                else
                                {
                                    PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
                                    CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
                                    CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
                                    CellTwoHdr.Padding = 5;
                                    pdfPTable.AddCell(CellTwoHdr);
                                }
                            }
                            pdfPTable.HeaderRows = 2;
                        }

                        //var imageURL = Request.Url.GetLeftPart(UriPartial.Authority) + "/images/Logo1.gif";
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

                        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                        PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                        PDFBackgroundHelper pageEventHelper = new PDFBackgroundHelper();
                        writer.PageEvent = pageEventHelper;
                        pdfDoc.Open();
                        htmlparser.Parse(sr);
                        pdfDoc.Add(jpg);
                        pdfDoc.Add(jpg1);
                        pdfDoc.Add(pdfPTable);

                        //----------- FOOTER -----------
                        PdfPTable footer = new PdfPTable(2);
                        PdfPTable footer2 = new PdfPTable(2);

                        float[] cols = new float[] { 100, 300 };

                        footer.SetWidthPercentage(cols, iTextSharp.text.PageSize.A3);
                        footer2.SetWidthPercentage(cols, iTextSharp.text.PageSize.A3);

                        footer.WriteSelectedRows(0, -1, pdfDoc.LeftMargin + 130, 90, writer.DirectContent);
                        footer2.WriteSelectedRows(0, -1, pdfDoc.LeftMargin + 130, 70, writer.DirectContent);
                        //----------- /FOOTER -----------

                        pdfDoc.Close();
                        Response.ContentType = "application/pdf";

                        Response.AddHeader("content-disposition", "attachment;" + "filename=Chemical_Consumption_Report_" + DateTime.Now.ToString("dd/MM/yyyy") + "_" + DateTime.Now.ToString("HH:mm:ss") + ".pdf");
                        Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        Response.Write(pdfDoc);
                        Response.Flush();
                        Response.Clear();
                        Response.End();

                    }
                }
            }
            catch (Exception ex)
            {
                // log.Error("Error", ex);
                ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp",
                    "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
            }

        }
        //protected void imgPDFButton_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string text = Session[ApplicationSession.OrganisationName].ToString();
        //        string text1 = Session[ApplicationSession.OrganisationAddress].ToString();
        //        string text2 = "Chemical Consumption Report";

        //        using (StringWriter sw = new StringWriter())
        //        {
        //            using (HtmlTextWriter hw = new HtmlTextWriter(sw))
        //            {

        //                //DateTime dtFromDateTime = Convert.ToDateTime(tempFDt); ;
        //                DateTime dtfromDateTime = DateTime.ParseExact(txtFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        //                DateTime dtToDateTime = DateTime.ParseExact(txtToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        //                //CommonFunctions objCommonFunction = new CommonFunctions();
        //                //objCommonFunction.FormatTime(txtFromTime.Text, txtToTime.Text, out outFromTime, out outToTime);
        //                //string tempFDt = txtFromDate.Text + " " + outFromTime.ToString();
        //                //string tempTDt = txtToDate.Text + " " + outToTime.ToString();

        //                //DateTime dtFromDateTime = Convert.ToDateTime(tempFDt);
        //                //DateTime dtToDateTime = Convert.ToDateTime(tempTDt);

        //                StringBuilder sb = new StringBuilder();
        //                sb.Append("<div align='center' style='font-size:13px;font-weight:bold;color:Black;'>");
        //                sb.Append(text);
        //                sb.Append("</div>");
        //                sb.Append("<br/>");
        //                sb.Append("<div align='center' style='font-size:11px;font-weight:bold;color:Black;'>");
        //                sb.Append(text1);
        //                sb.Append("</div>");
        //                sb.Append("<br/>");
        //                sb.Append("<div align='center' style='font-size:15px;color:Maroon;'><b>");
        //                sb.Append(text2);
        //                sb.Append("</b></div>");
        //                sb.Append("<br/><br/><br/>");

        //                string content = "<table style='display: table;width: 900px; clear:both;'> <tr> <th colspan='4' style='float: left;padding-left: 150px;'><div align='left'><strong>From DateTime : </strong>" + dtfromDateTime + " " + "</div></th>";
        //                content += "<th style='float:left; padding-left:-180px;'></th>";
        //                content += "<th style='float:left; padding-left:-210px;'></th>";
        //                content += "<th colspan='1' align='left' style=' float: left; padding-left:-80px;'><strong> To DateTime: </strong>" +
        //                dtToDateTime + " " + "</th>" +
        //                "</tr></table>";
        //                sb.Append(content);

        //                string strDate = DateTime.UtcNow.AddHours(5.5).ToString().Replace("/", "-").Replace(" ", "-").Replace(":", "-");
        //                object filename = "ChemicalConsumptionReport" + DateTime.Now.Date.ToString("dd-MM-yyyy") + ".pdf";
        //                ChemicalConsumptionBL objReportBL = new ChemicalConsumptionBL();

        //                ApplicationResult objDSResult = new ApplicationResult();
        //                objDSResult = new ChemicalConsumptionBL().ChemicalConsumption(dtfromDateTime, dtToDateTime);

        //                ApplicationResult objResult = new ApplicationResult();
        //                objResult.ResultDt = objDSResult.ResultDt;
        //                gvChemicalConsumption.DataSource = objResult.ResultDt;
        //                gvChemicalConsumption.DataBind();

        //                if (gvChemicalConsumption.Rows.Count > 0)
        //                {
        //                    iTextSharp.text.pdf.PdfPTable table = new PdfPTable(objResult.ResultDt.Columns.Count);
        //                    table.PaddingTop = 5;
        //                    table.SpacingBefore = 0;
        //                    float[] widths = new float[objResult.ResultDt.Columns.Count];
        //                    for (int x = 0; x < objResult.ResultDt.Columns.Count; x++)
        //                    {
        //                        string cellText = Server.HtmlDecode(gvChemicalConsumption.HeaderRow.Cells[x].Text);
        //                        PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
        //                        CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
        //                        CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
        //                        CellTwoHdr.Padding = 5;
        //                        CellTwoHdr.BorderWidth = 1.5f;
        //                        table.AddCell(CellTwoHdr);
        //                        int maxlength = 0;
        //                        var firstSpaceIndex = cellText.IndexOf(" ");
        //                        if (firstSpaceIndex == -1)
        //                        {
        //                            maxlength = cellText.Length;
        //                        }
        //                        else
        //                        {
        //                            var firstString = cellText.Substring(0, firstSpaceIndex);
        //                            var secondString = cellText.Substring(firstSpaceIndex + 1);
        //                            if (firstString.Length > secondString.Length)
        //                            {
        //                                maxlength = firstString.Length;
        //                            }
        //                            else
        //                            {
        //                                maxlength = secondString.Length;
        //                            }
        //                        }

        //                        if (maxlength <= 18 && maxlength >= 15)
        //                        {
        //                            widths[x] = 80.00F;
        //                        }
        //                        else if (maxlength <= 15 && maxlength >= 12)
        //                        {
        //                            widths[x] = 95.00F;
        //                        }
        //                        else if (maxlength <= 12 && maxlength >= 9)
        //                        {
        //                            widths[x] = 90.00F;
        //                        }
        //                        else if (maxlength <= 8)
        //                        {
        //                            widths[x] = 80.00F;
        //                        }
        //                        table.SetWidths(widths);
        //                    }

        //                    for (int i = 0; i < gvChemicalConsumption.Rows.Count; i++)
        //                    {
        //                        if (gvChemicalConsumption.Rows[i].RowType == DataControlRowType.DataRow)
        //                        {
        //                            for (int j = 0; j < objResult.ResultDt.Columns.Count; j++)
        //                            {
        //                                string cellText = Server.HtmlDecode(gvChemicalConsumption.Rows[i].Cells[j].Text);

        //                                DateTime dDate;
        //                                double dbvalue;
        //                                int intvalue;

        //                                if (DateTime.TryParse(cellText, out dDate))
        //                                {
        //                                    PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
        //                                    CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
        //                                    CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
        //                                    table.AddCell(CellTwoHdr);
        //                                }
        //                                else if (double.TryParse(cellText, out dbvalue) || Int32.TryParse(cellText, out intvalue))
        //                                {
        //                                    PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
        //                                    CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
        //                                    CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
        //                                    table.AddCell(CellTwoHdr);
        //                                }
        //                                else
        //                                {
        //                                    PdfPCell CellTwoHdr = new PdfPCell(new Phrase(cellText));
        //                                    CellTwoHdr.HorizontalAlignment = Element.ALIGN_CENTER;
        //                                    CellTwoHdr.VerticalAlignment = Element.ALIGN_MIDDLE;
        //                                    table.AddCell(CellTwoHdr);
        //                                }
        //                            }
        //                            table.HeaderRows = 1;
        //                        }
        //                    }

        //                    var imageURL = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath());
        //                    var imageURL1 = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath1());

        //                    iTextSharp.text.Image jpg = iTextSharp.text.Image.GetInstance(imageURL);
        //                    iTextSharp.text.Image jpg1 = iTextSharp.text.Image.GetInstance(imageURL1);


        //                    jpg.Alignment = Element.ALIGN_CENTER;
        //                    //jpg.SetAbsolutePosition(30, 1075);
        //                    jpg.SetAbsolutePosition(80, 1560);

        //                    jpg1.Alignment = Element.ALIGN_RIGHT;
        //                    jpg1.SetAbsolutePosition(2050, 1530);

        //                    StringReader sr = new StringReader(sb.ToString());

        //                    Document pdfDoc = new Document(iTextSharp.text.PageSize.A1.Rotate(), -200f, -200f, 40f, 30f);

        //                    //   Document pdfDoc = new Document(iTextSharp.text.PageSize.A1, -40f, -40f, 20f, 30f);
        //                    // pdfDoc.SetPageSize(iTextSharp.text.PageSize.A3.Rotate());
        //                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //                    PDFBackgroundHelper pageEventHelper = new PDFBackgroundHelper();
        //                    writer.PageEvent = pageEventHelper;
        //                    pdfDoc.Open();
        //                    htmlparser.Parse(sr);
        //                    pdfDoc.Add(jpg);
        //                    pdfDoc.Add(jpg1);
        //                    pdfDoc.Add(table);

        //                    PdfPTable footer = new PdfPTable(2);
        //                    PdfPTable footer2 = new PdfPTable(2);

        //                    float[] cols = new float[] { 100, 300 };

        //                    footer.SetWidthPercentage(cols, iTextSharp.text.PageSize.A3);
        //                    footer2.SetWidthPercentage(cols, iTextSharp.text.PageSize.A3);
        //                    footer.WriteSelectedRows(0, -1, pdfDoc.LeftMargin + 95, 90, writer.DirectContent);
        //                    footer2.WriteSelectedRows(0, -1, pdfDoc.LeftMargin + 95, 70, writer.DirectContent);
        //                    //----------- /FOOTER -----------

        //                    pdfDoc.Close();
        //                    Response.ContentType = "application/pdf";
        //                    Response.AddHeader("content-disposition", "attachment;" + "filename=" + filename);
        //                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //                    Response.Write(pdfDoc);
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        //  log.Error("PDF Export Button", ex);
        //        ClientScript.RegisterStartupScript(typeof(Page), "MessagePopUp", "<script>alert('Oops! There is some technical Problem. Contact to your Administrator.');</script>");
        //    }

        //}
        #endregion

        #region Excel export.
        protected void imgExcelButton_Click(object sender, EventArgs e)
        {
            try
            {
                int count = 0;
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.ContentEncoding = System.Text.Encoding.Unicode;
                Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
                string filename = "Chemical_Consumption_Report_" + DateTime.Now.ToString("dd/MM/yyyy") + "_" + DateTime.Now.ToString("HH:mm:ss") + ".xls";
                Response.AddHeader("content-disposition", "attachment;filename=" + filename);
                Response.Cache.SetCacheability(HttpCacheability.NoCache);

                StringWriter sw = new StringWriter();
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                gvChemicalConsumption.AllowPaging = false;
                gvChemicalConsumption.GridLines = GridLines.Both;
                foreach (TableCell cell in gvChemicalConsumption.HeaderRow.Cells)
                {
                    cell.BackColor = gvChemicalConsumption.HeaderStyle.BackColor;
                    count++;
                }

                // colh for set colspan for Ornanisation Name, Adress and Report Name
                // cold for set colspan  for Date
                int colh, cold;
                int temp = 0;
                string strTh = string.Empty;

                if (count <= 9)
                {
                    temp = 9 - count;
                    count = count + temp;
                    if (temp > 1)
                    {
                        temp = 1;
                    }
                    for (int i = 0; i < temp; i++)
                    {
                        strTh = strTh + "<th></th>";
                    }

                }

                colh = count - 4;
                cold = count - 8;


                foreach (GridViewRow row in gvChemicalConsumption.Rows)
                {

                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = gvChemicalConsumption.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = gvChemicalConsumption.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                        cell.HorizontalAlign = HorizontalAlign.Center;
                        List<Control> controls = new List<Control>();

                        //Add controls to be removed to Generic List
                        foreach (Control control in cell.Controls)
                        {
                            controls.Add(control);
                        }

                        //Loop through the controls to be removed and replace then with Literal
                        foreach (Control control in controls)
                        {
                            switch (control.GetType().Name)
                            {
                                case "HyperLink":
                                    cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
                                    break;
                                case "TextBox":
                                    cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
                                    break;
                                case "LinkButton":
                                    cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
                                    break;
                                case "CheckBox":
                                    cell.Controls.Add(new Literal { Text = (control as CheckBox).Text });
                                    break;
                                case "RadioButton":
                                    cell.Controls.Add(new Literal { Text = (control as RadioButton).Text });
                                    break;
                            }
                            cell.Controls.Remove(control);
                        }
                    }
                }


                gvChemicalConsumption.RenderControl(hw);
                string strSubTitle = "Chemical Consumption Report";

                string imageURL = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath());
                string imageURL1 = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath1());

                string content = "<div align='center' style='font-family:verdana;font-size:16px; width:800px;'>" +
                  "<table style='display: table; width: 800px; clear:both;'>" +
                  "<tr> </tr>" +
                  "<tr><th><img height='90' width='90' src='" + imageURL1 + "'/></th>" +
                   strTh +
                  "<th colspan='" + colh + "' style='width: 600px; float: left; font-weight:bold;font-size:16px;'>" + Session[ApplicationSession.OrganisationName] + 
                  "<th><img  height= '80' width= '90' src='" + imageURL + "'/></th>" +
                     "</tr>" +
                     "<tr><th colspan='2'>'" +  "'</th><th colspan='" + colh + "' style='font-size:13px;font-weight:bold;color:Black;'>" + Session[ApplicationSession.OrganisationAddress] + "</th></tr>" +
                     "<tr><th colspan='2'>'" +  "'</th><th colspan='" + colh + "'></th></tr>" +
                     "<tr><th colspan='2'>'" + "'</th><th colspan='" + colh + "' style='font-size:22px;color:Maroon;'><b>" + strSubTitle + "</b></th></tr>" +
                     "<tr></tr>" +
                     "<tr><th colspan='4' align='left' style='width: 200px; float: left;'><strong> From Date : </strong>" +
                (DateTime.ParseExact(txtFromDate.Text+" 07:00:00", "dd/MM/yyyy HH:mm:ss",CultureInfo.InvariantCulture)).ToString() + "</th>" +
                "<th colspan='" + cold + "'></th>" + strTh+
                "<th colspan = '2' align = 'right' style = 'width: 200px; float: right;'><strong> To Date : </strong>" +
                            (DateTime.ParseExact(txtToDate.Text+" 06:59:59", "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture)).ToString() + "</th></tr>" +
                "</table>" +

                      "<br/>" + sw.ToString() + "<br/></div>";

                string style = @"<!--mce:2-->";
                Response.Write(style);
                Response.Output.Write(content);
                Response.Flush();
                Response.Clear();
                Response.End();

            }
            catch (Exception ex)
            {
                //log.Error("Button EXCEL", ex);
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Oops! There is some technical issue. Please Contact to your administrator.');", true);
            }

        }

        //protected void imgExcelButton_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string text = Session[ApplicationSession.OrganisationName].ToString();
        //        string text1 = Session[ApplicationSession.OrganisationAddress].ToString();
        //        string text2 = "Chemical Consumption REPORT";
        //        string filename = "Chemical Consumption REPORT_" + DateTime.Now.Date.ToString("dd-MM-yyyy") + ".xls";
        //        Response.AddHeader("content-disposition", "attachment;filename=" + filename);
        //        //Response.AddHeader("content-disposition", "attachment;filename=WeighbridgeSummaryReport.xls");
        //        Response.Charset = "";
        //        Response.ContentType = "application/vnd.ms-excel";
        //        StringWriter sw = new StringWriter();
        //        HtmlTextWriter hw = new HtmlTextWriter(sw);
        //        gvChemicalConsumption.AllowPaging = false;
        //        gvChemicalConsumption.RenderControl(hw);
        //        string strTitle = text;
        //        string Date = DateTime.UtcNow.AddHours(5.5).ToString();
        //        string strSubTitle = text2 + "</br>";
        //        //string strPath = Request.Url.GetLeftPart(UriPartial.Authority) + "/images/Logo1.gif";
        //        string strPath = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath());
        //        string strPath1 = Request.Url.GetLeftPart(UriPartial.Authority) + (new CommonClass().SetLogoPath1());

        //        string content = "<div align='left' style='font-family:verdana;font-size:16px'><img width='100' height='100' src='" + strPath + "'/></div><div align='center' style='font-family:verdana;font-size:16px;style='text-align:center'><img width='100' height='100' src='" + strPath1 + "'/></div><div align='center' style='font-family:verdana;font-size:16px'><span style='font-size:16px;font-weight:bold;color:Black;'>" + Session[ApplicationSession.OrganisationName] +
        //               "</span><br/><span style='font-size:13px;font-weight:bold;color:Black;'>" + Session[ApplicationSession.OrganisationAddress] + "</span><br/>" +
        //                  "<span align='center' style='font-family:verdana;font-size:13px'><strong>" + strSubTitle + "</strong></span><br/>" +
        //                  "<div align='center' style='font-family:verdana;font-size:12px'><strong>From Date :</strong>" +
        //              DateTime.ParseExact(txtFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture) +
        //               "&nbsp;&nbsp;&nbsp;&nbsp;<strong> To Date :</strong>" +
        //               DateTime.ParseExact(txtToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture) +
        //               "</div><br/> "
        //               + sw.ToString() + "<br/></div>";
        //        Response.Output.Write(content);
        //        Response.Flush();
        //        Response.End();
        //    }
        //    catch (Exception ex)
        //    {
        //        // log.Error("Button EXCEL", ex);
        //        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Oops! There is some technical issue. Please Contact to your administrator.');", true);
        //    }
        //}
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
                        ColumnText.ShowTextAligned(cb, Element.ALIGN_LEFT, new Phrase("Chemical Consumption Report", FONT), 1190, 1665, 0);
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
    }
}