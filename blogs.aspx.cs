using System;
using System.Collections.Generic;
using System.IO;
using MongoDB.Driver;
using GGlimpse.DataModels;

namespace GGlimpse
{
    public partial class blogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var DB = (IMongoDatabase)Application["GlobeGlimpseDB"];
                var BlogsCollection = DB.GetCollection<BlogModel>("Blogs");
                var BlogsLst = BlogsCollection.Find(exists => true).ToList();
                GridView1.DataSource = BlogsLst;
                GridView1.DataBind();
            }
        }
        protected void postBlog(object sender, EventArgs e)
        {
            if (title.Value != "")
            {
                if (blg.Value != "")
                {
                    List<string> Files = new List<string>();
                    foreach (var uploadedFile in FileUpload1.PostedFiles)
                    {
                        string fileName = Path.GetFileName(uploadedFile.FileName);
                        string timestamp = DateTime.Now.ToString("yyyyMMddHHmmss");
                        string newFileName = timestamp + "_" + fileName;
                        Files.Add("~/BlogImages/" + newFileName);
                        string uploadPath = Server.MapPath("~/BlogImages/");
                        string filePath = Path.Combine(uploadPath, newFileName);

                        uploadedFile.SaveAs(filePath); // Save the file with timestamp

                        // You can do additional processing here, such as saving file details to a database.
                    }
                    var DB = (IMongoDatabase)Application["GlobeGlimpseDB"];
                    var blogsCollection = DB.GetCollection<BlogModel>("Blogs");
                    var newBlog = new BlogModel();
                    newBlog.Title = title.Value;
                    newBlog.Post = blg.Value;
                    newBlog.Images = Files;
                    blogsCollection.InsertOne(newBlog);
                    title.Value = "";
                    blg.Value = "";
                    var BlogsCollection = DB.GetCollection<BlogModel>("Blogs");
                    var BlogsLst = BlogsCollection.Find(exists => true).ToList();
                    GridView1.DataSource = BlogsLst;
                    GridView1.DataBind();
                }
            }


        }

        protected void DelBtn_Command(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            var DB = (IMongoDatabase)Application["GlobeGlimpseDB"];
            var blogsCollection = DB.GetCollection<BlogModel>("Blogs");
            var BlogID = e.CommandArgument.ToString();
            var delFilter = Builders<BlogModel>.Filter.Eq(Blog => Blog.id, BlogID);
            blogsCollection.DeleteOne(delFilter);
            var BlogsCollection = DB.GetCollection<BlogModel>("Blogs");
            var BlogsLst = BlogsCollection.Find(exists => true).ToList();
            GridView1.DataSource = BlogsLst;
            GridView1.DataBind();
        }
    }
}