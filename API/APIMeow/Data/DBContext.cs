using Microsoft.EntityFrameworkCore;

public class DBMeownagement : DbContext
{
    public DBMeownagement(DbContextOptions<DBMeownagement> options) : base(options)
    {
    }
    
    public DbSet<Usuario> Usuarios { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Configura o schema para a tabela Usuario
        modelBuilder.Entity<Usuario>().ToTable("Usuario", "Meownagement");
        
        // Configura a chave primária
        modelBuilder.Entity<Usuario>()
            .HasKey(u => u.IdUsuario);
            
        // Configura o IdUsuario como auto-increment
        modelBuilder.Entity<Usuario>()
            .Property(u => u.IdUsuario)
            .ValueGeneratedOnAdd();
            
        base.OnModelCreating(modelBuilder);
    }
}