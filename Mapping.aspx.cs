using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class Mapping : System.Web.UI.Page
{
    public string waypoints;
   

    protected void Page_Load(object sender, EventArgs e)
    {
        LblWelcome.Text = "Hello " + Session["DD"];

        string lat;
        string lng;

        //    make an sql datasource
        //    select lat,long from addresses where driver = "bob"
        //    results are in a datatable
      
        DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        DataTable dt = new DataTable();
        dt = dv.ToTable();

        int i = -1;


        waypoints = "[";


        foreach (DataRow row in dt.Rows)
        {
      
            i++;

            lat = row[2].ToString();
            lng = row[3].ToString();

            string newpoint = "{ location: { lat:" + lat + ", lng:" + lng + " }},";

            waypoints += newpoint;

        }


        waypoints = waypoints.Substring(0, waypoints.Length - 1);
        waypoints += "]";


    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }
   
   
}