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

public partial class Default5 : System.Web.UI.Page
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
            tResults.Visible = Label3.Visible = Label4.Visible = Label6.Visible = 
                Label7.Visible = worked.Visible = false;
            DataSet ds = Sql.GetUserList();
            ddUser.DataSource = ds.Tables[0];
            ddUser.DataTextField = ddUser.DataValueField = "username";
            ddUser.DataBind();
            ddUser.SelectedValue = Request.Cookies["Username"].Value.ToString();
            DataTable dt = new DataTable();
            dt.Columns.Add("Id");
            dt.Columns.Add("Name");
            dt.Rows.Add(new object[2] { 1, "January"});
            dt.Rows.Add(new object[2] { 2, "February" });
            dt.Rows.Add(new object[2] { 3, "March" });
            dt.Rows.Add(new object[2] { 4, "April" });
            dt.Rows.Add(new object[2] { 5, "May" });
            dt.Rows.Add(new object[2] { 6, "June" });
            dt.Rows.Add(new object[2] { 7, "July" });
            dt.Rows.Add(new object[2] { 8, "August" });
            dt.Rows.Add(new object[2] { 9, "September" });
            dt.Rows.Add(new object[2] { 10, "October" });
            dt.Rows.Add(new object[2] { 11, "November" });
            dt.Rows.Add(new object[2] { 12, "December" });
            DataTable di = new DataTable();
            ddMonth.DataSource = dt;
            ddMonth.DataTextField = "Name";
            ddMonth.DataValueField = "Id";
            ddMonth.DataBind();
            ddMonth.SelectedIndex = System.DateTime.Now.Month-1;
        }
        if (Request.Cookies["Class"].Value == "1")
        {
            ddUser.Enabled = false;
        }
        else
        {
            ddUser.Enabled = true;
        }
    }
    protected void bSubmit_Click(object sender, EventArgs e)
    {
        Int32 workHours=0;
        Double whd;
        Boolean half=false;
        String decimals="0";
        tResults.Visible = Label3.Visible = Label4.Visible =
            Label6.Visible = Label7.Visible = worked.Visible = true;
        Label5.Visible = true; hpd.Visible = true;
        DataTable dt = Sql.GetMonthlyStatus(ddUser.Text, ddMonth.SelectedIndex + 1);
        tResults.DataSource = dt;
        tResults.DataBind();
        Label4.Text = Sql.GetBalance(ddUser.Text, ddMonth.SelectedIndex + 1);
        hpd.Text = Sql.GetWorkHours(ddUser.Text, ddMonth.SelectedIndex + 1);
        if (!hpd.Text.StartsWith("N/A"))
            workHours = Sql.getMonthWorkHours(Convert.ToInt32(hpd.Text.Substring(0, hpd.Text.IndexOf(' ')),
            10), ddMonth.SelectedIndex + 1);
        else
            workHours = 0;
        Label4.Text=Label4.Text.Replace('.',',');
        if (Label4.Text.Contains(","))
        {
            half = true;
            decimals = Label4.Text.Substring(Label4.Text.IndexOf(',') + 1, Label4.Text.IndexOf(' ') - Label4.Text.IndexOf(',')-1);
        }
        if (Label4.Text.Length > 0)
            if (!half)
                workHours = workHours +
                    Convert.ToInt32(Label4.Text.Substring(0, Label4.Text.IndexOf(' ')), 10);
            else
                workHours = workHours +
                    Convert.ToInt32(Label4.Text.Substring(0, Label4.Text.IndexOf(',')), 10);
        if (Label4.Text.StartsWith("-"))
        {
            whd = workHours - Convert.ToInt32(decimals, 10) / Math.Pow(10, decimals.Length);
        }
        else
        {
            whd = workHours + Convert.ToInt32(decimals, 10) / Math.Pow(10, decimals.Length);
        }
        worked.Text = whd.ToString();
    }
    protected void bBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
}
