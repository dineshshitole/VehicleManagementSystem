using System.Linq;
using System.Web.Mvc;
using VehicleManagementSystem.Models;

namespace VehicleManagementSystem.Controllers
{
    [Authorize(Roles = "Client")]
    public class ClientController : Controller
    {
        private readonly VMSEntities _dbContext = new VMSEntities();

        /// <summary>
        /// The ClientCar method displays a list of cars to the view
        /// </summary>
        /// <returns></returns>        
        public ActionResult ClientCar()
        {
            return View(_dbContext.Sales.Where(a => a.User.Username == User.Identity.Name).ToList());
        }
    }
}