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

public class Sql
{
    public static String sqlConString = "";

    public static void LoadSettings(String s)
    {
        if (sqlConString == "")
            sqlConString = s;
    }

    public static Int32 UserId(String user)
    {
        Int32 id;
        String cmdString="SELECT id FROM users WHERE username LIKE '"+
            user+"';";
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand(cmdString,conn);
        try{
            conn.Open();
            id = Convert.ToInt32(comm.ExecuteScalar().ToString(),10);
        }
        catch(MySqlException ex){
            conn.Close();
            return -1;
        }
            conn.Close();
            return id;
    }

    public static bool CheckTimer(String user)
    {
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand("", conn);
	comm.CommandText = "SELECT COUNT(*) FROM hours WHERE id LIKE '" + 
	    UserId(user).ToString() + "';";
        try
        {
            conn.Open();
            if (Convert.ToInt32(comm.ExecuteScalar().ToString(), 10) == 0)
            {
        	conn.Close();
        	return true;
    	    }
	    comm.CommandText = "SELECT MIN(NOW()-added) FROM hours WHERE id LIKE '" +
            UserId(user).ToString() + "' LIMIT 1;";
            if (Convert.ToInt32(comm.ExecuteScalar().ToString(), 10) < 30)
            {
                conn.Close();
                return false;
            }
            else
            {
                conn.Close();
                return true;
            }
        }
        catch (MySqlException ex)
        {
            conn.Close();
            return false;
        }
        catch (ArgumentOutOfRangeException ex)
        {
            conn.Close();
            return true;
        }
    }

    public static bool AddEntry(String user, Int32 day, float mh, float rh)
    {
        String date = System.DateTime.Now.Year.ToString() + "-" +
            System.DateTime.Now.Month.ToString() + "-" + day.ToString();
        String cmdStr;
        if (mh > 0 && rh > 0)
            cmdStr = "INSERT INTO hours VALUES (" +
            UserId(user).ToString() + ", '" + date.ToString() + "', '-" + mh.ToString().Replace(',','.') + "', NOW());" +
            "INSERT INTO hours VALUES (" +
            UserId(user).ToString() + ", '" + date.ToString() + "', '" + rh.ToString().Replace(',', '.') + "', NOW());";
        else if (mh == 0 && rh > 0)
            cmdStr = "INSERT INTO hours VALUES (" +
            UserId(user).ToString() + ", '" + date.ToString() + "', '" + rh.ToString().Replace(',', '.') + "', NOW());";
        else
            cmdStr = "INSERT INTO hours VALUES (" +
            UserId(user).ToString() + ", '" + date.ToString() + "', '-" + mh.ToString().Replace(',', '.') + "', NOW());";
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand(cmdStr,conn);
        try{
            conn.Open();
            comm.ExecuteNonQuery();
        }
        catch(MySqlException ex){
            conn.Close();
            return false;
        }
        conn.Close();
        return true;
    }

    public static DataSet GetUserList()
    {
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand(
            "SELECT username FROM users ORDER BY username;",conn);
        MySqlDataAdapter adapter = new MySqlDataAdapter();
        adapter.SelectCommand = comm;
        DataSet ds = new DataSet();
        conn.Open();
        adapter.Fill(ds);
        conn.Close();
        return ds;
    }

    public static bool IsUser(String user)
    {
        String r;
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand(
            "SELECT COUNT(*) FROM users WHERE username LIKE '" +
            user + "';",conn);
        conn.Open();
        r = comm.ExecuteScalar().ToString();
        conn.Close();
        if (r == "0")
            return false;
        else
            return true;
    }

    public static DataTable GetMonthlyStatus(String user, Int32 month)
    {
        Int32 uid = UserId(user);
        DataTable dt;
        Int32 year = System.DateTime.Now.Year;
        if( month > 10 && System.DateTime.Now.Month < 6 )
    	    year--;
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand("", conn);
        comm.CommandText = "SELECT date Date, hours Hours, " +
            "added AddedOn FROM hours WHERE id LIKE '" +
            uid.ToString() + "' AND date >= '" + year + 
            "-" + month.ToString() + "-01 00:00:00' AND "+
            "date < '" + year + 
            "-" + (month+1).ToString() + "-01 00:00:00';";
        DataSet ds = new DataSet();
        MySqlDataAdapter adapter = new MySqlDataAdapter(comm);
        conn.Open();
        adapter.Fill(ds);
        conn.Close();
        dt = ds.Tables[0];
        return dt;
    }

    public static String GetBalance(String user, Int32 month)
    {
        Int32 uid = UserId(user);
        String s,bal,paid;
        Int32 year = System.DateTime.Now.Year;
        if( month > 10 && System.DateTime.Now.Month < 6 )
    	    year--;
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand("", conn);
        conn.Open();
        comm.CommandText = "SELECT SUM(hours) FROM hours WHERE id LIKE '" +
            uid.ToString() + "' AND date >= '" + year +
            "-" + month.ToString() + "-01 00:00:00' AND " +
            "date < '" + year +
            "-" + (month + 1).ToString() + "-01 00:00:00';";
        bal = (comm.ExecuteScalar().ToString() != "" ? comm.ExecuteScalar().ToString() + " hours" : "");
        comm.CommandText = "SELECT paid FROM status WHERE id LIKE '" +
            uid.ToString() + "' AND month LIKE '" + month.ToString() + "';";
        try
        {
            paid = (comm.ExecuteScalar().ToString() != "" ? comm.ExecuteScalar().ToString() + " hours paid vac." : "");
        }
        catch (Exception ex)
        {
            paid = "";
        }
        conn.Close();
        if (paid.IndexOf("hours") >= 0 && paid.IndexOf("0 h") != 0)
            s = bal + " from which " + paid;
        else
            s = bal + "";
        return s;
    }

