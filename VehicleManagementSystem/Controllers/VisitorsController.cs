using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using VehicleManagementSystem.Models;

namespace VehicleManagementSystem.Controllers
{
    public class VisitorsController : Controller
    {
        private readonly VMSEntities db = new VMSEntities();

        /// <summary>
        /// This index method displays the list of the visitors
        /// </summary>
        /// <returns></returns>
        [Authorize(Roles = "Admin")]
        public ActionResult Index()
        {
            return View(db.Visitors.ToList());
        }

        /// <summary>
        /// This is a get action for create method
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Create()
        {
            return View();
        }

        /// <summary>
        /// This create method sends the data to the database
        /// </summary>
        /// <param name="visitor"></param>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Name,DateOfVisit,City,Email")] Visitor visitor, int id)
        {
            if (ModelState.IsValid)
            {
                db.Visitors.Add(visitor);
                db.SaveChanges();
                return RedirectToAction("GenerateQuote","Home",new { visitorId = visitor.Id, vehicleId = id });               
            }
            return View(visitor);
        }

        /// <summary>
        /// It takes an id parameter to get the record from the database
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize(Roles = "Admin")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Visitor visitor = db.Visitors.Find(id);
            if (visitor == null)
            {
                return HttpNotFound();
            }
            return View(visitor);
        }

        /// <summary>
        /// This action edits the particular record in the database
        /// </summary>
        /// <param name="visitor"></param>
        /// <returns></returns>
        [Authorize(Roles = "Admin")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Name,DateOfVisit,City,Email")] Visitor visitor)
        {
            if (ModelState.IsValid)
            {
                db.Entry(visitor).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(visitor);
        }

        /// <summary>
        /// This action gets the id of the record to the deleted
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Visitor visitor = db.Visitors.Find(id);
            if (visitor == null)
            {
                return HttpNotFound();
            }
            return View(visitor);
        }

        /// <summary>
        /// This is a confirm delete method
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize(Roles = "Admin")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Visitor visitor = db.Visitors.Find(id);
            db.Visitors.Remove(visitor);
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
