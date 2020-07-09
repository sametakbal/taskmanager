using System.Threading.Tasks;
using taskmanager.Models;

namespace taskmanager.Interfaces
{
    public interface IUserRepository
    {
        Task<User> GetUserByIdAsync(int id);
        Task<User> GetUserByEmailAndPassword(string email, string password);

        Task Create(User user);

        Task Delete (int id);

        Task Update (User user);
    }
}