
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class UsuarioGato
{
    [ForeignKey("Usuario")]
    public int IdUsuario { get; set; }

    [ForeignKey("Gato")]
    public int IdGatos { get; set; }
    public int Copias { get; set; }
}