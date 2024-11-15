using ChatAppCS.SignalR_src;
using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;

namespace ChatAppCS.Hubs
{
    public class ChatHub : Hub
    {

        // Group: (UserID: ConnectionStr)
        public static Dictionary<string, Dictionary<string, string>> connectionsLst = new Dictionary<string, Dictionary<string, string>>();
        public static Dictionary<string,List<string>> BanList = new Dictionary<string, List<string>>();
        public static Dictionary<string, string> GroupAdmins = new Dictionary<string, string>();
        public void SendMessage(string GroupID, string UserName, string Msg, string UserID)
        {
            // If user is not banned
            if (!BanList[GroupID].Contains(UserID))
            {
                DateTime Timesent = DateTime.Now;
                Clients.Group(GroupID).recieveMessage(UserName, Msg, Timesent);

                var msg = new ChatMessage(UserName, Msg, Timesent);
                MessagesCache.AddMessageToCache(msg, GroupID);
            }
        }

        public void NewUserJoined(string RoomID, string NewUser, string newUserID)
        {
            DateTime Timesent = DateTime.Now;
            var sysmsg = NewUser + " has joined the chat";
            Clients.Group(RoomID).recieveMessage("system", sysmsg, Timesent);
            Clients.Group(RoomID).addUserToMembers(NewUser, newUserID);
            var msg = new ChatMessage("system", sysmsg, Timesent);
            MessagesCache.AddMessageToCache(msg, RoomID);
        }

        public void JoinRoom(string RoomID, string UserID)
        {
            // If user isn't banned
            if (!BanList[RoomID].Contains(UserID)){
                // If group hasn't been initialized, initialize it
                if (!connectionsLst.ContainsKey(RoomID))
                {
                    connectionsLst.Add(RoomID, new Dictionary<string, string>());
                }

                // If same User is accessing the group
                if (connectionsLst[RoomID].ContainsKey(UserID))
                {
                    // Remove old connectionId
                    Groups.Remove(connectionsLst[RoomID][UserID], RoomID);
                    Groups.Add(Context.ConnectionId, RoomID);

                    // Update ConnectionId in Dicitonary
                    connectionsLst[RoomID][UserID] = Context.ConnectionId;
                }
                else //If new user is accessing the group
                {
                    Groups.Add(Context.ConnectionId, RoomID);

                    // Add user to group
                    connectionsLst[RoomID].Add(UserID, Context.ConnectionId);
                }
            }
        }
        public void BanUser(string RoomID, string RoomName, string RemovalUserID)
        {
            var connection = connectionsLst[RoomID][RemovalUserID];
            Clients.Client(connection).bannedFromGroup(RoomName);
            Groups.Remove(connection, RoomID);
            // Add to BanList
            BanList[RoomID].Add(RemovalUserID);
            connectionsLst[RoomID].Remove(RemovalUserID);
        }

    }
}