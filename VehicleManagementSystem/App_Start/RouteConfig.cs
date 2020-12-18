using System.Web.Mvc;
using System.Web.Routing;

namespace VehicleManagementSystem
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "CarsDisplay", id = UrlParameter.Optional }
            );
        }
    }
}
