using ChatAppCS;
using GGlimpse.DataModels;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GGlimpse
{
    public partial class Login : System.Web.UI.Page
    {
        protected void UserLogin_Click(object sender, EventArgs e)
        {
            if (UserMailID.Text != "")
            {
                if (UserPwd.Text != "")
                {
                    var DB = (IMongoDatabase)Application["GlobeGlimpseDB"];
                    var UserCollection = DB.GetCollection<UsersModel>("Users");

                    var usersFilter = Builders<UsersModel>.Filter.Eq(User => User.UserMail, UserMailID.Text);
                    var usersLst = UserCollection.Find(usersFilter).ToList();

                    if (usersLst.Count > 0)
                    {
                        String salt = usersLst[0].UserSalt;
                        String storedHash = usersLst[0].UserHash;
                        String checkHash = Utility.GetHash(UserPwd.Text, Encoding.ASCII.GetBytes(salt));

                        if (String.Compare(storedHash, checkHash) == 0)
                        {
                            Session["UserDocument"] = usersLst[0];
                            var RoomID = Request.QueryString["Room"];
                            if (RoomID != null)
                            {
                                Response.Redirect("~/Chat.aspx?Room=" + RoomID);
                            }
                            else
                            {
                                Response.Redirect("~/Default.aspx");
                            }
                        }
                    }
                }
            }
        }
    }
}