using System.Data.SqlTypes;

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
    public int IdUsuario { get; set; }
    public string Nome { get; set; }
    public string Email { get; set; }
    public string Senha { get; set; }
    public decimal Saldo { get; set; }
    public int Pontos { get; set; }
}