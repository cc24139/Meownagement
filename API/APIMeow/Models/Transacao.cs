
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class Transacao
{
    [Key]
    public int IdTransacao { get; set; }
    public string Nome { get; set; }
    public decimal QuantiaDinheiro { get; set; }
    public DateTime DataCriacao { get; set; }
    public bool Feita { get; set; }
    public DateTime DataFinalizacao { get; set; }

    [ForeignKey("Usuario")]
    public int IdUsuario { get; set; }
    public Usuario Usuario { get; set; }

    [ForeignKey("Classificacao")]
    public int IdClassificacao { get; set; }
    public Classificacao Classificacao { get; set; }

    [ForeignKey("Recorrencia")]
    public int IdRecorrencia { get; set; }
    public Recorrencia Recorrencia { get; set; }
}
