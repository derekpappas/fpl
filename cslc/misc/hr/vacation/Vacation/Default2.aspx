<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vacation Servlet by Curca Claudiu</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: left">
        <asp:Label ID="Banner" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="XX-Large" ForeColor="#0000C0"></asp:Label><br />
        <br />
        <asp:Button ID="bAdd" runat="server" OnClick="bAdd_Click" Text="Add vacation entry"
            Width="150px" /><asp:Button ID="bStatus" runat="server" Text="View monthly status"
            Width="150px" OnClick="bStatus_Click" /><asp:Button ID="bPass" runat="server" Text="User preferences"
            Width="150px" OnClick="bPass_Click" /><br />
        <asp:Label ID="Label4" runat="server" Width="150px"></asp:Label>
        <asp:Button ID="bReport" runat="server" OnClick="bReport_Click" Text="Monthly report"
                Visible="False" Width="150px" /><br />
        <asp:Button ID="bUsers" runat="server" Enabled="False" Text="User Management"
            Width="150px" OnClick="bUsers_Click" /><asp:Button ID="bSettings" runat="server" Enabled="False" Text="Paid vacation"
            Width="150px" OnClick="bSettings_Click" /><asp:Button ID="bLogout" runat="server" OnClick="bLogout_Click"
            Text="Log out of vacation" Width="150px" />&nbsp;</div>
        <div>
            <hr />
        </div>
        <div>
            &nbsp; &nbsp;<br />
            &nbsp;
            <asp:Label ID="Label1" runat="server" Text="Day of month" Visible="False"></asp:Label>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <asp:Label ID="Label2" runat="server" Text="Missed Hours" Visible="False"></asp:Label>
            &nbsp; &nbsp; &nbsp; &nbsp;<asp:Label ID="Label3" runat="server" Text="Overtime/Recovered hours"
                Visible="False"></asp:Label>&nbsp;<br />
            &nbsp;
            <br />
            <asp:TextBox ID="dateTB" runat="server" Visible="False" Width="100px"></asp:TextBox>
            &nbsp;&nbsp; &nbsp;<asp:TextBox ID="mhoursTB" runat="server" Visible="False" Width="100px" MaxLength="6">0</asp:TextBox>
            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:TextBox ID="rhoursTB" runat="server"
                Visible="False" Width="100px" MaxLength="6">0</asp:TextBox><br />
            <br />
            <br />
            <asp:Button ID="bSubmit" runat="server" OnClick="bSubmit_Click" Text="Submit" Visible="False" /><br />
            <br />
            <asp:Label ID="errLabel" runat="server" Font-Italic="True" Font-Size="Large" ForeColor="Red"
                Text="Label" Visible="False"></asp:Label></div>
    </form>
</body>
</html>
