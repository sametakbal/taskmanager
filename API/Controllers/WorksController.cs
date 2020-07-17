using System;
using System.Threading.Tasks;
using Core.Entities;
using Core.Interfaces;
using Infrastructure.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Authorize]
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
        public async Task<ActionResult> GetAllWorks(int? id)
        {
            if (!id.HasValue)
            {
                return BadRequest();
            }
            return Ok(await _repo.GetWorksAsync(id.Value));
        }
        [HttpGet("getMonth")]
        public async Task<ActionResult> GetAllMonthWorks(int? id)
        {
            if (!id.HasValue)
            {
                return BadRequest();
            }
            return Ok(await _repo.GetMonthWorksAsync(id.Value));
        }
        [HttpGet("getYear")]
        public async Task<ActionResult> GetAllYearWorks(int? id)
        {
            if (!id.HasValue)
            {
                return BadRequest();
            }
            return Ok(await _repo.GetYearWorksAsync(id.Value));
        }

        [HttpGet("getDone")]
        public async Task<ActionResult> GetAllDoneWorks(int? id)
        {
            if (!id.HasValue)
            {
                return BadRequest();
            }
            return Ok(await _repo.GetDoneWorksAsync(id.Value));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult> GetWork(int id)
        {
            return Ok(await _repo.GetWorksByIdAsync(id));
        }

        [HttpGet("assign")]
        public async Task<ActionResult> AssignWork(int id, int personid)
        {
            return Ok(await _repo.AssignWork(id, personid));
        }
         [HttpGet("backAssign")]
        public async Task<ActionResult> BackAssignWork(int id)
        {
            return Ok(await _repo.BackAssignWork(id));
        }
        [HttpGet("getAssignedWork")]
        public async Task<ActionResult> GetAssignedWork(int id, int personid)
        {
            return Ok(await _repo.GetAssignedWorks(id, personid));
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

        [HttpGet("done")]
        public async Task<ActionResult> Done(int id)
        {
            return Ok(await _repo.WorkDone(id));
        }
    }
}