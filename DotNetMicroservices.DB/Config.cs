using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace DotNetMicroservices.DB
{
    class Config
    {
        public IConfiguration Configuration { get; set; }

        public Config()
        {
            var builder = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json")
            .AddEnvironmentVariables();

            Configuration = builder.Build();
        }
    }
}
