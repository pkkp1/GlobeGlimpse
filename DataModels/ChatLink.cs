using System.Collections.Generic;

namespace GGlimpse.DataModels
{
    public class ChatLink
    {
        public string GroupName { get; set; } = null;
        public string GroupLink { get; set; } = null;
        public List<string> Users { get; set; } = new List<string>();

        public ChatLink() { }
        public ChatLink(string groupName, string groupLink, List<string> Users)
        {
            GroupName = groupName;
            GroupLink = groupLink;
            this.Users = Users;
        }
    }
}