<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MainMaster.Master" AutoEventWireup="true" CodeBehind="LabReport.aspx.cs" Inherits="Powder_MISProduct.ReportUI.LabReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="breadcrumb">
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="../WebUI/DashBoard.aspx">Home</a></li>
            <li class="active">Lab Report</li>
        </ul>
    </div>
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-10" style="font-size: 24px;">
                        Lab Report
                    </div>
                    <div class="col-md-2 right" id="divExport" runat="server">
                        <asp:LinkButton ID="imgPDFButton" runat="server" OnClick="imgPDFButton_Click" CssClass="btn btn-danger quick-btn"><i class="fa fa-file-pdf-o"></i></asp:LinkButton>
                        <asp:LinkButton ID="imgExcelButton" runat="server" OnClick="imgExcelButton_Click" CssClass="btn btn-success quick-btn"><i class="fa fa-file-excel-o"></i></asp:LinkButton>
<%--                        <asp:LinkButton ID="imgWordButton" runat="server" OnClick="imgbtnWord_OnClick" CssClass="btn btn-info quick-btn"><i class="fa fa-file-word-o"></i></asp:LinkButton>--%>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-3">
                            From Date :
                        </div>
                        <div class="col-md-2">
                            From Time :
                        </div>
                        <div class="col-md-3">
                            To Date :
                        </div>
                        <div class="col-md-2">
                            To Time :
                        </div>
                        
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-3 has-error">
                            <div class='input-group date' id='datetimepicker1'>
                                <asp:TextBox ID="txtFromDate" CssClass="form-control" Placeholder="From Date" runat="server"></asp:TextBox>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="bootstrap-timepicker">
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtFromTime" ClientIDMode="Static" CssClass="form-control timepicker" Placeholder="From Time" runat="server"></asp:TextBox>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 has-error">
                            <div class='input-group date' id='datetimepicker2'>
                                <asp:TextBox ID="txtToDate" CssClass="form-control" Placeholder="To Date" runat="server"></asp:TextBox>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="bootstrap-timepicker">
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtToTime" ClientIDMode="Static" CssClass="form-control timepicker1" Placeholder="To Time" runat="server"></asp:TextBox>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                           <asp:Button runat="server" ID="btnGo" Text="Go" CssClass="btn btn-primary pull-right" ValidationGroup="g1" OnClick="btnGo_Click" />

                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12" style="overflow: scroll">
                         <asp:GridView runat="server" ID="gvLab"
                        AutoGenerateColumns="False" GridLines="Both" HeaderStyle-Wrap="false"
                        HeaderStyle-Font-Size="Medium" CssClass="gvTheGrid striped" OnPreRender="gvLab_PreRender">
<%--                        <RowStyle HorizontalAlign="Center"  Width="100%"/>--%>
                                  <Columns>
                            <asp:BoundField DataField="SrNo" HeaderText="Sr No." ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-Wrap="false" />
                             <asp:BoundField HeaderText="TypeofPowder" DataField="TypeofPowder" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Time" DataField="Time" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="SampleId" DataField="SampleId" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="BatchNo" DataField="BatchNo" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="BagNo" DataField="BagNo" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Weight" DataField="Weight" ItemStyle-Width="10%" />
                         <asp:BoundField HeaderText="TempOC" DataField="TempOC" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Fat" DataField="Fat" ItemStyle-Width="10%" />
                         <asp:BoundField HeaderText="SNF" DataField="SNF" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Acidity" DataField="Acidity" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Moisture" DataField="Moisture" ItemStyle-Width="10%" />
                         <asp:BoundField HeaderText="Sugar" DataField="Sugar" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="SolIndex" DataField="SolIndex" ItemStyle-Width="10%" />
                         <asp:BoundField HeaderText="Coffetest" DataField="Coffetest" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Particleontop" DataField="Particleontop" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="ParticleonBottom" DataField="ParticleonBottom" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Sendiments" DataField="Sendiments" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="BulkDensity" DataField="BulkDensity" ItemStyle-Width="10%" />
                         <asp:BoundField HeaderText="Scorchedparticle" DataField="Scorchedparticle" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Wettability" DataField="Wettability" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Dispersibility" DataField="Dispersibility" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="FreeFat" DataField="FreeFat" ItemStyle-Width="10%" />
                         <asp:BoundField HeaderText="TotalPlatecount" DataField="TotalPlatecount" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Coliform" DataField="Coliform" ItemStyle-Width="10%" />
                         <asp:BoundField HeaderText="YestMould" DataField="YestMould" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Ecoli" DataField="Ecoli" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Salmonella" DataField="Salmonella" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Saureus" DataField="Saureus" ItemStyle-Width="10%" />
                        <asp:BoundField HeaderText="Anerobicsporecount" DataField="Anerobicsporecount" ItemStyle-Width="10%" />
                         <asp:BoundField HeaderText="Listeriamonocytogen" DataField="Listeriamonocytogen" ItemStyle-Width="10%" />
                              <asp:BoundField HeaderText="Username" DataField="Username" ItemStyle-Width="10%" />
                         <asp:BoundField HeaderText="Remarks" DataField="Remarks" ItemStyle-Width="10%" />
                        </Columns>
                         </asp:GridView>

                    </div>
                </div>
                <div class="col-md-12 center" id="divNo" runat="server">No records found.</div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
       <script type="text/javascript">
        var date = new Date();
        var end = new Date(date.getFullYear(), date.getMonth(), date.getDate());
        var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());
        $('#datetimepicker1 input').datepicker({
            clearBtn: true,
            format: 'dd/mm/yyyy',
            autoclose: true,
            orientation: "top auto",
            endDate: end
        });
        $('#datetimepicker2 input').datepicker({
            clearBtn: true,
            format: 'dd/mm/yyyy',
            autoclose: true,
            orientation: "top auto",
            endDate: end
        });
        $(".timepicker").timepicker({
            showInputs: false,
            use24hours: true,
            format: 'HH:mm',
            showMeridian: false,
            showSeconds: true,
            minuteStep: 1,
            secondStep: 10
        });
        $(".timepicker1").timepicker({
            showInputs: false,
            use24hours: true,
            format: 'HH:mm',
            showMeridian: false,
            showSeconds: true,
            minuteStep: 1,
            secondStep: 10

        });
        $('datetimepicker1').datepicker('setDate', today);
        $('datetimepicker2').datepicker('setDate', today);
    </script>
</asp:Content>
