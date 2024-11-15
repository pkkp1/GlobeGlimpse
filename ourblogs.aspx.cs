using GGlimpse.DataModels;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GGlimpse
{
    public partial class ourblogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var DB = (IMongoDatabase)Application["GlobeGlimpseDB"];
            var BlogsCollection = DB.GetCollection<BlogModel>("Blogs");
            var BlogsLst = BlogsCollection.Find(exists => true).ToList();
            BlogsRepeater.DataSource = BlogsLst;
            BlogsRepeater.DataBind();
        }

        protected void BlogsRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Find the nested Repeater control in the main Repeater
                Repeater repeaterImages = (Repeater)e.Item.FindControl("repeaterImages");

                if (repeaterImages != null)
                {
                    // Get the "ImagesLst" data for the current item
                    List<string> imagesList = ((BlogModel)e.Item.DataItem).Images;

                    // Bind the images data to the nested Repeater
                    repeaterImages.DataSource = imagesList;
                    repeaterImages.DataBind();
                }
            }
        }
    }
}