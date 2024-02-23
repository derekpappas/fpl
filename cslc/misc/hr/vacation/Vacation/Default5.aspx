<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default5.aspx.cs" Inherits="Default5" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vacation Servlet by Curca Claudiu</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <asp:Label ID="Banner" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="XX-Large"
            ForeColor="#0000C0"></asp:Label><br />
        <br />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Username" Width="100px"></asp:Label><asp:DropDownList
            ID="ddUser" runat="server" Enabled="False" 
            Width="155px">
        </asp:DropDownList><br />
        <asp:Label ID="Label2" runat="server" Text="Month" Width="100px"></asp:Label><asp:DropDownList
            ID="ddMonth" runat="server" 
            Width="155px">
        </asp:DropDownList><br />
        <br />
        <asp:Button ID="bBack" runat="server" OnClick="bBack_Click" Text="Home" />
        <asp:Button ID="bSubmit" runat="server" Text="Submit" OnClick="bSubmit_Click" />&nbsp;<br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Balance: "></asp:Label>
        <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label><br />
        <asp:Label ID="Label6" runat="server" Text="Worked" Visible="False"></asp:Label>
        <asp:Label ID="worked" runat="server" Text=" " Visible="False"></asp:Label>
        <asp:Label ID="Label7" runat="server" Text="this month" Visible="False"></asp:Label><br />
        <asp:Label ID="Label5" runat="server" Text="Working" Visible="False"></asp:Label>
        <asp:Label ID="hpd" runat="server" Text="N/A" Visible="False"></asp:Label><br />
        <br />
        NOTE: The Worked hours DO NOT include paid vacation hours!<br />
        <br />
        <asp:GridView ID="tResults" runat="server" BackColor="White" BorderColor="#E7E7FF"
            BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <AlternatingRowStyle BackColor="#F7F7F7" />
        </asp:GridView>
    </div>
    </form>
</body>
</html>
