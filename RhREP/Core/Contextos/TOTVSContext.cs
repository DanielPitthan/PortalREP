using Microsoft.EntityFrameworkCore;
using Models.RequisicoesPessoais.REP;
using Models.Admin;
using Models.Cadastros;
using Models.Infra;
using Models.Tickets;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using MatBlazor;

namespace RHRep.Contextos
{
    public class TOTVSContext : DbContext
    {
        #region Properties
        
        public DbSet<Departamentos> SQB100 { get; set; }
        public DbSet<TabelaGenericaX5> SX5100 { get; set; }
        public DbSet<Base> RBS100 { get; set; }
        public DbSet<Turno> SR6100 { get; set; }
        public DbSet<Cargo> SQ3100 { get; set; }
        public DbSet<Empresa> SYS_COMPANY { get; set; }
        public DbSet<MunicipiosUF> CC2100 { get; set; }
        public DbSet<ParametrosOnline> ParametrosOnline { get; set; }
        public DbSet<ItemContabil> CTD100 { get; set; }
        public DbSet<WorkFlow> WorkFlow { get; set; }
        public DbSet<Responsabilidade> ZC7100 { get; set; }
        public DbSet<Assunto> ZC4100 { get; set; }
        public DbSet<Problema> ZC5100 { get; set; }
        public DbSet<Unidade> ZC6100 { get; set; }
        public DbSet<ImagensTickets> ImagensTickets { get; set; }
        public DbSet<CentroCusto> CTT100 { get; set; }
        public DbSet<Ticket> ZC0100 { get; set; }
        public DbSet<HistoricoTicket> ZC1100 { get; set; }
        public DbSet<Status> ZC2100 { get; set; }
        public DbSet<Login> RD0100 { get; set; }
        public DbSet<Funcionario> SRA100 { get; set; }
        public DbSet<AreaInterna> ZC3100 { get; set; }
        public DbSet<ControleLogin> ControleLogin { get; set; }
        public DbSet<RequisicaoPessoal> SQS100_PRECAD { get; set; }

        #endregion


        public TOTVSContext(DbContextOptions<TOTVSContext> options) : base(options) { }        

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            
            modelBuilder.Entity<Departamentos>().HasNoKey();
            modelBuilder.Entity<ItemContabil>().HasNoKey();
            modelBuilder.Entity<Assunto>().HasNoKey();
            modelBuilder.Entity<Problema>().HasNoKey();
            modelBuilder.Entity<Unidade>().HasNoKey();
            modelBuilder.Entity<Responsabilidade>().HasNoKey();
            modelBuilder.Entity<Ticket>().HasNoKey();
            modelBuilder.Entity<HistoricoTicket>().HasNoKey();
            modelBuilder.Entity<Status>().HasNoKey();
            modelBuilder.Entity<Login>().HasNoKey();
            modelBuilder.Entity<Funcionario>().HasNoKey();
            modelBuilder.Entity<AreaInterna>().HasNoKey();
            modelBuilder.Entity<CentroCusto>().HasNoKey();
            modelBuilder.Entity<RequisicaoPessoal>().HasNoKey();
            modelBuilder.Entity<MunicipiosUF>().HasNoKey();
            modelBuilder.Entity<Empresa>().HasNoKey();
            modelBuilder.Entity<Cargo>().HasNoKey();
            modelBuilder.Entity<Turno>().HasNoKey();
            modelBuilder.Entity<Base>().HasNoKey();
            modelBuilder.Entity<TabelaGenericaX5>().HasNoKey();

        }
    }
}
