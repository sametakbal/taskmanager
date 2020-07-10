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

        public async Task<Work> GetWorkByIdAsync(int id)
        { 
          return await _context.Work.FindAsync(id);  
        }

        public async Task<IReadOnlyList<Work>> GetWorksAsync(int userId)
        {
            List<Work> list =  await _context.Work.Where(w => _context.UserWorks
            .Where(e => e.UserId == userId)
            .Select(c => c.WorkId)
            .Contains(w.Id)).ToListAsync();
            return list;
        }

        public async Task Update(Work work)
        {
            _context.Work.Update(work);
            await _context.SaveChangesAsync();
        }
    }
}