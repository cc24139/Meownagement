using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class UsuarioGato
{
    [Key]
    [Column(Order = 0)]
    public int IdUsuario { get; set; }

    [Key]
    [Column(Order = 1)]
    public int IdGato { get; set; }

    public int Copias { get; set; }

    // Propriedades de navegação
    [ForeignKey("IdUsuario")]
    public virtual Usuario Usuario { get; set; }

    [ForeignKey("IdGato")]
    public virtual Gatos Gato { get; set; }

    public char Equipado { get; set; }
}