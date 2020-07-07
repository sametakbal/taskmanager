using Microsoft.AspNetCore.Mvc;
using taskmanager.Interfaces;

namespace taskmanager.Controllers
{
    public class WorkController : Controller
    {
        private readonly IWorkRepository _repo;
        public WorkController(IWorkRepository repo)
        {
            _repo = repo;
        }
    }
}