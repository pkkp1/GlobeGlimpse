using GGlimpse.DataModels;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GGlimpse
{
    public partial class AdminPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var DB = (IMongoDatabase)Application["GlobeGlimpseDB"];
                var BlogsCollection = DB.GetCollection<UserResponses>("UserResponses");
                var BlogsLst = BlogsCollection.Find(exists => true).ToList();
                GridView1.DataSource = BlogsLst;
                GridView1.DataBind();
            }
        }
    }
}