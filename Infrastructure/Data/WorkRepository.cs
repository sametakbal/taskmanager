using System.Collections.Generic;
using System.Threading.Tasks;
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
        public  async Task<Work> GetWorksByIdAsync(int id)
        {
            return await _context.Works.FindAsync(id);
        }

        public async Task<IReadOnlyList<Work>> GetWorkAsync()
        {
            return await _context.Works.ToListAsync();
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
    }
}