using Microsoft.EntityFrameworkCore;

namespace taskmanager.Models
{
    public class DatabaseContext : DbContext
    {
        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options) { }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>()
            .HasIndex(b => b.Email)
            .IsUnique(true);
            modelBuilder.Entity<User>()
            .HasIndex(b => b.Username)
            .IsUnique(true);
    }
        public DbSet<Work> Work {get;set;}
        public DbSet<User> User {get;set;}
        public DbSet<UserWorks> UserWorks {get;set;}
    }
}