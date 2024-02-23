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

public partial class Default6 : System.Web.UI.Page
{
    private Int32 workhours;

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
        MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
        MySqlCommand comm = new MySqlCommand("", conn);
        conn.Open();
        comm.CommandText = "SELECT SUM(hours) FROM hours WHERE id LIKE '" +
            Sql.UserId(Request.Cookies["Username"].Value).ToString() + 
            "' AND date >= '" + System.DateTime.Now.Year +
            "-" + System.DateTime.Now.Month.ToString() + "-01 00:00:00' AND " +
            "date < '" + System.DateTime.Now.Year +
            "-" + (System.DateTime.Now.Month+1).ToString() + "-01 00:00:00';";
        try
        {
            tbBalance.Text = comm.ExecuteScalar().ToString();
        }
        catch (Exception ex)
        {
            // TODO: Exception
        }
        comm.CommandText = "SELECT paidleft FROM status WHERE id LIKE '" +
            Sql.UserId(Request.Cookies["Username"].Value).ToString() +
            "' AND month LIKE '" + System.DateTime.Now.Month.ToString() + "';";
        try
        {
            tbAvailable.Text = comm.ExecuteScalar().ToString();
        }
        catch (Exception ex)
        {
            // TODO: Exception
        }
        comm.CommandText = "SELECT hpd FROM status WHERE id LIKE '" +
            Sql.UserId(Request.Cookies["Username"].Value).ToString() +
            "' AND month LIKE '" + System.DateTime.Now.Month.ToString() + "';";
        try
        {
            workhours = Convert.ToInt32(comm.ExecuteScalar().ToString());
        }
        catch (Exception ex)
        {
            // TODO: Exception
        }
        conn.Close();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Int32 hours;
        try
        {
            hours = Convert.ToInt32(tbUsed.Text);
        }
        catch (Exception ex)
        {
            errLabel.Visible = true;
            errLabel.Text = "Invalid input.";
            return;
        }
        if (hours <= 0)
        {
            errLabel.Visible = true;
            errLabel.Text = "Number of hours is not valid. Please enter a positive number.";
            return;
        }

        if (hours > Convert.ToInt32(tbAvailable.Text.ToString()))
        {
            errLabel.Visible = true;
            errLabel.Text = "You do not have enough paid vacation left. Select less hours.";
            return;
        }

        if (hours > 0-Convert.ToInt32(tbBalance.Text.ToString()))
        {
            errLabel.Visible = true;
            errLabel.Text = "You don't need so many hours...";
            return;
        }

        MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
        MySqlCommand comm = new MySqlCommand("", conn);
        conn.Open();
        comm.CommandText = "UPDATE status SET paid='" + hours.ToString() +
            "' WHERE id LIKE '" + Sql.UserId(Request.Cookies["Username"].Value) + 
            "' AND month LIKE '" + System.DateTime.Now.Month.ToString() + "';";
        try
        {
            comm.ExecuteNonQuery();
            errLabel.Visible = true;
            errLabel.Text = "Done.";
        }
        catch (Exception ex)
        {
            errLabel.Visible = true;
            errLabel.Text = "Mysql Error";
        }
        conn.Close();
    }
}
