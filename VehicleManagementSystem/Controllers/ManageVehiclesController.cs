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
    public class ManageVehiclesController : Controller
    {
        private readonly VMSEntities db = new VMSEntities();

        /// <summary>
        /// This method generates a search result based on the input given
        /// </summary>
        /// <param name="searchBy"></param>
        /// <param name="search"></param>
        /// <param name="page"></param>
        /// <returns></returns>                
        public ActionResult Index(string searchBy, string search, int? page)
        {
            if (searchBy == "ModelName")
            {
                return View(db.Vehicles.Where(a => a.ModelName == search || search == null).ToList().ToPagedList(page ?? 1, 4));
            }
            else
            {
                return View(db.Vehicles.Where(a => a.CompanyName == search || search == null).ToList().ToPagedList(page ?? 1, 4));
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
            List<Vehicle> list = new List<Vehicle>();
            list = db.Vehicles.Where(x => employeeIdsToDelete.Contains(x.Id)).ToList();
            foreach (Vehicle item in list)
            {
                var saleId = (from x in db.Sales where x.VehicleId == item.Id select x).FirstOrDefault();
                if (saleId != null)
                {
                    db.Sales.Remove(saleId);
                }
                db.Vehicles.Remove(item);
            }
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        /// <summary>
        /// It is a get method for create
        /// </summary>
        /// <returns></returns>
        public ActionResult Create()
        {
            return View();
        }

        /// <summary>
        /// This is a create method for Vehicle
        /// </summary>
        /// <param name="vehicle"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,SerialNumber,CompanyName,ModelName,AddedOn,ShowroomPrice,Description")] Vehicle vehicle)
        {
            if (ModelState.IsValid)
            {
                db.Vehicles.Add(vehicle);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(vehicle);
        }

        /// <summary>
        /// This is an edit action
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Vehicle vehicle = db.Vehicles.Find(id);
            if (vehicle == null)
            {
                return HttpNotFound();
            }
            return View(vehicle);
        }

        /// <summary>
        /// This is an edit action on database
        /// </summary>
        /// <param name="vehicle"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,SerialNumber,CompanyName,ModelName,AddedOn,ShowroomPrice,Description")] Vehicle vehicle)
        {
            if (ModelState.IsValid)
            {
                db.Entry(vehicle).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(vehicle);
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
