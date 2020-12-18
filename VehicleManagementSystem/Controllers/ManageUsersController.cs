using PagedList;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using VehicleManagementSystem.Models;

namespace VehicleManagementSystem.Controllers
{
    [Authorize(Roles = "Admin")]
    public class ManageUsersController : Controller
    {
        private readonly VMSEntities db = new VMSEntities();

        /// <summary>
        /// This method takes in search parameters and displays the result to the viewer
        /// </summary>
        /// <param name="searchBy"></param>
        /// <param name="search"></param>
        /// <param name="page"></param>
        /// <returns></returns>
        public ActionResult Index(string searchBy, string search, int? page)
        {
            if (searchBy == "Name")
            {
                return View(db.Users.Where(a => a.Name == search || search == null).ToList().ToPagedList(page ?? 1, 4));
            }
            else
            {
                return View(db.Users.Where(a => a.City == search || search == null).ToList().ToPagedList(page ?? 1, 4));
            }
        }

        /// <summary>
        /// This delete method is used to delete the selected rows
        /// </summary>
        /// <param name="employeeIdsToDelete"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Delete(IEnumerable<int> employeeIdsToDelete)
        {
            List<User> list = new List<User>();
            list = db.Users.Where(x => employeeIdsToDelete.Contains(x.Id)).ToList();
            foreach (User item in list)
            {
                var saleId = (from x in db.Sales where x.UserId == item.Id select x).FirstOrDefault();
                var userRoleId = (from x in db.UserRoleMappings where x.UserId == item.Id select x).FirstOrDefault();

                if(saleId != null)
                {
                    db.Sales.Remove(saleId);
                }
                if(userRoleId != null)
                {
                    db.UserRoleMappings.Remove(userRoleId);
                }                               
                db.Users.Remove(item);
            }
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        /// <summary>
        /// This is a get method for create
        /// </summary>
        /// <returns></returns>
        public ActionResult Create()
        {
            return View();
        }

        /// <summary>
        /// This is a post method for create
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Username,Password,Name,City,Email")] User user)
        {
            if (ModelState.IsValid)
            {

                db.Users.Add(user);
                UserRoleMapping role = new UserRoleMapping();     //Create a new user with a client role
                role.RoleId = 2;
                role.UserId = user.Id;
                db.UserRoleMappings.Add(role);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }

        /// <summary>
        /// this is an edit action, it get the id.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }

            return View(user);
        }

        /// <summary>
        /// This method edits the selected entry
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Username,Password,Name,Gender,Age,City,Email")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }


        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
