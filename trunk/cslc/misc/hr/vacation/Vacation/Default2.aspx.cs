using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Sockets;
using MySql.Data.MySqlClient;
using System.IO;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.Cookies["Username"].Value == "")
                Response.Redirect("Default.aspx");
        }
        catch (Exception ex)
        {
            Response.Redirect("Default.aspx");
        }
        if (Banner.Text == "")
        {
            Banner.Text = Strings.LoadBanner();
        }
        if (Request.Cookies["Class"].Value == "1")
        {
            bUsers.Enabled = false;
            bReport.Visible = false;
        }
        if (Request.Cookies["Class"].Value == "2")
        {
            bUsers.Enabled = true;
            bReport.Visible = true;
        }

        MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
        MySqlCommand comm = new MySqlCommand("", conn);
        conn.Open();
        comm.CommandText = "SELECT status.paidleft FROM users,status WHERE " +
            "users.id like status.id and users.username LIKE '" +
            Request.Cookies["Username"].Value + "' AND status.month LIKE '" +
            System.DateTime.Now.Month.ToString() + "';";
        try
        {
            if (comm.ExecuteScalar().ToString() == "0")
                bSettings.Enabled = false;
            else
                bSettings.Enabled = true;
        }
        catch (Exception ex)
        {
            bSettings.Enabled = false;
        }
        conn.Close();
    }
    protected void bLogout_Click(object sender, EventArgs e)
    {
        Response.Cookies["Username"].Value="";
        Response.Cookies["Class"].Value="";
        Response.Redirect("Default.aspx");
    }
    protected void bAdd_Click(object sender, EventArgs e)
    {
        if (!Sql.CheckMonthData(Request.Cookies["Username"].Value))
        {
            errLabel.Text = "Please setup your daily work hours for this month. Click on user preferences.";
            errLabel.Visible = true;
            return;
        }
        errLabel.Visible = false;
        Label1.Visible = Label2.Visible = Label3.Visible = dateTB.Visible =
            mhoursTB.Visible = rhoursTB.Visible = bSubmit.Visible = true;
        dateTB.Text = System.DateTime.Now.Day.ToString();
    }
    protected void bSubmit_Click(object sender, EventArgs e)
    {
        Int32 date;
        String mhours,rhours;
        String user;
        errLabel.Visible = false;
        try
        {
            user = Request.Cookies["Username"].Value;
            date = Convert.ToInt32(dateTB.Text, 10);
            mhours = mhoursTB.Text;
            rhours = rhoursTB.Text;
        }
        catch (Exception ex)
        {
            errLabel.Text = "Invalid data was entered. Please check again.";
            errLabel.Visible = true;
            return;
        }
        if(date < 1) {
            errLabel.Text = "Invalid date. Please check again.";
            errLabel.Visible = true;
            return;
        }
        Int32 cm = System.DateTime.Now.Month;
        if (cm == 1 || cm == 3 || cm == 5 || cm == 7 || cm == 8 || cm == 10 || cm == 12)
            if (date > 31)
            {
                errLabel.Text = "Invalid date. Please check again.";
                errLabel.Visible = true;
                return;
            }
            else {;}
        else if(cm == 2)
            if(System.DateTime.Now.Year %4 ==0)
                if (date > 29)
                {
                    errLabel.Text = "Invalid date. Please check again.";
                    errLabel.Visible = true;
                    return;
                }
                else { ;}
            else
                if (date > 28)
                {
                    errLabel.Text = "Invalid date. Please check again.";
                    errLabel.Visible = true;
                    return;
                }
                else { ;}
        else
            if (date > 30)
            {
                errLabel.Text = "Invalid date. Please check again.";
                errLabel.Visible = true;
                return;
            }
        try
        {
            Int32 rhr, mhr;
            rhr = Convert.ToInt32(rhours, 10);
            mhr = Convert.ToInt32(mhours, 10);
            if (rhr == 0 && mhr == 0)
            {
                errLabel.Text = "Empty form. Please check again.";
                errLabel.Visible = true;
                return;
            }
            if (rhr < 0 || mhr < 0)
            {
                errLabel.Text = "Number of hours must be positive. Please check again.";
                errLabel.Visible = true;
                return;
            }
        }
        catch (Exception ex)
        {

            try
            {
                Int32 a;
                if (rhours.IndexOf('-') >= 0 || mhours.IndexOf('-') >= 0)
                    throw new Exception();
                if (rhours.IndexOf('.') >= 0)
                {
                    a = Convert.ToInt32(rhours.Substring(0, rhours.IndexOf('.')), 10);
                    a = Convert.ToInt32(rhours.Substring(rhours.IndexOf('.') + 1), 10);
                }
                else
                    a = Convert.ToInt32(rhours, 10);
                if (mhours.IndexOf('.') >= 0)
                {
                    a = Convert.ToInt32(mhours.Substring(0, mhours.IndexOf('.')), 10);
                    a = Convert.ToInt32(mhours.Substring(mhours.IndexOf('.') + 1), 10);
                }
                else
                    a = Convert.ToInt32(mhours, 10);
            }
            catch (Exception ex2)
            {
                errLabel.Text = "Malformed hour input. Please check again.";
                errLabel.Visible = true;
                return;
            }
        }
        float mh, rh;
        if (mhours.IndexOf('.') >= 0)
            mh = (float)Convert.ToInt32(mhours.Substring(0, mhours.IndexOf('.')), 10) +
                (float)Convert.ToInt32(mhours.Substring(mhours.IndexOf('.') + 1), 10) / (float)(pow(mhours.Length - mhours.IndexOf('.') - 1));
        else
            mh = (float)Convert.ToInt32(mhours, 10);
        if (rhours.IndexOf('.') >= 0)
            rh = (float)Convert.ToInt32(rhours.Substring(0, rhours.IndexOf('.')), 10) +
                (float)Convert.ToInt32(rhours.Substring(rhours.IndexOf('.') + 1), 10) / (float)(pow(rhours.Length - rhours.IndexOf('.') - 1));
        else
            rh = (float)Convert.ToInt32(rhours, 10);
        if (!Sql.CheckTimer(user))
        {
            errLabel.Text = "You cannot post another entry yet. Please wait 30 seconds.";
            errLabel.Visible = true;
            return;
        }
        if (Sql.AddEntry(user, date, mh, rh) == false)
        {
            errLabel.Text = "MySQL connection error. Please contact the site admin.";
            errLabel.Visible = true;
            return;
        }
        MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
        MySqlCommand comm = new MySqlCommand("", conn);
        conn.Open();
        comm.CommandText="SELECT email FROM company";
        String to = comm.ExecuteScalar().ToString();
        comm.CommandText="SELECT email FROM users WHERE username LIKE '" +
            Request.Cookies["Username"].Value.ToString() + "';";
        String from = comm.ExecuteScalar().ToString();
        TcpClient SmtpServ = null;
        try
        {
            SmtpServ = new TcpClient("mail." +
            to.Substring(to.IndexOf("@") + 1), 25);
        }
        catch (Exception ex)
        {
            errLabel.Text = "Mail server is down. Try again later.";
            errLabel.Visible = true;
            conn.Close();
            return;
        }
        conn.Close();
        string Data;
        byte[] szData;
        string CRLF = "\r\n";
        String vData;
        float bal = rh-mh;
        vData = "On " + date.ToString() + "/" + System.DateTime.Now.Month +
            "/" + System.DateTime.Now.Year + "\tBalance: " + bal.ToString() + " hours";
        try
        {
            NetworkStream NetStrm = SmtpServ.GetStream();
            StreamReader RdStrm = new StreamReader(SmtpServ.GetStream());

            Data = "HELLO server " + CRLF;
            szData = System.Text.Encoding.ASCII.GetBytes(Data.ToCharArray());
            NetStrm.Write(szData, 0, szData.Length);
            Data = "MAIL FROM: <" + from + ">" + CRLF;
            szData = System.Text.Encoding.ASCII.GetBytes(Data.ToCharArray());
            NetStrm.Write(szData, 0, szData.Length);

            Data = "RCPT TO: " + "<" + to + ">" + CRLF;
            szData = System.Text.Encoding.ASCII.GetBytes(Data.ToCharArray());
            NetStrm.Write(szData, 0, szData.Length);

            Data = "DATA " + CRLF;
            szData = System.Text.Encoding.ASCII.GetBytes(Data.ToCharArray());
            NetStrm.Write(szData, 0, szData.Length);

            Data = "SUBJECT: Vacation new entry" + CRLF +
                vData + CRLF + "." + CRLF;
            szData = System.Text.Encoding.ASCII.GetBytes(Data.ToCharArray());
            NetStrm.Write(szData, 0, szData.Length);

            Data = "QUIT " + CRLF;
            szData = System.Text.Encoding.ASCII.GetBytes(Data.ToCharArray());
            NetStrm.Write(szData, 0, szData.Length);

            NetStrm.Close();
            RdStrm.Close();
        }
        catch (InvalidOperationException err)
        {

        }
        errLabel.Text = "Entry added successfully.";
        errLabel.Visible = true;
        return;
    }
    protected void bPass_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default4.aspx");
    }
    protected void bUsers_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default3.aspx");
    }
    Int32 pow(Int32 p)
    {
        Int32 r = 1;
        for (int i = 0; i < p; i++)
            r = r * 10;
        return r;
    }
    protected void bStatus_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default5.aspx");
    }

    protected void bSettings_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default6.aspx");
    }
    protected void bReport_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default7.aspx");
    }
}
