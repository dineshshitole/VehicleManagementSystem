using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using VehicleManagementSystem.Models;

namespace VehicleManagementSystem.Controllers
{
    [Authorize(Roles = "Admin")]
    public class UserRoleMappingsController : Controller
    {
        private readonly VMSEntities db = new VMSEntities();

        /// <summary>
        /// This index method displays the user roles to the view
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            var userRoleMappings = db.UserRoleMappings.Include(u => u.Role).Include(u => u.User);
            return View(userRoleMappings.ToList());
        }

        /// <summary>
        /// This is a create method with get action
        /// </summary>
        /// <returns></returns>
        public ActionResult Create()
        {
            ViewBag.RoleId = new SelectList(db.Roles, "Id", "RoleName");
            ViewBag.UserId = new SelectList(db.Users, "Id", "Username");
            return View();
        }

        /// <summary>
        /// This is a create method that takes a parameter 
        /// </summary>
        /// <param name="userRoleMapping"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,UserId,RoleId")] UserRoleMapping userRoleMapping)
        {
            if (ModelState.IsValid)
            {
                db.UserRoleMappings.Add(userRoleMapping);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.RoleId = new SelectList(db.Roles, "Id", "RoleName", userRoleMapping.RoleId);
            ViewBag.UserId = new SelectList(db.Users, "Id", "Username", userRoleMapping.UserId);
            return View(userRoleMapping);
        }

        /// <summary>
        /// This is an edit action that takes the id parameter to the database
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserRoleMapping userRoleMapping = db.UserRoleMappings.Find(id);
            if (userRoleMapping == null)
            {
                return HttpNotFound();
            }
            ViewBag.RoleId = new SelectList(db.Roles, "Id", "RoleName", userRoleMapping.RoleId);
            ViewBag.UserId = new SelectList(db.Users, "Id", "Username", userRoleMapping.UserId);
            return View(userRoleMapping);
        }

        /// <summary>
        /// This edit action update the database
        /// </summary>
        /// <param name="userRoleMapping"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,UserId,RoleId")] UserRoleMapping userRoleMapping)
        {
            if (ModelState.IsValid)
            {
                db.Entry(userRoleMapping).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.RoleId = new SelectList(db.Roles, "Id", "RoleName", userRoleMapping.RoleId);
            ViewBag.UserId = new SelectList(db.Users, "Id", "Username", userRoleMapping.UserId);
            return View(userRoleMapping);
        }

        /// <summary>
        /// This delete method takes id as a parameter
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserRoleMapping userRoleMapping = db.UserRoleMappings.Find(id);
            if (userRoleMapping == null)
            {
                return HttpNotFound();
            }
            return View(userRoleMapping);
        }

        /// <summary>
        /// This delete method finalises the delete action
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>       
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            UserRoleMapping userRoleMapping = db.UserRoleMappings.Find(id);
            db.UserRoleMappings.Remove(userRoleMapping);
            db.SaveChanges();
            return RedirectToAction("Index");
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
