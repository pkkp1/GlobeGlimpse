using GGlimpse.DataModels;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Caching;
using MongoDB.Driver;
using ChatAppCS;
using ChatAppCS.Hubs;
using System.IO;
using Newtonsoft.Json;

namespace GGlimpse
{
    public class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            InitCountries();
            // Connect to database
            var Client = new MongoClient("mongodb+srv://Admin:Admin_Kunal@demo-cluster.jurs58l.mongodb.net/?retryWrites=true&w=majority");
            var DB = Client.GetDatabase("GlobeGlimpse");

            // Give absolute path of GroupChats Dir to MessagesCache
            MessagesCache.filesDir = Server.MapPath("~/App_Data/GroupChats");

            // Store connection at application level
            Application["GlobeGlimpseDB"] = DB;

            // Initialize BanList for ChatHub
            var ChatsCollection = DB.GetCollection<GroupChatModel>("GroupChats");
            var ChatsLst = ChatsCollection.Find(exists => true).ToList();
            foreach (var Chat in ChatsLst)
            {
                ChatHub.BanList.Add(Chat.GroupLink, Chat.BanList);
                ChatHub.GroupAdmins.Add(Chat.GroupLink, Chat.GroupAdmin);
            }
        }

        protected void InitCountries()
        {
            Dictionary<string, Country> countryLst = new Dictionary<string, Country>();

            var jsonObj = File.ReadAllText(Server.MapPath("~/App_Data/countries_packages.json"));

            countryLst = JsonConvert.DeserializeObject<Dictionary<string, Country>>(jsonObj);

            // Country Code: country name, country description
            var countryDic = new Dictionary<string, Tuple<string, string>>();

            foreach (var country in countryLst)
            {
                countryDic.Add(
                    country.Key,
                    new Tuple<string, string>(
                        country.Value.country, country.Value.description
                    )
                );

                // Cache for tours on individual countries
                HttpRuntime.Cache.Insert(
                    "Country_" + country.Key,
                    country.Value,
                    null,
                    Cache.NoAbsoluteExpiration,
                    Cache.NoSlidingExpiration,
                    CacheItemPriority.AboveNormal,
                    null
                );
            }

            // Cache for general data on individual countries
            HttpRuntime.Cache.Insert(
                "countries",
                countryDic,
                null,
                Cache.NoAbsoluteExpiration,
                Cache.NoSlidingExpiration,
                CacheItemPriority.AboveNormal,
                null
            );
        }
    }
}