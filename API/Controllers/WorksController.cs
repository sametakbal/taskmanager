using System;
using System.Threading.Tasks;
using Core.Entities;
using Core.Interfaces;
using Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class WorksController : BaseApiController
    {
        private readonly IWorkRepository _repo;
        public WorksController(IWorkRepository repo)
        {
            _repo = repo;
        }
        [HttpGet]
        public async Task<ActionResult> GetAllWorks()
        {
            return Ok(await _repo.GetWorkAsync());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult> GetWork(int id)
        {
            return Ok(await _repo.GetWorksByIdAsync(id));
        }

        [HttpPost("add")]
        public async Task<ActionResult> AddWork(Work work)
        {
            return Ok(await _repo.AddWorkAsync(work));
        }

        [HttpDelete("delete/{id}")]
        public async Task<ActionResult> DeleteWork(int id)
        {
            return Ok(await _repo.DeleteWorkAsync(id));
        }

        [HttpPost("update")]
        public async Task<ActionResult> UpdateWork(Work work)
        {
            return Ok(await _repo.UpdateWorkAsync(work));
        }
    }
}