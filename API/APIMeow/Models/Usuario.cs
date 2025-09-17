
using System.ComponentModel.DataAnnotations;

public class Usuario
{
    [Key]
    public int IdUsuario { get; set; }
    public string Senha { get; set; }
    public string Biografia { get; set; }
    public string Nome { get; set; }
    public string Email { get; set; }
    public decimal Saldo { get; set; }
    public int Pontos { get; set; }
}