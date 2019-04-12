<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DisplayApps.aspx.cs" Inherits="AppointmentMS.DisplayApps" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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
    <div>
        <h1 class="textAlign">Appointment Management System Using ASP.NET</h1>
    </div>
    <table style="width: 100%">
        <tr>
            <td style="color: #333300">病人姓名 :<asp:DropDownList ID="ddlPatient" runat="server"
                Width="180px" AutoPostBack="True"
                DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="PatientID">
            </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                    SelectCommand="SELECT [Name], [PatientID] FROM [Patient]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <div align="center">
                    <asp:GridView ID="viewAp" runat="server" AllowPaging="True"
                        AutoGenerateColumns="False" CellPadding="4" PageSize="5"
                        Width="467px" ForeColor="Black" GridLines="Vertical" AllowSorting="True"
                        DataKeyNames="AptmentID" DataSourceID="SqlDataSource1"
                        BackColor="White" BorderColor="#DEDFDE"
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
                            <asp:BoundField DataField="DateOfAptment" DataFormatString="{0:d}" HeaderText="預約日期"
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
                    SelectCommand="SELECT Aptment.AptmentID, Aptment.PatientID, Aptment.DateOfAptment, Aptment.Time, Patient.Name, Patient.DateOfBirth FROM Aptment INNER JOIN Patient ON Aptment.PatientID = Patient.PatientID WHERE Aptment.PatientID = @pid"
                    UpdateCommand="UPDATE [Aptment] SET [PatientID] = @PatientID, [DateOfAptment] = @DateOfAptment, [Time] = @Time WHERE [AptmentID] = @AptmentID">
                    <DeleteParameters>
                        <asp:Parameter Name="AptmentID" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlPatient" Name="pid"
                            PropertyName="SelectedValue" />
                    </SelectParameters>
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