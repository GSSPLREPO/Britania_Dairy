<%@ Page Title="" Language="C#" MasterPageFile="~/Master/MainMaster.Master" AutoEventWireup="true" CodeBehind="TankLabReport.aspx.cs" Inherits="Powder_MISProduct.WebUI.TankLabReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <div id="breadcrumb">
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="../WebUI/DashBoard.aspx">Home</a></li>
            <li class="active">Tank Lab Report </li>
        </ul>
    </div>

    <div id="divCurrenTabSelected" class="hidden" visible="false">Setting</div>
    <div class="col-md-12">
        <div id="divGrid" runat="server" class="box box-primary">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-8">
                        <h4>
                            <asp:Label ID="lblHeading" runat="server" Text="Tank Lab Analysis"></asp:Label></h4>
                    </div>
                    <div class="col-md-3" style="padding-left: 20px;">
                        <div class="input-group">
                            <span id='search-icon' class="input-group-addon"><span class='glyphicon glyphicon-search'></span></span>
                            <input id="id_search" type="text" class="form-control" placeholder="Type here" onkeydown=" return (event.keyCode !== 13); " />
                        </div>
                    </div>
                    <div class="col-md-1 right">
                        <asp:Button runat="server" ID="btnAddNew" Text="Add New" CssClass="btn btn-warning pull-right btn-addnew" OnClick="btnAddNew_Click" data-original-title="Select Project" data-placement="bottom" data-toggle="tooltip" ToolTip="Add New"></asp:Button>
                    </div>
                    <div class="col-md-1 right">
                    </div>
                </div>
            </div>
            <%--<div class="box-body no-padding">--%>
            <div class="panel-body" style="overflow-x: auto">
                <asp:GridView runat="server" ID="gvTankReport" CssClass="table table-hover table-striped" AutoGenerateColumns="False" GridLines="None" OnRowCommand="gvTankReport_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="DateTime" HeaderText="Date & Time" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="SampleTime" HeaderText="SampleTime" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="SampleID" HeaderText="SampleID" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="SilotagNo" HeaderText="SilotagNo" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="TankName" HeaderText="TankName" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="Temp" HeaderText="Temp" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="SNF" HeaderText="SNF" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="FAT" HeaderText="FAT" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="TS" HeaderText="TS" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="pH" HeaderText="pH" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="Acidity" HeaderText="Acidity" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="Protein" HeaderText="Protein" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="TankStatus" HeaderText="TankStatus" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="TDS" HeaderText="TDS" ItemStyle-Width="70%" />
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-Width="70%" />

                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="imgEdit" CommandName="Edit1" CommandArgument='<%# Eval("Id") %>' ItemStyle-Width="10%" ImageUrl="../images/Edit.png"></asp:ImageButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="imgDelete" CommandName="Delete1" CommandArgument='<%# Eval("Id") %>' ItemStyle-Width="10%" ImageUrl="../images/Delete.png" OnClientClick="javascript:return confirm('Do you really want to Delete this record?');"></asp:ImageButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>


    <%--<div class="box box-primary" runat="server" id="divPanel">--%>
    <div class="panel panel-default" runat="server" id="divPanel">
        <%--<div class="box-header">--%>
        <div class="panel-heading">
            <h3 class="box-title">Tank Lab Report</h3>
        </div>
        <%--<div class="box-body">--%>
        <div class="panel-body">
            <%--<div class="row" style="margin-bottom: 20px;">--%>
            <div class="row">
                <div class="form-group">
                    <label class="col-md-2">Date & Time In :</label>
                    <div class="col-md-2">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            <asp:TextBox runat="server" ID="txtDate" CssClass="form-control date" placeholder="Date" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="bootstrap-timepicker">
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="txttime" ClientIDMode="Static" CssClass="form-control timepicker" placeholder="Time" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                            </div>
                        </div>
                    </div>

                    <%--</div>--%>
                    <%--Farheen: Added Sample Date and Time field --%>
                    <%--<div class="form-group">--%>

                    <label class="col-md-2">Sample Time:</label>
                    <div class="col-md-2">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            <asp:TextBox runat="server" ID="txtSampleDate" CssClass="form-control date" placeholder="Date" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="bootstrap-timepicker">
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="txtSampleTime" ClientIDMode="Static" CssClass="form-control timepicker" placeholder="Time" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="form-group">
                            <label class="col-md-2">Sample ID:</label>
                            <div class="col-md-4">
                                <asp:TextBox runat="server" ID="txtSampleID" ClientIDMode="Static" CssClass="form-control" placeholder="SampleId" />
                            </div>

                            <label class="col-md-2">Silo Tag No :</label>
                            <div class="col-md-4">
                                <asp:DropDownList runat="server" ID="DropDownListTankName" CssClass="form-control" OnSelectedIndexChanged="DropDownListTankName_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                    <asp:ListItem Value="W11T01" Text="W11T01"></asp:ListItem>
                                    <asp:ListItem Value="W12T01" Text="W12T01"></asp:ListItem>
                                    <asp:ListItem Value="W21T01" Text="W21T01"></asp:ListItem>
                                    <asp:ListItem Value="W22T01" Text="W22T01"></asp:ListItem>
                                    <asp:ListItem Value="B31T01" Text="B31T01"></asp:ListItem>
                                    <asp:ListItem Value="B51T01" Text="B51T01"></asp:ListItem>
                                    <asp:ListItem Value="W41T01" Text="W41T01"></asp:ListItem>
                                    <asp:ListItem Value="W42T01" Text="W42T01"></asp:ListItem>
                                    <asp:ListItem Value="W43T01" Text="W43T01"></asp:ListItem>
                                    <asp:ListItem Value="W51T01" Text="W51T01"></asp:ListItem>
                                    <asp:ListItem Value="C11T01" Text="C11T01"></asp:ListItem>
                                    <asp:ListItem Value="C12T01" Text="C12T01"></asp:ListItem>
                                    <asp:ListItem Value="C13T01" Text="C13T01"></asp:ListItem>
                                    <asp:ListItem Value="C14T01" Text="C14T01"></asp:ListItem>
                                    <asp:ListItem Value="F11T01" Text="F11T01"></asp:ListItem>
                                    <asp:ListItem Value="F12T01" Text="F12T01"></asp:ListItem>
                                    <asp:ListItem Value="F13T01" Text="F13T01"></asp:ListItem>
                                    <asp:ListItem Value="Whey Frop TP" Text="Whey Frop TP"></asp:ListItem>
                                    <asp:ListItem Value="Yogurt Frop Tp" Text="Yogurt Frop Tp"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="DropDownListTankName" ValidationGroup="g1"
                                    SetFocusOnError="True" ErrorMessage="Select Silo Tag No" ForeColor="Red" InitialValue="0">*</asp:RequiredFieldValidator>
                            </div>

                        </div>
                    </div>
                    <br />

                    <div class="row">
                        <div class="form-group">
                            <label class="col-md-2">Tank Name:</label>
                            <div class="col-md-4">
                                <asp:TextBox runat="server" ID="txtTankName" CssClass="form-control" placeholder="Tank Name" ReadOnly="true" />
                            </div>


                            <label class="col-md-2">Temperature :</label>
                            <div class="col-md-4">
                                <asp:TextBox runat="server" ID="txtTemp" CssClass="form-control" placeholder="Temp" />
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />

            <div class="row">
                <div class="form-group">
                    <label class="col-md-2">SNF% :</label>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtSNF" CssClass="form-control" placeholder="SNF" onkeypress="return PreventDecimalPointValue(event)" MaxLength="8" />
                        <%--<asp:RangeValidator ID="RangeValidator1" runat="server" ValidationGroup="g1" ErrorMessage="Please enter valid value!" ControlToValidate="txtSNF" MaximumValue="100.00" MinimumValue="0.00"></asp:RangeValidator>--%>
                    </div>
                    <label class="col-md-2">FAT% :</label>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtFAT" CssClass="form-control" placeholder="FAT" onkeypress="return PreventDecimalPointValue(event)" MaxLength="8" />
                        <%--<asp:RangeValidator ID="RangeValidator2" runat="server" ValidationGroup="g1" ErrorMessage="Please enter valid value!" ControlToValidate="txtFAT" MaximumValue="100.00" MinimumValue="0.00"></asp:RangeValidator>--%>

                    </div>

                </div>
            </div>

            <br />

            <div class="row">
                <div class="form-group">
                    <label class="col-md-2">TS% :</label>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtTS" CssClass="form-control" placeholder="TS" onkeypress="return PreventDecimalPointValue(event)" MaxLength="8" />
                    </div>
                    <label class="col-md-2">pH :</label>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtpH" CssClass="form-control" placeholder="PH" onkeypress="return PreventDecimalPointValue(event)" MaxLength="8" />
                    </div>
                </div>
            </div>

            <br />

            <div class="row">
                <div class="form-group">
                    <label class="col-md-2">Acidity :</label>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtAcidity" CssClass="form-control" placeholder="Acidity" onkeypress="return PreventDecimalPointValue(event)" MaxLength="8" />
                    </div>
                    <label class="col-md-2">Protein :</label>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtProtein" CssClass="form-control" placeholder="Protein" onkeypress="return PreventDecimalPointValue(event)" MaxLength="8" />
                    </div>
                </div>
            </div>

            <br />

            <div class="row">
                <div class="form-group">
                    <label class="col-md-2">Tank Status :</label>
                    <div class="col-md-4">
                        <asp:DropDownList runat="server" ID="ddTank_Status" CssClass="form-control">
                            <asp:ListItem Text="Ok" Value="ok"></asp:ListItem>
                            <asp:ListItem Text="Not Ok" Value="Not Ok"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <label class="col-md-2">TDS :</label>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtTDS" CssClass="form-control" placeholder="TDS" />
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="form-group">
                    <label class="col-md-2">Remarks :</label>
                    <div class="col-md-4">
                        <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" placeholder="Remarks" />
                    </div>
                </div>
            </div>

            <div class="panel-footer">
                <div class="row">
                    <div class="col-md-offset-10 col-md-2">
                        <asp:Button runat="server" ID="btnSave" CssClass="btn btn-primary" Text="Save" ValidationGroup="g1" OnClick="btnSave_Click" />
                        <asp:Button runat="server" ID="btnViewList" Text="Viewlist" CssClass="btn btn-primary" OnClick="btnViewList_Click" CausesValidation="False" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:ValidationSummary runat="server" ID="vs1" ValidationGroup="g1" ShowMessageBox="True" ShowSummary="False" />
                    </div>
                </div>
                <br />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <script type="text/javascript">
        var date = new Date();
        var end = new Date(date.getFullYear(), date.getMonth(), date.getDate());
        var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());
        <%--$(function () {
            $('#id_search').quicksearch('table#<%=gvTankReport.ClientID%> tbody tr');
        });--%>
        $('.date').datepicker({
            format: "dd/mm/yyyy",
            clearBtn: true,
            autoclose: true,
            todayHighlight: true
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
