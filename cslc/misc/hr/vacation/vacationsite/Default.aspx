<%@ page language="C#" autoeventwireup="true" inherits="_Default, App_Web_default.aspx.cdcab7d2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vacation Servlet by Curca Claudiu</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <span style="font-size: 24pt" title="Vacation Login">
            <asp:Label ID="Banner" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="XX-Large"
                ForeColor="#0000C0"></asp:Label><br />
            <span style="font-size: 12pt">
                <br />
                Username:&nbsp;
                <asp:TextBox ID="userTB" runat="server" Width="140px"></asp:TextBox><br />
                Password: <strong><em>&nbsp;</em></strong><input id="passTB" style="width: 140px; font-weight: bold; font-style: italic;" type="password" runat="server" /><br />
                <asp:Label ID="errorLabel" runat="server" Text="Illegal username or password" Visible="False"></asp:Label><br />
                <br />
                <strong><em>&nbsp;</em></strong><asp:Button ID="LoginSubmit" runat="server" OnClick="LoginSubmit_Click" Text="Submit"
                    Width="60px" /><br />
                <asp:Label ID="DebugTB" runat="server" Font-Bold="False" Font-Italic="False" Font-Names="Arial"
                    Font-Size="Small" Height="150px" Visible="False" Width="600px"></asp:Label><br />
                <em>
                    <asp:Label ID="sqlcmd" runat="server" Text="Database=;Data Source=;User Id=;Password="
                        Visible="False"></asp:Label></em></span></span></div>
    </form>
</body>
</html>
