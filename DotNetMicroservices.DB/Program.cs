using DotNetMicroservices.DB.Data;
using Microsoft.EntityFrameworkCore;
using System;

namespace DotNetMicroservices.DB
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = new ApplicationDbContext();

            Console.WriteLine("Applying migrations...");

            try
            {
               context.Database.Migrate();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error occured: {0}", ex.Message);
            }

            Console.WriteLine("Done!");
        }

    }
}
