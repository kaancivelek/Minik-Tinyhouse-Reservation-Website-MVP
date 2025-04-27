using Microsoft.EntityFrameworkCore;
using Minik.Server.Models;

namespace Minik.Server.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<TinyHouse> TinyHouses { get; set; }
    }
}
