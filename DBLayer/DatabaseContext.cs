using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Models.Models;

namespace DBLayer
{
    public class DatabaseContext : DbContext
    {
        public DbSet<Afdeling> afdeling { get; set; }
        public DbSet<AfdelingAdmin> afdelingadmin { get; set; }
        public DbSet<Bruger> brugere { get; set; }
        public DbSet<BrugerTeam> brugereteam { get; set; }
        public DbSet<BrugerTid> brugeretid { get; set; }
        public DbSet<Dagstatus> dagstatus { get; set; }
        public DbSet<Institution> institution { get; set; }
        public DbSet<InstitutionAdmin> institutionadmin { get; set; }
        public DbSet<Log> log { get; set; }
        public DbSet<Status> status { get; set; }
        public DbSet<SuperAdmin> superadmin { get; set; }
        public DbSet<Team> team { get; set; }
        public DbSet<TeamAdmin> teamadmin { get; set; }
        public DbSet<TeamsTid> teamstid { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            string path = @"server=localhost;user=root;database=flex_ultimate_new;password=123;SSL Mode=None";
            //"server=127.0.0.1;user=root;database=flex_ultimate;port=3306;password=123;SSL Mode=None"
            optionsBuilder.UseMySQL(path, o =>
            {
                //o.EnableRetryOnFailure();
            });
            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AfdelingAdmin>()
                .HasKey(t => new { t.afdelingId, t.brugerId });

            modelBuilder.Entity<AfdelingAdmin>()
                .HasOne(t => t.afdeling)
                .WithMany(t => t.admins)
                .HasForeignKey(t => t.afdelingId);

            modelBuilder.Entity<AfdelingAdmin>()
                .HasOne(t => t.bruger)
                .WithMany(t => t.afdAdmin)
                .HasForeignKey(t => t.brugerId);


            modelBuilder.Entity<BrugerTeam>()
                .HasKey(t => new { t.teamId, t.brugerId });

            modelBuilder.Entity<BrugerTeam>()
                .HasOne(t => t.Bruger)
                .WithMany(t => t.BrugerTeams)
                .HasForeignKey(t => t.teamId);

            modelBuilder.Entity<BrugerTeam>()
                .HasOne(t => t.Team)
                .WithMany(t => t.brugere)
                .HasForeignKey(t => t.brugerId);


            modelBuilder.Entity<InstitutionAdmin>()
                .HasKey(t => new { t.institutionsId, t.brugerId });

            modelBuilder.Entity<InstitutionAdmin>()
                .HasOne(t => t.Bruger)
                .WithMany(t => t.instAdmin)
                .HasForeignKey(t => t.brugerId);

            modelBuilder.Entity<InstitutionAdmin>()
                .HasOne(t => t.Institution)
                .WithMany(t => t.admins)
                .HasForeignKey(t => t.institutionsId);


            modelBuilder.Entity<TeamAdmin>()
                .HasKey(t => new { t.teamId, t.brugerId });

            modelBuilder.Entity<TeamAdmin>()
                .HasOne(t => t.Bruger)
                .WithMany(t => t.teamAdmin)
                .HasForeignKey(t => t.teamId);

            modelBuilder.Entity<TeamAdmin>()
                .HasOne(t => t.Team)
                .WithMany(t => t.admins)
                .HasForeignKey(t => t.brugerId);
        }
    }
}
