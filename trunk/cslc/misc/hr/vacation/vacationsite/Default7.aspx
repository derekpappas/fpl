<%@ page language="C#" autoeventwireup="true" inherits="Default7, App_Web_default7.aspx.cdcab7d2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vaction Servler by Claudiu Curca</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <asp:Label ID="Banner" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="XX-Large"
            ForeColor="#0000C0"></asp:Label><br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Home" />
        <br />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Month:"></asp:Label>&nbsp;<asp:DropDownList
            ID="ddMonth" runat="server" AutoPostBack="True">
        </asp:DropDownList><br />
        <br />
        NOTE: The Worked hours DO NOT include paid vacation hours!<br />
        <br />
        <asp:GridView ID="tResults" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#E3EAEB" />
            <EditRowStyle BackColor="#7C6F57" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
