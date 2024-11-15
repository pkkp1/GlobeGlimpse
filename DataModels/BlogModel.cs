using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GGlimpse.DataModels
{
    public class BlogModel
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string id { get; set; } = null;

        public string Title { get; set; } = null;
        public string Post {  get; set; } = null;
        public List<string> Images { get; set; } = new List<string>();
    }
}