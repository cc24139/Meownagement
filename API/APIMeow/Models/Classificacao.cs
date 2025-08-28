using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


public class Classificacao
{
    [Key]
    public int IdClassificacao { get; set; }
    public string Tipo { get; set; }

    // Relação com Metas
    public ICollection<Metas> Metas { get; set; }
}