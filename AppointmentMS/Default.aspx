﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AppointmentMS._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function getWidth() {
            var intViewportWidth = window.innerWidth;
            var w = window.innerWidth;
            var h = window.innerHeight;
            var ow = window.outerWidth; //including toolbars and status bar etc.
            var oh = window.outerHeight;
            if (window.matchMedia("(min-width: 400px)").matches) {
                /* the viewport is at least 400 pixels wide */
            }
            else {
                /* the viewport is less than 400 pixels wide */
            }
            if (self.innerWidth) {
                return self.innerWidth;
            }
            if (document.documentElement && document.documentElement.clientWidth) {
                return document.documentElement.clientWidth;
            }
            if (document.body) {
                return document.body.clientWidth;
            }
        }
    </script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script type="text/javascript">
        $(function () {
            // See if this is a touch device
            if ('ontouchstart' in window) {
                // Set the correct body class
                $('body').removeClass('no-touch').addClass('touch');

                // Add the touch toggle to show text
                $('div.boxInner img').click(function () {
                    $(this).closest('.boxInner').toggleClass('touchFocus');
                });
            }
        });
    </script>

    <asp:Table ID="Table1" runat="server" Height="85" BackColor="Plum"></asp:Table>
    <asp:Menu ID="Menu1" runat="server" BackColor="#CCFF66" DynamicHorizontalOffset="2" Font-Names="Verdana" Font-Size="Medium" ForeColor="#7C6F57" Orientation="Horizontal" StaticSubMenuIndent="10px">
        <DynamicHoverStyle BackColor="#7C6F57" ForeColor="White" />
        <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
        <DynamicMenuStyle BackColor="#F7F6F3" />
        <DynamicSelectedStyle BackColor="#5D7B9D" />
        <Items>
            <asp:MenuItem NavigateUrl="~/Default.aspx" Text="診所預約處理" Value="診所預約處理"></asp:MenuItem>
            <asp:MenuItem NavigateUrl="~/EditPatients.aspx" Text="病人資料管理" Value="病人資料管理"></asp:MenuItem>
            <asp:MenuItem NavigateUrl="~/DisplayApps.aspx" Text="診所預約查詢" Value="診所預約查詢"></asp:MenuItem>
        </Items>
    </asp:Menu>
    <h1 class="textAlign">Appointment Management System Using ASP.NET</h1>
    <p class="textAlign">&nbsp;</p>
    <table style="border-top: silver thin solid; border-bottom-width: thin; border-bottom-color: silver; width: 855px">
        <tr>
            <td style="width: 539px; height: 255px">
                <table style="width: 344px; height: 186px">
                    <tr>
                        <td style="width: 122px">病人姓名 :</td>
                        <td style="width: 122px">
                            <asp:DropDownList ID="DropDownListPatient" runat="server"
                                Width="180px" AutoPostBack="True"
                                OnSelectedIndexChanged="DropDownListPatient_SelectedIndexChanged">
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td style="width: 122px">病人編號 :</td>
                        <td style="width: 122px">
                            <asp:TextBox ID="TextBoxID" runat="server" Width="174px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="width: 122px">姓名 :</td>
                        <td style="width: 122px">
                            <asp:TextBox ID="TextBoxName" runat="server" Width="174px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="width: 122px">生日 :</td>
                        <td style="width: 122px">
                            <asp:TextBox ID="TextBoxDOB" runat="server" Width="173px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="width: 122px">地址 :</td>
                        <td style="width: 122px">
                            <asp:TextBox ID="TextBoxAddress" runat="server" Width="173px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="width: 122px; height: 1px">郵遞區號 :</td>
                        <td style="width: 122px; height: 1px">
                            <asp:TextBox ID="TextBoxPostCode" runat="server" Width="173px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="width: 122px; height: 1px">電話 :</td>
                        <td style="width: 122px; height: 1px">
                            <asp:TextBox ID="TextBoxPhone" runat="server" Width="173px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="width: 122px; height: 1px">預約時間 :</td>
                        <td style="width: 122px; height: 1px">
                            <asp:DropDownList ID="DropDownListApointment" runat="server" Width="180px">
                            </asp:DropDownList></td>
                    </tr>
                </table>
                <br />
                <br />
                <asp:Button ID="Button1" runat="server" Text="預約看診" OnClick="Button1_Click" />
            <td style="width: 663px; height: 255px">
                <asp:Calendar ID="CalendarDentist" runat="server" BackColor="White"
                    BorderColor="#999999" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black"
                    Height="224px" OnDayRender="CalendarDentist_DayRender" OnSelectionChanged="CalendarDentist_SelectionChanged"
                    Width="401px" DayNameFormat="Shortest" CellPadding="4">
                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" />
                    <WeekendDayStyle BackColor="#FFFFCC" />
                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <OtherMonthDayStyle ForeColor="#808080" />
                    <NextPrevStyle VerticalAlign="Bottom" />
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                    <TitleStyle BackColor="#999999" Font-Bold="True" BorderColor="Black" />
                </asp:Calendar>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="border-top: silver thin solid; height: 4px">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" style="border-top: silver thin solid; height: 4px"
                bgcolor="#669900">
                <asp:Label ID="LabelMessage" runat="server" Font-Bold="True" ForeColor="White"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="2" style="border-top: silver thin solid; height: 4px">
                <div align="center">
                    <asp:GridView ID="GridViewAppointment" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" CellPadding="4" PageSize="5"
                        Width="784px" ForeColor="Black" GridLines="Vertical" AllowSorting="True"
                        DataKeyNames="AptmentID" DataSourceID="SqlDataSource1"
                        OnRowDeleted="GridViewAppointment_RowDeleted" BackColor="White" BorderColor="#DEDFDE"
                        BorderStyle="None" BorderWidth="1px">
                        <FooterStyle BackColor="#CCCC99" />
                        <RowStyle BackColor="#F7F7DE" />
                        <Columns>
                            <asp:BoundField DataField="AptmentID" HeaderText="預約編號"
                                InsertVisible="False" ReadOnly="True" SortExpression="AptmentID" />
                            <asp:BoundField DataField="PatientID" HeaderText="病人編號"
                                SortExpression="PatientID" />
                            <asp:BoundField DataField="Name" HeaderText="病人姓名"
                                SortExpression="Name" />
                            <asp:BoundField DataField="DateOfAptment" HeaderText="預約日期" DataFormatString="{0:d}"
                                SortExpression="DateOfAptment" />
                            <asp:BoundField DataField="Time"
                                HeaderText="預約時間" SortExpression="Time" />
                        </Columns>
                        <SelectedRowStyle BackColor="#CE5D5A" ForeColor="White" Font-Bold="True" />
                        <PagerStyle ForeColor="Black" HorizontalAlign="Right"
                            BackColor="#F7F7DE" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                </div>
                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                    DeleteCommand="DELETE FROM [Aptment] WHERE [AptmentID] = @AptmentID"
                    InsertCommand="INSERT INTO [Aptment] ([PatientID], [DateOfAptment], [Time]) VALUES (@PatientID, @DateOfAptment, @Time)"
                    SelectCommand="SELECT Aptment.AptmentID, Aptment.PatientID, Aptment.DateOfAptment, Aptment.Time, Patient.Name, Patient.DateOfBirth FROM Aptment INNER JOIN Patient ON Aptment.PatientID = Patient.PatientID"
                    UpdateCommand="UPDATE [Aptment] SET [PatientID] = @PatientID, [DateOfAptment] = @DateOfAptment, [Time] = @Time WHERE [AptmentID] = @AptmentID">
                    <DeleteParameters>
                        <asp:Parameter Name="AptmentID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="PatientID" Type="Int32" />
                        <asp:Parameter Name="DateOfAptment" Type="DateTime" />
                        <asp:Parameter Name="Time" Type="String" />
                        <asp:Parameter Name="AptmentID" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="PatientID" Type="Int32" />
                        <asp:Parameter Name="DateOfAptment" Type="DateTime" />
                        <asp:Parameter Name="Time" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>