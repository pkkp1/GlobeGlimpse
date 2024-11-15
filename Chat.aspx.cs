using ChatAppCS.Hubs;
using ChatAppCS;
using GGlimpse.DataModels;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace GGlimpse
{

    public partial class Chat : System.Web.UI.Page
    {
        private IMongoDatabase DB = null;
        private IMongoCollection<GroupChatModel> ChatsCollection = null;
        private IMongoCollection<UsersModel> UsersCollection = null;
        protected void Page_Init(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Validate if user logged in or not
                if (Session["UserDocument"] == null)
                {
                    if (Request.QueryString.Count > 0)
                    {
                        Response.Redirect("~/login.aspx?Room=" + Request.QueryString["Room"]);
                    }
                    Response.Redirect("~/login.aspx");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            initCollections();
            if (!IsPostBack)
            {
                var LoggedUser = (UsersModel)Session["UserDocument"];
                UserNameLbl.Text = LoggedUser.UserName;
                var Chatsfilter = Builders<GroupChatModel>.Filter.In("GroupLink", LoggedUser.ChatsLst);
                var ChatsLst = ChatsCollection.Find(Chatsfilter).ToList();

                var ChatsData = new List<ChatLink>();
                foreach (var Chat in ChatsLst)
                {
                    var usersFilter = Builders<UsersModel>.Filter.Where(Member => Member.ChatsLst.Contains(Chat.GroupLink));
                    var usersObj = UsersCollection.Find(usersFilter).Project(Builders<UsersModel>.Projection.Include("Name")).ToList();
                    var usernames = usersObj.Select(doc => doc["Name"].AsString).ToList();
                    var ChatFormat = new ChatLink();
                    ChatsData.Add(new ChatLink(Chat.GroupName, Chat.GroupLink, usernames));
                }

                Session["UserChats"] = ChatsData;
                UpdateChatsLst();

                string RoomID = Request.QueryString["Room"];
                var infoFilter = Builders<GroupChatModel>.Filter.Eq(Group => Group.GroupLink, RoomID);
                var RoomInfo = ChatsCollection.Find(infoFilter).ToList();
                if (RoomInfo.Count > 0)
                {
                    // If user is banned from ChatRoom, redirect to default page,
                    if (!ChatHub.BanList[RoomID].Contains(LoggedUser.Id))
                    {
                        // If user is not a part of the chatroom,
                        // make them a part of it.
                        if (!LoggedUser.ChatsLst.Contains(RoomID))
                        {
                            var userFilter = Builders<UsersModel>.Filter.Eq(User => User.Id, LoggedUser.Id);
                            var userUpdate = Builders<UsersModel>.Update.Push("PartOfGroups", RoomID);
                            UsersCollection.FindOneAndUpdate(userFilter, userUpdate);
                            LoggedUser.ChatsLst.Add(RoomID);
                            Session["UserDocument"] = LoggedUser;

                            // WIP: Call isNewUser at ChatHub
                            var script = "isNewUser('" + LoggedUser.Id + "');";
                            ClientScript.RegisterStartupScript(this.GetType(), "NewUserScript", script, true);
                        }
                    }
                    else
                    {
                        if (LoggedUser.ChatsLst.Contains(RoomID))
                        {
                            LoggedUser.ChatsLst.Remove(RoomID);
                            Session["UserDocument"] = LoggedUser;
                        }
                    }

                    Session["CurrentChat"] = RoomInfo[0];

                    // If user is admin
                    if (RoomInfo[0].GroupAdmin == LoggedUser.Id)
                    {
                        // Get list of all chat members
                        var membersLst = new List<UsersModel>();
                        var memberFilter = Builders<UsersModel>.Filter.Where(Member => Member.ChatsLst.Contains(RoomID));
                        membersLst = UsersCollection.Find(memberFilter).ToList();
                        // Remove LoggedUser form List
                        var AdminIdx = membersLst.FindIndex(Member => Member.Id == LoggedUser.Id);
                        membersLst.RemoveAt(AdminIdx);

                        if (membersLst.Count > 0)
                        {
                            MembersDropDown.DataSource = membersLst;
                            MembersDropDown.DataTextField = "UserName";
                            MembersDropDown.DataValueField = "ID";
                            MembersDropDown.DataBind();
                        }
                        else
                        {
                            ListItem itm = new ListItem();
                            itm.Text = "No members in group";
                            itm.Value = "invalid";
                            MembersDropDown.Items.Add(itm);
                        }
                    }
                    else
                    {
                        AdminControlBox.Controls.Clear();
                    }
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
            ChatName.Text = ((GroupChatModel)Session["CurrentChat"]).GroupName;
            UserObjID.Value = ((UsersModel)Session["UserDocument"]).Id;
        }

        private void initCollections()
        {
            DB = (IMongoDatabase)Application["GlobeGlimpseDB"];
            ChatsCollection = DB.GetCollection<GroupChatModel>("GroupChats");
            UsersCollection = DB.GetCollection<UsersModel>("Users");
        }

        private void UpdateChatsLst()
        {
            var chatsLst = (List<ChatLink>)Session["UserChats"];
            ChatsNav.DataSource = chatsLst;
            ChatsNav.DataBind();
        }

        protected void newGroup_Click(object sender, EventArgs e)
        {
            if (GroupNameTBox.Text != "")
            {
                initCollections();
                var LoggedUser = (UsersModel)Session["UserDocument"];
                // Create a new GroupChat
                var newGroup = new GroupChatModel();
                newGroup.GroupName = GroupNameTBox.Text;
                newGroup.GroupAdmin = LoggedUser.Id;

                //There is an extremely small chance that a Link is repeated.
                //In which ase the database throws error.
                //Repeat until there is no error

                var isRepeat = true;
                while (isRepeat)
                {
                    try
                    {
                        //Link used to access Group Chat
                        newGroup.GroupLink = Utility.getRandomString(6);
                        ChatsCollection.InsertOne(newGroup);
                        isRepeat = false;
                    }
                    catch (Exception) { }
                }

                // Create filePath in which file name is Link of Group
                string filePath = Path.Combine(Server.MapPath("~/App_Data/GroupChats"), newGroup.GroupLink + ".json");
                // We do this new object[0] so that the only data inside the file is an
                // Empty array. 
                var data = new object[0];
                string JSON = JsonConvert.SerializeObject(data, Formatting.Indented);
                File.WriteAllText(filePath, JSON);

                var userFilter = Builders<UsersModel>.Filter.Eq(User => User.Id, LoggedUser.Id);
                var userUpdate = Builders<UsersModel>.Update.Push("PartOfGroups", newGroup.GroupLink);
                UsersCollection.FindOneAndUpdate(userFilter, userUpdate);

                var newChatsLst = (List<GroupChatModel>)Session["UserChats"];
                newChatsLst.Add(newGroup);
                Session["UserChats"] = newChatsLst;
                UpdateChatsLst();
                GroupNameTBox.Text = "";
            }
        }

        [WebMethod]
        public static string GetChatMessages(string RoomID)
        {
            return JsonConvert.SerializeObject(MessagesCache.GetMessagesForChat(RoomID));
        }

        [WebMethod]
        public static string RemoveUser(string UserID, string UserName, string RoomID)
        {

            var LoggedUser = (UsersModel)HttpContext.Current.Session["UserDocument"];
            var CurrentChat = (GroupChatModel)HttpContext.Current.Session["CurrentChat"];
            // Validate that request sender is Admin of the group
            if (String.Compare(LoggedUser.Id, CurrentChat.GroupAdmin) == 0)
            {
                string response = "";
                var DB = (IMongoDatabase)HttpContext.Current.Application["GlobeGlimpseDB"];
                var usersColleciton = DB.GetCollection<UsersModel>("Users");
                var chatsCollection = DB.GetCollection<GroupChatModel>("GroupChats");

                // Remove Current Group Link from User accessible Links
                var updateFilter = Builders<UsersModel>.Filter.Eq(DBUser => DBUser.Id, UserID);
                var updatePull = Builders<UsersModel>.Update.Pull(DBUser => DBUser.ChatsLst, RoomID);
                var result = usersColleciton.UpdateOne(updateFilter, updatePull);

                // Add User to Group BanList
                if (result.IsAcknowledged && result.ModifiedCount > 0)
                {
                    var BanFilter = Builders<GroupChatModel>.Filter.Eq(Group => Group.GroupLink, RoomID);
                    var BanUpdate = Builders<GroupChatModel>.Update.Push(Group => Group.BanList, UserID);
                    var finalRes = chatsCollection.UpdateOne(BanFilter, BanUpdate);
                    if (finalRes.IsAcknowledged && finalRes.ModifiedCount > 0)
                    {
                        response = "Banned " + UserName + " from Group";
                    }
                    else
                    {
                        response = "Could not ban " + UserName;
                    }
                }
                else
                {
                    response = "Could not ban " + UserName;
                }
                return response;
            }
            else
            {
                return "Invalid User Role";
            }
        }

        [WebMethod]
        public static string DeleteGroup(string RoomID)
        {
            var LoggedUser = (UsersModel)HttpContext.Current.Session["UserDocument"];
            var CurrentChat = (GroupChatModel)HttpContext.Current.Session["CurrentChat"];

            // Validate that request sender is Admin of the group
            if (String.Compare(LoggedUser.Id, CurrentChat.GroupAdmin) == 0)
            {
                string response = "";
                var DB = (IMongoDatabase)HttpContext.Current.Application["GlobeGlimpseDB"];
                var usersColleciton = DB.GetCollection<UsersModel>("Users");
                var chatCollection = DB.GetCollection<GroupChatModel>("GroupChats");

                // Move chat data to Archive
                var oldFilePath =
                    Path.Combine(HttpContext.Current.Server.MapPath("~/App_Data/GroupChats"), RoomID + ".json");
                var newFilePath =
                    Path.Combine(HttpContext.Current.Server.MapPath("~/App_Data/GroupChatsArchive"), RoomID + ".json");

                if (File.Exists(oldFilePath))
                {
                    File.Move(oldFilePath, newFilePath);
                }

                // Delete Groupchat from database
                chatCollection.DeleteOne(Chat => Chat.GroupLink == RoomID);

                // Remove Group reference from all users
                var updateFilter = Builders<UsersModel>.Filter.Where(Member => Member.ChatsLst.Contains(RoomID));
                var updatePull = Builders<UsersModel>.Update.Pull(DBUser => DBUser.ChatsLst, RoomID);

                var result = usersColleciton.UpdateMany(updateFilter, updatePull);

                if (result.IsAcknowledged && result.ModifiedCount > 0)
                {
                    response = "Deleted group";
                }
                else
                {
                    response = "Could not delete group";
                }
                return response;
            }
            else
            {
                return "Invalid User Role";
            }
        }

    }
}