using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using taskmanager.Interfaces;
using taskmanager.Models;

namespace taskmanager.Controllers
{
    public class WorkController : Controller
    {
        private readonly IWorkRepository _repo;
        public WorkController(IWorkRepository repo)
        {
            _repo = repo;
        }

        public async Task<IActionResult> Index()
        {
            return View(await _repo.GetWorksAsync(0));
        }

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

        [HttpPost]
        public async Task<IActionResult> Save(Work work){
            if(ModelState.IsValid){
                if(work.Id == 0){
                    await _repo.Create(work);
                }else {
                    await _repo.Update(work);
                }
            }
            return Json(new {isValid=true, html = Helper.RenderRazorViewToString(this,"_ViewAll",await _repo.GetWorksAsync(1))});
        }

        [HttpPost]
        public async Task<IActionResult> Delete(int id){
            await _repo.Delete(id);
            return Json(new {html = Helper.RenderRazorViewToString(this,"_ViewAll",await _repo.GetWorksAsync(1))});
        }
    }
}