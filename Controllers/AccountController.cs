using Microsoft.AspNetCore.Mvc;

namespace taskmanager.Controllers
{
    public class AccountController : Controller
    {
        public IActionResult Index() {
            return View();
        }
    }
}