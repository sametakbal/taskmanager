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
                return Json(false);
            }
            HttpContext.Session.SetInt32("id", user.Id);
            return Redirect("/Work/Index");
        }

        [HttpPost]
        public async Task<IActionResult> Signup(User user)
        {
            await _userRepo.Create(user);
            return Redirect("/Account/Index");
        }


    }
}