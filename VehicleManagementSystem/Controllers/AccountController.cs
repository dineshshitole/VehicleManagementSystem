using System.Linq;
using System.Web.Mvc;
using System.Web.Security;
using VehicleManagementSystem.Models;

namespace VehicleManagementSystem.Controllers
{
    public class AccountController : Controller
    {
        private readonly VMSEntities _dbContext = new VMSEntities();
        /// <summary>
        /// This is the login method of get type
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        /// <summary>
        /// This method takes user parameter and checks it with the database
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(User user)
        {
            bool IsValidUser = _dbContext.Users
           .Any(u => u.Username.ToLower() == user
           .Username.ToLower() &&
           u.Password == user.Password);

            if (IsValidUser)
            {
                FormsAuthentication.SetAuthCookie(user.Username, false);
                return RedirectToAction("CarsDisplay", "Home");
            }
            else
            {
                ModelState.AddModelError("CustomError", "The username or password is incorrect");
                return View();
            }
        }

        /// <summary>
        /// This is the logout method that clears the formauthentication
        /// </summary>
        /// <returns></returns>
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }
    }
}