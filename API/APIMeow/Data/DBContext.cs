using Microsoft.EntityFrameworkCore;

public class DBMeownagement : DbContext
{
    public DBMeownagement(DbContextOptions<DBMeownagement> options) : base(options)
    {
    }
    
    public DbSet<Usuario> Usuario { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.HasDefaultSchema("Meownagement");
        /*
        Precisa referenciar a chave primária da tabela
        Os outros campos não precisam ser referenciados aqui, apenas nas classes Models
        */
         modelBuilder.Entity<Usuario>().HasKey(u => u.IdUsuario);
    }
}