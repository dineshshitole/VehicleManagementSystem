using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using VehicleManagementSystem.Models;

namespace VehicleManagementSystem.Controllers
{
    [Authorize(Roles = "Admin")]
    public class QuotationsController : Controller
    {
        private readonly VMSEntities db = new VMSEntities();

        /// <summary>
        /// This index method displays the  list on view
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            var quotations = db.Quotations.Include(q => q.Vehicle).Include(q => q.Visitor);
            return View(quotations.ToList());
        }

        /// <summary>
        /// This edit method has get action for edit
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Quotation quotation = db.Quotations.Find(id);
            if (quotation == null)
            {
                return HttpNotFound();
            }
            ViewBag.VehicleId = new SelectList(db.Vehicles, "Id", "SerialNumber", quotation.VehicleId);
            ViewBag.VisitorId = new SelectList(db.Visitors, "Id", "Name", quotation.VisitorId);
            return View(quotation);
        }

        /// <summary>
        /// This method performs edit action on the database
        /// </summary>
        /// <param name="quotation"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,VisitorId,VehicleId")] Quotation quotation)
        {
            if (ModelState.IsValid)
            {
                db.Entry(quotation).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.VehicleId = new SelectList(db.Vehicles, "Id", "SerialNumber", quotation.VehicleId);
            ViewBag.VisitorId = new SelectList(db.Visitors, "Id", "Name", quotation.VisitorId);
            return View(quotation);
        }
        
        /// <summary>
        /// This is a delete method of get type
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Quotation quotation = db.Quotations.Find(id);
            if (quotation == null)
            {
                return HttpNotFound();
            }
            return View(quotation);
        }
        
        /// <summary>
        /// This method performs delete action on the database
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Quotation quotation = db.Quotations.Find(id);
            db.Quotations.Remove(quotation);
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
