<%@ page language="C#" autoeventwireup="true" inherits="Default3, App_Web_default3.aspx.cdcab7d2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vacation Servlet by Curca Claudiu</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div style="text-align: center">
            <asp:Label ID="Banner" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="XX-Large" ForeColor="#0000C0"></asp:Label><br />
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Username" Width="100px"></asp:Label>
            <asp:TextBox ID="userTB" runat="server"></asp:TextBox><br />
            <asp:Label ID="Label3" runat="server" Text="New Password" Width="100px"></asp:Label>
            <input id="Password2" runat="server" style="width: 150px" type="password" /><br />
            <asp:Label ID="Label4" runat="server" Text="Confirm Pass" Width="100px"></asp:Label>
            <input id="Password3" runat="server" style="width: 150px" type="password" /><br />
            <asp:Label ID="Label6" runat="server" Text="User Class" Width="100px"></asp:Label>
            <asp:DropDownList ID="classTB" runat="server" Width="156px">
                <asp:ListItem Selected="True" Value="1">User</asp:ListItem>
                <asp:ListItem Value="2">Admin</asp:ListItem>
            </asp:DropDownList><br />
            <asp:Label ID="Label7" runat="server" Text="E-Mail address" Width="100px"></asp:Label>
            <asp:TextBox ID="mailTB" runat="server"></asp:TextBox><br />
            <br />
            &nbsp; &nbsp;&nbsp;<asp:Button ID="bBack" runat="server" OnClick="bBack_Click" Text="Home" />
            &nbsp; &nbsp; &nbsp;
            <asp:Button ID="bSubmit" runat="server" OnClick="bSubmit_Click" Text="Submit" /><br />
            <asp:Label ID="errLabel" runat="server" Text="Label" Visible="False"></asp:Label></div>
    
    </div>
    </form>
</body>
</html>