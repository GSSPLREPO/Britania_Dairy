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
                        HeaderStyle-Font-Size="Medium" CssClass="table table-striped" OnPreRender="gvLab_PreRender">
<%--                        <RowStyle HorizontalAlign="Center"  Width="100%"/>--%>
                                  <Columns>
                            <asp:BoundField DataField="SrNo" HeaderText="Sr No." ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-Wrap="false" />
                             <asp:BoundField DataField="TypeofPowder" HeaderText="Type of Powder" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Time" HeaderText="Time" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="SampleId" HeaderText="Sample Id" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="BatchNo" HeaderText="Batch No" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="BagNo" HeaderText="Bag No" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Weight" HeaderText="Weight" ItemStyle-Width="10%" />
                         <asp:BoundField DataField="TempOC" HeaderText="Temp OC" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Fat" HeaderText="Fat" ItemStyle-Width="10%" />
                         <asp:BoundField DataField="SNF" HeaderText="SNF" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Acidity" HeaderText="Acidity" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Moisture" HeaderText="Moisture" ItemStyle-Width="10%" />
                         <asp:BoundField DataField="Sugar" HeaderText="Sugar" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="SolIndex" HeaderText="Sol Index" ItemStyle-Width="10%" />
                         <asp:BoundField DataField="Coffetest" HeaderText="Coffee test" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Particleontop" HeaderText="Particle on top" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="ParticleonBottom" HeaderText="Particle on Bottom" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Sendiments" HeaderText="Sendiments" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="BulkDensity" HeaderText="Bulk Density" ItemStyle-Width="10%" />
                         <asp:BoundField DataField="Scorchedparticle" HeaderText="Scorched particle" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Wettability" HeaderText="Wettability" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Dispersibility" HeaderText="Dispersibility" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="FreeFat" HeaderText="Free Fat" ItemStyle-Width="10%" />
                         <asp:BoundField DataField="TotalPlatecount" HeaderText="Total Plate count" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Coliform" HeaderText="Coliform" ItemStyle-Width="10%" />
                         <asp:BoundField DataField="YestMould" HeaderText="Yeast & Mould" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Ecoli" HeaderText="E.coli" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Salmonella" HeaderText="Salmonella" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Saureus" HeaderText="Saureus" ItemStyle-Width="10%" />
                        <asp:BoundField DataField="Anerobicsporecount" HeaderText="Anerobic spore count" ItemStyle-Width="10%" />
                         <asp:BoundField DataField="Listeriamonocytogen" HeaderText="Listeria monocytogen" ItemStyle-Width="10%" />
                              <asp:BoundField DataField="Username" HeaderText="Username" ItemStyle-Width="10%" />
                         <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-Width="10%" />
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