    public static bool CheckMonthData(String user)
    {
        Int32 uid = UserId(user);
        String s;
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand("SELECT hpd FROM status WHERE id " +
            "LIKE '" + uid.ToString() + "' AND month LIKE '" + 
            System.DateTime.Now.Month + "';", conn);
        conn.Open();
        try
        {
            s = comm.ExecuteScalar().ToString();
        }
        catch (NullReferenceException ex)
        {
            s = "";
        }
        conn.Close();
        if(s=="")
        {
            return false;
        }
        try
        {
            Int32 i = Convert.ToInt32(s);
            if (i > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public static void AddNewMonth(String user)
    {
        Int32 uid = UserId(user);
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand("", conn);
        conn.Open();
        comm.CommandText = "INSERT INTO status VALUES('" + uid.ToString() +
            "','" + System.DateTime.Now.Month.ToString() + "','0','0','0');";
        comm.ExecuteNonQuery();
        conn.Close();
    }

    public static String GetWorkHours(String user, Int32 month)
    {
        Int32 uid = UserId(user);
        String s;
        MySqlConnection conn = new MySqlConnection(sqlConString);
        MySqlCommand comm = new MySqlCommand("SELECT hpd FROM status WHERE id " +
            "LIKE '" + uid.ToString() + "' AND month LIKE '" +
            month.ToString() + "';", conn);
        conn.Open();
        try
        {
            s = comm.ExecuteScalar().ToString();
            s = (Convert.ToInt32(s)*5).ToString();
        }
        catch (NullReferenceException ex)
        {
            s = "N/A";
        }
        conn.Close();
        return (s + " hours per week");
    }

    public static DataTable GetMonthlyReportTable(int Month)
    {
        DataSet dsUsers = GetUserList();
        DataTable Result = new DataTable();
        Result.Columns.Add("User");
        Result.Columns.Add("Balance");
        Result.Columns.Add("Worked Hours");
        foreach (DataRow dr in dsUsers.Tables[0].Rows)
        {
            object[] drObjects = dr.ItemArray;
            String username = drObjects[0].ToString();
            String balance = GetBalance(username, Month).Replace('.',',');
            String worked;
            Int32 workHours=0;
            Double whd=0;
            Boolean half = false;
            String decimals = "0";
            //try
            {
                if (balance.Contains(","))
                {
                    half = true;
                    decimals = balance.Substring(balance.IndexOf(',') + 1, balance.IndexOf(' ') - balance.IndexOf(',') - 1);
                }
                if (balance.Length > 0)
                    if (!half)
                    {
                        workHours = (
                    getMonthWorkHours(Convert.ToInt32(GetWorkHours(username, Month).Substring(0,
                    GetWorkHours(username, Month).IndexOf(' ')), 10), Month) +
                    Convert.ToInt32(balance.Substring(0, balance.IndexOf(' ')).Replace(',', '.'), 10));
                    }
                    else
                    {
                        workHours = (
                    getMonthWorkHours(Convert.ToInt32(GetWorkHours(username, Month).Substring(0,
                    GetWorkHours(username, Month).IndexOf(' ')), 10), Month) +
                    Convert.ToInt32(balance.Substring(0, balance.IndexOf(',')).Replace(',', '.'), 10));
                    }
                if (balance.StartsWith("-"))
                {
                    whd = workHours - Convert.ToInt32(decimals, 10) / Math.Pow(10, decimals.Length);
                }
                else
                {
                    whd = workHours + Convert.ToInt32(decimals, 10) / Math.Pow(10, decimals.Length);
                }
                worked = whd.ToString();
            }/*
            catch (Exception e)
            {
                worked = "N/A";
            }*/
            Result.Rows.Add(username, balance, worked);
        }
        return Result;
    }

    public static Int32 getMonthWorkHours(Int32 hpd, Int32 month)
    {
        Int32 wdays = 0;
        Int32 year = DateTime.Now.Year;
        if (month > 6 && DateTime.Now.Month == 1)
            year--;
        for (Int32 i = 1; i <= DateTime.DaysInMonth(year, month); i++)
        {
            DateTime dt;
            try
            {
                dt = DateTime.Parse("20-" + month.ToString() + "-" + year.ToString());
                dt = DateTime.Parse(i.ToString() + "-" + month + "-" + year);
            }
            catch (Exception e)
            {
                dt = DateTime.Parse(month + "-" + i.ToString() + "-" + year);
            }
            DayOfWeek dow = dt.DayOfWeek;
            if (!(dow.ToString() == "Saturday" || dow.ToString() == "Sunday"))
/*			if((dt.Day == 1 && dt.Month == 1) ||
				(t.Day == 2 && dt.Month == 1))
				continue;*/
                wdays++;
        }
		if(month == 1)
		wdays = 21;
        if(month == 12)
    	    wdays = 19;
        return wdays * hpd / 5;
    }
}
