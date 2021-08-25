using System;
using Blazored.SessionStorage;
using Blazorise;
using Blazorise.Bootstrap;
using Blazorise.Icons.FontAwesome;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Radzen;
using RHRep.Contextos;
using RHRep.InjectionControl;

//using Blazor.Extensions.Storage;

namespace RHChamados
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddRazorPages();

            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromDays(90);
            });

            services.AddServerSideBlazor().AddCircuitOptions(o => {
                o.DetailedErrors = true;
            });
            services.AddHttpContextAccessor();
            services.AddHttpClient();

            services.AddDbContext<TOTVSContext>(options =>
            {
                options.UseSqlServer(Configuration["ConnectionString"])
                .EnableSensitiveDataLogging(); 
            }, ServiceLifetime.Transient);

            
            services.AddBlazorise(options =>
                     {
                         options.ChangeTextOnKeyPress = true; // optional
                     })
                     .AddBootstrapProviders()
                     .AddFontAwesomeIcons();

      
            services.AddBlazoredSessionStorage();
            services.AddScoped<DialogService>();

            #region Injeção de dependecia

            services.AddDependencia(Configuration);

            #endregion
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Error");
            }

            app.UseStaticFiles();
            app.UseHttpsRedirection();
            app.UseRouting();

            app.UseSession();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapBlazorHub();
                endpoints.MapFallbackToPage("/_Host");
                endpoints.MapControllers();
            });
        }
    }
}
