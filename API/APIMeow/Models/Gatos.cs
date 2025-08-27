using System.ComponentModel.DataAnnotations;

public class Gato
{
    [Key]
    public int IdGato { get; set; }
    [MaxLength(100)]
    public string Nome { get; set; }
    public int Raridade { get; set; }
    [MaxLength(100)]
    public string NomeImagem { get; set; }
    public int CodPaleta { get; set; }
    public string PathResources => $"API\\APIMeow\\Resources\\gatosGacha\\imagensTamanhos\\{NomeImagem}";
}