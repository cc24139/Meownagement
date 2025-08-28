

using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class Metas
{
    [Key]
    public int IdMeta { get; set; }
    public string Nome { get; set; }
    public decimal GastoLimite { get; set; }
    public int QtsMoedas { get; set; }
    public DateTime DataCriacao { get; set; }
    public DateTime DataTermino { get; set; }
    
    public char Feita{ get; set; }

    [ForeignKey("Usuario")]
    public int IdUsuario { get; set; }
    public Usuario Usuario { get; set; }

    [ForeignKey("Classificacao")]
    public int IdClassificacao { get; set; }
    public Classificacao Classificacao { get; set; }
}
