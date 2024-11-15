using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace GGlimpse.DataModels
{
    public class UserResponses
    {
        public UserResponses() { }
        public UserResponses(string uName, string uMail,string Contact, string res) { 
            Name = uName;
            Email = uMail;
            ContactNo = Contact;
            Response = res;
        }

        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; } = null;

        [BsonElement("SenderName")]
        public string Name { get; set; } = null;
        [BsonElement("SenderContact")]
        public string ContactNo { get; set; } = null;
        [BsonElement("SenderMail")]
        public string Email { get; set; } = null;
        [BsonElement("Response")]
        public string Response { get; set; } = null;
    }
}