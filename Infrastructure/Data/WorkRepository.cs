using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Core.Dtos;
using Core.Entities;
using Core.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data
{
    public class WorkRepository : IWorkRepository
    {
        private readonly DataContext _context;
        public WorkRepository(DataContext context)
        {
            _context = context;
        }
        public async Task<Work> GetWorksByIdAsync(int id)
        {
            return await _context.Works.FindAsync(id);
        }

        public async Task<IReadOnlyList<Work>> GetWorksAsync(int id)
        {
            DateTime today = DateTime.Today;
            return await _context.Works.Where(w => w.GoalTime >= today && w.GoalTime <= today.AddDays(7) && w.OwnerId == id && !w.IsDone).ToListAsync();
        }
        public async Task<IReadOnlyList<Work>> GetMonthWorksAsync(int id)
        {
            DateTime today = DateTime.Today;
            return await _context.Works.Where(w => w.GoalTime >= today && w.GoalTime <= today.AddMonths(1) && w.OwnerId == id && !w.IsDone).ToListAsync();
        }
        public async Task<IReadOnlyList<Work>> GetYearWorksAsync(int id)
        {
            DateTime today = DateTime.Today;
            return await _context.Works.Where(w => w.GoalTime >= today && w.GoalTime <= today.AddYears(1) && w.OwnerId == id && !w.IsDone).ToListAsync();
        }

        public async Task<bool> AddWorkAsync(Work work)
        {
            await _context.Works.AddAsync(work);
            int res = await _context.SaveChangesAsync();
            return res != 0 ? true : false;
        }

        public async Task<bool> DeleteWorkAsync(int id)
        {
            var work = await GetWorksByIdAsync(id);
            _context.Works.Remove(work);
            int res = await _context.SaveChangesAsync();
            return res != 0 ? true : false;
        }

        public async Task<bool> UpdateWorkAsync(Work work)
        {
            _context.Works.Update(work);
            int res = await _context.SaveChangesAsync();
            return res != 0 ? true : false;
        }

        public async Task<bool> WorkDone(int id)
        {
            var work = await GetWorksByIdAsync(id);
            work.IsDone = !work.IsDone;
            _context.Works.Update(work);
            int res = await _context.SaveChangesAsync();
            return res != 0 ? true : false;
        }

        public async Task<IReadOnlyList<Work>> GetAssignedWorks(int id)
        {
            return await _context.Works.Where(w => w.OwnerId == id && w.PersonId.HasValue).ToListAsync();
        }

        public async Task<Work> GetAssignedWorkById(int ownerId, int personId)
        {
            return await _context.Works.FirstOrDefaultAsync(w => w.OwnerId == ownerId && w.PersonId == personId);
        }

        public async Task<bool> AssignWork(int id, int personid)
        {
            var work = await _context.Works.FindAsync(id);
            if (work == null)
            {
                return false;
            }
            work.PersonId = personid;
            _context.Update(work);
            int res = await _context.SaveChangesAsync();
            return res != 0 ? true : false;
        }

        public async Task<IReadOnlyList<Work>> GetDoneWorksAsync(int id)
        {
            return await _context.Works.Where( w => w.OwnerId == id && w.IsDone).ToListAsync();
        }
    }
}