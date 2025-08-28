
using System.ComponentModel.DataAnnotations.Schema;

public class UsuarioGato
{
    [ForeignKey("Usuario")]
    public int IdUsuario { get; set; }
    public Usuario Usuario { get; set; }

    [ForeignKey("Gatos")]
    public int IdGato { get; set; }
    public Gatos Gato { get; set; }

    public int Copias { get; set; }
}