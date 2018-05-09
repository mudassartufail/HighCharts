using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace HighCharts
{
    public class DBClass
    {
        private DataTable table;

        public DBClass()
        {
            table = new DataTable();
        }

        public DataTable GetDataTable()
        {
            table.Columns.Add("Federal");
            table.Columns.Add("Punjab");
            table.Columns.Add("Sindh");
            table.Columns.Add("KPK");
            table.Columns.Add("Balochistan");
            table.Columns.Add("FATA");
            table.Rows.Add(0.61, 55.62, 22.99, 13.41, 4.96, 2.40);
          
            return table;
        }
    }
}