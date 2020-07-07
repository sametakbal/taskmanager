using System.Collections.Generic;
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

        public async Task<Work> GetWorkByIdAsync(int id)
        { 
          return await _context.Work.FindAsync(id);  
        }

        public async Task<IReadOnlyList<Work>> GetWorksAsync(int userId)
        {
            return await _context.Work.ToListAsync();
        }
    }
}