using System;

namespace ChatAppCS.SignalR_src
{
    public class ChatMessage
    {
        public ChatMessage() { 
        
        }
        public ChatMessage(string UserName, string Message, DateTime dateTime)
        {
            this.UserName = UserName;
            this.Message = Message;
            this.TimeStamp = dateTime;
        }

        public string UserName { get; set; } = null;
        public string Message { get; set; } = null;
        public DateTime TimeStamp { get; set; } = new DateTime();
        
    }
}