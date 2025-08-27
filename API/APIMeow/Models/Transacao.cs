using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;


public class Transacao
{
    [Key]
    public int IdTransacao { get; set; }
    public string Nome { get; set; }
    public decimal QuantiaDinheiro { get; set; }
    [ForeignKey("Usuario")]
    public int IdUsuario { get; set; }
    public Usuario Usuario { get; set; }
    public DateTime DataCriacao { get; set; }
    //FK
    public int IdClassificacao { get; set; }
    [ForeignKey("Recorrencia")]
    public int IdRecorrencia { get; set; }
    public Recorrencia Recorrencia { get; set; }
    public bool Feita { get; set; }
    public DateTime DataFinalizacao { get; set; }

}
