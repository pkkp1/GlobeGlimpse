using ChatAppCS.SignalR_src;
using System;
using System.Web.Caching;
using System.Collections.Generic;
using System.IO;
using System.Web;
using Newtonsoft.Json;

namespace ChatAppCS
{
    // Class is static as it is centralized cache manager and doesn't require instances
    // to be made
    public static class MessagesCache
    {
        public static string filesDir = null;

        public static IList<ChatMessage> GetMessagesForChat(string GroupID)
        {
            // Try to get messages from the cache
            var messages = HttpRuntime.Cache.Get(GroupID) as List<ChatMessage>;

            if (messages != null)
            {
                return messages;
            }

            // If not found in the cache, retrieve messages from the .json file
            messages = LoadChatData(GroupID);

            // Cache the messages
            HttpRuntime.Cache.Insert(
                GroupID,
                messages,
                null,  // Cache dependency (can be null)
                Cache.NoAbsoluteExpiration,  // Cache has no absolute expiration
                TimeSpan.FromSeconds(30),     // Cache has 30 second refresh timer
                CacheItemPriority.Default,   // Cache item priority
                WriteToJson                  // Cache expired/item removed callback
            );

            return messages;
        }

        private static List<ChatMessage> LoadChatData(string GroupID)
        {
            var messages = new List<ChatMessage>();
            var filePath = Path.Combine(filesDir, GroupID + ".json");
            var jsonData = File.ReadAllText(filePath);
            // Deserialize the JSON data into a C# object
            var allMessages = JsonConvert.DeserializeObject<List<ChatMessage>>(jsonData) ?? new List<ChatMessage>();

            if (allMessages.Count < 100)
            {
                messages = allMessages;
            }
            else
            {
                messages = allMessages.GetRange(allMessages.Count - 101, 100);
            }

            return messages;
        }

        public static void AddMessageToCache(ChatMessage msg, string GroupID)
        {
            // Retrieve the existing messages for the chat from the cache
            var cachedMessages = HttpRuntime.Cache.Get(GroupID) as IList<ChatMessage>;

            if (cachedMessages == null)
            {
                // If not found in the cache, retrieve messages from the .json file
                cachedMessages = LoadChatData(GroupID);
            }

            // Add the new message to the list of messages
            cachedMessages.Add(msg);

            // Update the cache with the modified list of messages
            HttpRuntime.Cache.Insert(
                GroupID,
                cachedMessages,
                null,               // Cache dependency data (can be null)
                Cache.NoAbsoluteExpiration,  // Cache has no absolute expiration
                TimeSpan.FromSeconds(30),     // Cache has 30 second refresh timer
                CacheItemPriority.Default,   // Cache item priority
                WriteToJson                  // Cache item expired/removed callback
            );
        }


        // key:     GroupLink in it which also corresponds to filename
        // value:   Value of cache item at time of expiration
        // reason:  Reason the cache item was removed ( expired, underused, etc. )
        private static void WriteToJson(string key, object value, CacheItemRemovedReason reason)
        {
            if (reason == CacheItemRemovedReason.Expired)
            {
                var fileName = key + ".json";
                var filePath = Path.Combine(filesDir, fileName);

                // Read the JSON data from the file
                var jsonData = File.ReadAllText(filePath);

                // Deserialize the JSON data into a C# object
                var messages = JsonConvert.DeserializeObject<List<ChatMessage>>(jsonData) ?? new List<ChatMessage>();

                // Extract new messages from cache
                var newMessages = (List<ChatMessage>)value;
                foreach (var msg in newMessages)
                {
                    messages.Add(msg);
                }
                // Serialize updated data to JSON data
                var updatedData = JsonConvert.SerializeObject(messages);

                // Write the updated JSON data back to the file
                File.WriteAllText(filePath, updatedData);
            }
        }
    }
}