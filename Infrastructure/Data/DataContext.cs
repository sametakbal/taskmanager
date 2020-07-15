using Core.Entities;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data
{
    public class DataContext : IdentityDbContext<User,Role,int>
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options){}

        public DbSet<Work> Works { get; set; }
    }
}