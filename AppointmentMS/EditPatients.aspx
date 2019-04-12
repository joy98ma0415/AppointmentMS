<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditPatients.aspx.cs" Inherits="AppointmentMS.EditPatients" %>

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
    <table style="width: 100px">
        <tr>
            <td>
                <div align="center">
                    <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" CellPadding="4" DataSourceID="SqlDataSource1" GridLines="Vertical" Height="50px" Width="393px" OnDataBound="DetailsView1_DataBound" ForeColor="Black" HeaderText="病人資料管理" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" AutoGenerateRows="False" DataKeyNames="PatientID">
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <Fields>
                            <asp:BoundField DataField="PatientID" HeaderText="病人編號" ReadOnly="True" SortExpression="PatientID" />
                            <asp:BoundField DataField="Name" HeaderText="姓名" SortExpression="Name" />
                            <asp:BoundField DataField="DateOfBirth" HeaderText="生日" SortExpression="DateOfBirth" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="Address" HeaderText="地址" SortExpression="Address" />
                            <asp:BoundField DataField="PostCode" HeaderText="郵遞區號" SortExpression="PostCode" />
                            <asp:BoundField DataField="Phone" HeaderText="電話" SortExpression="Phone" />
                            <asp:CommandField ShowDeleteButton="true" ShowEditButton="true" ShowInsertButton="true" />
                        </Fields>
                        <HeaderStyle BackColor="#6B696B" Font-Bold="true" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                        <EditRowStyle BackColor="#CE5D5A" Font-Bold="true" ForeColor="White" />
                        <RowStyle BackColor="#F7F7DE" />
                    </asp:DetailsView>
                </div>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        DeleteCommand="DELETE FROM [Patient] WHERE [PatientID] = @PatientID"
        InsertCommand="INSERT INTO [Patient] ([PatientID], [Name], [DateOfBirth], [Address], [PostCode], [Phone]) VALUES (@PatientID, @Name, @DateOfBirth, @Address, @PostCode, @Phone)"
        SelectCommand="SELECT * FROM [Patient]"
        UpdateCommand="UPDATE [Patient] SET [Name] = @Name, [DateOfBirth] = @DateOfBirth, [Address] = @Address, [PostCode] = @PostCode, [Phone] = @Phone WHERE [PatientID] = @PatientID">
        <DeleteParameters>
            <asp:Parameter Name="PatientID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PatientID" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="DateOfBirth" Type="DateTime" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="PostCode" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="DateOfBirth" Type="DateTime" />
            <asp:Parameter Name="Address" Type="String" />
            <asp:Parameter Name="PostCode" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="PatientID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>