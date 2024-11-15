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
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void UserRegister_Click(object sender, EventArgs e)
        {
            if (UserName.Text != "")
            {
                // Username cannot have the term system in it
                if (!UserName.Text.ToLower().Contains("system"))
                {
                    if (UserMailID.Text != "")
                    {
                        if (UserPwd.Text != "")
                        {
                            var DB = (IMongoDatabase)Application["GlobeGlimpseDB"];
                            var UserCollection = DB.GetCollection<UsersModel>("Users");

                            var newUser = new UsersModel();
                            newUser.UserMail = UserMailID.Text;
                            newUser.UserName = UserName.Text;

                            var usersFilter = Builders<UsersModel>.Filter.Eq(User => User.UserMail, UserMailID.Text);
                            var usersLst = UserCollection.Find(usersFilter).ToList();

                            if (usersLst.Count == 0)
                            {
                                try
                                {
                                    var usersalt = Utility.getRandomString(5);
                                    var userHash = Utility.GetHash(UserPwd.Text, Encoding.ASCII.GetBytes(usersalt));

                                    newUser.UserSalt = usersalt;
                                    newUser.UserHash = userHash;

                                    UserCollection.InsertOne(newUser);
                                    Session["UserDocument"] = newUser;
                                    Response.Redirect("~/Default.aspx");
                                }
                                catch (Exception)
                                {
                                    Console.WriteLine(e.ToString());
                                }
                            }
                            else
                            {
                                // Email ID already exists
                            }
                        }
                    }
                }
            }
        }
    }
}