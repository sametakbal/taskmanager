using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using taskmanager.Infrastructure;
using taskmanager.Interfaces;
using taskmanager.Models;

namespace taskmanager.Controllers
{
    public class AccountController : Controller
    {
        private readonly IUserRepository _userRepo;

        public AccountController(IUserRepository userRepo)
        {
            _userRepo = userRepo;
        }

        public IActionResult Index()
        {
            int? userId =HttpContext.Session.GetInt32("id");
            if(userId.HasValue){
                return Redirect("/Work/Index");
            }
            return View();
        }
        public IActionResult Register()
        {
            return View(new User());
        }
        [HttpPost]
        public async Task<IActionResult> Login(string email, string password)
        {
            var user = await _userRepo.GetUserByEmailAndPassword(email, password);
            if (user == null)
            {
                return Json(new { loginerror = true });
            }

            HttpContext.Session.SetInt32("id", user.Id);
            return Json(new { loginerror = false });
        }

        [HttpPost]
        public async Task<IActionResult> Signup(User user)
        {
            await _userRepo.Create(user);
            return Redirect("/Account/Index");
        }

        public IActionResult Logout(){
            HttpContext.Session.Clear();
            return RedirectToAction("Index");
        }


    }
}