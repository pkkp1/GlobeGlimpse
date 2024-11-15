using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;
using System.Collections.Generic;

namespace GGlimpse.DataModels
{
    public class UsersModel
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }

        [BsonElement("MailID")]
        public string UserMail { get; set; } = null;
        [BsonElement("Name")]
        public string UserName { get; set; } = null;
        [BsonElement("Salt")]
        public string UserSalt { get; set; } = null;

        [BsonElement("Hash")]
        public string UserHash { get; set; } = null;

        [BsonElement("PartOfGroups")]
        public List<string> ChatsLst { get; set; } = new List<string>();
    }
}