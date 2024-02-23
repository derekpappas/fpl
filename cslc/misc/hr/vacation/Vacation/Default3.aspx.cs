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

public partial class Default3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.Cookies["Username"].Value == "" || 
                Request.Cookies["Class"].Value != "2")
                Response.Redirect("Default.aspx");
        }
        catch (Exception ex)
        {
            Response.Redirect("Default.aspx");
        }
    }
    protected void bSubmit_Click(object sender, EventArgs e)
    {
        if (!Strings.ParseQueryString(userTB.Text.ToString()) ||
                 !Strings.ParseQueryString(Password2.Value.ToString()) ||
                 !Strings.ParseQueryString(Password3.Value.ToString()) ||
                 !Strings.ParseQueryString(mailTB.Text.ToString()) ||
                 !Strings.ParseQueryString(classTB.SelectedValue.ToString()))
        {
            errLabel.Text = "Illegal characters in info.";
            errLabel.Visible = true;
            return;
        }

        if (Sql.IsUser(userTB.Text.ToString()))
        {
            errLabel.Text = "Username already in use.";
            errLabel.Visible = true;
            return;
        }
        MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
        MySqlCommand comm = new MySqlCommand(
            "SELECT MAX(id) FROM users;", conn);
        conn.Open();
        Int32 m = Convert.ToInt32(comm.ExecuteScalar().ToString(), 10);
        m++;
        comm.CommandText = "INSERT INTO users VALUES('" + m.ToString() + "', '" +
            userTB.Text.ToString() + "', MD5('" + Password2.Value.ToString() +
            "'), '" + classTB.SelectedValue + "', '" + mailTB.Text + "');";
        comm.ExecuteNonQuery();
        conn.Close();
        Response.Redirect("Default.aspx");
    }
    protected void bBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
}
