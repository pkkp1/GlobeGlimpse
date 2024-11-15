using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;
using System.Collections.Generic;

namespace GGlimpse.DataModels
{
    public class GroupChatModel
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }

        public string GroupName { get; set; } = null;
        public string GroupLink { get; set; } = null;

        [BsonElement("Admin")]
        public string GroupAdmin { get; set; } = null;
        [BsonElement("BannedUsers")]
        public List<string> BanList { get; set; } = new List<string>();
    }
}