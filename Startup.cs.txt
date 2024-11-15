using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(ChatAppCS.Startup))]

namespace ChatAppCS
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.MapSignalR();
        }
    }
}
