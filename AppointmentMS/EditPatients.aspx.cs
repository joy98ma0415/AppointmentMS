using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppointmentMS
{
    public partial class EditPatients : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void DetailsView1_DataBound(object sender, EventArgs e)
        {
            if (DetailsView1.Rows.Count == 0)
            {
                DetailsView1.ChangeMode(DetailsViewMode.Insert);
            }
        }
    }
}