using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using VehicleManagementSystem.Models;

namespace VehicleManagementSystem.Controllers
{
    [AllowAnonymous]
    public class HomeController : Controller
    {
        private readonly VMSEntities _dbContext = new VMSEntities();

        /// <summary>
        /// It displays the list of vehicles
        /// </summary>
        /// <returns></returns>
        public ActionResult CarsDisplay()
        {
            return View(_dbContext.Vehicles.ToList());
        }

        /// <summary>
        /// This method takes an id parameter and generates a quotation
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult GenerateQuote(int visitorId,int vehicleId)
        {
            var isQuotePresent = _dbContext.Quotations.Where(a => a.VisitorId == visitorId).ToList();
            if(isQuotePresent.Count != 0)
            {
                var quoteDetails = _dbContext.Quotations.Where(a => a.VehicleId == vehicleId && a.VisitorId == visitorId).Include(a => a.Vehicle).Include(a => a.Visitor);
                return View(quoteDetails.ToList());
            }
            else
            {
                Quotation quote = new Quotation();
                quote.VehicleId = vehicleId;
                quote.VisitorId = visitorId;
                _dbContext.Quotations.Add(quote);
                _dbContext.SaveChanges();
                var quoteDetails = _dbContext.Quotations.Where(a => a.VehicleId == vehicleId && a.VisitorId == visitorId).Include(a => a.Vehicle).Include(a => a.Visitor);
                return View(quoteDetails.ToList());
            }                       
        }

        /// <summary>
        /// It takes grid html as an parameter and genrate a pdf
        /// </summary>
        /// <param name="GridHtml"></param>
        /// <returns></returns>
        [HttpPost]
        [ValidateInput(false)]
        public FileResult Export(string GridHtml)
        {
            using (MemoryStream stream = new MemoryStream())
            {
                StringReader sr = new StringReader(GridHtml);
                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, stream);
                pdfDoc.Open();
                XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
                pdfDoc.Close();
                return File(stream.ToArray(), "application/pdf", "Quotation.pdf");                
            }
        }

        /// <summary>
        /// Displays the information about site
        /// </summary>
        /// <returns></returns>
        public ActionResult About()
        {
            return View();
        }

        /// <summary>
        /// Consists of a view that shows a contact card
        /// </summary>
        /// <returns></returns>
        public ActionResult Contact()
        {
            return View();
        }
    }
}