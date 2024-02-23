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

public partial class Default7 : System.Web.UI.Page
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
            DataTable dt = new DataTable();
            dt.Columns.Add("Id");
            dt.Columns.Add("Name");
            dt.Rows.Add(new object[2] { 1, "January" });
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
            ddMonth.SelectedIndex = System.DateTime.Now.Month - 1;
        }
        PopulateGrid();
    }

    private void PopulateGrid()
    {
        DataTable dt = Sql.GetMonthlyReportTable(ddMonth.SelectedIndex + 1);
        tResults.DataSource = dt;
        tResults.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
}
