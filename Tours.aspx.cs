using GGlimpse.DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GGlimpse
{
    public partial class Tours : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var countryCode = Request.QueryString["Country"] == null ? "IN" : Request.QueryString["Country"];
            var CountryDetails = (Country)HttpRuntime.Cache.Get("Country_" + countryCode); ;
            // If querystring has invalid data, set to default country India
            if (CountryDetails == null)
            {
                CountryDetails = (Country)HttpRuntime.Cache.Get("Country_IN"); ;
            }
            Page.Title = CountryDetails.country;
            CountryName.Text = CountryDetails.country;
            CountryDesc.Text = CountryDetails.description;
            ToursLst.DataSource = CountryDetails.tours;
            ToursLst.DataBind();
        }

    }
}