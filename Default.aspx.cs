using GGlimpse.DataModels;
using MongoDB.Driver;
using System;
using System.Data.SqlClient;
using System.Security.AccessControl;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Xml.Linq;

public partial class _Default : System.Web.UI.Page
{
    [WebMethod]
    public static void SendInfo(string uName, string mail, string num, string msg)
    {
        try
        {
            var DB = (IMongoDatabase)HttpContext.Current.Application["GlobeGlimpseDB"];
            var ResCollection = DB.GetCollection<UserResponses>("UserResponses");
            var newRes = new UserResponses(uName, mail, num, msg);
            ResCollection.InsertOne(newRes);
        }
        catch (Exception)
        { }
    }
}