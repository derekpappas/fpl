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

public partial class Default4 : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            DataSet ds = Sql.GetUserList();
            Userlist.DataSource = ds.Tables[0];
            Userlist.DataTextField = Userlist.DataValueField = "username";
            Userlist.DataBind();
            Userlist.SelectedValue = Request.Cookies["Username"].Value.ToString();
            Userlist_SelectedIndexChanged(null, null);
        }
        if (Request.Cookies["Class"].Value == "1")
        {
            classTB.Enabled = Userlist.Enabled = false;
            mailTB.ReadOnly = true;
            tbDays.ReadOnly = true;
        }
        else
        {
            classTB.Enabled = Userlist.Enabled = true;
            mailTB.ReadOnly = false;
            tbHPD.ReadOnly = false;
            tbDays.ReadOnly = false;
        }
    }
    protected void bSubmit_Click(object sender, EventArgs e)
    {
        errLabel.Visible = false;
        try
        {
            if (Request.Cookies["Username"].Value == "")
                Response.Redirect("Default.aspx");
        }
        catch (Exception ex)
        {
            Response.Redirect("Default.aspx");
        }
        if (Password2.Value.ToString() != Password3.Value.ToString())
        {
            errLabel.Text = "Passwords do not match.";
            errLabel.Visible = true;
            return;
        }
        try
        {
            Int32 i = Convert.ToInt32(tbHPD.Text.ToString());
            if (i <= 0 || i>=24)
            {
                errLabel.Text = "Invalid number of hours per day entered.";
                errLabel.Visible = true;
                return;
            }
        }
        catch (Exception ex)
        {
            errLabel.Text = "Invalid number of hours per day entered." + ex.ToString();
            errLabel.Visible = true;
            return;
        }

        if (Request.Cookies["Class"].Value == "1")
        {
            if (!Strings.ParseQueryString(Password1.Value.ToString()) ||
                !Strings.ParseQueryString(Password2.Value.ToString()) ||
                !Strings.ParseQueryString(Password3.Value.ToString()))
            {
                errLabel.Text = "Illegal characters in password.";
                errLabel.Visible = true;
                return;
            }

            MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
            String cmdStr = "SELECT COUNT(*) FROM users WHERE " +
                "username LIKE '" + Request.Cookies["Username"].Value + "' AND password " +
                "LIKE MD5('" + Password1.Value.ToString() + "');";
            conn.Open();
            MySqlCommand comm = new MySqlCommand(cmdStr, conn);
            if (Password2.Value.ToString() != "")
            {
                if (comm.ExecuteScalar().ToString() == "0")
                {
                    errLabel.Text = "Wrong password.";
                    errLabel.Visible = true;
                    conn.Close();
                    return;
                }
                comm.CommandText = "UPDATE users SET password=MD5('" +
                    Password2.Value.ToString() + "') WHERE username " +
                    "LIKE '" + Request.Cookies["Username"].Value + "';";
                comm.ExecuteNonQuery();
            }
            comm.CommandText = "UPDATE status SET hpd='" + tbHPD.Text +
                "' WHERE id LIKE '" + Sql.UserId(Userlist.Text.ToString()) +
                "' AND month LIKE '" + System.DateTime.Now.Month.ToString() +
                "';";
            comm.ExecuteNonQuery();
            errLabel.Text = "Information successfully changed.";
            errLabel.Visible = true;
            conn.Close();

        }

        if (Request.Cookies["Class"].Value == "2")
        {
            if (!Strings.ParseQueryString(Password1.Value.ToString()) ||
                !Strings.ParseQueryString(Password2.Value.ToString()) ||
                !Strings.ParseQueryString(Password3.Value.ToString()) ||
                !Strings.ParseQueryString(mailTB.Text.ToString()) ||
                !Strings.ParseQueryString(classTB.SelectedValue.ToString()))
            {
                errLabel.Text = "Illegal characters in password.";
                errLabel.Visible = true;
                return;
            }

            MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
            conn.Open();
            MySqlCommand comm = new MySqlCommand("", conn);
            comm.CommandText = "UPDATE users SET password=MD5('" +
                Password2.Value.ToString() + "') WHERE username "+
                    "LIKE '"+Userlist.Text.ToString()+"';";
            if (Password2.Value.ToString() != "")
                comm.ExecuteNonQuery();
            comm.CommandText = "UPDATE users SET class='" +
                classTB.SelectedValue.ToString() + "' WHERE username " +
                    "LIKE '" + Userlist.Text.ToString() + "';";
            comm.ExecuteNonQuery();
            comm.CommandText = "UPDATE users SET email='" +
                mailTB.Text.ToString() + "' WHERE username " +
                    "LIKE '" + Userlist.Text.ToString() + "';";
            comm.ExecuteNonQuery();
            comm.CommandText = "UPDATE status SET hpd='" + tbHPD.Text +
                "' WHERE id LIKE '" + Sql.UserId(Userlist.Text.ToString()) +
                "' AND month LIKE '" + System.DateTime.Now.Month.ToString() +
                "';";
            comm.ExecuteNonQuery();
            comm.CommandText = "UPDATE status SET paidleft='" + tbDays.Text +
                "' WHERE id LIKE '" + Sql.UserId(Userlist.Text.ToString()) +
                "' AND month LIKE '" + System.DateTime.Now.Month.ToString() +
                "';";
            comm.ExecuteNonQuery();
            errLabel.Text = "Information successfully changed.";
            errLabel.Visible = true;
            conn.Close();

        }
    }
    protected void bBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
    protected void Userlist_SelectedIndexChanged(object sender, EventArgs e)
    {
        MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
        MySqlCommand comm;
        comm = new MySqlCommand("SELECT class FROM users WHERE username LIKE '" +
            Userlist.SelectedValue.ToString() + "';",conn);
        conn.Open();
        classTB.SelectedIndex = classTB.Items.IndexOf(classTB.Items.FindByValue(comm.ExecuteScalar().ToString()));
        comm.CommandText = "SELECT email FROM users WHERE username LIKE '" +
            Userlist.SelectedValue.ToString() + "';";
        mailTB.Text = comm.ExecuteScalar().ToString();
        comm.CommandText = "SELECT status.hpd FROM users,status WHERE " + 
            "users.id like status.id and users.username LIKE '" +
            Userlist.SelectedValue.ToString() + "' AND status.month LIKE '" +
            System.DateTime.Now.Month.ToString() + "';";
        if(!IsPostBack)try
        {
            tbHPD.Text = comm.ExecuteScalar().ToString();
        }
        catch (NullReferenceException ex)
        {
            Sql.AddNewMonth(Userlist.SelectedValue.ToString());
        }
        try
        {
            if (Convert.ToInt32(tbHPD.Text) > 0)
                tbHPD.ReadOnly = true;
        }
        catch (Exception ex)
        {
            tbHPD.Text = "0";
        }


        comm.CommandText = "SELECT status.paidleft FROM users,status WHERE " +
            "users.id like status.id and users.username LIKE '" +
            Userlist.SelectedValue.ToString() + "' AND status.month LIKE '" +
            System.DateTime.Now.Month.ToString() + "';";
        tbDays.Text = comm.ExecuteScalar().ToString();
        conn.Close();
    }
}
