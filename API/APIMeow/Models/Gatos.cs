
using System.ComponentModel.DataAnnotations;

public class Gatos
{
    [Key]
    public int IdGato { get; set; }
    public string Nome { get; set; }
    public int Raridade { get; set; }
    public int CodPaleta { get; set; }
    public string NomeImagem { get; set; }
}