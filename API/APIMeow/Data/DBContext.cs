using APIMeow.Models;
using Microsoft.EntityFrameworkCore;

public class DBMeownagement : DbContext
{
    public DBMeownagement(DbContextOptions<DBMeownagement> options) : base(options)
    {
    }
    
    public DbSet<Usuario> Usuario { get; set; }
    public DbSet<Gatos> Gatos { get; set; }
    public DbSet<Transacao> Transacao { get; set; }
    public DbSet<Cofrinho> Cofrinho { get; set; }
    public DbSet<Classificacao> Classificacao { get; set; }
    public DbSet<Metas> Metas { get; set; }
    public DbSet<Comentario> Comentario { get; set; }
    public DbSet<Post> Post { get; set; }
    public DbSet<Recorrencia> Recorrencia { get; set; }
    public DbSet<UsuarioGato> UsuarioGato { get; set; }
    public DbSet<MetaCofrinhoTransacao> MetaCofrinhoTransacao { get; set; }
    public DbSet<LoginDiario> LoginDiario { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.HasDefaultSchema("Meownagement");
        /*
        Precisa referenciar a chave primária da tabela
        Os outros campos não precisam ser referenciados aqui, apenas nas classes Models
        */
        modelBuilder.Entity<Usuario>().HasKey(u => u.IdUsuario);
        modelBuilder.Entity<Gatos>().HasKey(g => g.IdGato);
        modelBuilder.Entity<Transacao>().HasKey(t => t.IdTransacao);
        modelBuilder.Entity<Cofrinho>().HasKey(c => c.IdCofrinho);
        modelBuilder.Entity<Classificacao>().HasKey(c => c.IdClassificacao);
        modelBuilder.Entity<Metas>().HasKey(m => m.IdMeta);
        modelBuilder.Entity<Comentario>().HasKey(c => c.IdComentario);
        modelBuilder.Entity<Post>().HasKey(p => p.IdPost);
        modelBuilder.Entity<Recorrencia>().HasKey(r => r.IdRecorrencia);
        modelBuilder.Entity<UsuarioGato>().HasKey(ug => new { ug.IdUsuario, ug.IdGato });
        modelBuilder.Entity<MetaCofrinhoTransacao>().HasKey(mct => mct.IdRel);
        modelBuilder.Entity<LoginDiario>().HasKey(ld => ld.IdUsuario);

        // Configuração para UsuarioGato
        modelBuilder.Entity<UsuarioGato>()
            .HasKey(ug => new { ug.IdUsuario, ug.IdGato });

        modelBuilder.Entity<UsuarioGato>()
            .HasOne(ug => ug.Usuario)
            .WithMany()
            .HasForeignKey(ug => ug.IdUsuario);

        modelBuilder.Entity<UsuarioGato>()
            .HasOne(ug => ug.Gato)
            .WithMany()
            .HasForeignKey(ug => ug.IdGato);

        modelBuilder.Entity<LoginDiario>()
            .HasOne(ld => ld.Usuario)
            .WithMany()
            .HasForeignKey(ld => ld.IdUsuario);
    }
}