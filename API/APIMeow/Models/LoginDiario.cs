using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class LoginDiario
{
    [Key]
    public int IdLogin { get; set; }
    [ForeignKey("Usuario")]
    public int IdUsuario { get; set; }
    public int NumSequencia { get; set; }
    public DateTime UltimoLogin { get; set; }   
    public virtual Usuario Usuario { get; set; }
}