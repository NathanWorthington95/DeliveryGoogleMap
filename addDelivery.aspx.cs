using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Security.Cryptography;

public partial class addDelivery : System.Web.UI.Page

{
    public string SqlCommand1;
    SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\PackagesDB.mdf;Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        //Create connection to the database
        if (Page.IsValid)
        {
            //Find the username and password for user and see if they match in the admin table
            con.Open();
            string command = "INSERT INTO [postcodelatlng] (id, driver, cNumber, deliveryOption, postcode, name, latitude, longitude ) VALUES (@id, @driver, @cNumber, @deliveryOption, @postcode, @name, @latitude, @longitude)";
            SqlCommand cmd = new SqlCommand(command, con);
            cmd.Parameters.AddWithValue("@id", TxtPackID.Text);
            cmd.Parameters.AddWithValue("@driver", TxtDriver.Text);
            cmd.Parameters.AddWithValue("@name", TxtCustomerName.Text);
            cmd.Parameters.AddWithValue("@postcode", TxtPostcode.Text);
            cmd.Parameters.AddWithValue("@cNumber", TxtContactNum.Text);
            cmd.Parameters.AddWithValue("@deliveryOption", TxtUnavailbleOption.Text);
            cmd.Parameters.AddWithValue("@latitude", latTextBox.Text);
            cmd.Parameters.AddWithValue("@longitude", lngTextBox.Text);

            cmd.ExecuteNonQuery();
            con.Close();



            LBlValid.Visible = true;
            LBlValid.ForeColor = System.Drawing.Color.Green;
            LBlValid.Text = "Thank you for submitting your parcel will arrive shortly";
        }
        else
        {
            LBlValid.Visible = true;
            LBlValid.ForeColor = System.Drawing.Color.Red;
            LBlValid.Text = "Unfortunately the details are incorrect, please try again";
        }




    }

    protected void BtnUploadCsv_Click(object sender, EventArgs e)
    {
        //create object of data table 
        DataTable dt = new DataTable();

        //creating columns
        dt.Columns.AddRange(new DataColumn[8] {
            new DataColumn("id", typeof(string)),
            new DataColumn("postcode", typeof(string)),
            new DataColumn("latitude", typeof(decimal)),
            new DataColumn("longitude", typeof(decimal)),
            new DataColumn("deliveryOption",typeof(string)),
            new DataColumn("driver",typeof(string)),
            new DataColumn("name", typeof(string)),
            new DataColumn("cnumber", typeof(string))});

        string uploadpath = Server.MapPath("~/CSV/") + Path.GetFileName(FileUpload1.PostedFile.FileName);

        FileUpload1.SaveAs(uploadpath);

        string uploaddata = File.ReadAllText(uploadpath);
        //split row for new entry 
        foreach (string row in uploaddata.Split('\n'))

        {

            if (!string.IsNullOrEmpty(row))

            {
                dt.Rows.Add();

                int i = 0;

                foreach (string cell in row.Split(','))

                {
                    dt.Rows[dt.Rows.Count - 1][i] = cell;

                    i++;
                }
            }
        }

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PackagesDBConnectionString"].ToString());
        con.Open();

        {

            using (SqlBulkCopy copy = new SqlBulkCopy(con))

            {
                copy.DestinationTableName = "dbo.postcodelatlng";
                copy.WriteToServer(dt);
                con.Close();
            }
            LblCsv.Text = "CSV File successfully uploaded";
            LblCsv.ForeColor = System.Drawing.Color.Green;
        }

 


}

    public string Get8Digits()
    {
        var bytes = new byte[4];
        var rng = RandomNumberGenerator.Create();
        rng.GetBytes(bytes);
        uint random = BitConverter.ToUInt32(bytes, 0) % 100000000;
        return String.Format("{0:D8}", random);
      
    }



    protected void bcodeButton_Click(object sender, EventArgs e)
    {
       TxtPackID.Text = Get8Digits().ToString();
    }
}





