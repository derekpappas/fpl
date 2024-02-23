using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using MySql.Data.MySqlClient;
using MySql.Data.Types;

public sealed class Strings
{
    public static String LoadBanner()
    {
        String Banner;
        string cQuery =
            "SELECT banner FROM company;";
        MySqlConnection conn = new MySqlConnection(Sql.sqlConString);
        MySqlCommand comm = new MySqlCommand(cQuery);
        comm.Connection = conn;
        try
        {
            conn.Open();
        }
        catch (MySqlException ex)
        {
            return "";
        }
        if (!conn.Ping())
        {
            return "";
        }
        try
        {
            Banner = comm.ExecuteScalar().ToString();
        }
        catch (MySqlException ex)
        {
            return "";
        }
        conn.Close();
        return Banner;
    }

    public static Boolean ParseQueryString(String s)
    {
        char[] illegalChars = {'\'', '\"', '%', '&', '\\'};
        if (s.IndexOfAny(illegalChars) >= 0)
            return false;
        return true;
    }
}
