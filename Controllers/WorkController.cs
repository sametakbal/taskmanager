using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using taskmanager.Filters;
using taskmanager.Interfaces;
using Microsoft.AspNetCore.Http;
using taskmanager.Models;
using System;

namespace taskmanager.Controllers
{
    [UserFilter]
    public class WorkController : Controller
    {
        private readonly IWorkRepository _repo;
        public WorkController(IWorkRepository repo)
        {
            _repo = repo;
        }

        public async Task<IActionResult> Index()
        {
            return View(await _repo.GetWorksAsync(HttpContext.Session.GetInt32("id").Value));
        }
        public async Task<IActionResult> Month()
        {
            return View(await _repo.GetMonthWorksAsync(HttpContext.Session.GetInt32("id").Value));
        }
        public async Task<IActionResult> Year()
        {
            return View(await _repo.GetYearWorksAsync(HttpContext.Session.GetInt32("id").Value));
        }
        public async Task<IActionResult> AllTime()
        {
            return View(await _repo.GetAllTimeWorksAsync(HttpContext.Session.GetInt32("id").Value));
        }

        public async Task<IActionResult> Done()
        {
            return View(await _repo.GetAllTimeDonedWorksAsync(HttpContext.Session.GetInt32("id").Value));
        }

        [NoDirectAccess]
        public async Task<IActionResult> AddOrEdit(int? id)
        {
            if (id.HasValue)
            {
                Work work = await _repo.GetWorkByIdAsync(id.Value);
                if (work != null)
                {
                    return View(work);
                }
            }
            return View(new Work());
        }
        public IActionResult Statistics()
        {
            return View();
        }
        public IActionResult Chart()
        {
            var result = _repo.GetStatistics(HttpContext.Session.GetInt32("id").Value);
            return Json(result);
        }

        [HttpPost]
        public async Task<IActionResult> Save(Work work)
        {
            if (ModelState.IsValid)
            {
                if (work.Id == 0)
                {
                    work.UserId = HttpContext.Session.GetInt32("id").Value;
                    await _repo.Create(work);
                }
                else
                {
                    await _repo.Update(work);
                }
            }
            DateTime today = DateTime.Now;

            if (work.GoalTime <= today.AddDays(7))
            {
                return Json(new { isValid = true, html = Helper.RenderRazorViewToString(this, "_ViewAll", await _repo.GetWorksAsync(HttpContext.Session.GetInt32("id").Value)) });
            }
            else if (work.GoalTime <= today.AddMonths(1))
            {
                return Json(new { isValid = true, html = Helper.RenderRazorViewToString(this, "_ViewAll", await _repo.GetMonthWorksAsync(HttpContext.Session.GetInt32("id").Value)) });
            }

            return Json(new { isValid = true, html = Helper.RenderRazorViewToString(this, "_ViewAll", await _repo.GetYearWorksAsync(HttpContext.Session.GetInt32("id").Value)) });
        }

        [HttpPost]
        public async Task<IActionResult> Delete(int id)
        {
            await _repo.Delete(id);
            return Json(new { html = Helper.RenderRazorViewToString(this, "_ViewAll", await _repo.GetWorksAsync(HttpContext.Session.GetInt32("id").Value)) });
        }
        [HttpPost]
        public async Task<IActionResult> Done(int id)
        {
            await _repo.Done(id);
            return Json(new { html = Helper.RenderRazorViewToString(this, "_ViewAll", await _repo.GetWorksAsync(HttpContext.Session.GetInt32("id").Value)) });
        }
    }
}