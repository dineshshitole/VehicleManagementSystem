using System;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace VehicleManagementSystem
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        public void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs
            Exception ex = Server.GetLastError();
            LogError(ex, HttpContext.Current.Request.Path);
            Server.ClearError();
        }

        public void LogError(Exception ex, String source)
        {
            try
            {
                String LogFile = HttpContext.Current.Request.MapPath("/Errorlog.txt");
                if (LogFile != "")
                {
                    String Message = String.Format("{0}{0}=== {1} ==={0}{2}{0}{3}{0}{4}{0}{5}"
                             , Environment.NewLine
                             , DateTime.Now
                             , ex.Message
                             , source
                             , ex.InnerException
                             , ex.StackTrace);
                    byte[] binLogString = Encoding.Default.GetBytes(Message);

                    System.IO.FileStream loFile = new System.IO.FileStream(LogFile
                              , System.IO.FileMode.OpenOrCreate
                              , System.IO.FileAccess.Write, System.IO.FileShare.Write);
                    loFile.Seek(0, System.IO.SeekOrigin.End);
                    loFile.Write(binLogString, 0, binLogString.Length);
                    loFile.Close();
                }
            }
            catch { /*No need to catch the error here. */}
        }
    }
}
