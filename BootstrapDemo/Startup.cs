using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BootstrapDemo.Startup))]
namespace BootstrapDemo
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
