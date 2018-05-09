using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Newtonsoft.Json;

namespace HighCharts
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static string GetPopulation() 
        {
            DBClass objDB = new DBClass(); //Database Class for dynamic data
            DataTable recTable = new DataTable();
            recTable = objDB.GetDataTable(); //Get Table from database 

            //Convert Data Table to JSON with Newtonsoft's Json.NET
            string JSONdata = JsonConvert.SerializeObject(recTable);

            return JSONdata;
        }
    }
}