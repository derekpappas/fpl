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
using MySql.Data.MySqlClient;
using MySql.Data.Types;

public partial class _Default : System.Web.UI.Page
{
    public static bool DEBUG = true;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Sql.sqlConString == "")
            Sql.LoadSettings(sqlcmd.Text.ToString());
        if (Banner.Text == "")
        {
            Banner.Text = Strings.LoadBanner();
        }
        try
        {
            if (Request.Cookies["Username"].Value == "")
                return;
            Response.Redirect("Default2.aspx");
        }
        catch(Exception ex)
        {
            return;
        }
    }
    protected void LoginSubmit_Click(object sender, EventArgs e)
    {
        DebugTB.Visible = false;
        if (!Strings.ParseQueryString(userTB.Text) || !Strings.ParseQueryString(passTB.Value))
        {
            errorLabel.Visible = true;
            errorLabel.Text="Illegal username or password";
            return;
        }
        else
            errorLabel.Visible = false;
        String cQuery = 
            "SELECT COUNT(*) FROM users where username like '"+
            userTB.Text+"' and password like MD5('"+
            passTB.Value.ToString()+"');";
        String cQueryClass =
            "SELECT class FROM users where username like '" +
            userTB.Text + "';";
        MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
        MySqlCommand comm = new MySqlCommand(cQuery);
        comm.Connection = conn;
        try
        {
            conn.Open();
        }
        catch (MySqlException ex)
        {
            errorLabel.Visible = true;
            errorLabel.Text = "Could not connect to database. Contact the site administrator.";
            if (DEBUG)
            {
                DebugTB.Visible = true;
                DebugTB.Text = ex.ToString();
            }
            return;
        }
        if(!conn.Ping()){
            errorLabel.Visible = true;
            errorLabel.Text="Could not connect to database. Contact the network administrator.";
            return;
        }
        Int32 res = 0;
        try
        {
            res=Convert.ToInt32(comm.ExecuteScalar().ToString(),10);
        }
        catch (MySqlException ex)
        {
            errorLabel.Visible = true;
            errorLabel.Text = "Mysql error. Contact the site administrator.";
            if (DEBUG)
            {
                DebugTB.Visible = true;
                DebugTB.Text = ex.ToString();
            }
            return;
        }
        if (res == 0)
        {
            errorLabel.Visible = true;
            errorLabel.Text = "Login failed!";
            return;
        }
        comm.CommandText = cQueryClass;
        try
        {
            res = Convert.ToInt32(comm.ExecuteScalar().ToString(), 10);
        }
        catch (MySqlException ex)
        {
            errorLabel.Visible = true;
            errorLabel.Text = "Mysql error. Contact the site administrator.";
            if (DEBUG)
            {
                DebugTB.Visible = true;
                DebugTB.Text = ex.ToString();
            }
            return;
        }
        conn.Close();
        userTB.Enabled = false;
        passTB.Disabled = true;
        HttpCookie user = new HttpCookie("Username", userTB.Text.ToString());
        HttpCookie pass = new HttpCookie("Class", res.ToString());
        Response.Cookies.Add(user);
        Response.Cookies.Add(pass);
        Response.Redirect("Default2.aspx");
    }
}
