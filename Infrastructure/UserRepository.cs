using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using taskmanager.Interfaces;
using taskmanager.Models;

namespace taskmanager.Infrastructure
{
    public class UserRepository : IUserRepository
    {
        private readonly DatabaseContext _context;
        public UserRepository(DatabaseContext context)
        {
            _context = context;
        }
        public async Task Create(User user)
        {
            await _context.AddAsync(user);
            await _context.SaveChangesAsync();
        }

        public async Task Delete(int id)
        {
            var user = await GetUserByIdAsync(id);
            if (user != null)
            {
                _context.User.Remove(user);
                await _context.SaveChangesAsync();
            }

        }

        public async Task<User> GetUserByEmailAndPassword(string email, string password)
        {
            return await _context.User.FirstOrDefaultAsync(u => (u.Email.Equals(email) || u.Username.Equals(email)) && u.Password.Equals(password));
        }

        public async Task<User> GetUserByIdAsync(int id)
        {
            return await _context.User.FindAsync(id);
        }

        public async Task Update(User user)
        {
            _context.User.Update(user);
            await _context.SaveChangesAsync();
        }
    }
}