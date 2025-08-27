using System.ComponentModel.DataAnnotations;
using System.Data.SqlTypes;
using System.Diagnostics.CodeAnalysis;

public class Usuario
{
    /*
     senha VARCHAR(n),  
     nome Varchar(n),  
    email VARCHAR(n),  
    saldo FLOAT,  
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,  
    pontos INT,  
 */
    [Key]
    public int IdUsuario { get; set; }
    [MaxLength(100)]
    public string Nome { get; set; }
    [MaxLength(100)]
    public string Email { get; set; }
    [Required]
    public string Senha { get; set; }
    public decimal Saldo { get; set; }
    public int Pontos { get; set; }
}