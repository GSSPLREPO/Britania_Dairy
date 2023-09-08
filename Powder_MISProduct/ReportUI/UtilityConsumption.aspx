<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MainMaster.Master" AutoEventWireup="true" CodeBehind="UtilityConsumption.aspx.cs" Inherits="Powder_MISProduct.ReportUI.UtilityConsumption" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div id="breadcrumb">
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="../WebUI/DashBoard.aspx">Home</a></li>
            <li class="active">Utility Consumption Report</li>
        </ul>
    </div>
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-10" style="font-size: 24px;">
                       Utility Consumption Report
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
                     <asp:GridView runat="server" ID="gvUtilityConsumption"
                        AutoGenerateColumns="False" GridLines="Both" HeaderStyle-Wrap="false"
                        HeaderStyle-Font-Size="Medium" CssClass="gvTheGrid striped" OnPreRender="gvUtilityConsumption_PreRender">
<%--                        <RowStyle HorizontalAlign="Center"  Width="100%"/>--%>
                           <Columns>
<%--                            <asp:BoundField DataField="EndId" HeaderText="EndId"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>--%>
                            <asp:BoundField DataField="SrNo" HeaderText="Sr No" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="Time" HeaderText="Time" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="MCC1WheyProcesses" HeaderText="MCC1WheyProcesses" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="MCC2Evaporator" HeaderText="MCC2Evaporator" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="MCC3Dryer" HeaderText="MCC3Dryer" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="MCC4SCM" HeaderText="MCC4SCM" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
                           <asp:BoundField DataField="TotalPowerConsumption" HeaderText="TotalPowerConsumption" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>                                             
                            <asp:BoundField DataField="SteamConsumptioninWheyPlant" HeaderText="SteamConsumptioninWheyPlant" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
                            <asp:BoundField DataField="SteamConsumptioninEvaporator" HeaderText="SteamConsumptioninEvaporator " ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
                            <asp:BoundField DataField="HPSteamConsumptioninDryer" HeaderText="HPSteamConsumptioninDryer" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
                            <asp:BoundField DataField="SteamConsumptionindryerothers" HeaderText="SteamConsumptionindryerothers" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
                            <asp:BoundField DataField="TotalSteamConsumption" HeaderText="TotalSteamConsumption" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>       
                            <asp:BoundField DataField="ChilledWaterinWheyProcessing" HeaderText="ChilledWaterinWheyProcessing" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>     
                            <asp:BoundField DataField="ChilledWaterinpowderplant" HeaderText="ChilledWaterinpowderplant" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="Chilledwaterinlettemp" HeaderText="Chilledwaterinlettemp" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="ChilledwaterOutlettemp" HeaderText="ChilledwaterOutlettemp" ItemStyle-Wrap="false" />
                             <asp:BoundField DataField="TotalChilledWaterConsumption" HeaderText="TotalChilledWaterConsumption" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="SoftWater" HeaderText="SoftWater" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
                            <asp:BoundField DataField="ROWater" HeaderText="ROWater" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
                            <asp:BoundField DataField="CompressedAir" HeaderText="CompressedAir " ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
                            <asp:BoundField DataField="RawWater" HeaderText="RawWater" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-Wrap="false" ><ItemStyle CssClass="right-align" /></asp:BoundField>
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
