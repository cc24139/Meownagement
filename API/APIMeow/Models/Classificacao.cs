using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class Classificacao
{
    public int IdClassificacao { get; set; }
    [ForeignKey("Metas")]
    public int IdMetas { get; set; }
    public Metas Metas { get; set; }
    [MaxLength(100)]
    public string Tipo { get; set; }

}