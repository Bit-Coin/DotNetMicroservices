using DotNetMicroservices.DB.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using System;
using System.Collections.Generic;
using System.Text;

namespace DotNetMicroservices.DB.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>, IDesignTimeDbContextFactory<ApplicationDbContext>
    {
        public ApplicationDbContext()
        { }

        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }


        // db sets goes here

        public ApplicationDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();
            var configBuilder = new Config();

            optionsBuilder.UseNpgsql(configBuilder.Configuration["DatabaseConnection"]);

            return new ApplicationDbContext(optionsBuilder.Options);
        }
    }
}
