using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using taskmanager.Interfaces;
using taskmanager.Models;

namespace taskmanager.Infrastructure
{
    public class WorkRepository : IWorkRepository
    {
        private readonly DatabaseContext _context;
        public WorkRepository(DatabaseContext context)
        {
            _context = context;
        }

        public async Task Create(Work work)
        {
            await _context.Work.AddAsync(work);
            await _context.SaveChangesAsync();
        }

        public async Task Delete(int id)
        {
    
            var work = await _context.Work.FindAsync(id);
            _context.Work.Remove(work);
            await _context.SaveChangesAsync();
        }

        public async Task<IReadOnlyList<Work>> GetMonthWorksAsync(int id)
        {
            DateTime today = DateTime.Now;
            List<Work> list =  await _context.Work.Where(w => w.UserId == id && (today <= w.GoalTime && today.AddMonths(1) >= w.GoalTime)).ToListAsync();
            return list;
        }

        public async Task<Work> GetWorkByIdAsync(int id)
        { 
          return await _context.Work.FindAsync(id);  
        }

        public async Task<IReadOnlyList<Work>> GetWorksAsync(int userId)
        {
            DateTime today = DateTime.Now;
            List<Work> list =  await _context.Work.Where(w => w.UserId == userId && (today <= w.GoalTime && today.AddDays(7) >= w.GoalTime)).ToListAsync();
            return list;
        }

        public async Task<IReadOnlyList<Work>> GetYearWorksAsync(int id)
        {
            DateTime today = DateTime.Now;
            List<Work> list =  await _context.Work.Where(w => w.UserId == id && (today <= w.GoalTime && today.AddYears(1) >= w.GoalTime)).ToListAsync();
            return list;
        }

        public async Task Update(Work work)
        {
            _context.Work.Update(work);
            await _context.SaveChangesAsync();
        }
    }
}