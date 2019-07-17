using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Data;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void loginBtn_Click(object sender, EventArgs e)
    {
        //create SQL connection 
        SqlDataSource sds = new SqlDataSource();
        sds.ConnectionString = ConfigurationManager.ConnectionStrings["PackagesDBConnectionString"].ToString(); //Connection String
        sds.SelectParameters.Add("uName", TypeCode.String, this.uNameTextBox.Text);
        sds.SelectParameters.Add("password", TypeCode.String, this.passwordTextBox.Text);
        sds.SelectCommand = "SELECT * FROM [Register] WHERE [uName] = @uName AND [password] = @password";
        DataView dv = (DataView)sds.Select(DataSourceSelectArguments.Empty);
        //con.Open();

        //string query = "SELECT uName, password from Register where uName='" + uNameTextBox.Text + "'and password='" + passwordTextBox.Text + "'";   //Sql statement to check for correct login details
        //SqlCommand cmd = new SqlCommand(query, con);
        //SqlDataReader sdr = cmd.ExecuteReader();


        //string jobrole = "SELECT occupation from Register";
        //SqlCommand comm = new SqlCommand(jobrole, con);
        //SqlDataReader SDR = comm.ExecuteReader();

        //SqlCommand check_Job = new SqlCommand("SELECT occupation from Register", con);

        string jobrole = dv.Table.Rows[0]["occupation"].ToString();


        //if (sdr.Read())
        //{
        if (jobrole == "Delivery Driver")
        {
            Session["DD"] = uNameTextBox.Text;
            Response.Redirect("Mapping.aspx");
        }
        else if (jobrole == "Warehouse Worker")
        {
            //create session 
            Session["WH"] = uNameTextBox.Text;
            Response.Redirect("addDelivery.aspx");
        }

        else
        {
            //login credentials incorrect show "incorrect details" label
            lblFail.Visible = true;
        }


        //    con.Close();


        //}
    }
}