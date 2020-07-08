using System.IO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.AspNetCore.Mvc.ViewFeatures;

public class Helper {
  
  public static string RenderRazorViewToString(Controller controller, string viewName, object model = null)
  {
    controller.ViewData.Model = model;
    using (var sw = new StringWriter())
    {
        IViewEngine viewEngine = controller.HttpContext.RequestServices.GetService(typeof(ICompositeViewEngine)) as ICompositeViewEngine;
        ViewEngineResult viewResult = viewEngine.FindView(controller.ControllerContext, viewName, false);

        ViewContext viewContext = new ViewContext(
            controller.ControllerContext,
            viewResult.View,
            controller.ViewData,
            controller.TempData,
            sw,
            new HtmlHelperOptions()
        );
        viewResult.View.RenderAsync(viewContext);
        return sw.GetStringBuilder().ToString();
    }
  }

}