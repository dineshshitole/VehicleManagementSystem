using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using VehicleManagementSystem.Models;

namespace VehicleManagementSystem.Controllers
{
    [Authorize(Roles = "Admin")]
    public class SalesController : Controller
    {
        private readonly VMSEntities db = new VMSEntities();

        /// <summary>
        /// This is an index method for displaying the Sales data
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            var sales = db.Sales.Include(s => s.User).Include(s => s.Vehicle);
            return View(sales.ToList());
        }

        /// <summary>
        /// This is a create method for get action
        /// </summary>
        /// <returns></returns>
        public ActionResult Create()
        {
            ViewBag.UserId = new SelectList(db.Users, "Id", "Username");
            ViewBag.VehicleId = new SelectList(db.Vehicles, "Id", "ModelName");
            return View();
        }

        /// <summary>
        /// This method saves the sale parameter to the database
        /// </summary>
        /// <param name="sale"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,VehicleId,UserId,DateOfPurchase")] Sale sale)
        {
            if (ModelState.IsValid)
            {
                db.Sales.Add(sale);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserId = new SelectList(db.Users, "Id", "Username", sale.UserId);
            ViewBag.VehicleId = new SelectList(db.Vehicles, "Id", "ModelName", sale.Vehicle.ModelName);
            return View(sale);
        }

        /// <summary>
        /// This method is an edit action
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sale sale = db.Sales.Find(id);
            if (sale == null)
            {
                return HttpNotFound();
            }
            ViewBag.UserId = new SelectList(db.Users, "Id", "Username", sale.UserId);
            ViewBag.VehicleId = new SelectList(db.Vehicles, "Id", "SerialNumber", sale.VehicleId);
            return View(sale);
        }

        /// <summary>
        /// This edit method takes edit method to the database
        /// </summary>
        /// <param name="sale"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,VehicleId,UserId,DateOfPurchase")] Sale sale)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sale).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.UserId = new SelectList(db.Users, "Id", "Username", sale.UserId);
            ViewBag.VehicleId = new SelectList(db.Vehicles, "Id", "SerialNumber", sale.VehicleId);
            return View(sale);
        }

        /// <summary>
        /// This is a delete method that takes an id as an parameter
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Sale sale = db.Sales.Find(id);
            if (sale == null)
            {
                return HttpNotFound();
            }
            return View(sale);
        }

        /// <summary>
        /// This is a confirmation method for the delete action
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Sale sale = db.Sales.Find(id);
            db.Sales.Remove(sale);
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
