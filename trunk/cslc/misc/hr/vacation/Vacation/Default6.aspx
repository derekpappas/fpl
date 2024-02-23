<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default6.aspx.cs" Inherits="Default6" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vacation Servlet by Curca Claudiu</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Banner" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="XX-Large"
            ForeColor="#0000C0"></asp:Label><br />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Balance this month:" Width="135px"></asp:Label>
        <asp:TextBox ID="tbBalance" runat="server" ReadOnly="True" Width="155px"></asp:TextBox><br />
        <asp:Label ID="Label2" runat="server" Text="Paid hours available:" Width="135px"></asp:Label>
        <asp:TextBox ID="tbAvailable" runat="server" ReadOnly="True" Width="155px"></asp:TextBox><br />
        <asp:Label ID="Label3" runat="server" Text="Paid hours taken:" Width="135px"></asp:Label>
        <asp:TextBox ID="tbUsed" runat="server" Width="155px"></asp:TextBox><br />
        <br />
        <em>Please enter the number of paid hours.&nbsp;<br />
            </em>
        <br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Home" Width="60px" />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<asp:Button ID="Button2"
            runat="server" OnClick="Button2_Click" Text="Submit" Width="60px" />
        <br />
        <br />
        <asp:Label ID="errLabel" runat="server" Text="Label" Visible="False"></asp:Label></div>
    </form>
</body>
</html>
