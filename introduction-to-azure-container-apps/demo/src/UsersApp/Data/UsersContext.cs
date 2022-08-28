using Microsoft.EntityFrameworkCore;
using UsersApp.Controllers;

namespace UsersApp.Data
{
    public class UsersContext: DbContext
    {
        public UsersContext(DbContextOptions options):base (options)
        {

        }

        public DbSet<User> Users { get; set; }

    }
}
